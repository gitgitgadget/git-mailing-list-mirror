Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F5C433F1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B212067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZf8wXr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgGPRcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgGPRch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:32:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38027C08C5C0
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so7879518wrw.12
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=svJ05EVtCQYdiwTXj6EcGRWszaHhcwFTfNHUnaxmh8g=;
        b=VZf8wXr5G4ce02Rq1M0mDhZ7L/172vTApfqvVFUld6hjOYVkwBjHLDwo2UjXflZZ5e
         oodj5bKo5P3nGcla6sc1REnamWWOM3u2vl6RgEx4/O0aRBGwY8acc2f5H8lUg6zXVtTe
         1VxfaN/Nzhblx4PKstRrPFr5Mra0rc6OQI8Bto/IDqicflFuFRkbmaYB9avIDunegdbn
         e0boSHHvbhcsZ7UHp6O/l5myZCgwnSHLcQB/NnKtKZkLaCkrm1J2cExRyiqXktahKdk7
         QH4Bn7bM7Rlq6FYOW9IRm3iPm9n55vRw6KTAT3a//PtWo+icisovvRd9pt/DB3AXNxrZ
         FYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=svJ05EVtCQYdiwTXj6EcGRWszaHhcwFTfNHUnaxmh8g=;
        b=L++hg1gBVoPgpXCrnwK+tjeUaz1OZU7XIOeZAqpuSyppShpAcIObsiFZ1KrAQTvwEH
         DJ6EiDmbZ8z8CUseqKjupdsh47xyyvQ1ogb3Vlf4l2D/2wTFUmMvJ5L2SwepVkSE6ytT
         a0pJwEa29bAp1MdlGOHckIoQ2hIOw5YAUu0Yn/LL/Wh127eSydNJy2sxJivUk+PHZd3+
         7o8+ZovrJs5uZiSjqyW5xpPCHbIpeWtB0i5lS+LBm1hyqNrh7kL9vSx4S5QFkPwFq70d
         wF99sWVrQ9cBX68ti5zVhB+RCDj9gI6RQNSvmJsychVw4ZXir/K77YOus2udfs3fTCuC
         jRlg==
X-Gm-Message-State: AOAM5333vunBoOEWsrf0jnCboZqm3l0+GS2yMRw+Re/FTPkLwBnj7Wwo
        VFw0ZdrkvuXTwAGB8LQ0mtc=
X-Google-Smtp-Source: ABdhPJxO0IKxd2MKLgbMtc1ibqfg57Bu9/wJBPZNfnd7Lik3tm8sS26GWreUP2p1Xwo9xFX2Jlcnrw==
X-Received: by 2002:adf:c986:: with SMTP id f6mr6104679wrh.168.1594920755988;
        Thu, 16 Jul 2020 10:32:35 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id q1sm9890020wro.82.2020.07.16.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 10:32:35 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v7 5/5] rebase: add --reset-author-date
Date:   Thu, 16 Jul 2020 18:32:21 +0100
Message-Id: <20200716173221.103295-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716173221.103295-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200716173221.103295-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The previous commit introduced --ignore-date flag to rebase -i, but the
name is rather vague as it does not say whether the author date or the
committer date is ignored. Add an alias to convey the precise purpose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt   |  1 +
 builtin/rebase.c               |  4 +++-
 t/t3436-rebase-more-options.sh | 34 +++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e2717e20e6..a5f82913fb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -450,6 +450,7 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 583ac96fc7..b126fbe940 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1505,8 +1505,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_BOOL(0, "ignore-date", &options.ignore_date,
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
 			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-author-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 0ede2b8900..5b8963272a 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -117,53 +117,61 @@ test_ctime_is_ignored () {
 	! grep -v +0000 authortime
 }
 
-test_expect_success '--ignore-date works with apply backend' '
+test_expect_success '--reset-author-date works with apply backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --apply --ignore-date HEAD^ &&
+	git rebase --apply --reset-author-date HEAD^ &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works with merge backend' '
+test_expect_success '--reset-author-date works with merge backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date -m HEAD^ &&
+	git rebase --reset-author-date -m HEAD^ &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works after conflict resolution' '
-	test_must_fail git rebase --ignore-date -m \
+test_expect_success '--reset-author-date works after conflict resolution' '
+	test_must_fail git rebase --reset-author-date -m \
 		--onto commit2^^ commit2^ commit2 &&
 	echo resolved >foo &&
 	git add foo &&
 	git rebase --continue &&
 	test_ctime_is_ignored -1
 '
 
-test_expect_success '--ignore-date works with rebase -r' '
+test_expect_success '--reset-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
-	git rebase -r --root --ignore-date &&
+	git rebase -r --root --reset-author-date &&
 	test_ctime_is_ignored
 '
 
-test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
-		--ignore-date --onto commit2^^ commit2^ commit3 &&
+		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
 	git add foo &&
 	git rebase --continue &&
 	test_ctime_is_atime -2 &&
 	test_ctime_is_ignored -2
 '
 
-test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
 		PATH="./test-bin:$PATH" git rebase -i --strategy=test \
-				--ignore-date --committer-date-is-author-date \
-				side side &&
+				--reset-author-date \
+				--committer-date-is-author-date side side &&
 	test_ctime_is_atime -1 &&
 	test_ctime_is_ignored -1
  '
 
+test_expect_success '--ignore-date is an alias for --reset-author-date' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
+	git rebase -m --ignore-date HEAD^ &&
+	test_ctime_is_ignored -2
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.27.0

