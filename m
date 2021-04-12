Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51686C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199BE61288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbhDLRP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbhDLRP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:15:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4786FC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p6so7019678wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQslm6rbG7galvAXuNqG5fMYaXKsks/m4g5wUQTuYwY=;
        b=U2kCC3iyL6ZtifkL8JsQO2QPxcWJdmiUcbirds2xr6RP/CkkfzEo4F5gs0ziEhM1A7
         ArnQRJOUnWrbVyDCZpiJlUMEpSRudMOHCd6oxic7BHEpiktB31upeTbivSY5FL0bQtoF
         7rsXA7vcxDlOtaCZmmB8ZNuIvi/RLVz7vX4Etk0WpC86zVeb8uuy+s3ulG8hBJyYRbhI
         S+w4XDmWCOKXgh8D2EhlJuRK6A/TBjU5A8+Ur8iLNBhBrGnCkE02RZuinVXoN+4JoWW2
         2UBSiqSSZc3Lv0NG6f5J47vDsW7Vv39iCN5/2veaIFKssEuwRlQRhgZG0bZ2dJNRXc7q
         B2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQslm6rbG7galvAXuNqG5fMYaXKsks/m4g5wUQTuYwY=;
        b=TOZsNSSShfehVLtZztkjZPDPgcJgVV6oanQ/7+s3t+QZy6gFChdsSdMZmG15dBKQgy
         cXIMxbfNgK6YjKxoxEnDGFTr8QAq0UyoFSfBmjCbLRr/5Ud4rDOkkM9sRICi+rG3ZUf6
         0Tnnu6/uuenVRyNVTVI7+tx/tN6yWoWdcyzln7oizw2tUbpZOl/paEC/804i5F/490fi
         6wHxG/R+pm0C1loSXxp/gWDVnOd9yErdJI8K+xTZU+yuj4FC85xwOhmIatA6YYSb3o3e
         B/CO6f7kqpvGM0bHCpzhZIydHp63iCRjdfgeP44FLbU1VOY8vPuME7sBuWEKoadze57B
         T0Jw==
X-Gm-Message-State: AOAM5324dRwCvj7JfDs24f6RuJCZmhjHBO5/UavfKY1p+0t5a3rD6e4B
        YfGUi7RvvyoVJhLRjmOVerwvcHBeUcrI2Q==
X-Google-Smtp-Source: ABdhPJxeVk564iflTKXhBqwJ0MePS0PpKyUm1zbxlNz9QQ6j5VZTLUbTvwXCCZstRHQTUP/6WCCCsA==
X-Received: by 2002:adf:a119:: with SMTP id o25mr1410161wro.36.1618247738092;
        Mon, 12 Apr 2021 10:15:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/22] pickaxe: test and refactoring for future PCRE backend
Date:   Mon, 12 Apr 2021 19:15:07 +0200
Message-Id: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <20210216115801.4773-1-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This much-delayed re-roll of v2[2] is a test and refactoring change to
diffcore-pickaxe.c to allow an eventual removal of the kwset.[ch]
files and to add a PCRE backend.

This series is now based on my "test-lib.sh: new test_commit args,
simplification & fixes" series. The trivial dependency between the two
is using the new test_commit --printf option.

I'll not summarize the range-diff too much, but since v2 I addressed
all outstanding feedback from Junio. There's 2x new patches at the end
of the series to change the existing early return feature now using
"discard_hunk_line" to use a flag.

In v2 I had what I realized was a WIP migration of that to using
return values in the callback instead, but unlike the
xdiff_emit_line_fn I don't think that makes sense in
xdiff_emit_hunk_fn.

