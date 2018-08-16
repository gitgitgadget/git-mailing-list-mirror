Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB081F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbeHPTFm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:05:42 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:42136 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392167AbeHPTFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 15:05:42 -0400
Received: by mail-lj1-f182.google.com with SMTP id f1-v6so4073349ljc.9
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mn+u9PDZu0ToX0GF7M2juGl5WrCUSwnIqZOj6+yGVIk=;
        b=M8wXVx48kqg8q71SzWGkGlw+QucbnJoATy3K0uLYtGUcLo/WPeFTtFLhOaCg+XRLIx
         Lg/HRNS8ZRxi51FnwmHVIU/IL3emYQKn42DVnbUzjS6BFFUxk3XzcaVRJE9U9cbrlzdz
         5fb1dg4u/3rzJd6svG4F8FrShGtW7XCib4GxkVbQGQGmCOUfFh2yTEeogy1UB+IM//sh
         WE4pRStlBpUIkJrXY7Ql/8Nea7IllE/OPEMDeNssYRxe53emIKW73Kj4qQdmdWp+tDm8
         OLgNLkN5iuilQUqHlJyePI9+jlB0Z32y60SVHWrONPwC3XrbqTLfXRuMkpdscrD5x3q3
         qbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mn+u9PDZu0ToX0GF7M2juGl5WrCUSwnIqZOj6+yGVIk=;
        b=BqRZ1e7mtuF8xFoUyr0PvuklQ9S+S89lurqgseD70LvUqlvFPykf7UpTTW35sW80Sf
         dk9cEckZ/Z+KyBJlYuS8AfPXERfNLNm5LoEVclFmQcmaWf8eihiXRxwo4CairWwbSjoQ
         Za0Q78mcDXXrx17BMHmYT62xX1aXcspP1+3e0HH/Brj4aHPJqyTFFjTl/kTcclxtvc5d
         rcs233JXQuJoT+tTFJ0cyc+GB97x8oZhQE5CcnyiuZvB2dEL9ILizXWUfXOKNgy5ayqn
         r7Li5UjV3Rk8FIZTARIaUySIPlpIfYAkNHRSQ4jOfp6tFwOyujJVAZVwrcn3oWZCUEhk
         K3mw==
X-Gm-Message-State: AOUpUlEsIh46HvQKrZRXlniuLcTlP1tyTFRlwYEjM0QNYhVrhGKYbIW7
        LdEagQ+jyvKFegvNMZ1yHDyIH+13
X-Google-Smtp-Source: AA+uWPye1SEdv7cbqvuWOa/WFMNhEO/DPZ0CVxdcaVPdgekhyNTeJk1Bw1LCe6e7FCcsWXIuSJ9FkQ==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr5691253ljh.82.1534435577870;
        Thu, 16 Aug 2018 09:06:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 73-v6sm5010518lfs.44.2018.08.16.09.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:06:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
Date:   Thu, 16 Aug 2018 18:06:08 +0200
Message-Id: <20180816160608.20351-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
References: <CACsJy8CkXRc9NXRHt3a7=v04to0bMTvZo9x7zYNZWPiGDKQqdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--quit is supposed to be --abort but without restoring HEAD. Leaving
CHERRY_PICK_HEAD behind could make other commands mistake that
cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
work). Clean it too.

For --abort, this job of deleting CHERRY_PICK_HEAD is on "git reset"
so we don't need to do anything else. But let's add extra checks in
--abort tests to confirm.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/revert.c                | 9 +++++++--
 t/t3510-cherry-pick-sequence.sh | 7 ++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 76f0a35b07..9a66720cfc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -7,6 +7,7 @@
 #include "rerere.h"
 #include "dir.h"
 #include "sequencer.h"
+#include "branch.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -191,8 +192,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 	opts->strategy = xstrdup_or_null(opts->strategy);
 
-	if (cmd == 'q')
-		return sequencer_remove_state(opts);
+	if (cmd == 'q') {
+		int ret = sequencer_remove_state(opts);
+		if (!ret)
+			remove_branch_state();
+		return ret;
+	}
 	if (cmd == 'c')
 		return sequencer_continue(opts);
 	if (cmd == 'a')
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b42cd66d3a..68b8c14e27 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -103,7 +103,8 @@ test_expect_success '--quit cleans up sequencer state' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --quit &&
-	test_path_is_missing .git/sequencer
+	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD
 '
 
 test_expect_success '--quit keeps HEAD and conflicted index intact' '
@@ -132,6 +133,7 @@ test_expect_success '--abort to cancel multiple cherry-pick' '
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
 	test_cmp_rev initial HEAD &&
 	git update-index --refresh &&
 	git diff-index --exit-code HEAD
@@ -142,6 +144,7 @@ test_expect_success '--abort to cancel single cherry-pick' '
 	test_expect_code 1 git cherry-pick picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
 	test_cmp_rev initial HEAD &&
 	git update-index --refresh &&
 	git diff-index --exit-code HEAD
@@ -162,6 +165,7 @@ test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 	test_expect_code 1 git revert base..picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
 	test_cmp_rev anotherpick HEAD &&
 	git update-index --refresh &&
 	git diff-index --exit-code HEAD
@@ -239,6 +243,7 @@ test_expect_success '--abort after last commit in sequence' '
 	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
 	test_cmp_rev initial HEAD &&
 	git update-index --refresh &&
 	git diff-index --exit-code HEAD
-- 
2.18.0.1004.g6639190530

