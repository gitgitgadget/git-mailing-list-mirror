Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C4C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbiE0KI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349501AbiE0KIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E01269BF
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j21so3519898pga.13
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJP5b9P6losgPncHtZwywxjunAKi/o380S1YJI5MGvo=;
        b=hQyRScJciHARiKbZAN1K0e+4NTm3AC7Of87z334/Moj1a8BCT/xh/U2YpuO2+/P3Mz
         PJZHhDFL2AHAJeOS0Emb/y8hzgESv9ft8FpvOr+dfPdbUWBn/PaEBB9SFEkZa9npTt42
         hi1MixVb4kgcXeRGUHJVcKqaqvlhYUZCnkpfATyMMxFwO9uityVTiU5LJpbhJ3K3bAJ9
         LYgm5XwMU/Sn8ICNPHBfJUxGJ0k5gd4qJ9nDyeOESTUMiC50lipNazX8Dw64aWWJZoUO
         UlAmyHSWIi0IFIBbboqDQ/Ltnocbt6H0h5wDTJId61yoxPg5n4hFK2STBGJbxlj2hXun
         nSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJP5b9P6losgPncHtZwywxjunAKi/o380S1YJI5MGvo=;
        b=eHo5IJz7HrxGBjJEUIoq57Kp11eJIVCDzAmiJktHno0gyhjYvgJyXxtgmerw3FK2ir
         QPf1Vk1IfWmMjtinL8waWAx20itz1qkdTt0cyY8/DFaynsRqoKY6zepDpUEaKKI8X5Uw
         JD0+QV8R3MO7DtyE6SG/iPk81W6Lg7TTfp6XeUH8rfRmKzuQxaHc55taqLhzmd9+l/jD
         bsuOMYvPD8Wo2ToAy1MsenwuFXzjLhGDf5gW9bpeU19O04P0bkqGGUjkGDFTv7GOpZZg
         rYJmFa6joE4Q1MCSmbgKpWvrz+S+TJOJIaE4UW8/dR3e6lV4SHbzN07kDcZiUeX8T08X
         etVg==
X-Gm-Message-State: AOAM531EtcW5Ft2/12hlGlCWTrf4GV7NS51YALz8m4MXEMklsTXkguoY
        t91HDmlWnlwyV7EXvXfn058sb3ZIaa3WLQ==
X-Google-Smtp-Source: ABdhPJzDEhLEr7YQcewfEqavMaJLtMGKpJv2e8GmDLnn9U5GnG5mWJXmFSE7idkhkxNebDm+VirssQ==
X-Received: by 2002:a05:6a00:14c6:b0:518:abc2:56bc with SMTP id w6-20020a056a0014c600b00518abc256bcmr22892916pfu.72.1653646100281;
        Fri, 27 May 2022 03:08:20 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:19 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 2/5] mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
Date:   Fri, 27 May 2022 18:08:01 +0800
Message-Id: <20220527100804.209890-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> file which is not on-disk but exists in
index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
out with "bad source".

Change the checking logic, so that such <source>
file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 26 +++++++++++++++++++++++++-
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..32ad4d5682 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
+			/*
+			 * TODO: for now, when you try to overwrite a <destination>
+			 * with your <source> as a sparse file, if you supply a "--sparse"
+			 * flag, then the action will be done without providing "--force"
+			 * and no warning.
+			 *
+			 * This is mainly because the sparse <source>
+			 * is not on-disk, and this if-else chain will be cut off early in
+			 * this check, thus the "--force" check is ignored. Need fix.
+			 */
+
+			int pos = cache_name_pos(src, length);
+			if (pos >= 0) {
+				const struct cache_entry *ce = active_cache[pos];
+
+				if (ce_skip_worktree(ce)) {
+					if (!ignore_sparse)
+						string_list_append(&only_match_skip_worktree, src);
+					else
+						modes[i] = SPARSE;
+				}
+				else
+					bad = _("bad source");
+			}
 			/* only error if existence is expected. */
-			if (modes[i] != SPARSE)
+			else if (modes[i] != SPARSE)
 				bad = _("bad source");
 		} else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 963cb512e2..581ef4c0f6 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -239,7 +239,7 @@ test_expect_failure 'can move out-of-cone directory with --sparse' '
 	test_path_is_file sub/folder1/file1
 '
 
-test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+test_expect_success 'refuse to move out-of-cone file without --sparse' '
 	git sparse-checkout disable &&
 	git reset --hard &&
 	mkdir folder1 &&
@@ -255,7 +255,7 @@ test_expect_failure 'refuse to move out-of-cone file without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone file with --sparse' '
+test_expect_success 'can move out-of-cone file with --sparse' '
 	git sparse-checkout disable &&
 	git reset --hard &&
 	mkdir folder1 &&
-- 
2.35.1

