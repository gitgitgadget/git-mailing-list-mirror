Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC90EC433E3
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C481720758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDMm3opO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGMKLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgGMKLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 06:11:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9DDC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:11:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so15562292wrm.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=svJ05EVtCQYdiwTXj6EcGRWszaHhcwFTfNHUnaxmh8g=;
        b=PDMm3opOKsLx2OwEIf9GNLq9r7+YxN12An/BvF6DMFqy32cXKuxEbryzMDjP/6Qyn1
         nOqZ3PzC92roz+P+eOcM0lZTZSKZfZRifUtDIupMChVKv3flcmh9XyYSbggrygeekjnC
         GP8JDM/QuZh1gfpStW6lSeGVBMMq83ZMW4EbKfEzMPtNa/zjkoHEDeFd8TiF86tLGIBM
         mjDtz084rfjP6qTXOkUsvz7MS4pGbRpBLqOLaaZkFR+gf1E99e7q+RoR/jGlz8WBSGTp
         wmgDm9tuhUK0gc3VOTA80oEOHvP34fkS+IMu35i4FTVmA0E+feTZSnFHPWegqQKUekTt
         uuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=svJ05EVtCQYdiwTXj6EcGRWszaHhcwFTfNHUnaxmh8g=;
        b=eSMktr2LYonhlGpkRRtytTXlS4CNPWPLBomhTg9DgG6YIQBnW46UMTqUCB+A8wexfH
         ZwsIUu+r9qLVR6OH6xuF8iHrwwrqGnfIIO/m5THJGk+vjT/V2+Lr7vKQlWHYH/gHY4iA
         F53B/fwytiNgsJz/whgGMe3pLTH71Cdh/QNvEo/TuyxGOFZDSWemoc8pQcjvgK8QdL/z
         d/Oj5BzU8hQ4NseseY+E/jazigXzqLlYL9smYHWeWYcA/UFiSMdAeRi7MJgZgsRkVF4s
         fKQkM1/uiQcI10fWAGTnMYsypQWCa91mOMBPlknD6lAS/JwLA22T/5sa9OKOzlps4OWp
         LwXw==
X-Gm-Message-State: AOAM533jQvuDRoY3yHNmPJ/RFrxvRebXYmVbwnIQWzgtlvonHvzODsoz
        TufIuf5s05ER1YT2Mf1Ls2M=
X-Google-Smtp-Source: ABdhPJyNk9NM8mStsF27UqqbgqyeZJrgAbIrxYU18Qr3XXXbHpyCIqZZxqwkJHIHPMgYTwCu153LnQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr77842219wrj.273.1594635057873;
        Mon, 13 Jul 2020 03:10:57 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id v7sm23811549wrp.45.2020.07.13.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:10:57 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v6 5/5] rebase: add --reset-author-date
Date:   Mon, 13 Jul 2020 11:10:45 +0100
Message-Id: <20200713101045.27335-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713101045.27335-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
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

