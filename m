Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiL3CTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiL3CSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A21705F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so28876558edc.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwY/rw3XQB9PSPpd72bwLHGQPxrK+BM6Q0jY0901V44=;
        b=I4CmsCauH9GOoYss/omM6m6alt+ofJfc6+mRd9dlBFd7Alb5zUTDebDgD1HD4p2S7m
         4rwlgO12dfh2eNFPWCyB6DMeSeRA4HqVPa/oyKbwmYQVGiwy4zcgrkhasEpsl4tXOnM1
         rgNau+tUk48M6bIKqYJLkdIs+DpOHcTKiZGRcvntORZm7DCDidy/yMp5MKkjuImMw35b
         GL8GnrIDgaGH2ob8OP+0HJJwgFCvh+RdVsDhlLUNs+4aO545re4DpfkIimeITcFzcJLt
         hCX2cevoenHjqBbwJKRLNSFkm7G0i1L9L3E2GVivyfqk8NLxM/Accg15yUQ23kQlvaLm
         9Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwY/rw3XQB9PSPpd72bwLHGQPxrK+BM6Q0jY0901V44=;
        b=Y6bJi8y5tP2z6Ye/KMk4sFh5gpCZWARHh/aeRfvYE/GgRy2QYapwhmtMUAu4cnDQPP
         xkiZLp1h3vPR5MNFMGvrz/nV7sX/AnL3X3EL/KnP01o/boZH59hH8rfEGBhV9CY3q5DD
         tfkaPBAbi41eZYyvkM7aubdmK6cMwFs7WoEFYyzwUmXH4RW0Ij2dErhThagKTFD18NOh
         t5p+A86vQczL5tBRmIUFkP4M6Fq2uTYSuJaRWeHlhjeUJj7lNDjBj8APF3a7KYUsdgiV
         gbf9sIRYUqz0U8E2OygqVMCwjEKa83G3ZkVwwune1h45kJbM/3p9vExFjgtDjiEFRm40
         a0XQ==
X-Gm-Message-State: AFqh2kq4IO/87xMlfwRdsxHhUit9Nf8qAFpabgSsM2vjrhaAAX1weYyR
        RrxYfvK9ciUpf8YqN35zbpp5SjRwBidgjA==
X-Google-Smtp-Source: AMrXdXsXd9+Tq9pTZ2M5YXhcdVizjmBrrzP1bsbcVvseaOjTPfXrEXkhyoE5TinBFEhBUS8RvQtiZw==
X-Received: by 2002:a05:6402:914:b0:479:dc9c:1144 with SMTP id g20-20020a056402091400b00479dc9c1144mr27720628edz.24.1672366726717;
        Thu, 29 Dec 2022 18:18:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/20] worktree: fix a trivial leak in prune_worktrees()
Date:   Fri, 30 Dec 2022 03:18:23 +0100
Message-Id: <patch-v2-08.20-468615570f4-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

