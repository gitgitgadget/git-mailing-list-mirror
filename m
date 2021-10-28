Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20539C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C8F60232
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1S77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJ1S76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CCC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:57:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1843358wme.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUGZOvsdokC2rvMc37vKpf2P6pbXxq8gNLoq06V4cS8=;
        b=EqY9M6+wnxIKyYEx1ZBoaB69xF/Yfo01XIjexVOAGlrxGUIGQ0TpReFxoamAmaXlZ7
         Ko1MRtfYk/6HQXpJAwV+Cf2u/DcEZuXJc2Z4TWW58s0exBaAOvqshgd1LL9W3o0Vx2aH
         gCw4hMq15rdFptJWsr1yrdOX8ltd/YXR875aR0XTw9jmWhQGABc9U+PBoa+X3SLnAJB1
         pzU8IMpZGx8sSP0tFtocgeQIHodRn4Y2S4Y1LMBIajfMwUnyS9cVUxoXBoLREIFaScOA
         CD3LH9FDyriDHpS3ptlE40t3IDhOEB3f8wLUww6u/MMJB69WcyvEV5qfzErwCbf/AXd9
         yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUGZOvsdokC2rvMc37vKpf2P6pbXxq8gNLoq06V4cS8=;
        b=evfoavr9iv8IKCPbI3A7FzRY58/wPvXlqQRKRIu70OAD6SomN87CYv8n4OfZ5/BOO3
         VTmJ+glheyg/SrKMM01IR6xRS42rzWe/Y7Mt6laZvhM/gXsiyRjnm0uxnVWzXrZ4ko8y
         TAWGzRCNoQwE7B7/AgM2WK2pT1dWcchOHTwPLvXflJVGHi4VYXhlBzwYyiMIg0QC78Di
         0+eXFR1gxOK56kAh54cGlbncdeBT7TtWZQ9XTmwq1WHKxYgTiZn0K1yL03fWc8O+g7GI
         gz4HPZy/+7++sKo+Rz0Gyb+OBLaPxJzAmw2i5k18Wy10Oi9uM7V7Pg0j74o9hfAjLEbN
         qwmQ==
X-Gm-Message-State: AOAM530ATH2DehRmyFVWTc0z00fsAVk0FPgZG2HdlG69YEdrfXgpx3bh
        4DagajQfs1TmVpNXYAQvKBHNQSiP89EU+w==
X-Google-Smtp-Source: ABdhPJy1FU2pEYSspQ2oiI6jRXw9cfaMM9XPolK6foxC78+VQTt5DtiQYaqZ0yIVwQOlHyCMB/orUg==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr6345640wmq.79.1635447448873;
        Thu, 28 Oct 2021 11:57:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm3670605wrc.56.2021.10.28.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:57:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, "Theodore T ." <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] contrib: build & test scalar by default, optionally install
Date:   Thu, 28 Oct 2021 20:56:06 +0200
Message-Id: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1572.g4991fc4c1bd
In-Reply-To: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change how the newly proposed "scalar" command is handle, this builds
on top of the proposed patches that add it along with documentation
and tests to the "contrib/scalar/" directory[1].

With those patches we unconditionally build scalar.o and link it to
libgit.a, but don't build the "scalar" binary itself, and don't run
its tests as part of our normal test suite run or CI.

As the changes to "t/t9099-scalar.sh" here shows that sort of
arrangement leads to breakages. I.e. the scalar tests would fail on
OSX, which our OSX CI jobs will catch, but only if we run the
tests. Let's add a prerequisite to test that, which requires moving
around some of the setup code.

I think that for a libgit.a-using "scalar" in particular, and for
"contrib" in general we're better off by not only compiling the object
in question, but also linking it, and running its tests by
default. What we won't do is install it by default, unless an
"INSTALL_SCALAR=Y" is provided along with "make install".

For context: There's been ongoing discussion about how this command
should be integrated in terms of the "closeness" of its integration,
and how "contrib" sources within git.git should be organized.

