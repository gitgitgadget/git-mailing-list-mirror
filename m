Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B7CC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiFWK0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiFWK0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:26:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6B49F9F
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:26:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i206-20020a1c3bd7000000b003a0297a61ddso104109wma.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wFjdI9bidvQFej+yOktnCNgyYQBD5ZZ41vfYjf/P0s=;
        b=OgeImMJJ5dKp7r2YkP5IAEVfZz9eRHjA7CA1j5eKOWqFgqfYfk4NoUtm6UsqXjgsuh
         BRyZiWUxn9C3yFVH3Z3IkjONMS6qElAFG0ikiIwa6umtEM1UeleloejwvJHDPxbfvAPW
         6ih+Y4fMpuHqTVIdZbTjkrX/9WWSq/aBvXJC8jEumy34+qa+oueGBBIL3gb6YyOY5y6Y
         awPaBsqXJyHzkcH5uBboIJuw1+N1bEvZXN4Hx1MeoYPWYPqsQnGJiIjHEskUVQRYyQf1
         jAmtUUpX3e0yBYEkmGzIjXZqRjBvk2k3dApgauxemI6dwKUhMbJfJ2eKc/Bx7JbvdL/E
         s9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wFjdI9bidvQFej+yOktnCNgyYQBD5ZZ41vfYjf/P0s=;
        b=nTvMRqry42Ue3Bebmcsa9ERQpJbnjqeWIKARmC9m8AnYBn1a/11BLcVBZxFNYGdRwt
         6jM+ALfO0DRCopSOKgECOoHfT2uGNNGXozQIq22KhcuWRIXekdpa5oqi9oBhhPiFH76/
         SgQwYNv8/djUfdR74jk/tKF+LSDKWimhyZyaeTyDgoR36aGqgsLQs5lSTdCk3bLol9ma
         JmmhkFUwHaSYOxCcgA3kRlJuJrkhSFedUNWZlxd2mXyTIhcOm/U28pnDqNWCSRz2Gq5d
         VxLkrdU0pdlStwTiGaucqW0UlgpUM6/2BwwaZSe65dfPKHY8fMT5EmXMKTsPysoccjQc
         dGig==
X-Gm-Message-State: AJIora/H73+O+kgElRwKC356kUzZ+lSyq3gX5HSW1VIBkknIfFt1804y
        37nFUbcTFBPut5COxtKR6h5qnD9oFSA1sQ==
X-Google-Smtp-Source: AGRyM1sR0pjIj258p4tYExHl4M9FJHEOT8bU2N59wnMQaKJMVKqrrCKs2gTxrbAelshgMWs+AoOabQ==
X-Received: by 2002:a05:600c:1e8a:b0:3a0:2aff:7d7e with SMTP id be10-20020a05600c1e8a00b003a02aff7d7emr3259523wmb.95.1655979995552;
        Thu, 23 Jun 2022 03:26:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h30-20020adfaa9e000000b0020c7ec0fdf4sm26778865wrc.117.2022.06.23.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:26:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/1] scalar: reorganize from contrib/, still keep it "a contrib command"
Date:   Thu, 23 Jun 2022 12:26:23 +0200
Message-Id: <patch-v2-1.1-9743e2a1e6a-20220623T100554Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com> <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the optional scalar command added in 0a43fb22026 (scalar:
create a rudimentary executable, 2021-12-03) so that it builds, tests
and CI's with our usual build and testing process, but is still kept
"a contrib command" in how we talk about it in our documentation.

Before this change we've been building scalar.o in CI as part of the
"static-analysis" job, we'll now build the full binary, and run its
tests. We won't install it unless "INSTALL_SCALAR=Y" is provided to
the Makefile. Before this change there was no "make install" step for
the "scalar" binary at all.

Before this we needed a significant amount of Makefile boilerplate to
do something that the top-level Makefile could do with relatively
little work, and by doing so we'll get the advantage of testing and
CI-ing the scalar command along with our other commands.

