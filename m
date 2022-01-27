Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56352C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiA0L4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiA0L4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE00C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w11so4324067wra.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fg6IibH988k62MzI6o9M+c8qLSWrHrI8osWw2j9/Vmw=;
        b=W/HsdBpQU+K1uOcSNCjeBEk/z7S8edmCDYlDcRXC/yYsMsyhciitHJzzbF8HOdj9yN
         ZhNM7kJINCWvgi+BRG0qq/V9i0coOu5mu3o+DGKXM/secw35SsLPag90m8ADx+7SPgrq
         PCXXwSvQ3HTLL8xsTdT33c6OyOABktipenIWD8vVlxsnTy00xLTh/PyBdYJBCZqcIbmC
         q6Q3fn3txr8EZ3r5CGodswDcBRQJy0Vmmk96TIc8sWE2GQMMUqovcgqnsD47eys97ppu
         pil5edvLBoT17CK6hTVf+IzXcBmK/dLHIz8TcgkSEuttOH2v9tUCvosFQo3fMVN3J731
         xulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fg6IibH988k62MzI6o9M+c8qLSWrHrI8osWw2j9/Vmw=;
        b=W82J79GU6ktrc3wf8gDrvB9uvBe6owGZpIZ8GOxuJBtwUjtDOPYq3jqbd0CPOoOpg4
         Dm9JrCtjQDZjxQMdhq2lXKPtqadljuA0nBkALQliiYW6nFkW1U2Jo1X9hshqFu4+/NOO
         2mFehk6RXM6g5qGN8qHrBgmoFOGdl8s25E3n/YoeLiO/ORREXaJW5qlscBjiHshVCPqM
         mO+82GRLRmYqaCa/RFImtSyGaK+8sTa3mWzgAE8V1A8VthgYiWNvKHWKLbVP9jq97Il3
         cEWASC+huSAiCTnoujhdVaXZqA7GLhgWcgW3uLM18sA6S7qOinYadEn9uBNXV2Dftwg1
         lkaA==
X-Gm-Message-State: AOAM532G+Bzd09sTHhpL69deJsvH1nW5qUh/asuUxKcIZ1lZfTRdllsQ
        6SKC7FOUo8CC2NBPOiuHCIK2mSUnVCmiNA==
X-Google-Smtp-Source: ABdhPJw24IKPswDYrBQdKN16RiO8OLDpCftSLj+f/m9HQW6ccajT4TJcRGMGSHKpyDBD3a75OKKUhQ==
X-Received: by 2002:adf:e3c6:: with SMTP id k6mr2665838wrm.445.1643284595695;
        Thu, 27 Jan 2022 03:56:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 0/9] grep: simplify & delete "init" & "config" code
Date:   Thu, 27 Jan 2022 12:56:22 +0100
Message-Id: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes using the grep.[ch] API easier, by having it follow
the usual pattern of being initialized with:

    defaults -> config -> command-line

This is to make some follow-up work easier, this is a net code
deletion if we exclude newly added tests.

Changes since v8:

 * Addressed Junio's comments on the last two patches, the 9/9 is now
   rewritten to use the "struct grep_opts" to track the
   "extended_regexp_option" member, and the previous 10/10 has been
   dropped.

For the v8 see
https://lore.kernel.org/git/cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config tests
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep.h: make "grep_opt.pattern_type_option" use its enum
  grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 ++++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 120 ++++++++--------------------------------------
 grep.h            |  32 +++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 ++++++++++
 t/t7810-grep.sh   |  68 ++++++++++++++++++++++++++
 9 files changed, 165 insertions(+), 126 deletions(-)