1. https://lore.kernel.org/git/20210216115801.4773-1-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (22):
  grep/pcre2 tests: reword comments referring to kwset
  pickaxe tests: refactor to use test_commit --append --printf
  pickaxe tests: add test for diffgrep_consume() internals
  pickaxe tests: add test for "log -S" not being a regex
  pickaxe tests: test for -G, -S and --find-object incompatibility
  pickaxe tests: add missing test for --no-pickaxe-regex being an error
  pickaxe: die when -G and --pickaxe-regex are combined
  pickaxe: die when --find-object and --pickaxe-all are combined
  diff.h: move pickaxe fields together again
  pickaxe/style: consolidate declarations and assignments
  perf: add performance test for pickaxe
  pickaxe: refactor function selection in diffcore-pickaxe()
  pickaxe: assert that we must have a needle under -G or -S
  pickaxe -S: support content with NULs under --pickaxe-regex
  pickaxe: rename variables in has_changes() for brevity
  pickaxe -S: slightly optimize contains()
  xdiff-interface: prepare for allowing early return
  xdiff-interface: allow early return from xdiff_emit_line_fn
  pickaxe -G: terminate early on matching lines
  pickaxe -G: don't special-case create/delete
  xdiff users: use designated initializers for out_line
  xdiff-interface: replace discard_hunk_line() with a flag

 builtin/merge-tree.c           |   5 +-
 builtin/rerere.c               |   4 +-
 combine-diff.c                 |   5 +-
 diff.c                         |  39 +++++++----
 diff.h                         |   7 +-
 diffcore-pickaxe.c             | 106 ++++++++++++++++++------------
 range-diff.c                   |   3 +-
 t/perf/p4209-pickaxe.sh        |  70 ++++++++++++++++++++
 t/t4209-log-pickaxe.sh         | 114 ++++++++++++++++++++++++++++-----
 t/t7816-grep-binary-pattern.sh |   4 +-
 xdiff-interface.c              |  27 ++++----
 xdiff-interface.h              |  31 ++++++---
 xdiff/xdiff.h                  |   1 +
 xdiff/xemit.c                  |   3 +-
 14 files changed, 312 insertions(+), 107 deletions(-)
 create mode 100755 t/perf/p4209-pickaxe.sh

