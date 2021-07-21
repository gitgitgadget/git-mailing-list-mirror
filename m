Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C9C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A5B61175
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGUBCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhGUBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B4C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w13so401413wmc.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6fOjYPnL1uQmorQJFlXcpAuLY2JF7A87ULvXYnXl1jM=;
        b=BlcsiuFWmOFTkSDznnYlgfMabClrm6UKXjow2rkm9AM4OsG4IVtdv63FMrDI7ffnyG
         m+b8/Pys1oJ3Gta1j8PwY8wVP6oH3y5c1FDuxGSPDkM390YdjFtSrjVJUEGmJ7zMPKot
         b5Ox1FDIOQTirUnrM0af+jswvfXIXjxpwONBKXNeKgcFWg9YtbBKxB1Qe4htlMGjL3d4
         CRxVSV08oJen6UPUKj0ZhNq6TX1ATiNgmsvcMzOZHC0WLkecBANBbzUUDhU2cOlWQi4u
         e0Nr14/zygqruqmMNwO5TsE0/HV78WPxTazF4y1FQyrh+0wVQiA9SSWdvzMwce1GDCOz
         zN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6fOjYPnL1uQmorQJFlXcpAuLY2JF7A87ULvXYnXl1jM=;
        b=T8DpMQHn4EO1Kq8mtcjCJYGY2Me/z+glK1XQYdllHbvfdeOT54psJ4CUVt+gzvERjJ
         UiQkCOIZ5FuwDOnkogDOXW7zjn3QwkcIzqadwvcOSJ90V+dhnj2jcOv5VDNxuWOQvAKJ
         owZcr9oMGJl1alhREP+jySAghkp3GvP3tGGiiaaWbuIyKx3gB3PzT6M0uSwdYw+UwEn5
         4tbWSWAHNCAz6Uw0JAVKm/lwcTOM9M9O/Fgmq1rArxj2y9HvVF4hzhS0x8liVC182YFd
         SOWSu6NgzpMDA8olZ7Z11X3IyM0WrFMAIitXLqtTCIKXTjtM3zqmy9Vj24eeoDMKD7HN
         hSBA==
X-Gm-Message-State: AOAM531yD9E30q6kkixpU8UumKfRPBYNnRbMqKWgpuZHXP53kXszIIdA
        mZeIL3aguVZA8mqLvUqRKyg7boKhziM=
X-Google-Smtp-Source: ABdhPJwVb/0EYDVM1MtcyQQ+zhcEs4aclHr3An1RFS7RRh7AbKjz+XHM1ArPAHYdciwthHrbopXasg==
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr1396111wmo.24.1626831746302;
        Tue, 20 Jul 2021 18:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm27110007wrg.74.2021.07.20.18.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:25 -0700 (PDT)
Message-Id: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:16 +0000
Subject: [PATCH v2 0/8] Handle pull option precedence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on a recent list of rules for flag/option precedence for git-pull[1]
from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
here's an attempt to implement and document it. Given multiple recent
surprises from users about some of these behaviors[2][3] and a coworker just
yesterday expressing some puzzlement with git-pull and rebase vs. merge, it
seems like a good time to address some of these issues.

Since the handling of conflicting options was holding up two of Alex's
patches[4][5], and his patches fix some of the tests, I also include those
two patches in my series, with a few small changes to the first (so I've
kept him as author) and more substantial changes to the second (so I've
given him an Initial-patch-by attribution).

Changes since v1:

 * Rebased on latest master (resolved a simple conflict with
   dd/test-stdout-count-lines)
 * Patch 1: based on feedback from Junio, fixed some style issues, clarified
   function names, added a few new tests, and took a stab at fixing up the
   comments and test descriptions (but still unsure if I hit the mark on the
   last point)
 * Patch 2: changed the test expectations for one of the multiple head tests
   as per Junio's suggestion, and made one of the other tests expect a more
   specific error message
 * Patches 4 & 5 were squashed and fixed: these now address a submodule bug
   interaction with --ff-only
 * Old patch 6 (now 5): added a code comment explaining a subtle point
 * Old patch 8 (now 7): a few more documentation updates, especially making
   --ff-only not sound merge-specific
 * Old patch 9 (now 8): Updates for new test expectation from patch 2

