Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B9C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBBJx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjBBJxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677215552
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so918202wmr.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17Rlx901S0kqKb8WfSVS1uJY7ZdJnravOGWVxGkcUmE=;
        b=dpwf1jl4nLgtL5gfzlltCP5yaXLTrcgxzik3Yt7zl7pyEdEo9lXlcSCK03DgkUxSFO
         O2ZMakhh8op+oXI0CvRrJHR9jAkyv8HYSt+tXHWeI3E3YSsSwbnLaEyxEcEPVac3idc0
         XBkeTy4DZjOoCW5Dl7hH00KnJsIH520BfTTU3Rx3m+C+2UMzOFbWISH0Ny8DvmvG/5s2
         BoReDbhEPUBuRFocu8GxsW91KqlIQitfMpIRjL45HbWiqTTkEXlFpDyN+FsqeNw1np5D
         sakMsetfS6w4cqD/rYP2FBDhOZQw/OK7wbyfpAttIuy8M8jgujiFwhrO0FeTglBXFatC
         tbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17Rlx901S0kqKb8WfSVS1uJY7ZdJnravOGWVxGkcUmE=;
        b=rrpGZTid14UZwBrv7XA+Iv9mmAfGws3RHJ+Ifw7ETHxFPfl9y0VbHvWeVfmNZ0Qzuw
         O6SCE6q7aPDZW9fu341w+5W9YyzZfLJZSRRasjEReDQZ4UkaD5RZ7GXVklkpW1tzLaR5
         lImuXEoYh6jQegXl8GsvmWojAkqwK5e0BVfcipHugv4Rm+F9m6/h7ZMJ6ArBGNaSiJuw
         RbePd9Ytbr0m+tsTDqXMAQASwyS4jsObqNvhBvHfgmy4zUZHZ0/NWB5WK5e+FhtLYrLB
         6Q+0Zf49+r0DxIic2eTxLJ2ImS9EH4+Oy54wW/uvoWcxC0jLMVawzvI/cCluuDXJlf6m
         9P/A==
X-Gm-Message-State: AO0yUKXm2DHX3qVm2dbD3BCuIS1UoXi0E73Fw95EtU5gYwE2bIiBRLQ1
        scKOWnb+eiq/E1a7z5e8XK/AawzYh3qr12Jm
X-Google-Smtp-Source: AK7set+H97PCIyp7v1phKETiNumAnz23zMxPfN+anKAIlTOYtyCx8AanhLaWxiuoVZTmIEaHrQtKGA==
X-Received: by 2002:a1c:4c12:0:b0:3dc:16d4:a99f with SMTP id z18-20020a1c4c12000000b003dc16d4a99fmr5223593wmf.8.1675331584849;
        Thu, 02 Feb 2023 01:53:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Thu,  2 Feb 2023 10:52:39 +0100
Message-Id: <patch-v6-08.19-cd3eb9e68ff-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
index f51c40f1e1e..254283aa6f5 100644
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
2.39.1.1392.g63e6d408230

