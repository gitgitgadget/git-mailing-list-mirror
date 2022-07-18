Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD920C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiGRQru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:47:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D120BCC
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n4-20020a17090a73c400b001f1e87432c2so464654pjk.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mojweoBCdHalvPf+rMPhrsaOy6k/QJExYDYcvloXRxs=;
        b=AEEE9F+1Bc1eUo/yxaTgEWBlu1bE+vvMQpkB0HzK5q8Jo6IvGyWVQcW3FEmWRnIhtK
         hswzq/z6O94dypO3CUtckjQTbfxtva2DFyE5bL3CB2MXdf17NNc7qo0aCKRe8FykOs4u
         BbnIxKasJUfZjWPWoBERJZ2ETVNiVGrE7UfW0HEzJPj1ipVLKoFS6DflOJHzCAgKKt+T
         0kzfpCVXVBeGGrqFMPrNltvn2Z7+z7KwaNm/QLOM8yjqPf86yQnledGFJzVlAi/dBRFB
         sDE14WLVPt7Ghwis1vDoztK3QZ5LUFBbgSgR/fILyQEnNFQA46oeOKQlxvx+7XGAsgO3
         rT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mojweoBCdHalvPf+rMPhrsaOy6k/QJExYDYcvloXRxs=;
        b=UqouUk48t2hQERtGOyXZxp8IcWBmzEdjpWQ1TrKiXnAkbQDx4uZpmq0EBYjUL3LbQe
         H96fW707jQZ/2Fdb0qP1jvJZ/mA3LgYdfwNWjkbFQ/AbO4PMNTTg/Dh/b1HmguSEN2LV
         NweVTuuX6d//OHJ5CqxbciZLcK43vS2J0ntkCeHviGBUcMD+RiqVGq6QbiwTcOtwjQtf
         EeFzUTJvsZMTQIBNRCeU1JLqoGDE/FUht87ucOZoDBSsKHaKbdqlzlU0Tab8507ubSkB
         58SJzxYy5R1ibQevFGKgbkHPhfCALO/O5vH6ThkfzYpbxYECuTx+BpRsNOhyIxl1LQ3Z
         0u+g==
X-Gm-Message-State: AJIora9x3XSQcrv/OL+9DGxdiYIZnNx2xhuoGlGVYt+/qrsdZI0MMLyd
        gxQvsfH8qzAsbU8h2WIXHH0=
X-Google-Smtp-Source: AGRyM1tPiGYiq4V0Ug5T6KJ+28W+RoMLX06X/GyORbUHzR4//EMs/dhi5mZ3B5SnhHEFB+uzkZs+TQ==
X-Received: by 2002:a17:902:8bcb:b0:16c:a264:77ae with SMTP id r11-20020a1709028bcb00b0016ca26477aemr25159484plo.130.1658162867913;
        Mon, 18 Jul 2022 09:47:47 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:47:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 5/7] pack-bitmap.c: using error() instead of silently returning -1
Date:   Tue, 19 Jul 2022 00:46:04 +0800
Message-Id: <f60efe78d6a426f4a834680adf62a55937089aa9.1658159746.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
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