Quick overview:

 * Patches 1-2: new testcases (see the commit messages for the rules)
 * Patch 3: Alex's recent patch (abort if --ff-only but can't do so)
 * Patches 4-6: fix the precedence parts Alex didn't cover
 * Patch 7: Alex's other patch, abort if rebase vs. merge not specified
 * Patch 8: Compatibility of git-pull with merge-options.txt (think
   rebasing)
 * Patch 9: Fix multiple heads handling too

[1] https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/ [2]
https://lore.kernel.org/git/CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com/
[3]
https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
[4]
https://lore.kernel.org/git/20210711012604.947321-1-alexhenrie24@gmail.com/
[5]
https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Alex Henrie (1):
  pull: abort if --ff-only is given and fast-forwarding is impossible

Elijah Newren (7):
  t7601: test interaction of merge/rebase/fast-forward flags and options
  t7601: add tests of interactions with multiple merge heads and config
  pull: since --ff-only overrides, handle it first
  pull: make --rebase and --no-rebase override pull.ff=only
  pull: abort by default when fast-forwarding is not possible
  pull: update docs & code for option compatibility with rebasing
  pull: fix handling of multiple heads

 Documentation/git-merge.txt     |   2 +
 Documentation/git-pull.txt      |  21 +--
 Documentation/merge-options.txt |  40 ++++++
 advice.c                        |   5 +
 advice.h                        |   1 +
 builtin/merge.c                 |   2 +-
 builtin/pull.c                  |  63 ++++++---
 t/t4013-diff-various.sh         |   2 +-
 t/t5520-pull.sh                 |  26 ++--
 t/t5521-pull-options.sh         |   4 +-
 t/t5524-pull-msg.sh             |   4 +-
 t/t5553-set-upstream.sh         |  14 +-
 t/t5604-clone-reference.sh      |   4 +-
 t/t6402-merge-rename.sh         |  18 +--
 t/t6409-merge-subtree.sh        |   6 +-
 t/t6417-merge-ours-theirs.sh    |  10 +-
 t/t7601-merge-pull-config.sh    | 244 +++++++++++++++++++++++++++++---
 t/t7603-merge-reduce-heads.sh   |   2 +-
 18 files changed, 375 insertions(+), 93 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1049%2Fnewren%2Fhandle-pull-option-precedence-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1049/newren/handle-pull-option-precedence-v2
Pull-Request: https://github.com/git/git/pull/1049

