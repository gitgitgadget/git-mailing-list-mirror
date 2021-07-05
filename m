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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCBC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCEA613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGEMft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhGEMfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E558C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so18125440otq.11
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkvncpALXIg5iSxdVNeDiPdx31gMIlchJV7kU3IwbQQ=;
        b=pzyXZyNRJr4cLSzo5EsJHUqO8HeSpMuU39cPAGRrLN0yAmuG8vTzK314a4CN0c4npq
         l4XwX8tpW2nWkgCryDk+IAV7hwRgEkwuz6V4m0zk2R+onEbP0g6QMz7FyD/QsnW2bMIi
         RyV11teqsCTFOsDtD6SbLFath0LBxbHUOy/1YuYboVpyYPKtewywy1ZcS4QKepE1g6Cb
         LGUvWpM+Um3rOqOCUfGuN9EJ+Zq0lKZn0BXhWLC4xD2Jh34ANOX7xqWeuFsSLd4220FH
         9/l5/q+hKEQ1r5w7cgFr01d4SXQGAAmH65mVJhIWJdOmRo6pB/GKPXxOYT8K1MRE9Cej
         M4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkvncpALXIg5iSxdVNeDiPdx31gMIlchJV7kU3IwbQQ=;
        b=b2JphP+0aUle4PUvUb3dw++dob8/iDiiV9nVOPK9vhLujnM5yJTfKbYZxdDicEZFU/
         FCqUOzAx04Nw8whGyfEoRdT7kKBILl2NtzTrZbsP+tUHDbJroIVH16OEdMiE8p4/zW0J
         ZLSRTGYoT5ChgvOskbnd/lywPhS+951zt0fcyviATEZcC5Z/QQDU6rqVhvlHukzpWWEf
         HcAjx6LexqHBcJ4SUmFBAIyxsHajlULKp7cHjlVXFt7/8QpiN+28wr8Dp/W1a+82Ajxx
         iOJ/4NQ1M+anyw0wSRw9bcolPKVUWPQTb8V/7Q/96hy/zi1fe6QriLcHobJgadwCSkGv
         3LtA==
X-Gm-Message-State: AOAM530yMGSS3JHBAgUPmnUGbHk7PnzNCy+MBU+lUoXwEXKQ4uz/1PK6
        i3ThcigOtZ1EUtRa5Xb6tSE/AoUPxLdBsQ==
X-Google-Smtp-Source: ABdhPJzV+JkuoAZRrq1+KB78ohm3Dw0mG99Zv265gZIxYuuvgYwqiHy1CG2HkpBkf6JsTejrPHKwtQ==
X-Received: by 2002:a9d:826:: with SMTP id 35mr1138169oty.121.1625488388299;
        Mon, 05 Jul 2021 05:33:08 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x130sm351109oix.22.2021.07.05.05.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 33/35] pull: advice of future changes
Date:   Mon,  5 Jul 2021 07:32:07 -0500
Message-Id: <20210705123209.1808663-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have `pull.mode=fast-forward`, we can make it the default any
time we want to.

For now, simply explain the upcoming changes in the default warning, and
mention how to turn on the future default mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 28 +++++++++++++------------
 t/t5520-pull.sh              |  8 ++++++++
 t/t7601-merge-pull-config.sh | 40 ++++++++++++++++++------------------
 3 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 27ce2f2183..4771c953d2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -979,19 +979,21 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 
 static void show_advice_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-		 "you need to specify if you want a merge, or a rebase.\n"
-		 "\n"
-		 "  git pull --merge # the default\n"
-		 "  git pull --rebase\n"
-		 "\n"
-		 "You can quell this message by running one of the following commands:\n"
-		 "\n"
-		 "  git config --global pull.mode merge\n"
-		 "  git config --global pull.mode rebase\n"
-		 "  git config --global pull.mode fast-forward\n"
-		 "\n"
-		 "For more information check \"git help fast-forward\"."));
+	advise(_("The pull was not a fast-forward, in the future you will have to choose\n"
+		"between a merge or a rebase.\n"
+		"\n"
+		"To quell this message you have two main options:\n"
+		"\n"
+		"1. Adopt the new behavior:\n"
+		"\n"
+		"  git config --global pull.mode fast-forward\n"
+		"\n"
+		"2. Maintain the current behavior:\n"
+		"\n"
+		"  git config --global pull.mode merge\n"
+		"\n"
+		"For now we will fall back to the traditional behavior: merge.\n"
+		"For more information check \"git help fast-forward\"."));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index b3b70d145f..bc1c601b8b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -923,4 +923,12 @@ test_expect_success 'non-fast-forward error message (pull.mode=fast-forward)' '
 	test_i18ngrep "The pull was not fast-forward" error
 '
 
+test_expect_success 'non-fast-forward warning (default)' '
+	setup_non_ff &&
+	git pull 2> error &&
+	cat error &&
+	test_i18ngrep "The pull was not a fast-forward" error &&
+	test_i18ngrep "in the future you will have to choose" error
+'
+
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 47fd2e2d05..16d1e1ba47 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -30,65 +30,65 @@ test_expect_success 'setup' '
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.mode set' '
 	git reset --hard c0 &&
 	test_config pull.mode merge &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c0 &&
 	test_config pull.ff only &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c0 &&
 	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
@@ -96,65 +96,65 @@ test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+	test_i18ngrep "in the future you will have to choose" decoded
 '
 
 test_expect_success 'pull.mode set' '
 	git reset --hard c2 &&
 	test_config pull.mode merge &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "in the future you will have to choose" err
 '
 
 test_expect_success 'merge c1 with c2' '
-- 
2.32.0.36.g70aac2b1aa

