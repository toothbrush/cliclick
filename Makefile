CC = clang
CFLAGS = -include cliclick_Prefix.pch -I Actions -I .
PREFIX = /usr/local
BINS = cliclick

all: $(addprefix bin/,$(BINS))

bin/cliclick: Actions/ClickAction.o \
          Actions/ColorPickerAction.o \
          Actions/DoubleclickAction.o \
          Actions/DragDownAction.o \
          Actions/DragUpAction.o \
          Actions/KeyBaseAction.o \
          Actions/KeyDownAction.o \
          Actions/KeyDownUpBaseAction.o \
          Actions/KeyPressAction.o \
          Actions/KeyUpAction.o \
          Actions/MouseBaseAction.o \
          Actions/MoveAction.o \
          Actions/PrintAction.o \
          Actions/TripleclickAction.o \
          Actions/TypeAction.o \
          Actions/WaitAction.o \
          ActionExecutor.o \
          KeycodeInformer.o \
          cliclick.o
	$(CC) -o bin/cliclick $^ -framework Cocoa -framework Carbon

# This appears to be default in BSD Make, not GNU Make...
%.o: %.m
	$(CC) ${CFLAGS} -c -o $@ $<

bindir:
	@install -m755 -d $(PREFIX)/bin

install: all bindir $(addprefix $(PREFIX)/bin/,$(BINS))

$(PREFIX)/bin/%: bin/%
	@echo " INSTALL" $@
	@install -m 755 $< $@

clean:
	@rm -vf *.o Actions/*.o
	@rm -vf cliclick

.PHONY: all install clean
