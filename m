Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B5C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiGUJGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiGUJGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:06:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E52F64C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so1101028pgb.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkdsXSurNV5uQVnE1YMfl3r2YYllokLGbQBgP3jlhJM=;
        b=Smya2LtaPOXL0Tq3DK/DamZEmh+cd8Pu9niaKf0FqRojVW89ikbC1QvQntY7oof3S+
         nHbHC6BCFQHsWEwWuVo+Bd8ZzscR/Vn0wZltaZ9+MVvimZl52TjEzVW3B6uZFFC12Iwh
         gqsMKgjAh8W2yRE3thAgZq8i62vRaFTDTm12BKpvozyFwPQQp1T50vKXW6FVwJek8n1C
         p5GejOV0W0EXQyLKEiQCmVZ6neJdjlM9Ez4hwe3YwrzWqCZhx6n0VbSKvfVMPWSflLlP
         EwQo5pIV1I1OkjOCm+SXu9qaS2ZzcQHVpx1Khn2BPcvjyCD2nnAEu/cDEG9CgIuPpv3a
         ygyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkdsXSurNV5uQVnE1YMfl3r2YYllokLGbQBgP3jlhJM=;
        b=A/s0N+ZZNoVPu+CmSpMvTDyMLPxg64b+xZ57swwSPu9uP9g4zC+HctNCuaVm4sHKAV
         F/okYwbbO8rlSlM44z9I/Uzphof23w6dKZjUzNHr4XMCcBp7zdrP/bk9sSPoK48we+Us
         uq+NaveJsqxW4aOVgJGoopukioRBVWSXBL2ezUw/tHWtv6rSRK2oKOMmKOAcZaJv2qJC
         x8Qqv3Otg9IcsU2tYAKbeReDdYVQcYJKBw2mImxOFLOKJICV7NfZ3Kkmves1Iy2kSe6v
         0kH1udIeFQXyJ3XTj/K0f3Zu4r50U27OG+Tkdkkh6cTu4ec220X/3HMf30Ki+zs97tWo
         jscQ==
X-Gm-Message-State: AJIora/95vvCB06T18WPublSs9WDi0g6AfFa/RinnQQQYVe6Wq+TxlZr
        dcK0ibjsQZs82OTIVJimR+jiJ2+KuSo=
X-Google-Smtp-Source: AGRyM1sYuFBGsVFArIS89djPUz+GzK8qmePmr6goxbECi46ShDJMmqnDwUpvKrnGv+LjWRA469Duzg==
X-Received: by 2002:a62:4e89:0:b0:52b:6c56:7aea with SMTP id c131-20020a624e89000000b0052b6c567aeamr20872620pfb.19.1658394369744;
        Thu, 21 Jul 2022 02:06:09 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016c9e5f291bsm1127291plg.111.2022.07.21.02.06.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:06:09 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 5/6] pack-bitmap.c: using error() instead of silently returning -1
Date:   Thu, 21 Jul 2022 17:05:47 +0800
Message-Id: <f60efe78d6a426f4a834680adf62a55937089aa9.1658393856.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <cover.1658393855.git.dyroneteng@gmail.com>
References: <cover.1658393855.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

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
 pack-bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f8f9937c9e..318edd8e0d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -326,6 +326,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
+		error_errno(_("cannot fstat bitmap file"));
 		close(fd);
 		return -1;
 	}
@@ -350,8 +351,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
+		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
+	}
 
 	if (load_midx_revindex(bitmap_git->midx) < 0) {
 		warning(_("multi-pack bitmap is missing required reverse index"));
@@ -389,6 +392,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
+		error_errno(_("cannot fstat bitmap file"));
 		close(fd);
 		return -1;
 	}
-- 
2.35.0.rc0.679.gc613175da2

