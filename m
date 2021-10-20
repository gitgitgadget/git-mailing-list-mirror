Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C46C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6B7610E7
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhJTSma (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJTSm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67727C061753
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so129378wrb.8
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRF8kM5tAvtcHtLYZnEEbjkfdP3gG9YkQE+erjeLxWM=;
        b=FKYbum7i+cQ8FxxRlRbcPR0NlETBiK3meE2xHDpQHqUosWRn1BX9sZVHt3AShbqxm3
         zwf/W16M2j23SVwMTBcPEPe1n9kw0xHtfKQjSg1VbKWZSOaK7u/U58AHpYLCjkyUcw13
         ZlnK4/5dZ5UAFfe1bUXCGbx3hSJbKG2/dG9N/F8BNKSxPKV9dD8wGH1qw0OmHZSGpVLG
         WUQMUMSbKCmO8sZRimUfdJEB6FZDEpW7qc+L3gNqzXOyTxYYhxOzcAhZwcNyBnRBjk38
         voaC329TZRrhveV/W+ZqTHChbcKvSojacqhp16PPIrbslAstFIYoWTfTwmIALbJY1dS1
         juVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRF8kM5tAvtcHtLYZnEEbjkfdP3gG9YkQE+erjeLxWM=;
        b=UPdApYbHV2e6bNVZqO/e1gWh5u3ZfRUvHPQ1vE7eSKM1BhL74Vx8maQvEn6adQrZZ4
         CrPgfKNgBOJ/eGGMRIQxY4yTEsU+gQSBmQaeZCX/4yDiyJyNzZTMHPAxGz9p3UXKn/eL
         tjhkE+mfaPSfjtGO9D4tXERb7oLame+xaz8yqHlgf+i7R1O0vfPxH+5ke234RceHWgIK
         Xt+aw1EkKmhiZ3qwnsuhrpdSaQVfn12/RYLxayoF+/RrGY615kSW8dhbchLmzY2iAIBU
         N3AEcNM0Hub2SOOi/okp2xhQ1xV5Oay9Dfp9H0CZMphvcRILrdcMbbc9AQ72BKJH2DE2
         Z/9g==
X-Gm-Message-State: AOAM532OSR84F7J9hDO4aDIcqzwe+7YjuVS6z8DF8sEhkyf07eKHRJe9
        9tAsT+RuogkLU+wJh40edIVkpCfP4ZYzRA==
X-Google-Smtp-Source: ABdhPJxie4VZLwmvF42UNzokZjj62G9fk+DzInOuxxjKor7tQRifrggKWJ7fTggHh5E2mqj5Y3azKQ==
X-Received: by 2002:adf:f902:: with SMTP id b2mr1099353wrr.265.1634755209619;
        Wed, 20 Oct 2021 11:40:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] Makefile: stop having command-list.h depend on a wildcard
Date:   Wed, 20 Oct 2021 20:39:58 +0200
Message-Id: <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the dependency graph for "command-list.h" so that it's not
re-built in its entirety every time one file in Documentation/git*.txt
changes. This makes the generation of the command-list.h use a pattern
similar to that established in 8650c6298c1 (doc lint: make "lint-docs"
non-.PHONY, 2021-10-15) for the "lint-docs" target.

This change replaces the monolithic "generate-cmdlist.sh" invocation
with a dependency chain like:

    Documentation/git-add.txt ->
    .build/command-list.h.d/git-add.gen (and "git-add.txt" intermediary) ->
    command-list.h

I.e. we'll now generate intermediary files when extracting the "NAME"
section the documentation. Here the 6th line of
"Documentation/git.txt" will be extracted to
".build/command-list.h.d/git-add.gen.txt":

    git-add - Add file contents to the index

We'll then create an intermediate
".build/command-list.h.d/git-add.gen" (leading "\t" stripped):

    ./generate-cmdlist.sh --entry-only .build/command-list.h.d/git-add.gen.txt
    { "git-add", N_("Add file contents to the index"), 0 | CAT_mainporcelain | CAT_worktree },