Range-diff against v2:
 1:  75bfc8eba13 =  1:  cfe934d6081 grep/pcre2 tests: reword comments referring to kwset
 2:  cddb1f75f6c <  -:  ----------- test-lib-functions: document and test test_commit --no-tag
 3:  44540f6039e <  -:  ----------- test-lib-functions: reword "test_commit --append" docs
 4:  0e1f133476f <  -:  ----------- test-lib functions: add --printf option to test_commit
 5:  2a814e8d53a !  2:  413a330d3d6 pickaxe tests: refactor to use test_commit --append --printf
    @@ Metadata
      ## Commit message ##
         pickaxe tests: refactor to use test_commit --append --printf
     
    -    Refactor existing tests added in e0e7cb8080c (log -G: ignore binary
    -    files, 2018-12-14) to use the --append option I added in
    +    Refactor the existing tests added in e0e7cb8080c (log -G: ignore
    +    binary files, 2018-12-14) to use the --append option I added in
         3373518cc8b (test-lib functions: add an --append option to
    -    test_commit, 2021-01-12) and the --printf option added in a preceding
    -    commit.
    +    test_commit, 2021-01-12) and the --printf option added as part of an
    +    in-flight topic of mine this commit depends on.
    +
    +    While I'm at it change some of the setup of the test to use a more
    +    sensible pattern, e.g. setting up a temporary repo instead of creating
    +    an orphan branch.
    +
    +    Since the -G and -S options will behave the same way with truncated
    +    and removed content also change the "git rm" to emptying data.bin,
    +    that's just catering to how test_commit works. The resulting test is
    +    shorter.
     
         See also f5d79bf7dd6 (tests: refactor a few tests to use "test_commit
         --append", 2021-01-12) for prior similar refactoring.
    @@ t/t4209-log-pickaxe.sh: test_expect_success 'log -S --no-textconv (missing textc
     -	git commit -m "delete binary file" data.bin &&
     -	git log >full-log
     +	test_create_repo GS-bin-txt &&
    -+	test_commit -C GS-bin-txt --append --printf A data.bin "a\na\0a\n" &&
    ++	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
     +	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
     +	test_commit -C GS-bin-txt C data.bin "" &&
     +	git -C GS-bin-txt log >full-log
 6:  f49eb6c95e5 !  3:  ddd2224836b pickaxe tests: add test for diffgrep_consume() internals
    @@ t/t4209-log-pickaxe.sh: test_expect_success 'log -S --no-textconv (missing textc
     +
      test_expect_success 'setup log -[GS] binary & --text' '
      	test_create_repo GS-bin-txt &&
    - 	test_commit -C GS-bin-txt --append --printf A data.bin "a\na\0a\n" &&
    + 	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
 7:  80c62fb0448 =  4:  ca6340c1fa7 pickaxe tests: add test for "log -S" not being a regex
 8:  6d329e0c3b1 !  5:  0c4657189a8 pickaxe tests: test for -G, -S and --find-object incompatibility
    @@ t/t4209-log-pickaxe.sh: test_expect_success setup '
      
     +test_expect_success 'usage' '
     +	test_expect_code 128 git log -Gregex -Sstring 2>err &&
    -+	test_i18ngrep "mutually exclusive" err &&
    ++	grep "mutually exclusive" err &&
     +
     +	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
    -+	test_i18ngrep "mutually exclusive" err &&
    ++	grep "mutually exclusive" err &&
     +
    -+	test_expect_code 128 git log -Gstring --find-object=HEAD 2>err &&
    -+	test_i18ngrep "mutually exclusive" err
    ++	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
    ++	grep "mutually exclusive" err
     +'
     +
      test_log	expect_initial	--grep initial
 -:  ----------- >  6:  1696076bb09 pickaxe tests: add missing test for --no-pickaxe-regex being an error
 9:  bd0c3b7e3b0 !  7:  83e7b4793b6 pickaxe: die when -G and --pickaxe-regex are combined
    @@ Commit message
         matching regular expressions, 2006-03-29) only the -S option
         existed. Then when -G was added in f506b8e8b5 (git log/diff: add
         -G<regexp> that greps in the patch text, 2010-08-23) neither the
    -    documentation for --pickaxe-regex was updater accordingly, nor was
    +    documentation for --pickaxe-regex was updated accordingly, nor was
         something like this assertion added.
     
         Since 5bc3f0b567 (diffcore-pickaxe doc: document -S and -G properly,
         2013-05-31) we've claimed that --pickaxe-regex should only be used
    -    with -S, but have silently toileted combining it with -G, let's die
    +    with -S, but have silently tolerated combining it with -G, let's die
         instead.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ diff.h: int git_config_rename(const char *var, const char *value);
     
      ## t/t4209-log-pickaxe.sh ##
     @@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
    - 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
    - 	test_i18ngrep "mutually exclusive" err &&
    + 	grep "mutually exclusive" err
    + '
      
    ++test_expect_success 'usage: --pickaxe-regex' '
     +	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
    -+	test_i18ngrep "mutually exclusive" err &&
    ++	grep "mutually exclusive" err
    ++'
     +
    - 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
    - 	test_i18ngrep "mutually exclusive" err &&
    - 
    + test_expect_success 'usage: --no-pickaxe-regex' '
    + 	cat >expect <<-\EOF &&
    + 	fatal: unrecognized argument: --no-pickaxe-regex
10:  72075874f5c !  8:  749c3ca3f98 pickaxe: die when --find-object and --pickaxe-all are combined
    @@ diff.h: int git_config_rename(const char *var, const char *value);
     
      ## t/t4209-log-pickaxe.sh ##
     @@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
    - 	test_i18ngrep "mutually exclusive" err &&
    + 	grep "mutually exclusive" err &&
      
    - 	test_expect_code 128 git log -Gstring --find-object=HEAD 2>err &&
    -+	test_i18ngrep "mutually exclusive" err &&
    + 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
    ++	grep "mutually exclusive" err &&
     +
     +	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
    - 	test_i18ngrep "mutually exclusive" err
    + 	grep "mutually exclusive" err
      '
      
