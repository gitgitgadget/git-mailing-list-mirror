Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E5C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiFSD0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiFSD0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4936EB861
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so6960812plf.11
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VjMXTCwloixnfFye9Oqcx47NsZU71R4j1Q5TLyQ+fo=;
        b=jDsz3uBdffixJEDrjSL187qz5ce9ZZZqXYuixpyE2RG1wxO8JVfUasCOooeXL9UELj
         uGZBKVXvYXN9kB9GWaz2se5fUNwqmPrTbj74CmIMrT/IYAI36GIEwwHdCIjnUzCsvkLc
         HaTgUtRKIgga8nMcr0hORoEbxzIbAJBNvWlI2HeOof0UstCmvk2D4uZg7L2akQajzeaB
         ccoBqn1+d9eR5Q52L3pqd47JjFcbQy804FxYUa+h/npQJZ1xaChFZm/ea8YiEO9/VMQj
         mTCG6O13eb4ZGcz+Jq/zsS2WdcNUkPyh8LZF8NwxN5WBmxnX9dlt8PJUWB3g0XzEzFUJ
         NQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VjMXTCwloixnfFye9Oqcx47NsZU71R4j1Q5TLyQ+fo=;
        b=sOeU6QrVkpPkRcRUW26yjoHu3VdRGKPQOZ1b77pa/p9wCdLl7Ns8ECEuBBdUC1kfL4
         sg3hSpywi2PoawLqNimhi6CPYiYPS8DK256R/OroFat95tA4KBNmOFkoSYY/sjdbFdJ/
         ariEhKzm+8TT0fNhQWP8QlbYBb2qC64e+AUJl0Q9mwtuwxzxqVF/K4olsSQjszSAhzcp
         BYYRu9VH/MckD+XHYyl27BXbBlzzKXh//BP2dy22fykLwe2sM620Cjqf1UAx1a27GS5c
         Y9M7f0HYivtR25CbaoLxKBLMKLilAxHBHQNmRSTgz9z0woi8V9VKYNPM46KJtOvoFVLg
         737g==
X-Gm-Message-State: AJIora8NFnoZ6aoewffhrx1RNxpblL0t670g+Ly9wL/X0ULrOCXuFOEX
        TjlCqc5DMOQ1BnODvx1KJxU=
X-Google-Smtp-Source: AGRyM1t4zONeJMGL0qdZ270Og5B4zq7EL6/0CPp3WP3ETrpo0NpQtLYLljtSLiDvaLuE64eDipftvw==
X-Received: by 2002:a17:902:ce83:b0:166:42de:29d5 with SMTP id f3-20020a170902ce8300b0016642de29d5mr17570553plg.123.1655609173690;
        Sat, 18 Jun 2022 20:26:13 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:13 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 3/7] mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
Date:   Sun, 19 Jun 2022 11:25:45 +0800
Message-Id: <20220619032549.156335-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
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
 builtin/mv.c                  | 21 +++++++++++++++++++--
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 1ca2c21da8..9d8494a2e4 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -185,11 +185,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
-			/* only error if existence is expected. */
-			if (modes[i] != SPARSE) {
+			int pos;
+			const struct cache_entry *ce;
+
+			pos = cache_name_pos(src, length);
+			if (pos < 0) {
+				/* only error if existence is expected. */
+				if (modes[i] != SPARSE)
+					bad = _("bad source");
+				goto act_on_entry;
+			}
+
+			ce = active_cache[pos];
+			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
 				goto act_on_entry;
 			}
+
+			if (!ignore_sparse)
+				string_list_append(&only_match_skip_worktree, src);
+			else
+				modes[i] = SPARSE;
+			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
 		    (dst[length] == 0 || dst[length] == '/')) {
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index d6e7315a5a..1984cf131d 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -242,7 +242,7 @@ test_expect_failure 'can move out-of-cone directory with --sparse' '
 	test_path_is_file sub/folder1/file1
 '
 
-test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+test_expect_success 'refuse to move out-of-cone file without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -253,7 +253,7 @@ test_expect_failure 'refuse to move out-of-cone file without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone file with --sparse' '
+test_expect_success 'can move out-of-cone file with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-- 
2.35.1