The "command-list.h" itself can the be made by having
"generate-cmdlist.sh" emit only the header section, followed by:

    LC_ALL=sort .build/command-list.h.d/*.gen

Unfortunately we can't drop the old code completely due to the CMake
integration, see 061c2240b1b (Introduce CMake support for configuring
Git, 2020-06-12). It will keep using the older and slower script.

With this the initial creation of the command-list.h is a bit slower
with -j1, but around 2x as fast -j8[1]. The real benefit comes from
the more common case of an incremental build, say when only
"Documentation/git-add.txt" was updated after a "pull". There we're
4-5x as fast with this new method[2].

The benefit of optimizing this is because this file is very frequently
re-generated, e.g. for "git rebase -i --exec 'make git'" with
"git-add.txt" modified we're around 1.7 times as fast[3]. That target
will need to re-make "git" (via "help.o") due to help.c's use of
command-list.h.

In terms of implementation: I'm adding $(QUIET) while I'm at it, which
is here so we don't quiet the equivalent of trace output under V=1,
this could be used in other places that use "@cmd" to quiet "cmd"
output.

Some of the dependencies between "command-list.h" and
"$(COMMAND_LIST_GEN)" are redundant, considering that the former
depends on the latter. I'm sticking to listing dependencies mentioned
in the rule itself, e.g. "command-list.h" itself calls
"generate-cmdlist.sh", so I list the dependency even though it would
get it via a recursive dependency.

These rules can be lazy about leaving behind files on error thanks to
the .DELETE_ON_ERROR flag, see 7b76d6bf221 (Makefile: add and use the
".DELETE_ON_ERROR" flag, 2021-06-29), or in the case of the
"*.txt.gen" files because we'll unconditionally clobber them anyway if
the relevant source file is touched, so we can leave them for "make
clean".

1. Piped through: <cmd> 2>/dev/null | grep -P -v "^\s*$"; ditto below:
   hyperfine -s basic -L j ", -j8" -L s ,.old -p 'rm -rf .build command-list.h' 'make{j} -f Makefile{s} command-list.h'
   Benchmark #1: make -f Makefile command-list.h
     Time (mean ± σ):     769.3 ms ±  90.4 ms    [User: 892.4 ms, System: 98.8 ms]
     Range (min … max):   665.6 ms … 941.9 ms    10 runs
   Benchmark #2: make -j8 -f Makefile command-list.h
     Time (mean ± σ):     212.5 ms ±  45.0 ms    [User: 954.4 ms, System: 136.9 ms]
     Range (min … max):   187.6 ms … 326.2 ms    11 runs
   Benchmark #3: make -f Makefile.old command-list.h
     Time (mean ± σ):     515.0 ms ±  70.5 ms    [User: 613.8 ms, System: 110.9 ms]
     Range (min … max):   407.6 ms … 603.9 ms    10 runs
   Benchmark #4: make -j8 -f Makefile.old command-list.h
     Time (mean ± σ):     474.9 ms ±  62.7 ms    [User: 569.7 ms, System: 106.0 ms]
     Range (min … max):   407.0 ms … 556.8 ms    10 runs
   Summary
     'make -j8 -f Makefile command-list.h' ran
       2.24 ± 0.56 times faster than 'make -j8 -f Makefile.old command-list.h'
       2.42 ± 0.61 times faster than 'make -f Makefile.old command-list.h'
       3.62 ± 0.88 times faster than 'make -f Makefile command-list.h'
2. hyperfine -s basic -L j ", -j8" -L s ,.old -p 'touch Documentation/git-add.txt' 'make{j} -f Makefile{s} command-list.h'
   Benchmark #1: make -f Makefile command-list.h
     Time (mean ± σ):      94.6 ms ±  26.7 ms    [User: 83.0 ms, System: 14.1 ms]
     Range (min … max):    79.4 ms … 186.0 ms    15 runs
   Benchmark #2: make -j8 -f Makefile command-list.h
     Time (mean ± σ):      80.3 ms ±  10.5 ms    [User: 81.3 ms, System: 12.9 ms]
     Range (min … max):    76.9 ms … 127.6 ms    37 runs
   Benchmark #3: make -f Makefile.old command-list.h
     Time (mean ± σ):     348.9 ms ± 174.5 ms    [User: 415.3 ms, System: 70.6 ms]
     Range (min … max):    66.0 ms … 550.3 ms    43 runs
   Benchmark #4: make -j8 -f Makefile.old command-list.h
     Time (mean ± σ):     406.7 ms ± 157.1 ms    [User: 473.4 ms, System: 78.3 ms]
     Range (min … max):    67.4 ms … 560.4 ms    34 runs
   Summary
     'make -j8 -f Makefile command-list.h' ran
       1.18 ± 0.37 times faster than 'make -f Makefile command-list.h'
       4.34 ± 2.25 times faster than 'make -f Makefile.old command-list.h'
       5.07 ± 2.07 times faster than 'make -j8 -f Makefile.old command-list.h'
3. hyperfine -s basic -L j " -j8" -L s ,.old -p 'touch Documentation/git-add.txt' 'make{j} -f Makefile{s} git'
   Benchmark #1: make -j8 -f Makefile git
     Time (mean ± σ):     484.2 ms ±  53.5 ms    [User: 253.2 ms, System: 83.5 ms]
     Range (min … max):   400.7 ms … 580.5 ms    10 runs
   Benchmark #2: make -j8 -f Makefile.old git
     Time (mean ± σ):     836.7 ms ±  37.3 ms    [User: 729.2 ms, System: 157.1 ms]
     Range (min … max):   774.2 ms … 885.6 ms    10 runs
   Summary
     'make -j8 -f Makefile git' ran
       1.73 ± 0.21 times faster than 'make -j8 -f Makefile.old git'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore          |  1 +
 Makefile            | 52 +++++++++++++++++++++++++++++++++++++++------
 generate-cmdlist.sh | 36 +++++++++++++++++++++++++------
 3 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 054249b20a8..dc03a988b16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,6 +198,7 @@
 *.[aos]
 *.o.json
 *.py[co]
+.build/
 .depend/
 *.gcda
 *.gcno
diff --git a/Makefile b/Makefile
index 381bed2c1d2..ce4cce57eb8 100644
--- a/Makefile
+++ b/Makefile
@@ -1954,6 +1954,7 @@ endif
 
 ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
+	QUIET          = @
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
@@ -2242,12 +2243,50 @@ config-list.h: generate-configlist.sh
 config-list.h: Documentation/*config.txt Documentation/config/*.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@
 
-command-list.h: generate-cmdlist.sh command-list.txt
-
-command-list.h: $(wildcard Documentation/git*.txt)
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
-		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@
+EXCLUDED_COMMAND_LIST =
+EXCLUDED_COMMAND_LIST += git
+EXCLUDED_COMMAND_LIST += git-bisect-lk2009
+EXCLUDED_COMMAND_LIST += git-credential-cache--daemon
+EXCLUDED_COMMAND_LIST += git-fsck-objects
+EXCLUDED_COMMAND_LIST += git-init-db
+EXCLUDED_COMMAND_LIST += git-mergetool--lib
+EXCLUDED_COMMAND_LIST += git-remote-ext
+EXCLUDED_COMMAND_LIST += git-remote-fd
+EXCLUDED_COMMAND_LIST += git-sh-i18n--envsubst
+EXCLUDED_COMMAND_LIST += git-submodules
+EXCLUDED_COMMAND_LIST += git-tools
+EXCLUDED_COMMAND_LIST += git-version
+EXCLUDED_COMMAND_LIST += git-web--browse
+EXCLUDED_COMMAND_LIST += gitweb.conf
+
+EXCLUDED_TXT += $(patsubst %,Documentation/%.txt,$(EXCLUDED_PROGRAMS) $(EXCLUDED_COMMAND_LIST))
+COMMAND_LIST_TXT_DEP = $(filter-out $(EXCLUDED_TXT), $(wildcard Documentation/git*.txt))
+
+COMMAND_LIST_GEN = $(patsubst Documentation/%.txt,.build/command-list.h.d/%.gen,$(COMMAND_LIST_TXT_DEP))
+
+.build:
+	$(QUIET)mkdir .build
+.build/command-list.h.d: | .build
+	$(QUIET)mkdir -p .build/command-list.h.d
+
+# We must depend on .build/command-list.h as an "order-only"
+# prerequisite, its mtime will change when these targets run.
+$(COMMAND_LIST_GEN): | .build/command-list.h.d
+$(COMMAND_LIST_GEN): command-list.txt
+$(COMMAND_LIST_GEN): generate-cmdlist.sh
+$(COMMAND_LIST_GEN): .build/command-list.h.d/%.gen: Documentation/%.txt
+	$(QUIET)grep "^$(patsubst .build/command-list.h.d/%.gen,%,$@) " command-list.txt >$@.txt && \
+	./generate-cmdlist.sh --entry-only $@.txt >$@
+
+command-list.h: $(COMMAND_LIST_GEN)
+command-list.h: generate-cmdlist.sh
+command-list.h: command-list.txt
+	$(QUIET_GEN){ \
+		$(SHELL_PATH) ./generate-cmdlist.sh --header-only command-list.txt && \
+		echo "static struct cmdname_help command_list[] = {" && \
+		LC_ALL=C sort $(COMMAND_LIST_GEN) && \
+		echo "};"; \
+	} >$@
 
 hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
@@ -3238,6 +3277,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) -r .build/
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a1ab2b1f077..2bc528e8cae 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -15,7 +15,7 @@ get_category_line () {
 }
 
 category_list () {
-	command_list "$1" |
+	grep -v '^#' "$1" |
 	cut -c 40- |
 	tr ' ' '\012' |
 	grep -v '^$' |
@@ -23,13 +23,14 @@ category_list () {
 }
 
 get_synopsis () {
+	head -n 10 "Documentation/$1.txt" |
 	sed -n '
 		/^NAME/,/'"$1"'/H
 		${
 			x
 			s/.*'"$1"' - \(.*\)/N_("\1")/
 			p
-		}' "Documentation/$1.txt"
+		}'
 }
 
 define_categories () {
@@ -61,16 +62,12 @@ define_category_names () {
 }
 
 print_command_list () {
-	echo "static struct cmdname_help command_list[] = {"
-
-	command_list "$1" |
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
 		printf " | CAT_%s" $(echo "$rest" | get_category_line)
 		echo " },"
 	done
-	echo "};"
 }
 
 exclude_programs=
@@ -81,6 +78,19 @@ do
 	shift
 done
 
+header_only=
+case $1 in
+--entry-only)
+	shift
+	print_command_list $1 <"$1"
+	exit 0
+	;;
+--header-only)
+	shift
+	header_only=t
+	;;
+esac
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
@@ -92,4 +102,18 @@ define_categories "$1"
 echo
 define_category_names "$1"
 echo
+
+if test -n "$header_only"
+then
+	exit 0
+fi
+
+# The old compatibility mode for CMmake. See 061c2240b1b (Introduce
+# CMake support for configuring Git, 2020-06-12)
+echo "static struct cmdname_help command_list[] = {"
+grep -v \
+	-e '^#' \
+	-e '^git-fsck-objects ' \
+	"$1" |
 print_command_list "$1"
+echo "};"
-- 
2.33.1.1338.g20da966911a

