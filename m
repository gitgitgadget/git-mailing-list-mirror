From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] Use $(RM) in makefiles instead of rm
Date: Fri, 13 Jul 2007 12:48:43 -0500
Message-ID: <11843489233943-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 19:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9PKX-0006cD-2z
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbXGMRxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756974AbXGMRxG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:53:06 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:51431 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbXGMRxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:53:04 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l6DHr0E0029935
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 10:53:01 -0700 (MST)
Received: from localhost.localdomain ([10.82.124.180])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6DHr0HA016659;
	Fri, 13 Jul 2007 12:53:00 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc0.90.gbaa79
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52406>

Use $(RM) in makefiles instead of rm

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 Documentation/Makefile |   14 +++++-----
 Makefile               |   66 ++++++++++++++++++++++++------------------------
 contrib/emacs/Makefile |    2 +-
 git-gui/Makefile       |   14 +++++-----
 t/Makefile             |    2 +-
 templates/Makefile     |    2 +-
 6 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f3a6c73..eaab01d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -84,7 +84,7 @@ install: man
 # Determine "include::" file references in asciidoc files.
 #
 doc.dep : $(wildcard *.txt) build-docdep.perl
-	rm -f $@+ $@
+	$(RM) $@+ $@
 	perl ./build-docdep.perl >$@+
 	mv $@+ $@
 
@@ -109,11 +109,11 @@ cmd-list.made: cmd-list.perl $(MAN1_TXT)
 git.7 git.html: git.txt core-intro.txt
 
 clean:
-	rm -f *.xml *.xml+ *.html *.html+ *.1 *.5 *.7 howto-index.txt howto/*.html doc.dep
-	rm -f $(cmds_txt) *.made
+	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7 howto-index.txt howto/*.html doc.dep
+	$(RM) $(cmds_txt) *.made
 
 %.html : %.txt
-	rm -f $@+ $@
+	$(RM) $@+ $@
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
 	mv $@+ $@
@@ -122,7 +122,7 @@ clean:
 	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
-	rm -f $@+ $@
+	$(RM) $@+ $@
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
 	mv $@+ $@
@@ -137,7 +137,7 @@ user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
-	rm -f $@+ $@
+	$(RM) $@+ $@
 	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
 	mv $@+ $@
 
@@ -147,7 +147,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
-	rm -f $@+ $@
+	$(RM) $@+ $@
 	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+
 	mv $@+ $@
 
diff --git a/Makefile b/Makefile
index d7541b4..2453fc8 100644
--- a/Makefile
+++ b/Makefile
@@ -729,7 +729,7 @@ export TAR INSTALL DESTDIR SHELL_PATH
 
 all:: $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS)
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$p';)
 endif
 
 all::
@@ -743,7 +743,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 gitk-wish: gitk GIT-GUI-VARS
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
 	chmod +x $@+ && \
 	mv -f $@+ $@
@@ -759,10 +759,10 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 help.o: common-cmds.h
 
 git-merge-subtree$X: git-merge-recursive$X
-	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && ln git-merge-recursive$X $@
 
 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)rm -f $@ && ln git$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
 
 common-cmds.h: ./generate-cmdlist.sh
 
@@ -770,7 +770,7 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -782,7 +782,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 
 $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
-	rm -f $@ $@+
+	$(RM) $@ $@+
 	sed -e '1s|#!.*/python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
@@ -794,7 +794,7 @@ perl/perl.mak: GIT-CFLAGS
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
@@ -813,7 +813,7 @@ git-status: git-commit
 	$(QUIET_GEN)cp $< $@+ && mv $@+ $@
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -836,7 +836,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	mv $@+ $@
 
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
@@ -849,11 +849,11 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	mv $@+ $@
 
 configure: configure.ac
-	$(QUIET_GEN)rm -f $@ $<+ && \
+	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< > $<+ && \
 	autoconf -o $@ $<+ && \
-	rm -f $<+
+	$(RM) $<+
 
 # These can record GIT_VERSION
 git.o git.spec \
@@ -908,7 +908,7 @@ $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o
@@ -916,7 +916,7 @@ $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
 perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
@@ -927,11 +927,11 @@ doc:
 	$(MAKE) -C Documentation all
 
 TAGS:
-	rm -f TAGS
+	$(RM) TAGS
 	find . -name '*.[hcS]' -print | xargs etags -a
 
 tags:
-	rm -f tags
+	$(RM) tags
 	find . -name '*.[hcS]' -print | xargs ctags -a
 
 ### Detect prefix changes
@@ -1010,9 +1010,9 @@ endif
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
 
 install-doc:
@@ -1042,7 +1042,7 @@ dist: git.spec git-archive configure
 		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
-	@rm -rf $(GIT_TARNAME)
+	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
@@ -1051,13 +1051,13 @@ rpm: dist
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
 dist-doc:
-	rm -fr .doc-tmp-dir
+	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
 	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
 	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
 	gzip -n -9 -f $(htmldocs).tar
 	:
-	rm -fr .doc-tmp-dir
+	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
 	$(MAKE) -C Documentation DESTDIR=./ \
 		man1dir=../.doc-tmp-dir/man1 \
