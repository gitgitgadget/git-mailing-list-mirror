Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB6EC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377730AbhK2Sat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbhK2S2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:28:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C110C12B681
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i12so14865501wmq.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKnGRdPqcHRQAj/qBQR0OmJJ6xQDyOEscqaB9zdg284=;
        b=Dp/WYnQJpb9Rr3tsNqH1UtzE7DOM0LigMtYnDwk9Ek0ngvuRo5igx8s7+lSmMKQ7du
         skD6497xY1A6otbFsj/pvz0wWUoh5nc8X5cDdBk9GX7hkJzP362jVrGB6JA2+lKpEuQP
         +xWj4VdLPcFn+qDtyalTzuJCBkW6qcARCBWIOU+OFenHI8Uie3oBVNDblHnco+JkEIIC
         oSUjqrLNqdCn1xouOu5J7G5uWjGNh3qwF1H79mnWcKpZA21zTRFYwbbkJ+xie5X9/FDB
         G0Pv/CpNraOylVV1i/lf0Srz4tEFAgHlNZMpfbdJTDrwMM+o/vkYBAdmXmfHnm0T5Dad
         ZmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKnGRdPqcHRQAj/qBQR0OmJJ6xQDyOEscqaB9zdg284=;
        b=m7+F8ZIbMriCXHeiye8TzM2mj2yRisLEmpGjKQexVKOX4QlY/v3jdo5WgK0beJBGHy
         WRo8O5IN5vJdh/GF4CoSIIOjQUXnjHDgVnSOnYKO2s37EIJtiZREKOZH7LlaSYfMyhVX
         qGJ2X8PaxNVkqp9aUvqoeCkx23NuSNyxflSuwTWzGXhlWAjPoYF6T4jMpTVlzEsxxT9Z
         Cu6q1t4LkC8S3QKiqwFi4gKbDzrkhBR8lHEsQIM6yvKvVeNAcjIdy2yph758sksl4f+F
         RzX3OQmuTfTlcmwleqL/zGF9AJcYXysO9br9pKrtf3LzBq1iQHUgOJbbNAdFqyn5lbcM
         z3jA==
X-Gm-Message-State: AOAM532R3y49O1B5h3I/E1wXNExjLdQfqm1yzDES3rCo+4ApxvxIaQtE
        5CXh3t2FE5ayJw5zViJnqTWsOqpOovXzxA==
X-Google-Smtp-Source: ABdhPJyaXx5JivqXO3PYg4UJkVgLDQADshkOQonkldNdeCzUdhmXE8Babt9RcQrIX1ArhcryvI43Hw==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr36759362wmm.83.1638197456494;
        Mon, 29 Nov 2021 06:50:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:50:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] grep: simplify & delete "init" & "config" code
Date:   Mon, 29 Nov 2021 15:50:46 +0100
Message-Id: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In v1 and v2[1] of this series more code in grep.c was deleted by
changing what I think is a really obscure interaction between
"grep.extendedRegexp=true" and "grep.patternType".

Junio preferred having a deprecation period[2], so here's a re-roll
that preserves all existing behavior, at the cost of bit less code
deletion & simplification (from "97 insertions(+), 174 deletions(-)"
to "106 insertions(+), 131 deletions(-)").

Notes on individual patches below. This re-roll should address all
outstanding feedback on v2.

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqk0hdqifg.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (7):
  grep.h: remove unused "regex_t regexp" from grep_opt

No change.

  log tests: check if grep_config() is called by "log"-like cmds

Simplified the test, and it no longer depends (optionally) PCRE. We
just test BRE v.s. ERE instead.

  grep tests: add missing "grep.patternType" config test

A new test to assert existing behavior, we had a blindspot in this
area (could have hidden a possible regression).

  built-ins: trust the "prefix" from run_builtin()

Substantially the same, but I made some edits as requested to minimize
the diff size / skip any cleanups-while-at it.

  grep.c: don't pass along NULL callback value

