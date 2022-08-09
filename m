Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E2BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiHIMJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHIMJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC52496A
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so10592153pfb.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X469WROovn5VaE3OAc+dJxHmhUoHwaMuvoqvRtRENb8=;
        b=agICLeR0Mnu+i6C/aSu0s5IUKng3Qm37ghyPBx0kDj2ZmKi9VhEfHIlycPxJwOyVvd
         ipY1fgshZcHLTonH99XayqVKM1JyVjF2lmbe+7+uejNRpNdgCuOOFJ+FWi/jdtTJ9wSo
         ubpQTaudnTwyiMpftT7zH/LXe342GrqGmm2UHZ1hjsmB1bwLtwnIT/wtaBks9fwwdfCn
         sel+DzOIiM6Le0I/RdavSeAfpnCJreLrghq23gfa9+7a38EO4WzOJtR3aNHlMkghDn+z
         gxS4/Zc32e7z2xq2tz0hnO0fYyKQokf1l2XWtAlBP+NFhNiH5mUtRM5hbAqMIj3WTgsF
         9S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X469WROovn5VaE3OAc+dJxHmhUoHwaMuvoqvRtRENb8=;
        b=FqT2raqvkhpdAUN8K31CUzRt/J844dkFMO5FDEGALrlJQU4+hRv11ZYYRx+kESZcGB
         N9OLpH6M9enQ/Zfwgci/uRapwrnLozWKwNWBEgKDawet01+ZHtAhDZU2Wj6ARpFmXzw/
         GSHA2UaLaDvYUjSiUkgEL6wTGnGnUad8QU2mHoRi8F9sPaixtspgbLGBdEBlhP++SufL
         LylWrIvjfo0VBB7ksGoc7OIZfP/7x07uzH4cKDX4/EQswZZLe1WDMCeaYT+XQH083KEA
         E6deFNytu3vJ/S0MAQpMFibwaCYlqBy2bJEdjefsZ1nkvsReBu8P7XQVVfLPk/dSfRiu
         Q5xA==
X-Gm-Message-State: ACgBeo1MStFK7y2s2+XKezoJFo5NXW359E74f8eG/a5OKh4ulkiqg1BD
        p/4IMuUUU1CBisIECcLhZ4Q7EGVy+0igfA==
X-Google-Smtp-Source: AA6agR5l0EiigxuXCtJa5658nvgfYCNX+Q/b4xsXHqTDhX2G0hWfw2yiX3BbrIJ47JhfeReL2BlgWw==
X-Received: by 2002:a63:6a86:0:b0:419:da8e:8fc9 with SMTP id f128-20020a636a86000000b00419da8e8fc9mr18975265pgc.174.1660046976656;
        Tue, 09 Aug 2022 05:09:36 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:36 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 2/9] mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
Date:   Tue,  9 Aug 2022 20:09:03 +0800
Message-Id: <20220809120910.2021413-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Method check_dir_in_index() introduced in b91a2b6594 (mv: add
check_dir_in_index() and solve general dir check issue, 2022-06-30)
does not describe its intent and behavior well.

Change its name to empty_dir_has_sparse_contents(), which more
precisely describes its purpose.

Reverse the return values, check_dir_in_index() return 0 for success
and 1 for failure; reverse the values so empty_dir_has_sparse_contents()
return 1 for success and 0 for failure. These values are more intuitive
because 1 usually means "has" and 0 means "not found".

Also modify the documentation to better align with the method's
intent and behavior.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 4729bb1a1a..7c11b8f995 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -125,15 +125,13 @@ static int index_range_of_same_dir(const char *src, int length,
 }
 
 /*
- * Check if an out-of-cone directory should be in the index. Imagine this case
- * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
- * and thus the directory is sparsified.
- *
- * Return 0 if such directory exist (i.e. with any of its contained files not
- * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
- * Return 1 otherwise.
+ * Given the path of a directory that does not exist on-disk, check whether the
+ * directory contains any entries in the index with the SKIP_WORKTREE flag
+ * enabled.
+ * Return 1 if such index entries exist.
+ * Return 0 otherwise.
  */
-static int check_dir_in_index(const char *name)
+static int empty_dir_has_sparse_contents(const char *name)
 {
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
@@ -144,14 +142,14 @@ static int check_dir_in_index(const char *name)
 	if (pos < 0) {
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
-			return 1;
+			return 0;
 		ce = active_cache[pos];
 		if (strncmp(with_slash, ce->name, length))
-			return 1;
-		if (ce_skip_worktree(ce))
 			return 0;
+		if (ce_skip_worktree(ce))
+			return 1;
 	}
-	return 1;
+	return 0;
 }
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
@@ -232,7 +230,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			if (pos < 0) {
 				const char *src_w_slash = add_slash(src);
 				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
-				    !check_dir_in_index(src)) {
+				    empty_dir_has_sparse_contents(src)) {
 					modes[i] |= SKIP_WORKTREE_DIR;
 					goto dir_check;
 				}
-- 
2.37.0