Range-diff vs v1:

  1:  6cb771297f5 !  1:  17560927211 t7601: add relative precedence tests for merge and rebase flags/options
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    t7601: add relative precedence tests for merge and rebase flags/options
     +    t7601: test interaction of merge/rebase/fast-forward flags and options
      
          The interaction of rebase and merge flags and options was not well
          tested.  Add several tests to check for correct behavior from the
          following rules:
     -        * --ff-only takes precedence over --[no-]rebase
     -          * Corollary: pull.ff=only overrides pull.rebase
     -        * --rebase[=!false] takes precedence over --no-ff and --ff
     -          * Corollary: pull.rebase=!false overrides pull.ff=!only
     +        * --ff-only vs. --[no-]rebase
     +          (and the related pull.ff=only vs. pull.rebase)
     +        * --rebase[=!false] vs. --no-ff and --ff
     +          (and the related pull.rebase=!false overrides pull.ff=!only)
              * command line flags take precedence over config, except:
                * --no-rebase heeds pull.ff=!only
     -          * pull.rebase=!false takes precedence over --no-ff and --ff
     +          * pull.rebase=!false vs --no-ff and --ff
      
          For more details behind these rules and a larger table of individual
          cases, refer to https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
       	test_i18ngrep ! "Pulling without specifying how to reconcile" err
       '
       
     -+test_does_rebase() {
     ++test_does_rebase () {
      +	git reset --hard c2 &&
      +	git "$@" . c1 &&
      +	# Check that we actually did a rebase
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
      +	rm actual expect
      +}
      +
     -+test_does_merge_noff() {
     ++# Prefers merge over fast-forward
     ++test_does_merge_when_ff_possible () {
      +	git reset --hard c0 &&
      +	git "$@" . c1 &&
      +	# Check that we actually did a merge
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
      +	rm actual expect
      +}
      +
     -+test_does_merge_ff() {
     ++# Prefers fast-forward over merge or rebase
     ++test_does_fast_forward () {
      +	git reset --hard c0 &&
      +	git "$@" . c1 &&
     -+	# Check that we actually did a merge
     ++
     ++	# Check that we did not get any merges
      +	git rev-list --count HEAD >actual &&
      +	git rev-list --merges --count HEAD >>actual &&
      +	test_write_lines 2 0 >expect &&
      +	test_cmp expect actual &&
     ++
     ++	# Check that we ended up at c1
     ++	git rev-parse HEAD >actual &&
     ++	git rev-parse c1^{commit} >expect &&
     ++	test_cmp actual expect &&
     ++
     ++	# Remove temporary files
      +	rm actual expect
      +}
      +
     -+test_does_need_full_merge() {
     ++# Doesn't fail when fast-forward not possible; does a merge
     ++test_falls_back_to_full_merge () {
      +	git reset --hard c2 &&
      +	git "$@" . c1 &&
      +	# Check that we actually did a merge
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
      +	rm actual expect
      +}
      +
     -+test_attempts_fast_forward() {
     ++# Attempts fast forward, which is impossible, and bails
     ++test_attempts_fast_forward () {
      +	git reset --hard c2 &&
      +	test_must_fail git "$@" . c1 2>err &&
      +	test_i18ngrep "Not possible to fast-forward, aborting" err
      +}
      +
      +#
     -+# Rule 1: --ff-only takes precedence over --[no-]rebase
     -+# (Corollary: pull.ff=only overrides pull.rebase)
     ++# Group 1: Interaction of --ff-only with --[no-]rebase
     ++# (And related interaction of pull.ff=only with pull.rebase)
      +#
     -+test_expect_failure '--ff-only takes precedence over --rebase' '
     ++test_expect_failure '--ff-only overrides --rebase' '
      +	test_attempts_fast_forward pull --rebase --ff-only
      +'
      +
     -+test_expect_failure '--ff-only takes precedence over --rebase even if first' '
     ++test_expect_failure '--ff-only overrides --rebase even if first' '
      +	test_attempts_fast_forward pull --ff-only --rebase
      +'
      +
     -+test_expect_success '--ff-only takes precedence over --no-rebase' '
     ++test_expect_success '--ff-only overrides --no-rebase' '
      +	test_attempts_fast_forward pull --ff-only --no-rebase
      +'
      +
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
      +	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=false pull
      +'
      +
     -+# Rule 2: --rebase=[!false] takes precedence over --no-ff and --ff
     -+# (Corollary: pull.rebase=!false overrides pull.ff=!only)
     -+test_expect_success '--rebase takes precedence over --no-ff' '
     ++# Group 2: --rebase=[!false] overrides --no-ff and --ff
     ++# (And related interaction of pull.rebase=!false and pull.ff=!only)
     ++test_expect_success '--rebase overrides --no-ff' '
      +	test_does_rebase pull --rebase --no-ff
      +'
      +
     -+test_expect_success '--rebase takes precedence over --ff' '
     ++test_expect_success '--rebase overrides --ff' '
      +	test_does_rebase pull --rebase --ff
      +'
      +
     -+test_expect_success 'pull.rebase=true takes precedence over pull.ff=false' '
     ++test_expect_success '--rebase fast-forwards when possible' '
     ++	test_does_fast_forward pull --rebase --ff
     ++'
     ++
     ++test_expect_success 'pull.rebase=true overrides pull.ff=false' '
      +	test_does_rebase -c pull.rebase=true -c pull.ff=false pull
      +'
      +
     -+test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
     ++test_expect_success 'pull.rebase=true overrides pull.ff=true' '
      +	test_does_rebase -c pull.rebase=true -c pull.ff=true pull
      +'
      +
     -+# Rule 3: command line flags take precedence over config
     ++# Group 3: command line flags take precedence over config
      +test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
      +	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
      +'
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase not set and --ff-
      +	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
      +'
      +
     -+test_expect_failure '--no-rebase overrides pull.ff=only' '
     -+	test_does_need_full_merge -c pull.ff=only pull --no-rebase
     ++test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
     ++	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
      +'
      +
      +test_expect_success '--rebase takes precedence over pull.ff=only' '
      +	test_does_rebase -c pull.ff=only pull --rebase
      +'
      +
     -+test_expect_success '--rebase takes precedence over pull.ff=true' '
     ++test_expect_success '--rebase overrides pull.ff=true' '
      +	test_does_rebase -c pull.ff=true pull --rebase
      +'
      +
     -+test_expect_success '--rebase takes precedence over pull.ff=false' '
     ++test_expect_success '--rebase overrides pull.ff=false' '
      +	test_does_rebase -c pull.ff=false pull --rebase
      +'
      +
     -+test_expect_success '--rebase takes precedence over pull.ff unset' '
     ++test_expect_success '--rebase overrides pull.ff unset' '
      +	test_does_rebase pull --rebase
      +'
      +
     -+# Rule 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
     ++# Group 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
      +
      +test_expect_success '--no-rebase works with --no-ff' '
     -+	test_does_merge_noff pull --no-rebase --no-ff
     ++	test_does_merge_when_ff_possible pull --no-rebase --no-ff
      +'
      +
      +test_expect_success '--no-rebase works with --ff' '
     -+	test_does_merge_ff pull --no-rebase --ff
     ++	test_does_fast_forward pull --no-rebase --ff
      +'
      +
      +test_expect_success '--no-rebase does ff if pull.ff unset' '
     -+	test_does_merge_ff pull --no-rebase
     ++	test_does_fast_forward pull --no-rebase
      +'
      +
      +test_expect_success '--no-rebase heeds pull.ff=true' '
     -+	test_does_merge_ff -c pull.ff=true pull --no-rebase
     ++	test_does_fast_forward -c pull.ff=true pull --no-rebase
      +'
      +
      +test_expect_success '--no-rebase heeds pull.ff=false' '
     -+	test_does_merge_noff -c pull.ff=false pull --no-rebase
     ++	test_does_merge_when_ff_possible -c pull.ff=false pull --no-rebase
      +'
      +
     -+# Rule 5: pull.rebase=!false takes precedence over --no-ff and --ff
     -+test_expect_success 'pull.rebase=true takes precedence over --no-ff' '
     ++# Group 5: pull.rebase=!false in combination with --no-ff or --ff
     ++test_expect_success 'pull.rebase=true and --no-ff' '
      +	test_does_rebase -c pull.rebase=true pull --no-ff
      +'
      +
     -+test_expect_success 'pull.rebase=true takes precedence over --ff' '
     ++test_expect_success 'pull.rebase=true and --ff' '
      +	test_does_rebase -c pull.rebase=true pull --ff
      +'
      +
     -+# End of precedence rules
     ++test_expect_success 'pull.rebase=false and --no-ff' '
     ++	test_does_merge_when_ff_possible -c pull.rebase=false pull --no-ff
     ++'
     ++
     ++test_expect_success 'pull.rebase=false and --ff, ff possible' '
     ++	test_does_fast_forward -c pull.rebase=false pull --ff
     ++'
     ++
     ++test_expect_success 'pull.rebase=false and --ff, ff not possible' '
     ++	test_falls_back_to_full_merge -c pull.rebase=false pull --ff
     ++'
     ++
     ++# End of groupings for conflicting merge vs. rebase flags/options
      +
       test_expect_success 'merge c1 with c2' '
       	git reset --hard c1 &&
  2:  329802382bf !  2:  66fe7f7f934 t7601: add tests of interactions with multiple merge heads and config
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t7601-merge-pull-config.sh ##
     -@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=true takes precedence over --ff' '
     +@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=false and --ff, ff not possible' '
       
     - # End of precedence rules
     + # End of groupings for conflicting merge vs. rebase flags/options
       
     -+test_expect_failure 'Multiple heads does not warn about fast forwarding' '
     ++test_expect_failure 'Multiple heads warns about inability to fast forward' '
      +	git reset --hard c1 &&
     -+	git pull . c2 c3 2>err &&
     -+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
     ++	test_must_fail git pull . c2 c3 2>err &&
     ++	test_i18ngrep "Pulling without specifying how to reconcile" err
      +'
      +
     -+test_expect_success 'Cannot fast-forward with multiple heads' '
     ++test_expect_failure 'Multiple can never be fast forwarded' '
      +	git reset --hard c0 &&
      +	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
      +	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
     -+	test_i18ngrep "Not possible to fast-forward, aborting" err
     ++	# In addition to calling out "cannot fast-forward", we very much
     ++	# want the "multiple branches" piece to be called out to users.
     ++	test_i18ngrep "Cannot fast-forward to multiple branches" err
      +'
      +
      +test_expect_success 'Cannot rebase with multiple heads' '
  3:  ae54afd8b01 !  3:  c45cd239666 pull: abort if --ff-only is given and fast-forwarding is impossible
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
       	if (opt_rebase) {
      
       ## t/t7601-merge-pull-config.sh ##
     -@@ t/t7601-merge-pull-config.sh: test_attempts_fast_forward() {
     - # Rule 1: --ff-only takes precedence over --[no-]rebase
     - # (Corollary: pull.ff=only overrides pull.rebase)
     +@@ t/t7601-merge-pull-config.sh: test_attempts_fast_forward () {
     + # Group 1: Interaction of --ff-only with --[no-]rebase
     + # (And related interaction of pull.ff=only with pull.rebase)
       #
     --test_expect_failure '--ff-only takes precedence over --rebase' '
     -+test_expect_success '--ff-only takes precedence over --rebase' '
     +-test_expect_failure '--ff-only overrides --rebase' '
     ++test_expect_success '--ff-only overrides --rebase' '
       	test_attempts_fast_forward pull --rebase --ff-only
       '
       
     --test_expect_failure '--ff-only takes precedence over --rebase even if first' '
     -+test_expect_success '--ff-only takes precedence over --rebase even if first' '
     +-test_expect_failure '--ff-only overrides --rebase even if first' '
     ++test_expect_success '--ff-only overrides --rebase even if first' '
       	test_attempts_fast_forward pull --ff-only --rebase
       '
       
     -@@ t/t7601-merge-pull-config.sh: test_expect_success '--ff-only takes precedence over --no-rebase' '
     +@@ t/t7601-merge-pull-config.sh: test_expect_success '--ff-only overrides --no-rebase' '
       	test_attempts_fast_forward pull --ff-only --no-rebase
       '
       
     @@ t/t7601-merge-pull-config.sh: test_expect_success '--ff-only takes precedence ov
       	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
       '
       
     -@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
     +@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=true overrides pull.ff=true' '
       '
       
     - # Rule 3: command line flags take precedence over config
     + # Group 3: command line flags take precedence over config
      -test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
      +test_expect_success '--ff-only takes precedence over pull.rebase=true' '
       	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
       '
       
     -@@ t/t7601-merge-pull-config.sh: test_expect_failure '--no-rebase overrides pull.ff=only' '
     - 	test_does_need_full_merge -c pull.ff=only pull --no-rebase
     +@@ t/t7601-merge-pull-config.sh: test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
     + 	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
       '
       
      -test_expect_success '--rebase takes precedence over pull.ff=only' '
  4:  de4b460b09d <  -:  ----------- pull: since --ff-only overrides, handle it first
  5:  3d9ff69198e !  4:  1a821d3b1dd pull: ensure --rebase overrides ability to ff
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    pull: ensure --rebase overrides ability to ff
     +    pull: since --ff-only overrides, handle it first
      
     -    Now that the handling of fast-forward-only in combination with rebases
     -    has been moved before the merge-vs-rebase logic, we have an unnecessary
     -    special fast-forward case left within the rebase logic.  Actually, more
     -    than unnecessary, it's actually a violation of the rules.  As per
     -    https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/, --rebase is
     -    supposed to override all ff flags other than an explicit --ff-only.
     -    Ensure that it does so by removing the fast-forward special case that
     -    exists within the rebase logic.
     +    There are both merge and rebase branches in the logic, and previously
     +    both had to handle fast-forwarding.  Merge handled that implicitly
     +    (because git merge handles it directly), while in rebase it was
     +    explicit.  Given that the --ff-only flag is meant to override any
     +    --rebase or --no-rebase, make the code reflect that by handling
     +    --ff-only before the merge-vs-rebase logic.
     +
     +    It turns out that this also fixes a bug for submodules.  Previously,
     +    when --ff-only was given, the code would run `merge --ff-only` on the
     +    main module, and then run `submodule update --recursive --rebase` on the
     +    submodules.  With this change, we still run `merge --ff-only` on the
     +    main module, but now run `submodule update --recursive --checkout` on
     +    the submodules.  I believe this better reflects the intent of --ff-only
     +    to have it apply to both the main module and the submodules.
     +
     +    (Sidenote: It is somewhat interesting that all merges pass `--checkout`
     +    to submodule update, even when `--no-ff` is specified, meaning that it
     +    will only do fast-forward merges for submodules.  This was discussed in
     +    commit a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
     +    changes only)", 2017-06-23).  The same limitations apply now as then, so
     +    we are not trying to fix this at this time.)
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/pull.c ##
      @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
     + 
     + 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
     + 
     +-	if (!can_ff) {
     +-		if (opt_ff) {
     +-			if (!strcmp(opt_ff, "--ff-only"))
     +-				die_ff_impossible();
     +-		} else {
     +-			if (rebase_unspecified && opt_verbosity >= 0)
     +-				show_advice_pull_non_ff();
     +-		}
     ++	/* ff-only takes precedence over rebase */
     ++	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
     ++		if (!can_ff)
     ++			die_ff_impossible();
     ++		opt_rebase = REBASE_FALSE;
     + 	}
     ++	/* If no action specified and we can't fast forward, then warn. */
     ++	if (!opt_ff && rebase_unspecified && !can_ff)
     ++		show_advice_pull_non_ff();
     + 
     + 	if (opt_rebase) {
     + 		int ret = 0;
     +@@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
       		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
       			die(_("cannot rebase with locally recorded submodule modifications"));
       
  6:  b379fea097d !  5:  9b116f3d284 pull: make --rebase and --no-rebase override pull.ff=only
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
      -	if (!opt_ff)
      +	if (!opt_ff) {
       		opt_ff = xstrdup_or_null(config_get_ff());
     ++		/*
     ++		 * A subtle point: opt_ff was set on the line above via
     ++		 * reading from config.  opt_rebase, in contrast, is set
     ++		 * before this point via command line options.  The setting
     ++		 * of opt_rebase via reading from config (using
     ++		 * config_get_rebase()) does not happen until later.  We
     ++		 * are relying on the next if-condition happening before
     ++		 * the config_get_rebase() call so that an explicit
     ++		 * "--rebase" can override a config setting of
     ++		 * pull.ff=only.
     ++		 */
      +		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
      +			opt_ff = "--ff";
      +	}
     @@ t/t7601-merge-pull-config.sh: test_expect_success '--ff-only takes precedence ov
       	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
       '
       
     --test_expect_failure '--no-rebase overrides pull.ff=only' '
     -+test_expect_success '--no-rebase overrides pull.ff=only' '
     - 	test_does_need_full_merge -c pull.ff=only pull --no-rebase
     +-test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
     ++test_expect_success '--no-rebase takes precedence over pull.ff=only' '
     + 	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
       '
       
      -test_expect_failure '--rebase takes precedence over pull.ff=only' '
  7:  dca0455898a !  6:  f061f8b4e75 pull: abort by default when fast-forwarding is not possible
     @@ builtin/pull.c: static int get_can_ff(struct object_id *orig_head, struct object
       		 "  git config pull.rebase false  # merge (the default strategy)\n"
       		 "  git config pull.rebase true   # rebase\n"
      @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
     - 			return run_merge();
     + 		opt_rebase = REBASE_FALSE;
       	}
       	/* If no action specified and we can't fast forward, then warn. */
      -	if (!opt_ff && rebase_unspecified && !can_ff)
     @@ t/t6402-merge-rename.sh: test_expect_success 'setup' '
      -	test_expect_code 1 git pull . white &&
      +	test_expect_code 1 git pull --no-rebase . white &&
       	git ls-files -s &&
     - 	git ls-files -u B >b.stages &&
     - 	test_line_count = 3 b.stages &&
     + 	test_stdout_line_count = 3 git ls-files -u B &&
     + 	test_stdout_line_count = 1 git ls-files -s N &&
      @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into another renaming one' \
       	rm -f B &&
       	git reset --hard &&
       	git checkout red &&
      -	test_expect_code 1 git pull . white &&
      +	test_expect_code 1 git pull --no-rebase . white &&
     - 	git ls-files -u B >b.stages &&
     - 	test_line_count = 3 b.stages &&
     - 	git ls-files -s N >n.stages &&
     + 	test_stdout_line_count = 3 git ls-files -u B &&
     + 	test_stdout_line_count = 1 git ls-files -s N &&
     + 	sed -ne "/^g/{
      @@ t/t6402-merge-rename.sh: test_expect_success 'pull unrenaming branch into renaming one' \
       '
       	git reset --hard &&
       	git show-branch &&
      -	test_expect_code 1 git pull . main &&
      +	test_expect_code 1 git pull --no-rebase . main &&
     - 	git ls-files -u B >b.stages &&
     - 	test_line_count = 3 b.stages &&
     - 	git ls-files -s N >n.stages &&
     + 	test_stdout_line_count = 3 git ls-files -u B &&
     + 	test_stdout_line_count = 1 git ls-files -s N &&
     + 	sed -ne "/^g/{
      @@ t/t6402-merge-rename.sh: test_expect_success 'pull conflicting renames' \
       '
       	git reset --hard &&
       	git show-branch &&
      -	test_expect_code 1 git pull . blue &&
      +	test_expect_code 1 git pull --no-rebase . blue &&
     - 	git ls-files -u A >a.stages &&
     - 	test_line_count = 1 a.stages &&
     - 	git ls-files -u B >b.stages &&
     + 	test_stdout_line_count = 1 git ls-files -u A &&
     + 	test_stdout_line_count = 1 git ls-files -u B &&
     + 	test_stdout_line_count = 1 git ls-files -u C &&
      @@ t/t6402-merge-rename.sh: test_expect_success 'interference with untracked working tree file' '
       	git reset --hard &&
       	git show-branch &&
     @@ t/t7601-merge-pull-config.sh: test_expect_success 'setup' '
      +	test_i18ngrep ! "You have divergent branches" err
       '
       
     - test_does_rebase() {
     + test_does_rebase () {
     +@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=false and --ff, ff not possible' '
     + 
     + # End of groupings for conflicting merge vs. rebase flags/options
     + 
     +-test_expect_failure 'Multiple heads warns about inability to fast forward' '
     ++test_expect_success 'Multiple heads warns about inability to fast forward' '
     + 	git reset --hard c1 &&
     + 	test_must_fail git pull . c2 c3 2>err &&
     +-	test_i18ngrep "Pulling without specifying how to reconcile" err
     ++	test_i18ngrep "You have divergent branches" err
     + '
     + 
     + test_expect_failure 'Multiple can never be fast forwarded' '
     + 	git reset --hard c0 &&
     + 	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
     +-	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
     ++	test_i18ngrep ! "You have divergent branches" err &&
     + 	# In addition to calling out "cannot fast-forward", we very much
     + 	# want the "multiple branches" piece to be called out to users.
     + 	test_i18ngrep "Cannot fast-forward to multiple branches" err
     +@@ t/t7601-merge-pull-config.sh: test_expect_failure 'Multiple can never be fast forwarded' '
     + test_expect_success 'Cannot rebase with multiple heads' '
     + 	git reset --hard c0 &&
     + 	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
     +-	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
     ++	test_i18ngrep ! "You have divergent branches" err &&
     + 	test_i18ngrep "Cannot rebase onto multiple branches." err
     + '
     + 
      
       ## t/t7603-merge-reduce-heads.sh ##
      @@ t/t7603-merge-reduce-heads.sh: test_expect_success 'merge c1 with c2, c3, c4, c5' '
  8:  d1952f014f2 !  7:  90d49e0fb78 pull: update docs & code for option compatibility with rebasing
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/git-merge.txt ##
     +@@ Documentation/git-merge.txt: merge has resulted in conflicts.
     + 
     + OPTIONS
     + -------
     ++:git-merge: 1
     ++
     + include::merge-options.txt[]
     + 
     + -m <msg>::
     +
       ## Documentation/git-pull.txt ##
     -@@ Documentation/git-pull.txt: When false, merge the current branch into the upstream branch.
     - +
     - When `interactive`, enable the interactive mode of rebase.
     - +
     -+Note that `--ff-only` takes precedence over any `--rebase` flag.
     -++
     - See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
     - linkgit:git-config[1] if you want to make `git pull` always use
     - `--rebase` instead of merging.
     +@@ Documentation/git-pull.txt: Incorporates changes from a remote repository into the current branch.
     + If the current branch is behind the remote, then by default it will
     + fast-forward the current branch to match the remote.  If the current
     + branch and the remote have diverged, the user needs to specify how to
     +-reconcile the divergent branches with `--no-ff`, `--ff`, or `--rebase`
     +-(or the corresponding configuration options in `pull.ff` or
     +-`pull.rebase`).
     ++reconcile the divergent branches with `--rebase` or `--no-rebase` (or
     ++the corresponding configuration option in `pull.rebase`).
     + 
     + More precisely, `git pull` runs `git fetch` with the given parameters
     + and then depending on configuration options or command line flags,
     +-will call either `git merge` or `git rebase` to reconcile diverging
     ++will call either `git rebase` or `git merge` to reconcile diverging
     + branches.
     + 
     + <repository> should be the name of a remote repository as
     +@@ Documentation/git-pull.txt: published that history already.  Do *not* use this option
     + unless you have read linkgit:git-rebase[1] carefully.
     + 
     + --no-rebase::
     +-	Override earlier --rebase.
     ++	This is shorthand for --rebase=false.
     + 
     + Options related to fetching
     + ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      
       ## Documentation/merge-options.txt ##
      @@
     @@ Documentation/merge-options.txt
       +
       With --no-commit perform the merge and stop just before creating
       a merge commit, to give the user a chance to inspect and further
     -@@ Documentation/merge-options.txt: could instead be resolved as a fast-forward.
     +@@ Documentation/merge-options.txt: set to `no` at the beginning of them.
     + 	to `MERGE_MSG` before being passed on to the commit machinery in the
     + 	case of a merge conflict.
     + 
     ++ifdef::git-merge[]
     + --ff::
     + --no-ff::
     + --ff-only::
     +@@ Documentation/merge-options.txt: set to `no` at the beginning of them.
     + 	default unless merging an annotated (and possibly signed) tag
     + 	that is not stored in its natural place in the `refs/tags/`
     + 	hierarchy, in which case `--no-ff` is assumed.
     ++endif::git-merge[]
     ++ifdef::git-pull[]
     ++--ff-only::
     ++	Only update to the new history if there is no divergent local
     ++	history.  This is the default when no method for reconciling
     ++	divergent histories is provided (via the --rebase=* flags).
     ++
     ++--ff::
     ++--no-ff::
     ++	When merging rather than rebasing, specifies how a merge is
     ++	handled when the merged-in history is already a descendant of
     ++	the current history.  If merging is requested, `--ff` is the
     ++	default unless merging an annotated (and possibly signed) tag
     ++	that is not stored in its natural place in the `refs/tags/`
     ++	hierarchy, in which case `--no-ff` is assumed.
     ++endif::git-pull[]
     + +
     + With `--ff`, when possible resolve the merge as a fast-forward (only
     + update the branch pointer to match the merged branch; do not create a
     +@@ Documentation/merge-options.txt: descendant of the current history), create a merge commit.
     + +
     + With `--no-ff`, create a merge commit in all cases, even when the merge
     + could instead be resolved as a fast-forward.
     ++ifdef::git-merge[]
       +
       With `--ff-only`, resolve the merge as a fast-forward when possible.
       When not possible, refuse to merge and exit with a non-zero status.
     -+ifdef::git-pull[]
     -++
     -+Note that `--no-ff` and `--ff` are ignored when rebasing is requested.
     -+endif::git-pull[]
     ++endif::git-merge[]
       
       -S[<keyid>]::
       --gpg-sign[=<keyid>]::
  9:  3d8df246772 !  8:  f03b15b7eb0 pull: fix handling of multiple heads
     @@ Commit message
          pull: fix handling of multiple heads
      
          With multiple heads, we should not allow rebasing or fast-forwarding.
     -    Also, it seems wrong to have our can_ff computation return true, so fix
     -    that while we are at it too (we won't actually use the can_ff flag due
     -    to setting opt_ff to "--no-ff", but it's confusing to leave it as
     -    computed to be true).
     +    Make sure any fast-forward request calls out specifically the fact that
     +    multiple branches are in play.  Also, since we cannot fast-forward to
     +    multiple branches, fix our computation of can_ff.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
      +			die(_("Cannot rebase onto multiple branches."));
      +		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
      +			die(_("Cannot fast-forward to multiple branches."));
     -+		if (!opt_ff)
     -+			opt_ff = "--no-ff";
      +	}
       
      -	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
       	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
      
       ## t/t7601-merge-pull-config.sh ##
     -@@ t/t7601-merge-pull-config.sh: test_expect_success 'pull.rebase=true takes precedence over --ff' '
     - 
     - # End of precedence rules
     +@@ t/t7601-merge-pull-config.sh: test_expect_success 'Multiple heads warns about inability to fast forward' '
     + 	test_i18ngrep "You have divergent branches" err
     + '
       
     --test_expect_failure 'Multiple heads does not warn about fast forwarding' '
     -+test_expect_success 'Multiple heads does not warn about fast forwarding' '
     - 	git reset --hard c1 &&
     - 	git pull . c2 c3 2>err &&
     - 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
     -@@ t/t7601-merge-pull-config.sh: test_expect_success 'Cannot fast-forward with multiple heads' '
     +-test_expect_failure 'Multiple can never be fast forwarded' '
     ++test_expect_success 'Multiple can never be fast forwarded' '
       	git reset --hard c0 &&
       	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
     - 	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
     --	test_i18ngrep "Not possible to fast-forward, aborting" err
     -+	test_i18ngrep "Cannot fast-forward to multiple branches" err
     - '
     - 
     - test_expect_success 'Cannot rebase with multiple heads' '
     + 	test_i18ngrep ! "You have divergent branches" err &&

-- 
gitgitgadget