Range-diff against v8:
 1:  010a2066656 =  1:  b9372cde017 grep.h: remove unused "regex_t regexp" from grep_opt
 2:  e4981fa3417 =  2:  30219a0ae9d log tests: check if grep_config() is called by "log"-like cmds
 3:  59092169e55 =  3:  a75b288340b grep tests: add missing "grep.patternType" config tests
 4:  331c9019a0e =  4:  6e7f9730a7d built-ins: trust the "prefix" from run_builtin()
 5:  25dd327b653 =  5:  fbcfea84696 grep.c: don't pass along NULL callback value
 6:  3c559ad006a =  6:  96c8cc7806e grep API: call grep_config() after grep_init()
 7:  daf873899c1 =  7:  e09616056b4 grep.h: make "grep_opt.pattern_type_option" use its enum
 8:  62650a78ea9 =  8:  61fc6a4dac8 grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
 9:  c211bb0c69d !  9:  445467e87f7 grep: simplify config parsing and option parsing
    @@ Commit message
          2. We'd support the existing "grep.extendedRegexp" option, but ignore
             it when the new "grep.patternType" option is set. We said we'd
             only ignore the older "grep.extendedRegexp" option "when the
    -        `grep.patternType` option is set. to a value other than
    +        `grep.patternType` option is set to a value other than
             'default'".
     
         In a preceding commit we changed grep_config() to be called after
    @@ Commit message
             -c grep.extendedRegexp=true \
             -c grep.patternType=default
     
    -    Should select ERE due to "grep.extendedRegexp=true and
    -    grep.extendedRegexp=default", not BRE, even though that's the
    -    "default" patternType. We can determine this as we parse the config,
    -    because:
    +    should select ERE due to "grep.extendedRegexp=true and
    +    grep.patternType=default". We can determine this as we parse the
    +    config, because:
     
    -     * If we see "grep.extendedRegexp" we set the internal "ero" to its
    -       boolean value.
    +     * If we see "grep.extendedRegexp" we set "extended_regexp_option" to
    +       its boolean value.
     
          * If we see "grep.extendedRegexp" but
            "grep.patternType=[default|<unset>]" is in effect we *don't* set
    @@ Commit message
     
          * If we see "grep.patternType!=default" we can set our internal
            "pattern_type_option" directly, it doesn't matter what the state of
    -       "grep.extendedRegexp" is, but we don't forget what it was, in case
    -       we see a "grep.patternType=default" again.
    +       "extended_regexp_option" is, but we don't forget what it was, in
    +       case we see a "grep.patternType=default" again.
     
          * If we see a "grep.patternType=default" we can set the pattern to
            ERE or BRE depending on whether we last saw a
            "grep.extendedRegexp=true" or
            "grep.extendedRegexp=[false|<unset>]".
     
    -    We could equally call this new adjust_pattern_type() in
    -    compile_regexp(), i.e. this fixup on top of this passes all our
    -    tests (with -U0 for brevity):
    -
    -        @@ -60,0 +61 @@ static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
    -        +static int ero = -1;
    -        @@ -65 +65,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -        -       static int ero = -1;
    -        @@ -72 +71,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -        -               adjust_pattern_type(&opt->pattern_type_option, ero);
    -        @@ -80 +78,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -        -               adjust_pattern_type(&opt->pattern_type_option, ero);
    -        @@ -445,0 +444,2 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
    -        +       if (ero != -1)
    -        +               adjust_pattern_type(&opt->pattern_type_option, ero);
    -
    -    But doing it as we stream the git_config() makes it
    -    clear that we can determine the interplay between these two variables
    -    as we go. We don't need to wait until we see the last value of the two
    -    configuration variables.
    -
    -    This is true because of the rationale above, and because the
    -    subsequent code in compile_regexp() treats
    -    "pattern_type_option=GREP_PATTERN_TYPE_{UNSPECIFIED,BRE}"
    -    equally. I.e. we'll end up with different internal
    -    ""pattern_type_option" values there for:
    -
    -        # UNSPECIFIED
    -        -c grep.patternType=default
    -        # BRE
    -        -c grep.extendedRegexp=false -c grep.patternType=default
    -
    -    But the difference won't matter, which simplifies some of this logic,
    -    we never need to adjust a "grep.patternType" if we didn't see a
    -    "grep.extendedRegexp" before. We can also remove the
    -    "extended_regexp_option" member from "struct grep_opt" in favor of a
    -    static variable in grep_config().
    +    With this change the "extended_regexp_option" member is only used
    +    within grep_config(), and in the current codebase we could equally
    +    track it as a "static" variable within that function, see [1] for a
    +    version for this patch that did that. We're keeping it a struct member
    +    to make that function reentrant, in case it ends up mattering in the
    +    future.
     
         The command-line parsing in cmd_grep() can then completely ignore
         "grep.extendedRegexp". Whatever effect it had before that step won't
    @@ Commit message
         API, 2017-06-29) for addition of the two comments being removed here,
         i.e. the complexity noted in that commit is now going away.
     
    +    1. https://lore.kernel.org/git/patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/grep.c ##
    @@ grep.c: static int parse_pattern_type_arg(const char *opt, const char *arg)
       * Read the configuration file once and store it in
       * the grep_defaults template.
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    - {
    - 	struct grep_opt *opt = cb;
    - 	const char *slot;
    -+	static int ero = -1;
    - 
    - 	if (userdiff_config(var, value) < 0)
    - 		return -1;
      
      	if (!strcmp(var, "grep.extendedregexp")) {
    --		opt->extended_regexp_option = git_config_bool(var, value);
    -+		ero = git_config_bool(var, value);
    -+		adjust_pattern_type(&opt->pattern_type_option, ero);
    + 		opt->extended_regexp_option = git_config_bool(var, value);
    ++		adjust_pattern_type(&opt->pattern_type_option,
    ++				    opt->extended_regexp_option);
      		return 0;
      	}
      
      	if (!strcmp(var, "grep.patterntype")) {
      		opt->pattern_type_option = parse_pattern_type_arg(var, value);
    -+		if (ero == -1)
    ++		if (opt->extended_regexp_option == -1)
     +			return 0;
    -+		adjust_pattern_type(&opt->pattern_type_option, ero);
    ++		adjust_pattern_type(&opt->pattern_type_option,
    ++				    opt->extended_regexp_option);
      		return 0;
      	}
      
    @@ grep.h: struct grep_opt {
      	int pathname;
      	int null_following_name;
     @@ grep.h: struct grep_opt {
    - 	int max_depth;
    - 	int funcname;
    - 	int funcbody;
    --	int extended_regexp_option;
    - 	enum grep_pattern_type pattern_type_option;
    - 	int ignore_locale;
    - 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
    + 	.relative = 1, \
    + 	.pathname = 1, \
    + 	.max_depth = -1, \
    ++	.extended_regexp_option = -1, \
    + 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
    + 	.colors = { \
    + 		[GREP_COLOR_CONTEXT] = "", \
     @@ grep.h: struct grep_opt {
      
      int grep_config(const char *var, const char *value, void *);
10:  b52a0c11fa9 <  -:  ----------- grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED
-- 
2.35.0.894.g563b84683b9