Trivial commit message typo fix.

  grep API: call grep_config() after grep_init()

Removed stray leftover WIP code (an unused "caller_priv" struct
member), oops.

  grep: simplify config parsing and option parsing

Mostly new, replaces the now-ejected two last commits of v2 that
changed obscure behavior. We still delete most of the code involved in
this part of grep initialization and config handling, but now with no
changes in existing behavior.

This is now also ejected:

  grep docs: de-duplicate configuration sections
  (https://lore.kernel.org/git/patch-v2-4.8-efe95397d72-20211110T013632Z-avarab@gmail.com/)

Since I don't need to change any documentation anymore, moving around
the grep docs to live in one place isn't within the scope of this
series.

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 124 ++++++++--------------------------------------
 grep.h            |  33 ++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |   9 ++++
 9 files changed, 106 insertions(+), 131 deletions(-)

Range-diff against v2:
1:  1435db727ef = 1:  71ff51cb3c9 grep.h: remove unused "regex_t regexp" from grep_opt
3:  41e38ebb32c ! 2:  ec8e42ced1a log tests: check if grep_config() is called by "log"-like cmds
    @@ Commit message
         whether "git log" handles "grep.patternType", but also "git show"
         etc.
     
    -    It's sufficient to check whether a PCRE regex matches for the purposes
    -    of this test, we otherwise assume that it's running the same code as
    -    "git log", whose behavior is tested more exhaustively by test added in
    -    9df46763ef1e.
    +    It's sufficient to check whether we match a "fixed" or a "basic" regex
    +    here to see if these codepaths correctly invoked grep_config(). We
    +    don't need to check the details of their regular expression matching
    +    as the "log" test does.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t4202-log.sh: test_expect_success !FAIL_PREREQS 'log with various grep.pattern
      
     +for cmd in show whatchanged reflog format-patch
     +do
    -+	myarg=
    -+	if test "$cmd" = "format-patch"
    -+	then
    -+		myarg="HEAD~.."
    -+	fi
    ++	case "$cmd" in
    ++	format-patch) myarg="HEAD~.." ;;
    ++	*) myarg= ;;
    ++	esac
     +
    -+	test_expect_success PCRE "$cmd: understands grep.patternType=perl, like 'log'" '
    -+		git -c grep.patternType=fixed -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
    -+		test_must_be_empty actual &&
    -+		git -c grep.patternType=perl -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
    -+		test_file_not_empty actual
    ++	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
    ++		git init "pattern-type-$cmd" &&
    ++		(
    ++			cd "pattern-type-$cmd" &&
    ++			test_commit 1 file A &&
    ++			test_commit "(1|2)" file B 2 &&
    ++
    ++			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
    ++			test_must_be_empty actual &&
    ++
    ++			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
    ++			test_file_not_empty actual
    ++		)
     +	'
     +done
    ++test_done
     +
      test_expect_success 'log --author' '
      	cat >expect <<-\EOF &&
