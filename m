Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EDDC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiL1SBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiL1SAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA11869E
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w1so3414956wrt.8
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAc2JEZYYZQHlHVtPzhQl3aiRKZwIYWHgqs1G5PNvTo=;
        b=TNYoy1WibrKLEvO33G5JuqNX4n892qIzBe7XDw00Jbhc+G/BSvr8/xhWJXa3jfQLiD
         TnG4xzvwvdYvSjZgkbKhAfXhltniCZzS4zeb3R2INfkn8tAQf5u2R/jZy/DuXPaEDI6F
         QvG7+HLE29rbu9srunnbMbr4/aQZzGTyw/599UnXQw83FcGAukT/z71WL6tODVV73r/h
         bFyY9XL3z/SErtRoZePGlfj8OkTSwP3AKxpreoKCTtjf19Z2unhq24G8mAIt8pCqa6fO
         Q1RiLyasoF1wg3Ec55oLQhERVQqhETJKj531lmGO3Wbkt9YEJ5JeTMJMYLMOrcj8vPKf
         vToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAc2JEZYYZQHlHVtPzhQl3aiRKZwIYWHgqs1G5PNvTo=;
        b=urNSxIDVHRvXPJV7dRJSFuJzFZ/YCI0togKd01EQ/ZVskJdsYG+HcRYymIxkCOuQKI
         3wKyfoZaBY1tTvuCUkBaGXNYK7P9uT9sow6q3k4uExhAuItCWH17t1VlE1FOe30NuIMG
         AVY7uI5vWebnzYZS0yMHb18unpVoZ0KKKs3A8f/4xlyXq5jkYAomq3ynC30LtDYDCfa5
         dv9PitD/TurmtIgOeLpJ66cW94W5No64NfcK7U8O9ktcw0HLVM/K1mNqGX42rarDKviK
         gSAWKGqKKC5gKpLTo72IWQHsYf9GRr6Eruf/vC3xNUbpkk/YmTkkNgUk76CcLfq4cgWq
         /jEQ==
X-Gm-Message-State: AFqh2kryVicukHZTkBbFM0Z/zLhU92uDMYueUzzAf26TKD5lCHk245Nc
        Blxpwc7/6skXJXXGrORgoavidNjo83vZMg==
X-Google-Smtp-Source: AMrXdXvI8BkDjkSbEJIXcKuTMFCyqiqXtkY5WBBqb2l0nkLRaqeSiAlReUwo6K8zF9CqnfPTAm4o/g==
X-Received: by 2002:a5d:5045:0:b0:27b:b974:2c01 with SMTP id h5-20020a5d5045000000b0027bb9742c01mr9493978wrt.71.1672250436862;
        Wed, 28 Dec 2022 10:00:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/20] worktree: fix a trivial leak in prune_worktrees()
Date:   Wed, 28 Dec 2022 19:00:11 +0100
Message-Id: <patch-11.20-ee05254eb6a-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were leaking both the "struct strbuf" in prune_worktrees(), as well
as the "path" we got from should_prune_worktree(). Since these were
the only two uses of the "struct string_list" let's change it to a
"DUP" and push these to it with "string_list_append_nodup()".

For the string_list_append_nodup() we could also string_list_append()
the main_path.buf, and then strbuf_release(&main_path) right away. But
doing it this way avoids an allocation, as we already have the "struct
strbuf" prepared for appending to "kept".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c         | 6 +++---
 t/t2401-worktree-prune.sh  | 1 +
 t/t2406-worktree-repair.sh | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..865ce9be22b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -173,7 +173,7 @@ static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf main_path = STRBUF_INIT;
-	struct string_list kept = STRING_LIST_INIT_NODUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
 	if (!dir)
@@ -184,14 +184,14 @@ static void prune_worktrees(void)
 		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
-			string_list_append(&kept, path)->util = xstrdup(d->d_name);
+			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
 	}
 	closedir(dir);
 
 	strbuf_add_absolute_path(&main_path, get_git_common_dir());
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
-	string_list_append(&kept, strbuf_detach(&main_path, NULL));
+	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 3d28c7f06b2..568a47ec426 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -5,6 +5,7 @@ test_description='prune $GIT_DIR/worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 5c44453e1c1..8970780efcc 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -2,6 +2,7 @@
 
 test_description='test git worktree repair'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.1153.gb0033028ca9

