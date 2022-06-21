Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF7ACCA483
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiFUNeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351434AbiFUNbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1E2AC6E
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o18so5471570plg.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/r8JRLHdYM+5p1XDW85HmYMw7+KNWd0BuBVGeCQ7ck=;
        b=OoTZUAZdnVAoEPcD4akRi54HTcmRwowzi1JVfSkYVSCcXjSdiUZ3DZTtSPBvOcYlGn
         gA7PtZpNmlEACIRoZXxVtZ90Vy3K09+V1fDN+Xzp09CiK82zdbGpd/LkkyOWAUGVZNwH
         9G9Y8PEbP1CgPLS5golqqYbL2fOZjg/uvgMewCTev7af57skO+8UGmUdw5c7+muPWm4O
         e2I+REf/N14Ca7c0ezeFcSLd/x9Nbad45RQgGId2s9EqtyVjHtNqtSTb9HGi2RTmUlSN
         eMVHeiqEo7LKZP6fI5je30gvg4+oe4eLR5qIXdkDb9hu+RsMK+u+uEOk8dPpi9kL3kz1
         tQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/r8JRLHdYM+5p1XDW85HmYMw7+KNWd0BuBVGeCQ7ck=;
        b=SXt3ZhK2YpeOrABmhejl4A4a+Zn1hqgIPS8pKLK6o0vpXtf9OKZrlx3njLA96Niszb
         c+/M6aFg5toItVviTrU9KVKTd5jGwKSLfu/clzGkFmXAkwdor6xNEN7Xwpx1G8vvVUQt
         8Z/RoIlpYCZ0dPgQKY3PZyeHOQASAJM3x9XcR6w5lI9Mtot2NaVl7jChEKZVvklXC/7C
         QaosnZA8pOH8X1B7mJ5BSUYr2Z7V0PWujvf22IXp5648VB+Bw6hyQ6IbwrOtb6uFRkxY
         qZqmh8kLDiCXFnyr47JQrZb8S2nydxaNs0FqMIKffssHBeoqOm64xdDQp4+3+yzu3mjB
         Tm0A==
X-Gm-Message-State: AJIora8nSb8wrUONxoaveeQJ1pIM3dZm8C8NZxh4EOs0xKVoPQrWCQdM
        lbFpd5G0Hd9oFcE9rFNeAmc=
X-Google-Smtp-Source: AGRyM1swyuYj44q5uNnbEBf0SZwgTz6WGZPyceIDhTxfUkQaKdkq+A9xKcT5MwhGToDqrxSGubVRFg==
X-Received: by 2002:a17:903:240d:b0:169:684c:dad8 with SMTP id e13-20020a170903240d00b00169684cdad8mr24455572plo.173.1655817924235;
        Tue, 21 Jun 2022 06:25:24 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:23 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 4/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Tue, 21 Jun 2022 21:25:04 +0800
Message-Id: <917551f2b53196c4754d8881a383e989a02d571e.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_pack_bitmap_1()" and "open_midx_bitmap_1()", it's better to
return error() instead of "-1" when some unexpected error occurs like
"stat bitmap file failed", "bitmap header is invalid" or "checksum
mismatch", etc.

There are places where we do not replace, such as when the bitmap
does not exist (no bitmap in repository is allowed) or when another
bitmap has already been opened (in which case it should be a warning
rather than an error).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index af0f41833e..a54d5a0c9f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -323,7 +323,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot stat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	bitmap_git->map_pos = 0;
 	bitmap_git->map = NULL;
 	bitmap_git->midx = NULL;
-	return -1;
+	return error(_("cannot open midx bitmap file"));
 }
 
 static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
@@ -382,7 +382,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot stat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -394,7 +394,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (!is_pack_valid(packfile)) {
 		close(fd);
-		return -1;
+		return error(_("packfile is invalid"));
 	}
 
 	bitmap_git->pack = packfile;
@@ -409,7 +409,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		bitmap_git->map_size = 0;
 		bitmap_git->map_pos = 0;
 		bitmap_git->pack = NULL;
-		return -1;
+		return error(_("bitmap header is invalid"));
 	}
 
 	return 0;
-- 
2.35.1.582.g270d558070.dirty