11:  f8116a2b814 =  9:  fe4e75c39d2 diff.h: move pickaxe fields together again
12:  4778357cfc7 = 10:  afe70b163a2 pickaxe/style: consolidate declarations and assignments
13:  7449a59b104 = 11:  97616d741c7 perf: add performance test for pickaxe
14:  160f7d8b0f2 ! 12:  c29deb428b1 pickaxe: refactor function selection in diffcore-pickaxe()
    @@ diffcore-pickaxe.c: void diffcore_pickaxe(struct diff_options *o)
      		regcomp_or_die(&regex, needle, cflags);
      		regexp = &regex;
     +
    -+		/* diff.c errors on -G and --pickaxe-regex for us */
     +		if (opts & DIFF_PICKAXE_KIND_G)
     +			fn = diff_grep;
     +		else if (opts & DIFF_PICKAXE_REGEX)
     +			fn = has_changes;
     +		else
    ++			/*
    ++			 * We don't need to check the combination of
    ++			 * -G and --pickaxe-regex, by the time we get
    ++			 * here diff.c has already died if they're
    ++			 * combined. See the usage tests in
    ++			 * t4209-log-pickaxe.sh.
    ++			 */
     +			BUG("unreachable");
      	} else if (opts & DIFF_PICKAXE_KIND_S) {
      		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
15:  05fc57e54e1 ! 13:  115a369d067 pickaxe: assert that we must have a needle under -G or -S
    @@ diffcore-pickaxe.c: void diffcore_pickaxe(struct diff_options *o)
      	kwset_t kws = NULL;
      	pickaxe_fn fn;
      
    -+	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND && !needle)
    ++	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND &&
    ++	    (!needle || !*needle))
     +		BUG("should have needle under -G or -S");
      	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
      		int cflags = REG_EXTENDED | REG_NEWLINE;
    @@ t/t4209-log-pickaxe.sh: test_expect_success setup '
     +	test_i18ngrep "switch.*requires a value" err &&
     +
      	test_expect_code 128 git log -Gregex -Sstring 2>err &&
    - 	test_i18ngrep "mutually exclusive" err &&
    + 	grep "mutually exclusive" err &&
      
16:  550620ec13b ! 14:  a86032792b6 pickaxe -S: support content with NULs under --pickaxe-regex
    @@ Commit message
         for pickaxe matching regular expressions, 2006-03-29).
     
         It wasn't needed anymore, and as the now-passing test shows, actively
    -    getting in our way.
    +    getting in our way. Since we always require REG_STARTEND support we do
    +    not need to stop at NULs. If we are dealing with a haystack with NUL
    +    in it. The needle may be behind that NUL.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t4209-log-pickaxe.sh: test_expect_success 'log -S looks into binary files' '
     +	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
     +	test_cmp log full-log &&
     +
    -+	git -C GS-bin-txt log --pickaxe-regex -S[a] >log &&
    ++	git -C GS-bin-txt log --pickaxe-regex -S"[a]" >log &&
     +	test_cmp log full-log
     +'
     +
17:  985e077d561 = 15:  10f85edcff7 pickaxe: rename variables in has_changes() for brevity
18:  648e6e5f11b ! 16:  ed83c3add89 pickaxe -S: slightly optimize contains()
    @@ Commit message
         pre-image and post-image of a change. As soon as we know we had e.g. 1
         before and 2 now we can stop, we don't need to keep counting past 2.
     
    +    With this change a diff between A and B may have different performance
    +    characteristics than between B and A. That's OK in this case, since
    +    we'll emit the same output, and the effect is to make one of them
    +    better.
    +
    +    I'm picking a check of "one" first on the assumption that it's a more
    +    common case to have files grow over time than not.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## diffcore-pickaxe.c ##
