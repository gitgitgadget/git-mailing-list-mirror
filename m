Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C1C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiE0KIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbiE0KIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC921271B1
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z11so4163418pjc.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gC6e6S67vceQBgW0gDAauSnuDIu9RHshbM++lf6J+4=;
        b=gOg3JGzNSac7ttHjFvNGu3SbiKw6INLjr0HkRkjuWQqaubUKEiTOPoStDCvSZw5LYD
         dYfuEh6z83Z3q1p1YrfKoee1sCovjinLcvg0SwQD9nEwUzQRWIGoIxnhCJ+VP0O444qG
         KPd1F7VCWbKzkNuCwHUk5SX8wcjJw08U0tBNSkA57N6GTN9GONKuWoXX2EaXT5fntumM
         70pUxXPMa2TJ/iFzqOrOi2l+Z987ePTis/7ngT4zpJ4kXZf3K2OQUbG6X6R6NlR22Ohg
         /fTK2Mds6qkJ0AeGBTtPOQi3pUn+QmodDJzLodPtxcvdIQmfx0/G2UX6cYJ3KKVv7QfC
         RtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gC6e6S67vceQBgW0gDAauSnuDIu9RHshbM++lf6J+4=;
        b=XU0Zo6m6SE5FjW30DTe6rK1w9IG91wLDH1tTvD1HOx94u5TJB37t0jv82o9od18xJY
         GqkThQ/svxYxIBI0GtkNKd5zYr2r0dZmZJrNTzPYdV7pU7qjpuTxWYdqyKALgfeKBhqp
         nVI9J70LycXQjcJ81qUbooePA8kt92Y2DxBeQXY2TRVCqtjm7D1fepXPstsrTRduzEEN
         5g+Y94sbKjVPQhNqH3rVzou826/mm9D9iAnZ+RQUv+1BrsQ9cQqocXFnbYN7hYm6lYVo
         TwX+LW1XHrT56niMwagiIIecHCPjL7W8ifGZktBAk29v9PnRDmlzlnCJUaXJQqvraW+L
         6Hlg==
X-Gm-Message-State: AOAM532/zXU1TUDSXiHpJ8DiA+wy2ebF/cbX5C6F3kUndP9OsKO017JD
        BDjhUgmAGwQegG6QPQdMqQAuOLZpjD6/lw==
X-Google-Smtp-Source: ABdhPJz7hXeGJTZBHbit2qjMgIIwZrs5ejwx0tujaww/mGrMr0H0cE0ajZJe4hBDL0to04qXWsucyg==
X-Received: by 2002:a17:90a:8005:b0:1df:ecbc:bd2c with SMTP id b5-20020a17090a800500b001dfecbcbd2cmr7496666pjn.10.1653646110056;
        Fri, 27 May 2022 03:08:30 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:29 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 5/5] mv: use update_sparsity() after touching sparse contents
Date:   Fri, 27 May 2022 18:08:04 +0800
Message-Id: <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, "git mv" a sparse file/directory from out/in-cone to
in/out-cone does not update the sparsity following the sparse-checkout
patterns.

Use update_sparsity() after touching sparse contents, so the sparsity
will be updated after the move.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 19 +++++++++++++++++++
 t/t7002-mv-sparse-checkout.sh | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index e64f251a69..2c02120941 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -13,6 +13,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "unpack-trees.h"
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [<options>] <source>... <destination>"),
@@ -158,6 +159,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
+	int sparse_moved = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -376,6 +378,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		if (!sparse_moved && mode & (SPARSE | SKIP_WORKTREE_DIR))
+			sparse_moved = 1;
 		if (show_only || verbose)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
@@ -403,6 +407,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		rename_cache_entry_at(pos, dst);
 	}
 
+	if (sparse_moved) {
+		struct unpack_trees_options o;
+		memset(&o, 0, sizeof(o));
+		o.verbose_update = isatty(2);
+		o.update = 1;
+		o.head_idx = -1;
+		o.src_index = &the_index;
+		o.dst_index = &the_index;
+		o.skip_sparse_checkout = 0;
+		o.pl = the_index.sparse_checkout_patterns;
+		setup_unpack_trees_porcelain(&o, "mv");
+		update_sparsity(&o);
+		clear_unpack_trees_porcelain(&o);
+	}
+
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index cf2f5dc46f..1fd3e3c0fc 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -287,6 +287,22 @@ test_expect_success 'refuse to move sparse file to existing destination' '
 	test_cmp expect stderr
 '
 
+# Need fix.
+#
+# The *expected* behavior:
+#
+# Using --sparse to accept a sparse file, --force to overwrite the destination.
+# The folder1/file1 should replace the sub/file1 without error.
+#
+# The *actual* behavior:
+#
+# It emits a warning:
+#
+# warning: Path ' sub/file1
+# ' already present; will not overwrite with sparse update.
+# After fixing the above paths, you may want to run `git sparse-checkout
+# reapply`.
+
 test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
 	git sparse-checkout disable &&
 	git reset --hard &&
-- 
2.35.1