The recent [1] shows a (now retracted, see [2]) series to integrate
scalar with CI while it still lived in contrib/*. For context: There's
been past discussion about how this command should be integrated in
terms of the "closeness" of its integration, and how "contrib" sources
within git.git should be organized.

That discussion started with my [3], was followed by a WIP patch[4] to
implement the approach being finished up here, which prompted the
"[Discussion] The architecture of Scalar (and others) within Git"
thread[4]. See also the large earlier discussion hanging off [4]. An
earlier version of this change was proposed at [6].

Part of the reason for sticking the new command in "contrib/scalar/"
was to implicitly make it clear from the paths that it was
different. I do think that would be a worthwhile goal in the abstract.

But given the build simplifications we can attain by moving it to the
top level that we should seek to resolve that ambiguity in the minds
of any potential git.git code maintainers in some other way.

To do that we now have a new 'OPTIONAL CONTRIB COMMANDS' section in
"git help git" explaining our backwards and forwards compatibility
non-promises when it comes to this and similar future commands. Our
users are the ones most likely to be confused about why their git
package has installed a "/usr/bin/scalar" that seemingly duplicates
parts of git's own functionality. We're much better off by
cross-linking our documentation, and mentioning the state of scalar in
git's own documentation, along with the full list of porcelain and
plumbing utilities.

Commentary on changes in specific sub-components:

A.: The tests now live in "t/t7990-scalar.sh" (per the naming guide in
    t/README).

    Previously it had to be manually tested by cd-ing to
    contrib/scalar and running "make test", and it would not benefit
    from the combination of our various CI targets.

B.: The "Documentation/cmd-list.perl" change is needed because that
    command wasn't capable of understanding commands in the
    command-list.txt whose name didn't start with "git".

    If we don't make this change we won't cross-link to "scalar(1)"
    from "OPTIONAL CONTRIB COMMANDS" in "git(1)".

C. We'll always mention scalar in "OPTIONAL CONTRIB COMMANDS" in
   "git(1)", but the "scalar(1)" manpage itself depends on whether we
   build with "INSTALL_SCALAR=Y".

D.: We'll unconditionally build scalar's documentation, and it will be
    linted along with the rest, including checking for broken links to
    other documentation.

    The minor change to scalar.txt here is needed due to the lint
    check added in cafd9828e89 (doc lint: lint and fix missing "GIT"
    end sections, 2021-04-09), perhaps we should have a different end
    blurb for this command, but for now let's make it consistent with
    the rest.

    When installed (see below) this command is part of the git suite,
    so the end blurb should say something to that effect.

E.: "make install" will now install the "scalar" binary, but only if
    "INSTALL_SCALAR" is defined.

    Relative to our $(prefix) we'll now have (this is with
    INSTALL_SYMLINKS=Y):

        libexec/git-core/scalar: symbolic link to ../../bin/scalar
        bin/scalar: ELF 64-bit LSB pie executable,

    Putting it into libexec isn't strictly necessary, but as we do it
    with "git" we do that by default, and this will ensure that anyone
    who relies on their path being "$(git --exec-path)" will also be
    able to find "scalar".

    Perhaps we shouldn't put it in "libexec" at all, but for now let's
    just follow the herd.

F.: Likewise "make install-man install-doc install-html" works, and
    will install "scalar" documentation if "INSTALL_SCALAR" is
    defined.

    We'll install these files with those targets (and correctly split
    them by target, e.g. only scalar.1 with "install-man"):

        share/doc/git-doc/scalar.txt: ASCII text
        share/doc/git-doc/scalar.html: XML 1.0 document, ASCII text, with CRLF line terminators
        share/man/man1/scalar.1: troff or preprocessor input, ASCII text, with very long lines

== Fixed ==

G.: The dependency graph of contrib/scalar/Makefile was broken when it
    came to scalar.o, it only depended on ../../libgit.a. So it was a
    requirement to run the top-level Makefile first to get around some
    of its dependency issues:

        make && make -C contrib/scalar

H.: By having the top-level Makefile build scalar.o it'll work as well
    as any other git code, including benefiting from
    COMPUTE_HEADER_DEPENDENCIES.

    Targets such as (and possibly others):

        - "make tags TAGS cscope"
        - "make coccicheck"
	- "make check-docs"

    Wouldn't consider contrib/scalar at all, some of those would have
    been fixable, but as shown in the rest of this patch it's easier
    just to have scalar built like any other program instead.

1. https://lore.kernel.org/git/220602.86ee07z6qb.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet/
3. https://lore.kernel.org/git/87czpuxbwp.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/
5. https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/
6: https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                                    |  1 +
 Documentation/Makefile                        |  4 +
 Documentation/cmd-list.perl                   |  2 +-
 Documentation/git.txt                         | 12 +++
 {contrib/scalar => Documentation}/scalar.txt  |  4 +-
 Makefile                                      | 57 +++++++++----
 command-list.txt                              |  2 +
 contrib/buildsystems/CMakeLists.txt           | 15 +++-
 contrib/scalar/.gitignore                     |  2 -
 contrib/scalar/Makefile                       | 35 --------
 contrib/scalar/t/Makefile                     | 81 -------------------
 contrib/scalar/scalar.c => scalar.c           |  0
 .../t/t9099-scalar.sh => t/t7990-scalar.sh    |  8 +-
 13 files changed, 79 insertions(+), 144 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (99%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (100%)
 rename contrib/scalar/t/t9099-scalar.sh => t/t7990-scalar.sh (96%)

diff --git a/.gitignore b/.gitignore
index a4522157641..b06d0923ade 100644
--- a/.gitignore
+++ b/.gitignore
@@ -219,6 +219,7 @@
 /configure
 /.vscode/
 /tags
+/scalar
 /TAGS
 /cscope*
 /compile_commands.json
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f2e7fc1daa5..10fff5976af 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,6 +21,9 @@ MAN1_TXT += $(filter-out \
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
+ifndef NO_INSTALL_SCALAR_DOC
+MAN1_TXT += scalar.txt
+endif
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
@@ -284,6 +287,7 @@ endif
 cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
 	cmds-mainporcelain.txt \
+	cmds-optionalcontrib.txt \
 	cmds-plumbinginterrogators.txt \
 	cmds-plumbingmanipulators.txt \
 	cmds-synchingrepositories.txt \
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index af5da45d287..0f4b1b23cfe 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -10,7 +10,7 @@ sub format_one {
 	$state = 0;
 	open I, '<', "$name.txt" or die "No such file $name.txt";
 	while (<I>) {
-		if (/^git[a-z0-9-]*\(([0-9])\)$/) {
+		if (/^[a-z0-9-]*\(([0-9])\)$/) {
 			$mansection = $1;
 			next;
 		}
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 302607a4967..10c1979396b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -339,6 +339,18 @@ The following documentation pages are guides about Git concepts.
 
 include::cmds-guide.txt[]
 
+Optional contrib commands
+-------------------------
+
+The following commands are included with the git sources, but may not
+be present in your installation.
+
+These should be considered "contrib"-level when it comes to
+maintenance and stability promises. They might not even be included in
+your installation, and may either drastically change in the future, or
+go away entirely.
+
+include::cmds-optionalcontrib.txt[]
 
 Configuration Mechanism
 -----------------------
diff --git a/contrib/scalar/scalar.txt b/Documentation/scalar.txt
similarity index 99%
rename from contrib/scalar/scalar.txt
rename to Documentation/scalar.txt
index c0425e06533..b11e9eecf21 100644
--- a/contrib/scalar/scalar.txt
+++ b/Documentation/scalar.txt
@@ -162,6 +162,6 @@ SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
 
-Scalar
+GIT
 ---
-Associated with the linkgit:git[1] suite
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..28294cd3626 100644
--- a/Makefile
+++ b/Makefile
@@ -469,6 +469,11 @@ include shared.mak
 # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
 # if your $(INSTALL) command supports the option.
 #
+# Define INSTALL_SCALAR if you would like to install the optional
+# "scalar" command. This command is considered "contrib"-level, see
+# 'Optional "contrib" commands' in the built (with "make man") git(1)
+# manual page.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -602,6 +607,7 @@ GIT_OBJS =
 LIB_OBJS =
 OBJECTS =
 PROGRAM_OBJS =
+OTHER_PROGRAMS =
 PROGRAMS =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
@@ -812,7 +818,8 @@ BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build but not install in gitexecdir
-OTHER_PROGRAMS = git$X
+OTHER_PROGRAMS += git$X
+OTHER_PROGRAMS += scalar$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
@@ -821,6 +828,18 @@ BINDIR_PROGRAMS_NEED_X += git-shell
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
+# Sometimes we only have a test wrapper, but not a program to
+# install. This isn't so pretty, and we could refactor the
+# bin-wrappers/% and install code to make it unnecessary.
+ifdef INSTALL_SCALAR
+PROGRAMS += scalar$X
+BINDIR_PROGRAMS_NEED_X += scalar
+endif
+TEST_BINDIR_PROGRAMS_NEED_X = $(BINDIR_PROGRAMS_NEED_X)
+ifndef INSTALL_SCALAR
+TEST_BINDIR_PROGRAMS_NEED_X += scalar
+endif
+
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
 # Set paths to tools early so that they can be used for version tests.
@@ -2543,7 +2562,7 @@ ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
 
-SCALAR_SOURCES := contrib/scalar/scalar.c
+SCALAR_SOURCES := scalar.c
 SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
 OBJECTS += $(SCALAR_OBJECTS)
 
@@ -2678,7 +2697,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
+scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -3041,15 +3060,18 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+test_bindir_programs := $(patsubst %,bin-wrappers/%,$(TEST_BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
+# Substitution that's only done on programs named git-* in
+# bin-wrappers/*
+GIT_TEST_BINDIR_PROGRAMS_NEED_X = $(filter-out scalar,$(TEST_BINDIR_PROGRAMS_NEED_X))
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(GIT_TEST_BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -3281,11 +3303,18 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
+# We must not "export" this as e.g. "check-docs" needs to know about
+# scalar.txt. We only exclude scalar.txt for the "install-*" targets.
+NO_INSTALL_SCALAR_DOC =
+ifndef INSTALL_SCALAR
+NO_INSTALL_SCALAR_DOC = NoScalarPlease
+endif
+
 install-doc: install-man-perl
-	$(MAKE) -C Documentation install
+	$(MAKE) -C Documentation install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 install-man: install-man-perl
-	$(MAKE) -C Documentation install-man
+	$(MAKE) -C Documentation install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 install-man-perl: man-perl
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
@@ -3293,22 +3322,22 @@ install-man-perl: man-perl
 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
 
 install-html:
-	$(MAKE) -C Documentation install-html
+	$(MAKE) -C Documentation install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 install-info:
-	$(MAKE) -C Documentation install-info
+	$(MAKE) -C Documentation install-info NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 install-pdf:
-	$(MAKE) -C Documentation install-pdf
+	$(MAKE) -C Documentation install-pdf NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 quick-install-doc:
-	$(MAKE) -C Documentation quick-install
+	$(MAKE) -C Documentation quick-install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 quick-install-man:
-	$(MAKE) -C Documentation quick-install-man
+	$(MAKE) -C Documentation quick-install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 quick-install-html:
-	$(MAKE) -C Documentation quick-install-html
+	$(MAKE) -C Documentation quick-install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
 
 
 
@@ -3497,7 +3526,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS) scalar) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
diff --git a/command-list.txt b/command-list.txt
index 9bd6f3c48f4..721f968b3d1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -16,6 +16,7 @@
 #   synchingrepositories
 #   synchelpers
 #   purehelpers
+#   optionalcontrib
 #
 # The type names are self explanatory. But if you want to see what
 # command belongs to what group to get a better picture, have a look
@@ -215,3 +216,4 @@ gittutorial                             guide
 gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
+scalar                                  optionalcontrib
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1b23f2440d8..3de83f7f454 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -610,7 +610,8 @@ unset(CMAKE_REQUIRED_INCLUDES)
 #programs
 set(PROGRAMS_BUILT
 	git git-daemon git-http-backend git-sh-i18n--envsubst
-	git-shell)
+	git-shell
+	scalar)
 
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
@@ -745,6 +746,9 @@ list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
 target_link_libraries(git common-main)
 
+add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
+target_link_libraries(scalar common-main)
+
 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
@@ -902,10 +906,16 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 
 #install
+option(INSTALL_SCALAR "Install the optional 'scalar' contrib command")
 foreach(program ${PROGRAMS_BUILT})
 if(program STREQUAL "git" OR program STREQUAL "git-shell")
 install(TARGETS ${program}
 	RUNTIME DESTINATION bin)
+elseif(program STREQUAL "scalar")
+if(INSTALL_SCALAR)
+install(TARGETS ${program}
+	RUNTIME DESTINATION bin)
+endif()
 else()
 install(TARGETS ${program}
 	RUNTIME DESTINATION libexec/git-core)
@@ -977,7 +987,8 @@ endif()
 
 #wrapper scripts
 set(wrapper_scripts
-	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
+	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext
+	scalar)
 
 set(wrapper_test_scripts
 	test-fake-ssh test-tool)
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
deleted file mode 100644
index ff3d47e84d0..00000000000
--- a/contrib/scalar/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/*.exe
-/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
deleted file mode 100644
index 37f283f35d7..00000000000
--- a/contrib/scalar/Makefile
+++ /dev/null
@@ -1,35 +0,0 @@
-# The default target of this Makefile is...
-all::
-
-# Import tree-wide shared Makefile behavior and libraries
-include ../../shared.mak
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
-TARGETS = scalar$(X) scalar.o
-GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
-
-all:: scalar$(X) ../../bin-wrappers/scalar
-
-$(GITLIBS):
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
-
-$(TARGETS): $(GITLIBS) scalar.c
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
-
-clean:
-	$(RM) $(TARGETS) ../../bin-wrappers/scalar
-
-../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
-	@mkdir -p ../../bin-wrappers
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell cd ../.. && pwd)|' \
-	     -e 's|@@PROG@@|contrib/scalar/scalar$(X)|' < $< > $@ && \
-	chmod +x $@
-
-test: all
-	$(MAKE) -C t
-
-.PHONY: $(GITLIBS) all clean test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
deleted file mode 100644
index 01e82e56d15..00000000000
--- a/contrib/scalar/t/Makefile
+++ /dev/null
@@ -1,81 +0,0 @@
-# Import tree-wide shared Makefile behavior and libraries
-include ../../../shared.mak
-
-# Run scalar tests
-#
-# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
-#
-
--include ../../../config.mak.autogen
--include ../../../config.mak
-
-SHELL_PATH ?= $(SHELL)
-PERL_PATH ?= /usr/bin/perl
-RM ?= rm -f
-PROVE ?= prove
-DEFAULT_TEST_TARGET ?= test
-TEST_LINT ?= test-lint
-
-ifdef TEST_OUTPUT_DIRECTORY
-TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-else
-TEST_RESULTS_DIRECTORY = ../../../t/test-results
-endif
-
-# Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-
-T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-
-all: $(DEFAULT_TEST_TARGET)
-
-test: $(TEST_LINT)
-	$(MAKE) aggregate-results-and-cleanup
-
-prove: $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
-	$(MAKE) clean-except-prove-cache
-
-$(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
-
-clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
-	$(RM) -r valgrind/bin
-
-clean: clean-except-prove-cache
-	$(RM) .prove
-
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
-
-test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
-		test -z "$$dups" || { \
-		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
-
-test-lint-executable:
-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
-		test -z "$$bad" || { \
-		echo >&2 "non-executable tests:" $$bad; exit 1; }
-
-test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
-
-aggregate-results-and-cleanup: $(T)
-	$(MAKE) aggregate-results
-	$(MAKE) clean
-
-aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
-
-valgrind:
-	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
-
-test-results:
-	mkdir -p test-results
-
-.PHONY: $(T) aggregate-results clean valgrind
diff --git a/contrib/scalar/scalar.c b/scalar.c
similarity index 100%
rename from contrib/scalar/scalar.c
rename to scalar.c
diff --git a/contrib/scalar/t/t9099-scalar.sh b/t/t7990-scalar.sh
similarity index 96%
rename from contrib/scalar/t/t9099-scalar.sh
rename to t/t7990-scalar.sh
index 10b1172a8aa..897c8e760ef 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/t/t7990-scalar.sh
@@ -2,13 +2,7 @@
 
 test_description='test the `scalar` command'
 
-TEST_DIRECTORY=$PWD/../../../t
-export TEST_DIRECTORY
-
-# Make it work with --no-bin-wrappers
-PATH=$PWD/..:$PATH
-
-. ../../../t/test-lib.sh
+. ./test-lib.sh
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
-- 
2.36.1.1239.gfba91521d90