19:  b991660fbf5 ! 17:  62c306275c7 xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
    +    xdiff-interface: prepare for allowing early return
     
    -    Change the function prototype of xdiff_emit_{line,hunk}_fn to return
    -    an int instead of void. This will allow for returning early from hunk
    -    & diff consumers that want some of the data, but not all of it.
    +    Change the function prototype of xdiff_emit_line_fn to return an "int"
    +    instead of "void". Change all of those functions to "return 0",
    +    nothing checks those return values yet, and no behavior is being
    +    changed.
     
    -    No behavior is being changed here, just replacing the equivalent of
    -    "return" with "return 0", nothing acts on the changed return values
    -    yet.
    -
    -    There was some work in this area of xdiff-interface.[ch] recently with
    -    3b40a090fd4 (diff: avoid generating unused hunk header lines,
    -    2018-11-02) and 7c61e25fbf1 (diff: use hunk callback for word-diff,
    -    2018-11-02).
    -
    -    In combination those two changes allow us to not do any work on the
    -    hunks and diff at all, but didn't change the status quo with regards
    -    to consumers that e.g. want the diff lines, but might want to abort
    -    early.
    -
    -    Whereas soon we can abort e.g. on the first "-line" of a 1000 line
    -    diff if that's all we needed.
    -
    -    This interface is rather scary as noted in the comment to
    -    xdiff-interface.h being added here, but it will be useful for
    -    diffcore-pickaxe.c in a subsequent commit. A future change could
    -    e.g. add more exit codes, and hack xdl_emit_diff() and friends to
    -    ignore or skip things more selectively as a result.
    +    In subsequent commits the interface will be changed to allow early
    +    return via this new return value.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## combine-diff.c ##
    -@@ combine-diff.c: struct combine_diff_state {
    - 	struct sline *lost_bucket;
    - };
    - 
    --static void consume_hunk(void *state_,
    -+static int consume_hunk(void *state_,
    - 			 long ob, long on,
    - 			 long nb, long nn,
    - 			 const char *funcline, long funclen)
     @@ combine-diff.c: static void consume_hunk(void *state_,
    - 		state->sline[state->nb-1].p_lno =
    - 			xcalloc(state->num_parent, sizeof(unsigned long));
      	state->sline[state->nb-1].p_lno[state->n] = state->ob;
    -+
    -+	return 0;
      }
      
     -static void consume_line(void *state_, char *line, unsigned long len)
    @@ combine-diff.c: static void consume_line(void *state_, char *line, unsigned long
      static void combine_diff(struct repository *r,
     
      ## diff.c ##
    -@@ diff.c: static int color_words_output_graph_prefix(struct diff_words_data *diff_words)
    - 	}
    - }
    - 
    --static void fn_out_diff_words_aux(void *priv,
    --				  long minus_first, long minus_len,
    --				  long plus_first, long plus_len,
    --				  const char *func, long funclen)
    -+static int fn_out_diff_words_aux(void *priv,
    -+				 long minus_first, long minus_len,
    -+				 long plus_first, long plus_len,
    -+				 const char *func, long funclen)
    - {
    - 	struct diff_words_data *diff_words = priv;
    - 	struct diff_words_style *style = diff_words->style;
    -@@ diff.c: static void fn_out_diff_words_aux(void *priv,
    - 
    - 	diff_words->current_plus = plus_end;
    - 	diff_words->last_minus = minus_first;
    -+
    -+	return 0;
    - }
    - 
    - /* This function starts looking at *begin, and returns 0 iff a word was found. */
     @@ diff.c: static void find_lno(const char *line, struct emit_callback *ecbdata)
      	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
      }
    @@ diff.c: static void diffstat_consume(void *priv, char *line, unsigned long len)
      }
      
      const char mime_boundary_leader[] = "------------";
    -@@ diff.c: static int is_conflict_marker(const char *line, int marker_size, unsigned long l
    - 	return 1;
    - }
    - 
    --static void checkdiff_consume_hunk(void *priv,
    -+static int checkdiff_consume_hunk(void *priv,
    - 				   long ob, long on, long nb, long nn,
    - 				   const char *func, long funclen)
    - 
    - {
    - 	struct checkdiff_t *data = priv;
    +@@ diff.c: static void checkdiff_consume_hunk(void *priv,
      	data->lineno = nb - 1;
    -+	return 0;
      }
      
     -static void checkdiff_consume(void *priv, char *line, unsigned long len)
    @@ range-diff.c: static void find_exact_matches(struct string_list *a, struct strin
     +	return 0;
      }
      
    --static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
    --			  const char *funcline, long funclen)
    -+static int diffsize_hunk(void *data, long ob, long on, long nb, long nn,
    -+			 const char *funcline, long funclen)
    - {
    - 	diffsize_consume(data, NULL, 0);
    -+	return 0;
    - }
    - 
    - static int diffsize(const char *a, const char *b)
    + static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
     
      ## xdiff-interface.c ##
     @@ xdiff-interface.c: static int xdiff_out_hunk(void *priv_,
    @@ xdiff-interface.c: static void consume_one(void *priv_, char *s, unsigned long s
      }
      
      static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
    -@@ xdiff-interface.c: int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
    - 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
    - }
    - 
    --void discard_hunk_line(void *priv,
    --		       long ob, long on, long nb, long nn,
    --		       const char *func, long funclen)
    -+int discard_hunk_line(void *priv,
    -+		      long ob, long on, long nb, long nn,
    -+		      const char *func, long funclen)
    - {
    -+	return 0;
    - }
    - 
    - int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
     
      ## xdiff-interface.h ##
     @@
    @@ xdiff-interface.h
      #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
      
     -typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
    --typedef void (*xdiff_emit_hunk_fn)(void *data,
    --				   long old_begin, long old_nr,
    --				   long new_begin, long new_nr,
    --				   const char *func, long funclen);
    -+/*
    -+ * The xdiff_emit_{line,hunk}_fn consumers can return -1 to abort
    -+ * early, or 0 to continue processing. Note that doing so is an
    -+ * all-or-nothing affair, as returning -1 will return all the way to
    -+ * the top-level, e.g. the xdi_diff_outf() call to generate the diff.
    -+ *
    -+ * Thus returning -1 from a hunk header callback means you won't be
    -+ * getting any more hunks, or diffs, and likewise returning from a
    -+ * line callback means you won't be getting anymore lines.
    -+ *
    -+ * We may extend the interface in the future to understand other more
    -+ * granular return values, but for now use it carefully, or consider
    -+ * e.g. using discard_hunk_line() if you say just don't care about
    -+ * hunk headers.
    -+ */
     +typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
    -+typedef int (*xdiff_emit_hunk_fn)(void *data,
    -+				  long old_begin, long old_nr,
    -+				  long new_begin, long new_nr,
    -+				  const char *func, long funclen);
    - 
    - int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
    - int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
    -@@ xdiff-interface.h: extern int git_xmerge_style;
    -  * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
    -  * one just sends the hunk line to the line_fn callback).
    -  */
    --void discard_hunk_line(void *priv,
    --		       long ob, long on, long nb, long nn,
    --		       const char *func, long funclen);
    -+int discard_hunk_line(void *priv,
    -+		      long ob, long on, long nb, long nn,
    -+		      const char *func, long funclen);
    - 
    - /*
    -  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
    + typedef void (*xdiff_emit_hunk_fn)(void *data,
    + 				   long old_begin, long old_nr,
    + 				   long new_begin, long new_nr,
20:  69b061832b3 ! 18:  76d667f152f xdiff-interface: support early exit in xdiff_outf()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    xdiff-interface: support early exit in xdiff_outf()
    +    xdiff-interface: allow early return from xdiff_emit_line_fn
     
    -    Bridge the gap between the preceding "xdiff-interface: allow early
    -    return from xdiff_emit_{line,hunk}_fn" change and the public
    -    interface.
    +    Finish the change started in the preceding commit and allow an early
    +    return from "xdiff_emit_line_fn" callbacks, this will allows
    +    diffcore-pickaxe.c to save itself redundant work.
     
    -    This change was split off from the preceding commit as it wasn't a
    -    purely mechanical addition of "return 0".
    +    Our xdiff interface also had the limitation of not being able to abort
    +    early since the beginning, see d9ea73e0564 (combine-diff: refactor
    +    built-in xdiff interface., 2006-04-05). Although at that time
    +    "xdiff_emit_line_fn" was called "xdiff_emit_consume_fn", and
    +    "xdiff_emit_hunk_fn" didn't exist yet.
     
    -    Here we want to be able to abort early, but do so in a way that
    -    doesn't skip the appropriate strbuf_reset() invocations.
    +    There was some work in this area of xdiff-interface.[ch] recently with
    +    3b40a090fd4 (diff: avoid generating unused hunk header lines,
    +    2018-11-02) and 7c61e25fbf1 (diff: use hunk callback for word-diff,
    +    2018-11-02).
    +
    +    In combination those two changes allow us to not do any work on the
    +    hunks and diff at all, but didn't change the status quo with regards
    +    to consumers that e.g. want the diff lines, but might want to abort
    +    early.
    +
    +    Whereas now we can abort e.g. on the first "-line" of a 1000 line diff
    +    if that's all we needed.
    +
    +    This interface is rather scary as noted in the comment to
    +    xdiff-interface.h being added here, as noted there a future change
    +    could add more exit codes, and hack xdl_emit_diff() and friends to
    +    ignore or skip things more selectively as a result.
    +
    +    I did not see an inherent reason for why xdl_emit_{diffrec,record}()
    +    could not be changed to ferry the "xdiff_emit_line_fn" error code
    +    upwards instead of returning -1 on all "ret < 0".
     
    -    The use of -1 as a return value is consistent with the rest of the
    -    xdiff codebase, where doing so signals an abort or error that'll
    -    propagate up the stack.
    +    But doing so would require corresponding changes in xdl_emit_diff(),
    +    xdl_diff(). I didn't see any issue with narrowly doing that to
    +    accomplish what I needed here, but it would leave xdiff's own return
    +    values in an inconsistent state.
    +
    +    Instead I've left it at returning a more conventional (for git's own
    +    codebase) 1 for an early return, and translating it (or rather, all
    +    non-zero) to -1 for xdiff's consumption.
    +
    +    The reason for most of the "stop" complexity in xdiff_outf() is
    +    because we want to be able to abort early, but do so in a way that
    +    doesn't skip the appropriate strbuf_reset() invocations.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## xdiff-interface.c ##
     @@ xdiff-interface.c: static int consume_one(void *priv_, char *s, unsigned long size)
    + 	char *ep;
    + 	while (size) {
      		unsigned long this_size;
    ++		int ret;
      		ep = memchr(s, '\n', size);
      		this_size = (ep == NULL) ? size : (ep - s + 1);
     -		priv->line_fn(priv->consume_callback_data, s, this_size);
    -+		if (priv->line_fn(priv->consume_callback_data, s, this_size))
    -+			return -1;
    ++		ret = priv->line_fn(priv->consume_callback_data, s, this_size);
    ++		if (ret)
    ++			return ret;
      		size -= this_size;
      		s += this_size;
      	}
    @@ xdiff-interface.c: static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
      
      	for (i = 0; i < nbuf; i++) {
     +		if (stop)
    -+			return -1;
    ++			return 1;
      		if (mb[i].ptr[mb[i].size-1] != '\n') {
      			/* Incomplete line */
      			strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
    @@ xdiff-interface.c: static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
      	return 0;
      }
      
    +
    + ## xdiff-interface.h ##
    +@@
    +  */
    + #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
    + 
    ++/**
    ++ * The `xdiff_emit_line_fn` function can return 1 to abort early, or 0
    ++ * to continue processing. Note that doing so is an all-or-nothing
    ++ * affair, as returning 1 will return all the way to the top-level,
    ++ * e.g. the xdi_diff_outf() call to generate the diff.
    ++ *
    ++ * Thus returning 1 means you won't be getting any more diff lines. If
    ++ * you need something in-between those two options you'll to use
    ++ * `xdl_emit_hunk_consume_func_t` and implement your own version of
    ++ * xdl_emit_diff().
    ++ *
    ++ * We may extend the interface in the future to understand other more
    ++ * granular return values. While you should return 1 to exit early,
    ++ * doing so will currently make your early return indistinguishable
    ++ * from an error internal to xdiff, xdiff itself will see that
    ++ * non-zero return and translate it to -1.
    ++ */
    + typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
    + typedef void (*xdiff_emit_hunk_fn)(void *data,
    + 				   long old_begin, long old_nr,
21:  fc0aa61d093 ! 19:  53e9405f849 pickaxe -G: terminate early on matching lines
    @@ Commit message
     
         Solve a long-standing item for "git log -Grx" of us e.g. finding "+
         str" in the diff context and noting that we had a "hit", but xdiff
    -    diligently continuing to generate and spew the rest of the diff at us.
    +    diligently continuing to generate and spew the rest of the diff at
    +    us. This makes use of a new "early return" xdiff interface added by
    +    preceding commits.
     
    -    The TODO item has been there since "git log -G" was implemented. See
    -    f506b8e8b5f (git log/diff: add -G<regexp> that greps in the patch
    -    text, 2010-08-23).
    +    The TODO item (or, the NEEDSWORK comment) has been there since "git
    +    log -G" was implemented. See f506b8e8b5f (git log/diff: add -G<regexp>
    +    that greps in the patch text, 2010-08-23).
     
    -    Our xdiff interface also had the limitation of not being able to abort
    -    early since the beginning, see d9ea73e0564 (combine-diff: refactor
    -    built-in xdiff interface., 2006-04-05). Although at that time
    -    "xdiff_emit_line_fn" was called "xdiff_emit_consume_fn", and
    -    "xdiff_emit_hunk_fn" didn't exist yet.
    -
    -    But now with the support added in the preceding ""xdiff-interface:
    -    allow early return from xdiff_emit_{line,hunk}_fn" commit we can
    -    return early, and furthermore test the functionality of the new
    -    early-exit xdiff-interface by having a BUG() call here to die if it
    -    ever starts handing us needless work again.
    +    But now with the support added in the preceding changes to the
    +    xdiff-interface we can return early. Let's assert the behavior of that
    +    new early-return xdiff-interface by having a BUG() call here to die if
    +    it ever starts handing us needless work again.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ diffcore-pickaxe.c: static int diffgrep_consume(void *priv, char *line, unsigned
     +	if (!regexec_buf(data->regexp, line + 1, len - 1, 1,
     +			 &regmatch, 0)) {
     +		data->hit = 1;
    -+		return -1;
    ++		return 1;
     +	}
      	return 0;
      }
    @@ diffcore-pickaxe.c: static int diff_grep(mmfile_t *one, mmfile_t *two,
     +
     +	/*
     +	 * An xdiff error might be our "data->hit" from above. See the
    -+	 * comment for xdiff_emit_{line,hunk}_fn in xdiff-interface.h
    -+	 * for why.
    ++	 * comment for xdiff_emit_line_fn in xdiff-interface.h
     +	 */
     +	ret = xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
     +			    &ecbdata, &xpp, &xecfg);
    @@ diffcore-pickaxe.c: static int diff_grep(mmfile_t *one, mmfile_t *two,
     
      ## xdiff-interface.h ##
     @@
    -  * granular return values, but for now use it carefully, or consider
    -  * e.g. using discard_hunk_line() if you say just don't care about
    -  * hunk headers.
    +  * doing so will currently make your early return indistinguishable
    +  * from an error internal to xdiff, xdiff itself will see that
    +  * non-zero return and translate it to -1.
     + *
    -+ * Note that just returning -1 will make your early return
    -+ * indistinguishable from an error internal to xdiff. See "diff_grep"
    -+ * in diffcore-pickaxe.c for a trick to work around this, i.e. using
    -+ * the "consume_callback_data" to note the desired early return.
    ++ * See "diff_grep" in diffcore-pickaxe.c for a trick to work around
    ++ * this, i.e. using the "consume_callback_data" to note the desired
    ++ * early return.
       */
      typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
    - typedef int (*xdiff_emit_hunk_fn)(void *data,
    + typedef void (*xdiff_emit_hunk_fn)(void *data,
22:  c81b18ca4c7 = 20:  76de6ebc8b8 pickaxe -G: don't special-case create/delete
 -:  ----------- > 21:  9bb7ac910f3 xdiff users: use designated initializers for out_line
 -:  ----------- > 22:  1178956fb3d xdiff-interface: replace discard_hunk_line() with a flag
-- 
2.31.1.639.g3d04783866f

