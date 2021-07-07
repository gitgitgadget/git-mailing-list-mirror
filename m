Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F291C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA52461952
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGGDM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 23:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhGGDM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 23:12:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612F9C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 20:09:48 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l21so1798090oig.3
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 20:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyafR+DJnDEFJBQNIAz2A/jlR8f3VdyfPv9MLeQf2Vg=;
        b=C0Sdyu+TXSmiV77XbwXDsqMbw8ITlHzNhG0WN2W2+dBoKtPKjQRKrk4/eOccTYFyGp
         V+/DX3qYWW5H15Urw9p81VcT0M22Cw5sjtcBPGs8XE2G0QFHRyH6cDXWMFAKkP6rnx1p
         B3BZO/to3WXr7TqgZN+GIaFdFD21V0vHKcUhBTStprQtC1C/u0slailoRSy/qZ1PNiLD
         StN0qocRW2A21JHtF6gSM/MN0FZNZuLk+/FXTXfaZiBPSVCJW5x3ik6dv9KdP8hTApD6
         gTBOOm6RGb7BxWXyHszs34epEto59wUMVynREIxYE2bK0H1MUjKpgKzhx0/KK0Ls4Dy1
         be+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyafR+DJnDEFJBQNIAz2A/jlR8f3VdyfPv9MLeQf2Vg=;
        b=FI1eGoCyQyV264Lp2EXULEr6yQJ9nQyyNWYHAdNhYAlmA68J8Mzs4NhPJDfDxib+ur
         jNWur6BlT7MZqdszEQ84PDtxTiOPm4y8vj3hhooCTM/SpIbiT4lYq1CFVRjh6LkZqtgx
         zauzB5WEuWq+3Lhw3QqLaZXAnk80M+rgDTPRTPQtDZ/o4REv/Q49xCDKDuNIyxetmWX8
         ZdPNFlk94h05lDb98o/wAwCq2X3dFcAj6veruw7nlZ1Zoy32aYYY9eftVldInHxRTdRc
         WES5qcweQd/yRns1zl4/iPMZ/pf3ZBcwiEVjdQvmcGE0kvdFx4SqTCMXFLGtmg3WHHEP
         ZoOw==
X-Gm-Message-State: AOAM532HDASoiOF6H2doMqdSKvj+OhojhFBzfCfu8i7R1HQVdAbLxGc4
        uHIIpV6csv0f5fgC6ZM0wIYsjNtxnK4=
X-Google-Smtp-Source: ABdhPJwvsLIveyCeHqGoSKVMMW0Xi435WBY5/SbxPhbB1yFAWJYHBe4twHhEyfTf4H0RxubEse4OqQ==
X-Received: by 2002:a05:6808:56f:: with SMTP id j15mr3040043oig.162.1625627387444;
        Tue, 06 Jul 2021 20:09:47 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id a19sm1911626oto.25.2021.07.06.20.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 20:09:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] pull: introduce --merge option
Date:   Tue,  6 Jul 2021 22:09:43 -0500
Message-Id: <20210707030943.3135270-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatibility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 7 +++++--
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..d23128fa72 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -131,8 +131,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index b4ee05b39f..8f17b537cf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -129,6 +129,8 @@ static struct option pull_options[] = {
 	  "(false|true|merges|preserve|interactive)",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -936,7 +938,7 @@ static void show_advice_pull_non_ff(void)
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+		 "preference for all repositories. You can also pass --rebase, --merge,\n"
 		 "or --ff-only on the command line to override the configured default per\n"
 		 "invocation.\n"));
 }
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..6d03e0b9fe 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -60,9 +60,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
@@ -119,9 +119,9 @@ test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
+test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.32.0.36.g70aac2b1aa