8:  cc904d93b26 ! 3:  fcad1b1664b grep: make "extendedRegexp=true" the same as "patternType=extended"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep: make "extendedRegexp=true" the same as "patternType=extended"
    +    grep tests: add missing "grep.patternType" config test
     
    -    In the preceding commit we changed how a "grep.patternType=default"
    -    set after "grep.extendedRegexp=true" would be handled so that the last
    -    set would win, but a "grep.extendedRegexp=true" would only be used if
    -    "grep.patternType" was set to a value other than "default".
    -
    -    Thus a user who had old config and set "grep.extendedRegexp=true" in
    -    their ~/.gitconfig expecting ERE behavior would be opted-in to say
    -    "perl" regexes if a system "/etc/gitconfig" started setting
    -    "grep.patternType=perl".
    -
    -    These funny semantics of only paying attention to a set if another key
    -    is not set to a given value aren't how we treat other config keys, so
    -    let's do away with this caveat for consistency.
    -
    -    The new semantics are simple, a "grep.extendedRegexp=true" is an exact
    -    synonym for specifying "grep.patternType=extended" in the
    -    config. We'll keep ignoring ""grep.extendedRegexp=false", although
    -    arguably we could treat it as a "grep.patternType=basic".
    -
    -    As argued in the preceding commit I think this behavior came about
    -    because we were conflating the state of our code's own internal
    -    "default" value with what we found in explicit user config. See
    -    84befcd0a4a (grep: add a grep.patternType configuration setting,
    -    2012-08-03) for that past behavior.
    -
    -    Let's further change the documentation to note that
    -    "grep.extendedRegexp" is a deprecated synonym, perhaps we'll be able
    -    to remove it at some point in the future and do away with this
    -    special-case entirely.
    +    Extend the grep tests to assert that setting
    +    "grep.patternType=extended" followed by "grep.patternType=default"
    +    will behave as if "--extended-regexp" was provided, and not as
    +    "--basic-regexp". In a subsequent commit we'll need to treat
    +    "grep.patternType=default" as a special-case, but let's make sure we
    +    don't ignore it if "grep.patternType" was set to a non-"default" value
    +    before.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/config/grep.txt ##
    -@@ Documentation/config/grep.txt: grep.patternType::
    - 	value 'default' will return to the default matching behavior.
    - 
    - grep.extendedRegexp::
    --	If set to true, enable `--extended-regexp` option by default. This
    --	option is ignored when the `grep.patternType` option is set.
    -+	Deprecated synonym for 'grep.patternType=extended`.
    - 
    - grep.threads::
    - 	Number of grep worker threads to use. If unset (or set to 0), Git will
    -
    - ## grep.c ##
    -@@ grep.c: static const char *color_grep_slots[] = {
    - 
    - static int parse_pattern_type_arg(const char *opt, const char *arg)
    - {
    --	if (!strcmp(arg, "default"))
    --		return GREP_PATTERN_TYPE_UNSPECIFIED;
    --	else if (!strcmp(arg, "basic"))
    -+	if (!strcmp(arg, "basic") ||
    -+	    !strcmp(arg, "default"))
    - 		return GREP_PATTERN_TYPE_BRE;
    - 	else if (!strcmp(arg, "extended"))
    - 		return GREP_PATTERN_TYPE_ERE;
    -@@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    - 	if (userdiff_config(var, value) < 0)
    - 		return -1;
    - 
    --	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED &&
    --	    !strcmp(var, "grep.extendedregexp") &&
    -+	if (!strcmp(var, "grep.extendedregexp") &&
    - 	    git_config_bool(var, value)) {
    - 		opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
    - 		return 0;
    -
    - ## grep.h ##
    -@@ grep.h: enum grep_expr_node {
    - };
    - 
    - enum grep_pattern_type {
    --	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
    --	GREP_PATTERN_TYPE_BRE,
    -+	GREP_PATTERN_TYPE_BRE = 0,
    - 	GREP_PATTERN_TYPE_ERE,
    - 	GREP_PATTERN_TYPE_FIXED,
    - 	GREP_PATTERN_TYPE_PCRE
    -@@ grep.h: struct grep_opt {
    - 	.relative = 1, \
    - 	.pathname = 1, \
    - 	.max_depth = -1, \
    --	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
    - 	.colors = { \
    - 		[GREP_COLOR_CONTEXT] = "", \
    - 		[GREP_COLOR_FILENAME] = "", \
    -
      ## t/t7810-grep.sh ##
     @@ t/t7810-grep.sh: do
    + 		test_cmp expected actual
      	'
      
    - 	test_expect_success "grep $L with grep.patternType=basic and grep.extendedRegexp=true" '
    --		echo "${HC}ab:a+bc" >expected &&
    -+		echo "${HC}ab:abc" >expected &&
    ++	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
    ++		echo "${HC}ab:a+bc" >expected &&
    ++		git \
    ++			-c grep.patternType=extended \
    ++			-c grep.patternType=default \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    + 	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
    + 		echo "${HC}ab:abc" >expected &&
      		git \
    - 			-c grep.patternType=basic \
    - 			-c grep.extendedRegexp=true \
2:  63cf2fe266d ! 4:  854ffe8d0b9 built-ins: trust the "prefix" from run_builtin()
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
     
      ## builtin/ls-tree.c ##
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 		OPT__ABBREV(&abbrev),
    - 		OPT_END()
    - 	};
    --
    --	git_config(git_default_config, NULL);
    + 
    + 	git_config(git_default_config, NULL);
      	ls_tree_prefix = prefix;
     -	if (prefix && *prefix)
     +	if (prefix)
      		chomp_prefix = strlen(prefix);
      
    -+	git_config(git_default_config, NULL);
      	argc = parse_options(argc, argv, prefix, ls_tree_options,
    - 			     ls_tree_usage, 0);
    - 	if (full_tree) {
    --		ls_tree_prefix = prefix = NULL;
    -+		ls_tree_prefix = NULL;
    - 		chomp_prefix = 0;
    - 	}
    - 	/* -d -r should imply -t, but -d by itself should not have to. */
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
    - 				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
    - 		       PATHSPEC_PREFER_CWD,
    --		       prefix, argv + 1);
    -+		       ls_tree_prefix, argv + 1);
    - 	for (i = 0; i < pathspec.nr; i++)
    - 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
    - 	pathspec.has_wildcard = 0;
     
      ## git.c ##
    -@@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
    - {
    - 	int status, help;
    - 	struct stat st;
    --	const char *prefix;
    -+	const char *prefix = NULL;
    - 
    --	prefix = NULL;
    - 	help = argc == 2 && !strcmp(argv[1], "-h");
    - 	if (!help) {
    - 		if (p->option & RUN_SETUP)
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
      			int nongit_ok;
      			prefix = setup_git_directory_gently(&nongit_ok);
4:  efe95397d72 < -:  ----------- grep docs: de-duplicate configuration sections
5:  d0f0ac6c7ae ! 5:  2536eae2c32 grep.c: don't pass along NULL callback value
    @@ Metadata
      ## Commit message ##
         grep.c: don't pass along NULL callback value
     
    -    Change grep_cmd_config() top stop passing around the always-NULL "cb"
    +    Change grep_cmd_config() to stop passing around the always-NULL "cb"
         value. When this code was added in 7e8f59d577e (grep: color patterns
         in output, 2009-03-07) it was non-NULL, but when that changed in
         15fabd1bbd4 (builtin/grep.c: make configuration callback more
6:  917944f79a5 ! 6:  4e1be7c165b grep API: call grep_config() after grep_init()
    @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
     
      ## grep.h ##
     @@ grep.h: struct grep_opt {
    - 	int show_hunk_mark;
    - 	int file_break;
    - 	int heading;
    -+	void *caller_priv;
    - 	void *priv;
    - 
    - 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
      	void *output_priv;
      };
      
7:  140a7416223 ! 7:  f40ab932cb1 grep: simplify config parsing, change grep.<rx config> interaction
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep: simplify config parsing, change grep.<rx config> interaction
    +    grep: simplify config parsing and option parsing
     
    -    Change the interaction between "grep.patternType=default" and
    -    "grep.extendedRegexp=true" to make setting "grep.extendedRegexp=true"
    -    synonymous with setting "grep.patternType=extended".
    -
    -    This changes our existing config parsing behavior as detailed below,
    -    but in a way that's consistent with how we parse other
    -    configuration.
    -
    -    We are breaking past promises here, but I doubt that this will impact
    -    anyone in practice. The reduction in complexity and resulting
    -    consistency with other default config behavior is worth it.
    +    Simplify the parsing of "grep.patternType" and
    +    "grep.extendedRegexp". This changes no behavior, but gets rid of
    +    complex parsing logic that isn't needed anymore.
     
         When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
    -    grep.patternType configuration setting, 2012-08-03) we made two
    -    seemingly contradictory promises:
    +    grep.patternType configuration setting, 2012-08-03) we promised that:
     
          1. You can set "grep.patternType", and "[setting it to] 'default'
             will return to the default matching behavior".
     
    -     2. Support the existing "grep.extendedRegexp" option, but ignore it
    -        when the new "grep.patternType" is set, *except* "when the
    -        `grep.patternType` option is set. to a value other than 'default'".
    -
    -    I think that 84befcd0a4a probably didn't intend this behavior, but
    -    instead ended up conflating our internal "unspecified" state with a
    -    user's explicit desire to set the configuration back to the
    -    default.
    -
    -    I.e. a user would correctly expect this to keep working:
    -
    -        # ERE grep
    -        git -c grep.extendedRegexp=true grep <pattern>
    -
    -    And likewise for "grep.patternType=default" to take precedence over
    -    the disfavored "grep.extendedRegexp" option, i.e. the usual "last set
    -    wins" semantics.
    +     2. We'd support the existing "grep.extendedRegexp" option, but ignore
    +        it when the new "grep.patternType" option is set. We said we'd
    +        only ignore the older "grep.extendedRegexp" option "when the
    +        `grep.patternType` option is set. to a value other than
    +        'default'".
     
    -        # BRE grep
    -        git -c grep.extendedRegexp=true -c grep.patternType=basic grep <pattern>
    +    In a preceding commit we changed grep_config() to be called after
    +    grep_init(), which means that much of the complexity here can go
    +    away.
     
    -    But probably not for this to ignore the favored "grep.patternType"
    -    option entirely, say if /etc/gitconfig was still setting
    -    "grep.extendedRegexp", but "~/.gitconfig" used the new
    -    "grep.patternType" (and wanted to use the "default" value):
    -
    -        # Was ERE, now BRE
    -        git -c grep.extendedRegexp=true grep.patternType=default grep <pattern>
    -
    -    I think that in practice nobody or almost nobody is going to be
    -    relying on this obscure interaction, and as shown here it makes the
    -    config parsing much simpler. We no longer have to carry a complex
    -    state machine in "grep_commit_pattern_type()" and
    -    "grep_set_pattern_type_option()".
    -
    -    We can also do away with the "int fixed" and "int pcre2" members in
    -    favor of using "pattern_type_option" directly in "grep.c", as well as
    -    dropping the "pattern_type_arg" variable in "builtin/grep.c" in favor
    -    of using the "pattern_type_option" member directly.
    +    Now as before when we only understand a "grep.extendedRegexp" setting
    +    of "true", and if "grep.patterntype=default" is set we'll interpret it
    +    as "grep.patterntype=basic", except if we previously saw a
    +    "grep.extendedRegexp", then it's interpreted as
    +    "grep.patterntype=extended".
     
         See my 07a3d411739 (grep: remove regflags from the public grep_opt
         API, 2017-06-29) for addition of the two comments being removed here,
         i.e. the complexity noted in that commit is now going away.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    We don't need grep_commit_pattern_type() anymore, we can instead have
    +    OPT_SET_INT() in "builtin/grep.c" manipulate the "pattern_type_option"
    +    member in "struct grep_opt" directly.
     
    - ## Documentation/config/grep.txt ##
    -@@ Documentation/config/grep.txt: grep.patternType::
    - 
    - grep.extendedRegexp::
    - 	If set to true, enable `--extended-regexp` option by default. This
    --	option is ignored when the `grep.patternType` option is set to a value
    --	other than 'default'.
    -+	option is ignored when the `grep.patternType` option is set.
    - 
    - grep.threads::
    - 	Number of grep worker threads to use. If unset (or set to 0), Git will
    +    We can also do away with the indirection of the "int fixed" and "int
    +    pcre2" members in favor of using "pattern_type_option" directly in
    +    "grep.c".
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/grep.c ##
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		int fallback = 0;
     
      ## grep.c ##
    +@@ grep.c: static const char *color_grep_slots[] = {
    + 
    + static int parse_pattern_type_arg(const char *opt, const char *arg)
    + {
    +-	if (!strcmp(arg, "default"))
    +-		return GREP_PATTERN_TYPE_UNSPECIFIED;
    +-	else if (!strcmp(arg, "basic"))
    ++	if (!strcmp(arg, "basic"))
    + 		return GREP_PATTERN_TYPE_BRE;
    + 	else if (!strcmp(arg, "extended"))
    + 		return GREP_PATTERN_TYPE_ERE;
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    - 	if (userdiff_config(var, value) < 0)
      		return -1;
      
    --	if (!strcmp(var, "grep.extendedregexp")) {
    --		opt->extended_regexp_option = git_config_bool(var, value);
    -+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED &&
    -+	    !strcmp(var, "grep.extendedregexp") &&
    -+	    git_config_bool(var, value)) {
    -+		opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
    + 	if (!strcmp(var, "grep.extendedregexp")) {
    ++		if (opt->extended_regexp_option)
    ++			return 0;
    + 		opt->extended_regexp_option = git_config_bool(var, value);
    ++		if (opt->extended_regexp_option)
    ++			opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
    ++		return 0;
    ++	}
    ++
    ++	if (!strcmp(var, "grep.patterntype") &&
    ++	    !strcmp(value, "default")) {
    ++		opt->pattern_type_option = opt->extended_regexp_option == 1
    ++			? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
      		return 0;
      	}
      
    + 	if (!strcmp(var, "grep.patterntype")) {
    ++		opt->extended_regexp_option = -1; /* ignore */
    + 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
    + 		return 0;
    + 	}
     @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo)
      	opt->header_tail = &opt->header_list;
      }
    @@ grep.c: static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
      	if (err) {
     
      ## grep.h ##
    +@@ grep.h: enum grep_expr_node {
    + };
    + 
    + enum grep_pattern_type {
    +-	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
    +-	GREP_PATTERN_TYPE_BRE,
    ++	GREP_PATTERN_TYPE_BRE = 0,
    + 	GREP_PATTERN_TYPE_ERE,
    + 	GREP_PATTERN_TYPE_FIXED,
    + 	GREP_PATTERN_TYPE_PCRE
     @@ grep.h: struct grep_opt {
      	int unmatch_name_only;
      	int count;
    @@ grep.h: struct grep_opt {
      	int pathname;
      	int null_following_name;
     @@ grep.h: struct grep_opt {
    - 	int max_depth;
      	int funcname;
      	int funcbody;
    --	int extended_regexp_option;
    + 	int extended_regexp_option;
     -	int pattern_type_option;
     +	enum grep_pattern_type pattern_type_option;
      	int ignore_locale;
      	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
      	unsigned pre_context;
     @@ grep.h: struct grep_opt {
    + 	.relative = 1, \
    + 	.pathname = 1, \
    + 	.max_depth = -1, \
    +-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
    + 	.colors = { \
    + 		[GREP_COLOR_CONTEXT] = "", \
    + 		[GREP_COLOR_FILENAME] = "", \
    +@@ grep.h: struct grep_opt {
      
      int grep_config(const char *var, const char *value, void *);
      void grep_init(struct grep_opt *, struct repository *repo);
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      	if (!is_encoding_utf8(get_log_output_encoding()))
      		revs->grep_filter.ignore_locale = 1;
      	compile_grep_patterns(&revs->grep_filter);
    -
    - ## t/t7810-grep.sh ##
    -@@ t/t7810-grep.sh: do
    - 	'
    - 
    - 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=default" '
    --		echo "${HC}ab:abc" >expected &&
    -+		echo "${HC}ab:a+bc" >expected &&
    - 		git \
    - 			-c grep.extendedRegexp=true \
    - 			-c grep.patternType=default \
-- 
2.34.1.841.gf15fb7e6f34