@@ -1066,31 +1066,31 @@ dist-doc:
 		install
 	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar .
 	gzip -n -9 -f $(manpages).tar
-	rm -fr .doc-tmp-dir
+	$(RM) -r .doc-tmp-dir
 
 ### Cleaning rules
 
 clean:
-	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
+	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
-	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
-	rm -f $(TEST_PROGRAMS)
-	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
-	rm -rf autom4te.cache
-	rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
-	rm -rf $(GIT_TARNAME) .doc-tmp-dir
-	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
-	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
-	rm -f gitweb/gitweb.cgi
+	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
+	$(RM) $(TEST_PROGRAMS)
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
+	$(RM) -r autom4te.cache
+	$(RM) configure config.log config.mak.autogen config.mak.append config.status config.cache
+	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
+	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
+	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
+	$(RM) gitweb/gitweb.cgi
 	$(MAKE) -C Documentation/ clean
 	$(MAKE) -C perl clean
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
-	rm -f gitk-wish
+	$(RM) gitk-wish
 	$(MAKE) -C git-gui clean
 endif
-	rm -f GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
+	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS
 
 .PHONY: all install clean strip
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags .FORCE-GIT-CFLAGS
diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index 98aa0aa..7000d99 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -17,4 +17,4 @@ install: all
 %.elc: %.el
 	$(EMACS) -batch -f batch-byte-compile $<
 
-clean:; rm -f $(ELC)
+clean:; $(RM) $(ELC)
diff --git a/git-gui/Makefile b/git-gui/Makefile
index 1bac6fe..ab13b8a 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -37,7 +37,7 @@ INSTALL_R0 = $(INSTALL) -m644 # space is required here
 INSTALL_R1 =
 INSTALL_X0 = $(INSTALL) -m755 # space is required here
 INSTALL_X1 =
-INSTALL_L0 = rm -f # space is required here
+INSTALL_L0 = $(RM) # space is required here
 INSTALL_L1 = && ln # space is required here
 INSTALL_L2 =
 INSTALL_L3 =
@@ -59,7 +59,7 @@ ifndef V
 	INSTALL_L0 = dst=
 	INSTALL_L1 = && src=
 	INSTALL_L2 = && dst=
-	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
+	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && $(RM) "$$dst" && ln "$$src" "$$dst"
 endif
 
 TCL_PATH   ?= tclsh
@@ -83,7 +83,7 @@ exedir    = $(dir $(gitexecdir))share/git-gui/lib
 exedir_SQ = $(subst ','\'',$(exedir))
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	$(QUIET_GEN)rm -f $@ $@+ && \
+	$(QUIET_GEN)$(RM) $@ $@+ && \
 	GITGUI_RELATIVE= && \
 	if test '$(exedir_SQ)' = '$(libdir_SQ)'; then \
 		if test "$(uname_O)" = Cygwin; \
@@ -101,7 +101,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	mv $@+ $@
 
 $(GITGUI_BUILT_INS): git-gui
-	$(QUIET_BUILT_IN)rm -f $@ && ln git-gui $@
+	$(QUIET_BUILT_IN)$(RM) $@ && ln git-gui $@
 
 lib/tclIndex: $(ALL_LIBFILES)
 	$(QUIET_INDEX)if echo \
@@ -110,7 +110,7 @@ lib/tclIndex: $(ALL_LIBFILES)
 	| $(TCL_PATH) $(QUIET_2DEVNULL); then : ok; \
 	else \
 	 echo 1>&2 "    * $(TCL_PATH) failed; using unoptimized loading"; \
-	 rm -f $@ ; \
+	 $(RM) $@ ; \
 	 echo '# Autogenerated by git-gui Makefile' >$@ && \
 	 echo >>$@ && \
 	 $(foreach p,$(PRELOAD_FILES) $(ALL_LIBFILES),echo '$(subst lib/,,$p)' >>$@ &&) \
@@ -151,8 +151,8 @@ dist-version:
 	@echo $(GITGUI_VERSION) > $(TARDIR)/version
 
 clean::
-	rm -f $(ALL_PROGRAMS) lib/tclIndex
-	rm -f GIT-VERSION-FILE GIT-GUI-VARS
+	$(RM) $(ALL_PROGRAMS) lib/tclIndex
+	$(RM) GIT-VERSION-FILE GIT-GUI-VARS
 
 .PHONY: all install dist-version clean
 .PHONY: .FORCE-GIT-VERSION-FILE
diff --git a/t/Makefile b/t/Makefile
index b25caca..dc9e8cc 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -19,7 +19,7 @@ $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 clean:
-	rm -fr trash
+	$(RM) -r trash
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
diff --git a/templates/Makefile b/templates/Makefile
index aaa39d3..50a5453 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -42,7 +42,7 @@ custom:
 	$(QUIET): no custom templates yet
 
 clean:
-	rm -rf blt boilerplates.made
+	$(RM) -r blt boilerplates.made
 
 install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
-- 
1.5.3.rc0.90.gbaa79
