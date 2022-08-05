Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5282C19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiHEDGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiHEDG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:06:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE89FFE
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:06:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj1so1563301pjb.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tO+nvSO883HQ6yqwLe/5TG7lDlnEVb9iMR8nxhoUMdw=;
        b=Mr5NogyAwoGaatGqGDnTwc+/beGVWhpadmko0GUfOrmeFadfcdBmWuN6ArzxAdBUJH
         ulMowMjiBnScGM+x/rLjrVFVgvLBI01qSqP/eZq2FRx35eWIs9TKmCLr5jVYBv2MzZL9
         aSJWzDhtg7iqJKd1zZH5hoa81ig5/1Yobn2BoNDRWdm1THCA/hxPh5flpicuGovWBO29
         RqzuthlcNdItd1lmDY41MW75USJ5rfAAf2adQoYM3kdXxh8knHclVGZaqoeQ+75BMIiV
         /+4MDQHtmWkKx0BMKume/aGDbNdI+ZbtYQNW5kMcilUknhij34YWrP9KYnHzsNQB4V7V
         US9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tO+nvSO883HQ6yqwLe/5TG7lDlnEVb9iMR8nxhoUMdw=;
        b=ipeN341xNko6q069no8tDyTwrab43h5up5W2gUcB5m+sMfDgMJl7cCjl/PN2afWkFo
         AWCo212lL8T/8C+6GcmdoZeugUpeJtdChccPFUzYyESr69+s76Q1yblQzRe+ultRImcY
         bw13IwzVZTjqfICL1vSKRKmJNLm5ROPYYUqE9jSfUwlQkAx34pbj15jBSg30UGClbHZG
         ECQaabXGcnYw+kUZYWhj0fpwOrL2SYOYXDtEpazz24RPs4QYInIz8zT7OP9SPFFIWiid
         89YsjgLibfNemp2ko+cj0sOQSsgp0Xso3qnb4YtPlLVqz4oYC+snyX3UMGxdcXULrR7m
         OeDg==
X-Gm-Message-State: ACgBeo1RynD0qvhlzKvB+zRc4EyDmUYJhR5AQuVtniT9OQ5suuk0YzVv
        derdz4J65yeBCvNUXl8cf2llKP+uVAFa8a+m
X-Google-Smtp-Source: AA6agR6USGxWbsqZi9oBQalQcfm3NPdy82O3pZ+81iqRsz4g5ISCbyUZFaGYX7JHyj0c0apQ4avqjw==
X-Received: by 2002:a17:902:ec90:b0:16d:d156:2c01 with SMTP id x16-20020a170902ec9000b0016dd1562c01mr4925810plg.114.1659668760651;
        Thu, 04 Aug 2022 20:06:00 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:06:00 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 7/9] mv: cleanup empty WORKING_DIRECTORY
Date:   Fri,  5 Aug 2022 11:05:26 +0800
Message-Id: <20220805030528.1535376-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
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
index e4a14aea2d..a58387a986 100644
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
@@ -304,6 +307,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 			/* last - first >= 1 */
 			modes[i] |= WORKING_DIRECTORY;
+
+			ALLOC_GROW(src_dir, src_dir_nr + 1, src_dir_alloc);
+			src_dir[src_dir_nr++] = src;
+
 			n = argc + last - first;
 			REALLOC_ARRAY(source, n);
 			REALLOC_ARRAY(destination, n);
@@ -487,6 +494,26 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
index fc9577b2a6..23d0c4cec6 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -366,6 +366,7 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
+	mkdir sub/dir/deep &&
 
 	test_must_fail git mv sub/dir folder1 2>stderr &&
 	cat sparse_error_header >expect &&
@@ -376,6 +377,7 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 	git mv --sparse sub/dir folder1 2>stderr &&
 	test_must_be_empty stderr &&
 
+	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1 &&
 	git ls-files -t >actual &&
 	! grep "H sub/dir/e" actual &&
@@ -385,6 +387,7 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
+	mkdir sub/dir/deep &&
 	touch sub/dir/e2 sub/dir/e3 &&
 	git add sub/dir/e2 sub/dir/e3 &&
 	echo "modified" >>sub/dir/e2 &&
@@ -400,6 +403,7 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 
 	git mv --sparse sub/dir folder1 2>stderr &&
 
+	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1/dir/e &&
 	test_path_is_file folder1/dir/e2 &&
 	test_path_is_file folder1/dir/e3 &&
-- 
2.37.0

