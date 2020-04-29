Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2B1C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F2C2073E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT7gVOJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD2K04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgD2K0v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F80EC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so1849681wrw.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=pNBWmxi/svDetC05U6KLgXbiXOqB9Vcrn/INjtJYlpE=;
        b=MT7gVOJp3IXqTlE2aXfeYSfCud4ZptEuKF1rOv6kJGlIplT4XP08nQ9U2Y4TRBrmve
         FflZzPmznGrcSPWVLc7FLWTPGYkdxw7kfs0vASnu2iGZFVY/gfu2j2r6pTxQHwD8vb64
         8xpSqR5jApLtxBzHYOgX6r2UAg37maN20WEqltj//cNDQr3dg36/aqSMjlAg9QhlF85I
         MS8gWFNQxwQW6MyEtvzKbs/A97YGSKaCDJOp5YeCh6y4HeTyi3qeZTLkfjikq4yQ8smf
         pEfiOdyRrrqGGi49sd4r5pme61mieduEoRTqKAs8VangU4a9gqs6/wX6sC/6XXVeDx1e
         58jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=pNBWmxi/svDetC05U6KLgXbiXOqB9Vcrn/INjtJYlpE=;
        b=ModH6Pk/NR31eXp6Rwhf3JyxCb5cbtefmNyMIvzJTPTfnw0s107z7Wi2234y39IgHA
         DReAxuNczC2/ORQP1dj3MmDSO/duSZ8J9VMOky1MQ4DCNj7yvBzgtVktxVUKP6m04aXS
         3WKUwAIuQUFsDErqKi91UmqqnNIOoRbo0OP8SUFUkabVf5ygwe3B8omtkLQjZQpznQRd
         1RowHr/hoj8uyhd0sL0cxFdgzZUKdgUp4KZ6HgTcvdNNtzvbJrD0leVJC/9CNXb9ImzY
         Gm1T5/fOkEuBbXNZvbIdTGxTDooDxCvPBZhcBngJ3rblxCMg3q5+UK9F7MlKq/EziwWX
         TNfA==
X-Gm-Message-State: AGi0PuYPS1iYGecVoTfOzQE/imLShaHs/h9+ir7Bgtt/eCX7aY4AO7hr
        EZWFO9aepgAwytqVP6eWyG3vKP8a
X-Google-Smtp-Source: APiQypILGJwvzwtZjSn1DUa9k2btDcOM3+kTU/8zDT5TFBqImEjDug72pPR64zUswmReqRpChdSAgQ==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr39164603wro.409.1588156010015;
        Wed, 29 Apr 2020 03:26:50 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 5/5] rebase: add --reset-author-date
Date:   Wed, 29 Apr 2020 11:25:21 +0100
Message-Id: <20200429102521.47995-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429102521.47995-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
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
 builtin/rebase.c               |  6 ++++--
 t/t3436-rebase-more-options.sh | 34 ++++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96c7125791..0020b97110 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -443,6 +443,7 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index cf86240bc8..911587690b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1519,8 +1519,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_BOOL(0, "ignore-date", &options.ignore_date,
-			 "ignore author date and use current date"),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-author-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 6cd3848689..2ee7346562 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -137,22 +137,22 @@ test_expect_success '--committer-date-is-author-date works when committing confl
 # Checking for +0000 in author time is enough since default
 # timezone is UTC, but the timezone used while committing
 # sets to +0530.
-test_expect_success '--ignore-date works with apply backend' '
+test_expect_success '--reset-author-date works with apply backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --apply --ignore-date HEAD^ &&
+	git rebase --apply --reset-author-date HEAD^ &&
 	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works with merge backend' '
+test_expect_success '--reset-author-date works with merge backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date -m HEAD^ &&
+	git rebase --reset-author-date -m HEAD^ &&
 	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
-test_expect_success '--ignore-date works after conflict resolution' '
-	test_must_fail git rebase --ignore-date -m \
+test_expect_success '--reset-author-date works after conflict resolution' '
+	test_must_fail git rebase --reset-author-date -m \
 		--onto commit2^^ commit2^ commit2 &&
 	echo resolved >foo &&
 	git add foo &&
@@ -161,17 +161,17 @@ test_expect_success '--ignore-date works after conflict resolution' '
 	grep +0000 authortime
 '
 
-test_expect_success '--ignore-date works with rebase -r' '
+test_expect_success '--reset-author-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
-	git rebase -r --root --ignore-date &&
+	git rebase -r --root --reset-author-date &&
 	git log --pretty=%ai >authortime &&
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
 	test_must_fail git rebase -m --committer-date-is-author-date \
-		--ignore-date --onto commit2^^ commit2^ commit3 &&
+		--reset-author-date --onto commit2^^ commit2^ commit3 &&
 	git checkout --theirs foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -181,16 +181,26 @@ test_expect_success '--ignore-date with --committer-date-is-author-date works' '
 	! grep -v "+0000" authortime
 '
 
-test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
-		git rebase -i --strategy=resolve --ignore-date \
+		git rebase -i --strategy=resolve --reset-author-date \
 		--committer-date-is-author-date side side &&
 	git log -1 --pretty=%ai >authortime &&
 	git log -1 --pretty=%ci >committertime &&
 	test_cmp authortime committertime &&
 	grep "+0000" authortime
  '
 
+test_expect_success '--ignore-date is an alias for --reset-author-date' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
+	git rebase -m --ignore-date HEAD^ &&
+	git log -2 --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime >output &&
+	test_line_count = 2 output
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.26.2

