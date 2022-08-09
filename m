Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9DC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiHIMJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiHIMJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8C24977
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so10592471pfb.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6avJBto7zNLge1VSRuZ52yJVcL2eyC8pogf3vr8kk2Y=;
        b=GHjrSuHMK7L++aqUCZ34gAG5kpJ3SOPQWi9Fl+2GaLdfSJ+vWFMy/ZOrlmGy3Bux8c
         Qsf0+aBaTAIrhETLfqRUJ2jrUFMdjnMLc7yJ0rR6pTh3Y0NOABSf6POz94F+Z7S6Lj6f
         lrzXkK+Z6NpxL+Tmbu1FcVFDkFkkzitmHDG+OZDZZgStCik93FivOSSIjXCtjJGe/C8f
         cDhiSKBAm6erZo7U3Sj24RP/+VL4eF1Zsa4w/dWEuxvsgze9iXXJjqOSrIRJI3MmWHYR
         2wj7PHsfQp9p2+pOeT2CLTtdH3A334d4r6FTJ1QyLNjLgrQJBO4CKwPQNRPO8FCP2zyF
         GW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6avJBto7zNLge1VSRuZ52yJVcL2eyC8pogf3vr8kk2Y=;
        b=VSPHkpONUvr+tdgmIELwd1ceHn54YRJhIu3HGuIBNvZem8J9m16NGfUBnfkuI+7SRT
         B4pqWv1VRgSe2rOMZgmG1vMplDJiRio8qMfG8DRIA4OhxPy1sncy6grNzPGv6MDqAkI/
         wuKsyjXaxFLme9Bio4BMMtrHhuBHPuBfbO8i6LY6FnjEnozhBNhQsThFYiKP8MkpiWmP
         Fh2pAF1ejx5JuIUuN0Y3Vk5Wz/8YqCPuGDoEaB0P3muqeQ9uRxDxCnN/1st+NPinsILV
         WL/vrF3U5/31r+xnNcE4BEaRMeCDsMbEHS6lKo9Lz3b0K4mXrVaqDgnSOaxuz80C/dQy
         GvgA==
X-Gm-Message-State: ACgBeo1kZ5xystzb6yl7TLoLQ1AlQLjGPpe66jkLd0WtsyGx4ASv5WF0
        4rmBfzVExHIJ9OrwyldZvt0ZS4jR6o6uyQ==
X-Google-Smtp-Source: AA6agR7zqD8RGgmLo9yM8Hh3X2zSoQlJpUCtclq926WA107Dn/TyOTfsyoHIU+2Q5PWrDQLEorJGug==
X-Received: by 2002:a63:560e:0:b0:41c:590a:62ed with SMTP id k14-20020a63560e000000b0041c590a62edmr19692270pgb.250.1660046984807;
        Tue, 09 Aug 2022 05:09:44 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:44 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 7/9] mv: cleanup empty WORKING_DIRECTORY
Date:   Tue,  9 Aug 2022 20:09:08 +0800
Message-Id: <20220809120910.2021413-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving from-in-to-out may leave an empty <source>
directory on-disk (this kind of directory is marked as
WORKING_DIRECTORY).

Cleanup such directories if they are empty (don't have any entries
under them).

Modify two tests that take <source> as WORKING_DIRECTORY to test
this behavior.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 27 +++++++++++++++++++++++++++
 t/t7002-mv-sparse-checkout.sh |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 6a6420c984..32e7ac4896 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -171,6 +171,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
 	const char *dst_w_slash;
+	const char **src_dir = NULL;
+	int src_dir_nr = 0, src_dir_alloc = 0;
+	struct strbuf a_src_dir = STRBUF_INIT;
 	enum update_mode *modes, dst_mode = 0;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
@@ -314,6 +317,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 			/* last - first >= 1 */
 			modes[i] |= WORKING_DIRECTORY;
+
+			ALLOC_GROW(src_dir, src_dir_nr + 1, src_dir_alloc);
+			src_dir[src_dir_nr++] = src;
+
 			n = argc + last - first;
 			REALLOC_ARRAY(source, n);
 			REALLOC_ARRAY(destination, n);
@@ -503,6 +510,26 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/*
+	 * cleanup the empty src_dirs
+	 */
+	for (i = 0; i < src_dir_nr; i++) {
+		int dummy;
+		strbuf_addstr(&a_src_dir, src_dir[i]);
+		/*
+		 * if entries under a_src_dir are all moved away,
+		 * recursively remove a_src_dir to cleanup
+		 */
+		if (index_range_of_same_dir(a_src_dir.buf, a_src_dir.len,
+					    &dummy, &dummy) < 1) {
+			remove_dir_recursively(&a_src_dir, 0);
+		}
+		strbuf_reset(&a_src_dir);
+	}
+
+	strbuf_release(&a_src_dir);
+	free(src_dir);
+
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index d875f492dd..df8c0fa572 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -442,6 +442,7 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
+	mkdir sub/dir/deep &&
 
 	test_must_fail git mv sub/dir folder1 2>stderr &&
 	cat sparse_error_header >expect &&
@@ -452,6 +453,7 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 	git mv --sparse sub/dir folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
+	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1 &&
 	git ls-files -t >actual &&
 	! grep "H sub/dir/e" actual &&
@@ -461,6 +463,7 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
+	mkdir sub/dir/deep &&
 	touch sub/dir/e2 sub/dir/e3 &&
 	git add sub/dir/e2 sub/dir/e3 &&
 	echo "modified" >>sub/dir/e2 &&
@@ -476,6 +479,7 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 
 	git mv --sparse sub/dir folder1 2>stderr &&
 
+	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1/dir/e &&
 	test_path_is_file folder1/dir/e2 &&
 	test_path_is_file folder1/dir/e3 &&
-- 
2.37.0