That discussion started with my [2], was followed by a WIP patch[3] to
implement the approach being finished up here, and has spawned the
"[Discussion] The architecture of Scalar (and others) within Git"
thread[4]. See also the large earlier discussion hanging off [3].

I really don't think it's important whether a given source file lives
in-tree at "contrib/scalar/scalar.c" or the top-level "scalar.c", but
as the diff below shows the latter approach is a smaller overall
change in our build system, due to how it's organized, more details on
that below under "Build changes".

I think that part of the reason for sticking the new command in
"contrib/scalar/" was to implicitly make it clear from the paths that
it was different. I do think that would be a worthwhile goal in the
abstract.

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

= Build changes =

This fixes dependency bugs in the previous "contrib/scalar/Makefile", as
well as implementing various missing bits of functionality, most
notably "make install" will now install the "scalar" command, but only
if INSTALL_SCALAR is defined.

Those and other changes and non-changes, categorized as "Same", "New"
and "Fixed" below:

== Same ==

A.: We'll unconditionally build scalar.o, as before it's in the
    $(OBJECTS) list.

B.: "make contrib/scalar/scalar.o" has the same dependency graph as
    before, but is now spelled "make scalar.o", more on the rename below.

== New ==

C.: We'll now unconditionally build and test the scalar command.
Before we'd only build scalar.o, but not link it.

    Its test lives in "t/t9099-scalar.sh" now (and take <1s to
    run). We should have test coverage of this in-tree command that's
    linking to libgit.a.

    Previously it had to be manually tested by cd-ing to
    contrib/scalar and running "make test", and it would not benefit
    from the combination of our various CI targets.

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

== Discussion and motivation ==

I've been fixing various dependency issues in git's Makefile
infrastructure recently, some of which has been integrated into
"master", some of which is currently under review on-list, and some of
which isn't submitted yet.

To the extent that we have build dependency issues and cases where we
can't build something in parallel it's usually because we're invoking
one Makefile from another. That's the case in most of our
sub-Makefiles, which will usually need to invoke or depend on
something created in the top-level Makefile.

None of {t,Documentation,template}/Makefile etc. are truly
independent, as looking at $(git grep -F '../' '*Makefile') will
reveal, and we'll sometimes need to duplicate logic between them
purely to get around them not being driven by one top-level Makefile
logic.

Much has been written on this topic, likely most notably the
"Recursive Make Considered Harmful" paper (full PDF link at [5]), and
to be fair, the there's also a well-known "Non-recursive Make
Considered Harmful" retort at [6]).

Theoretical opinions on the topic clearly differ. From a purely
practical perspective I ran into textual and semantic conflicts with
the "contrib/scalar/" work.

I think the diffstat of this patch demonstrates that this is a much
simpler approach, particularly considering that the code being
replaced didn't perform much of the needed integrations that are "new"
here. E.g. we now have "make install". The unsubmitted [7] (linked to
by [8]) shows the boilerplate we'd need for that with the alternate
approach.

It would be more pleasing to not have to hardcode "git" in the
pre-image and now "git" and "scalar" in the post-image in several
places. My initial WIP [3] looks better, but built on a set of
Makefile reorganization patches.

I'd like to not make those patches a dependency of this change, but
readers should rest assured that we're really not ending up with as
many "scalar" special-cases in the long term as this diff indicates,
most or all of those can all be generalized into Makefile refactoring
that teaches our build system to build N number of differently named
top-level commands.

1. https://lore.kernel.org/git/pull.1005.v6.git.1635323239.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/87czpuxbwp.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/
5. https://web.archive.org/web/20150330111905/http://miller.emu.id.au/pmiller/books/rmch/
6. https://www.microsoft.com/en-us/research/wp-content/uploads/2016/03/hadrian.pdf
7. https://github.com/dscho/git/commit/473ca8ae673
8. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Oct 27 2021, Derrick Stolee wrote:

