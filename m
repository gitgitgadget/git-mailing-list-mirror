Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C10C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC3E64E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhBQVD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBQVDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:20 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE593C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:40 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x14so58094qkm.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlKzLEa7xdFWXMBcMcWaeCRbNT3v20gR1UMHkOSLheI=;
        b=DPCOb/cc/DuG3SSMzJFZm7FdhbIlwgfOixBuX24EnEm7MZMJOz4s4GTmFMB65qbndm
         czuxboRn9AyDHZCvLHlVJxQbrCwAHGQJOvfdlTF/QOSGf9oTgbpm5G5DJEBGzXjZL0JX
         +P/q4rtlVfXp8Mo6q5N6nO38d8+KkJ6bxYy51lo/WVYQFr9IEi6mfbz0uEbuq/hOEVby
         PY83FkpfLmpkBAdUctpvdkzHAcACRewp7z6KeEqxXKunmR2YogQNn9ipZ4Nmu6Qjd1Nc
         t5lFp9Moc3wIyCYO6itM9DIFLSbbhe07+XuUh4M8okbx9aOokNC0Hu3ISFHLB+IHLhbh
         fOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlKzLEa7xdFWXMBcMcWaeCRbNT3v20gR1UMHkOSLheI=;
        b=kHyYOWiE974AP+2CcyBZKRw9dE61nVUz5vu8XnlixoSEKCCLMp538F7JOb5B1BGxcZ
         V3fCQ5ej/+40B4ousqc41QVaKpO0z+ujFo2eWRuy93hzVylPYZjG7+dQ5m5R5R0nQvSG
         wOmhfd+4gVdulexY2dl/6Mwkvf/0BOBa4D1nXKKRdd0/tZjYgSYGgieRaXmLil4MGl8/
         PFF6AEcLB7Bi9bws4cklR8j7u31xD7OHP+syPIP8c2V9ElUzJ/9iGLDQN0JYIedjtll+
         NFLxdgQcJu7jr9yryjQMyYE6+H4ZeHuObiGgrX7HivP/hpY6iVeVzI0dpttV7H9s0FSj
         kzrQ==
X-Gm-Message-State: AOAM532nrc2r4LG3iJBmjYVNyc0zhTOYo3b6u2PNwXAxGfZ0/x1Vdsge
        kSsn0xjnSu51DqU3nD6E+/cig4XCrC9M/A==
X-Google-Smtp-Source: ABdhPJxIEK/x90QVW6H1HBBknqwYuH91ZM/pPxzup6UAtSzbtDx1wGLi1WcWAnZ7oIgzvHSLj2IKIQ==
X-Received: by 2002:a05:620a:1354:: with SMTP id c20mr1161741qkl.104.1613595759604;
        Wed, 17 Feb 2021 13:02:39 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:39 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 1/7] add --chmod: don't update index when --dry-run is used
Date:   Wed, 17 Feb 2021 18:02:24 -0300
Message-Id: <2256132f9de01cc06a001aa8c44e29dc5a218441.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add --chmod` applies the mode changes even when `--dry-run` is
used. Fix that and add some tests for this option combination.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  |  7 ++++---
 t/t3700-add.sh | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a825887c50..f757de45ea 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,7 +38,7 @@ struct update_callback_data {
 	int add_errors;
 };
 
-static void chmod_pathspec(struct pathspec *pathspec, char flip)
+static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
 	int i;
 
@@ -48,7 +48,8 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip)
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
-		if (chmod_cache_entry(ce, flip) < 0)
+		if ((show_only && !S_ISREG(ce->ce_mode)) ||
+		    (!show_only && chmod_cache_entry(ce, flip) < 0))
 			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
 	}
 }
@@ -609,7 +610,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= add_files(&dir, flags);
 
 	if (chmod_arg && pathspec.nr)
-		chmod_pathspec(&pathspec, chmod_arg[0]);
+		chmod_pathspec(&pathspec, chmod_arg[0], show_only);
 	unplug_bulk_checkin();
 
 finish:
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b7d4ba608c..fc81f2ef00 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -386,6 +386,26 @@ test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working
 	! test -x foo4
 '
 
+test_expect_success 'git add --chmod honors --dry-run' '
+	git reset --hard &&
+	echo foo >foo4 &&
+	git add foo4 &&
+	git add --chmod=+x --dry-run foo4 &&
+	test_mode_in_index 100644 foo4
+'
+
+test_expect_success 'git add --chmod --dry-run reports error for non regular files' '
+	git reset --hard &&
+	test_ln_s_add foo foo4 &&
+	git add --chmod=+x --dry-run foo4 2>stderr &&
+	grep "cannot chmod +x .foo4." stderr
+'
+
+test_expect_success 'git add --chmod --dry-run reports error for unmatched pathspec' '
+	test_must_fail git add --chmod=+x --dry-run nonexistent 2>stderr &&
+	test_i18ngrep "pathspec .nonexistent. did not match any files" stderr
+'
+
 test_expect_success 'no file status change if no pathspec is given' '
 	>foo5 &&
 	>foo6 &&
-- 
2.29.2