> [...]
> All of what I say is up for debate. I would love for others to contribute
> options that I missed. I will send a reply to this message that summarizes
> all options that are recommended in this thread, along with some attempt
> to summarize any consensus that we might be approaching.

I figured working code was better than continuing discussion on-list
with reference to working code. As noted in the patch itself htis goes
on top of Johannes's v6 scalar patches. CI run at :
https://github.com/avar/git/actions/runs/1395993870

To the extent that the above commit message & below diff don't serve
as a reply I'll reply to your E-Mail seperately.

Thanks a lot for getting the ball rolling on this.

 .gitignore                                   |  1 +
 Documentation/Makefile                       |  4 +
 Documentation/cmd-list.perl                  |  2 +-
 Documentation/git.txt                        | 12 +++
 {contrib/scalar => Documentation}/scalar.txt |  4 +-
 Makefile                                     | 96 ++++++++++++++------
 command-list.txt                             |  2 +
 contrib/scalar/.gitignore                    |  5 -
 contrib/scalar/Makefile                      | 57 ------------
 contrib/scalar/t/Makefile                    | 78 ----------------
 contrib/scalar/scalar.c => scalar.c          |  0
 {contrib/scalar/t => t}/t9099-scalar.sh      | 42 ++++++---
 12 files changed, 115 insertions(+), 188 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (99%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (100%)
 rename {contrib/scalar/t => t}/t9099-scalar.sh (72%)

diff --git a/.gitignore b/.gitignore
index 054249b20a8..7f590115545 100644
--- a/.gitignore
+++ b/.gitignore
@@ -216,6 +216,7 @@
 /configure
 /.vscode/
 /tags
+/scalar
 /TAGS
 /cscope*
 /compile_commands.json
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 911b6bf79c5..c017619ad2a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -18,6 +18,9 @@ MAN1_TXT += $(filter-out \
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
+ifndef NO_INSTALL_SCALAR_DOC
+MAN1_TXT += scalar.txt
+endif
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
@@ -311,6 +314,7 @@ endif
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
index d63c65e67d8..d2b1280ff9d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -337,6 +337,18 @@ The following documentation pages are guides about Git concepts.
 
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
index cf4e5b889cc..197e9983a0f 100644
--- a/contrib/scalar/scalar.txt
+++ b/Documentation/scalar.txt
@@ -150,6 +150,6 @@ SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
 
-Scalar
+GIT
 ---
-Associated with the linkgit:git[1] suite
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 033a50a8b99..78da6c3661a 100644
--- a/Makefile
+++ b/Makefile
@@ -459,6 +459,11 @@ all::
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
@@ -579,8 +584,10 @@ GIT_OBJS =
 LIB_OBJS =
 OBJECTS =
 PROGRAM_OBJS =
+OTHER_PROGRAMS =
 PROGRAMS =
 EXCLUDED_PROGRAMS =
+SCALAR_OBJS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
 SCRIPT_SH =
@@ -784,7 +791,8 @@ BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build but not install in gitexecdir
-OTHER_PROGRAMS = git$X
+OTHER_PROGRAMS += git$X
+OTHER_PROGRAMS += scalar$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
@@ -793,6 +801,18 @@ BINDIR_PROGRAMS_NEED_X += git-shell
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
@@ -2210,9 +2230,13 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIBS)
+define top-level-cmd-rule
+$(1)$X: $(1).o GIT-LDFLAGS $$(GITLIBS) $(2)
+	$$(QUIET_LINK)$$(CC) $$(ALL_CFLAGS) -o $$@ $$(ALL_LDFLAGS) \
+		$$(filter %.o,$$^) $(LIBS)
+endef
+$(eval $(call top-level-cmd-rule,git,$(BUILTIN_OBJS)))
+$(eval $(call top-level-cmd-rule,scalar,))
 
 help.sp help.s help.o: command-list.h
 hook.sp hook.s hook.o: hook-list.h
@@ -2448,7 +2472,12 @@ GIT_OBJS += git.o
 .PHONY: git-objs
 git-objs: $(GIT_OBJS)
 
+SCALAR_OBJS += scalar.o
+.PHONY: scalar-objs
+scalar-objs: $(SCALAR_OBJS)
+
 OBJECTS += $(GIT_OBJS)
+OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
@@ -2457,10 +2486,6 @@ ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
 
-SCALAR_SOURCES := contrib/scalar/scalar.c
-SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
-OBJECTS += $(SCALAR_OBJECTS)
-
 .PHONY: objects
 objects: $(OBJECTS)
 
@@ -2594,10 +2619,6 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIBS)
-
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -2870,15 +2891,18 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+test_bindir_programs := $(patsubst %,bin-wrappers/%,$(TEST_BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
+# Substitution that's only done on programs named git-* in
+# bin-wrappers/*
+GIT_TEST_BINDIR_PROGRAMS_NEED_X = $(filter-out scalar,$(TEST_BINDIR_PROGRAMS_NEED_X))
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(GIT_TEST_BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -3113,25 +3137,26 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
-install-doc: install-man-perl
-	$(MAKE) -C Documentation install
-
-install-man: install-man-perl
-	$(MAKE) -C Documentation install-man
+ifdef INSTALL_SCALAR
+NO_INSTALL_SCALAR_DOC =
+else
+NO_INSTALL_SCALAR_DOC = NoScalarPlease
+endif
 
 install-man-perl: man-perl
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
 	(cd perl/build/man/man3 && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
 
-install-html:
-	$(MAKE) -C Documentation install-html
-
-install-info:
-	$(MAKE) -C Documentation install-info
-
-install-pdf:
-	$(MAKE) -C Documentation install-pdf
+define install-doc-rule
+$(1): $(3)
+	$$(MAKE) -C Documentation $(2) NO_INSTALL_SCALAR_DOC=$$(NO_INSTALL_SCALAR_DOC)
+endef
+$(eval $(call install-doc-rule,install-doc,install,install-man-perl))
+$(eval $(call install-doc-rule,install-man,install-man,install-man-perl))
+$(eval $(call install-doc-rule,install-html,install-html,))
+$(eval $(call install-doc-rule,install-info,install-info,))
+$(eval $(call install-doc-rule,install-pdf,install-pdf,))
 
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
@@ -3183,8 +3208,19 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
-artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
+# No scalar in "cmake" yet, and since 4c2c38e800f (ci: modification of
+# main.yml to use cmake for vs-build job, 2020-06-26) the "vs-build"
+# job has a hard dependency on it. Let's fail in the tests instead of
+# in the "vs-build" job itself.
+ifeq ($(wildcard scalar),scalar)
+ARCHIVE_OTHER_PROGRAMS = $(OTHER_PROGRAMS)
+ARCHIVE_TEST_BINDIR_PROGRAMS = $(test_bindir_programs)
+else
+ARCHIVE_OTHER_PROGRAMS = $(filter-out scalar%, $(OTHER_PROGRAMS))
+ARCHIVE_TEST_BINDIR_PROGRAMS = $(filter-out bin-wrappers/scalar,$(test_bindir_programs))
+endif
+artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(ARCHIVE_OTHER_PROGRAMS) \
+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(ARCHIVE_TEST_BINDIR_PROGRAMS) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
@@ -3327,7 +3363,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS) scalar) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6f..350f5aec074 100644
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
@@ -214,3 +215,4 @@ gitsubmodules                           guide
 gittutorial-2                           guide
 gittutorial                             guide
 gitworkflows                            guide
+scalar                                  optionalcontrib
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
deleted file mode 100644
index 00441073f59..00000000000
--- a/contrib/scalar/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-/*.xml
-/*.1
-/*.html
-/*.exe
-/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
deleted file mode 100644
index 44796572ef4..00000000000
--- a/contrib/scalar/Makefile
+++ /dev/null
@@ -1,57 +0,0 @@
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1  =
-
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
-ifndef V
-	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			 $(MAKE) $(PRINT_DIR) -C $$subdir
-	QUIET          = @
-else
-	export V
-endif
-endif
-
-all:
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
-TARGETS = scalar$(X) scalar.o
-GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
-
-all: scalar$(X) ../../bin-wrappers/scalar
-
-$(GITLIBS):
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
-
-$(TARGETS): $(GITLIBS) scalar.c
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
-
-clean:
-	$(RM) $(TARGETS) ../../bin-wrappers/scalar
-	$(RM) scalar.1 scalar.html scalar.xml
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
-docs: scalar.html scalar.1
-
-scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
-
-scalar.html scalar.1: scalar.txt
-	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/scalar/scalar.txt \
-		../contrib/scalar/$@
-	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
-
-.PHONY: $(GITLIBS) all clean docs test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
deleted file mode 100644
index 6170672bb37..00000000000
--- a/contrib/scalar/t/Makefile
+++ /dev/null
@@ -1,78 +0,0 @@
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
diff --git a/contrib/scalar/t/t9099-scalar.sh b/t/t9099-scalar.sh
similarity index 72%
rename from contrib/scalar/t/t9099-scalar.sh
rename to t/t9099-scalar.sh
index 7e8771d0eff..788695d857e 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/t/t9099-scalar.sh
@@ -2,13 +2,13 @@
 
 test_description='test the `scalar` command'
 
-TEST_DIRECTORY=$PWD/../../../t
-export TEST_DIRECTORY
+. ./test-lib.sh
 
-# Make it work with --no-bin-wrappers
-PATH=$PWD/..:$PATH
-
-. ../../../t/test-lib.sh
+if test_have_prereq WINDOWS && ! scalar list 2>/dev/null
+then
+	skip_all='the contrib cmake process does not build "scalar" yet'
+	test_done
+fi
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
 export GIT_TEST_MAINT_SCHEDULER
@@ -17,7 +17,23 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
-test_expect_success 'scalar unregister' '
+test_expect_success 'setup' '
+	test_commit first &&
+	test_commit second &&
+	test_commit third &&
+	git switch -c parallel first
+'
+
+test_lazy_prereq SCALAR_REGISTER '
+	git init test/src &&
+	scalar register test/src &&
+	scalar list >expect &&
+	scalar unregister test/src &&
+	(cd test/src && echo "$PWD") >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SCALAR_REGISTER 'scalar unregister' '
 	git init vanish/src &&
 	scalar register vanish/src &&
 	git config --get --global --fixed-value \
@@ -32,18 +48,14 @@ test_expect_success 'scalar unregister' '
 	! grep -F "$(pwd)/vanish/src" scalar.repos
 '
 
-test_expect_success 'set up repository to clone' '
-	test_commit first &&
-	test_commit second &&
-	test_commit third &&
-	git switch -c parallel first &&
+test_expect_success SCALAR_REGISTER 'set up repository to clone' '
 	mkdir -p 1/2 &&
 	test_commit 1/2/3 &&
 	git config uploadPack.allowFilter true &&
 	git config uploadPack.allowAnySHA1InWant true
 '
 
-test_expect_success 'scalar clone' '
+test_expect_success SCALAR_REGISTER 'scalar clone' '
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -65,7 +77,7 @@ test_expect_success 'scalar clone' '
 	)
 '
 
-test_expect_success 'scalar reconfigure' '
+test_expect_success SCALAR_REGISTER 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
 	git -C one/src config core.preloadIndex false &&
@@ -80,7 +92,7 @@ test_expect_success 'scalar delete without enlistment shows a usage' '
 	test_expect_code 129 scalar delete
 '
 
-test_expect_success 'scalar delete with enlistment' '
+test_expect_success SCALAR_REGISTER 'scalar delete with enlistment' '
 	scalar delete cloned &&
 	test_path_is_missing cloned
 '
-- 
2.33.1.1572.g4991fc4c1bd

