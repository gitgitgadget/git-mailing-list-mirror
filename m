Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD6C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGUJGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGUJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:06:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F70550CA
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso875206pjk.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rYUYjSkuhDuzXIz9CZcmnccXk6O1YJ7zyWLIBPHayQ=;
        b=qmgyq435gsFziXMSC6hS0zx35hrZ+v6pNYywFKuXJA5XQGU8Al7ijSwS13M4o7p1sW
         se5a8wRE0eNrtQMM/VtEyvr5nESXH/Hfg7xwPPAKeA/f0kNqZlh/A+No8tchM2XAZUMc
         IbpGD1gN0G2SLJycH30xMVtST3ip2FxtLgYX3XIps08OGv18mLAGVNqJlff5o9WOQKUt
         IZ36gX/2UGLcgkR8h3lCQpRtbBWbD2t5lJi5JTsDdObBoPGs9UkqZBN3EhIAg4NxLNbz
         FiwntLeddY3Wd+EcrIS6cx+TOzVJZGg8YzIKxNhhdwx8jHvWoVFs9WBynfodEvexyfyv
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rYUYjSkuhDuzXIz9CZcmnccXk6O1YJ7zyWLIBPHayQ=;
        b=xoy4l5CGNoNNWKJiVUT9Vzx+HYqaayzRmG7hCtPli8CIuP+ObaLf0VPygQEJdbA7+f
         jk323ydGBuZjWo+PM+EoVEegnmivlPdHQknPxDe7m6h9yWh8MAOczk1I8ZKs9llNLxFu
         sIcaTe+ow5rB2wnu8+rnS8Y1CguD5zJW4vHSRLmby8dUkb2IzDbWgzzR+JeEUervBXeD
         66dhOfHewGUft2nTNM35+fmaqm2hftUiYBG/PIaOtD18qaOLiHEFKpCSUNyNli2KMwbD
         WyHm8j3fOxuPmfbyPYcjSR1t/k2vXTKAPlR4RrbIKKAOvhzYS6KRpfZmGwAj6ZnZeDuO
         mpjw==
X-Gm-Message-State: AJIora/gT59Vhd9fqCG7rOoFE6ANHqsX4YR75iFXtFRlUct69t1BZIFt
        TR+A48BvEwLo7323XF8UwL4=
X-Google-Smtp-Source: AGRyM1tpVPvBHZpwHb25D+zPd6FeUj9cjWtCV80ne7dkglQ+dl7isrx32u/4B5WXqrNs8iXVDKEQcA==
X-Received: by 2002:a17:902:b701:b0:16d:12a7:c2fa with SMTP id d1-20020a170902b70100b0016d12a7c2famr11387823pls.67.1658394372171;
        Thu, 21 Jul 2022 02:06:12 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016c9e5f291bsm1127291plg.111.2022.07.21.02.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:06:11 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 6/6] pack-bitmap.c: continue looping when first MIDX bitmap is found
Date:   Thu, 21 Jul 2022 17:05:48 +0800
Message-Id: <83090308ad63543c9becfb4cec9c1cedcffb1fdc.1658393856.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <cover.1658393855.git.dyroneteng@gmail.com>
References: <cover.1658393855.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
the first one has been found, then will break out by a "return"
directly.

But actually, it's better to continue the loop until we have visited
both the MIDX in our repository, as well as any alternates (along with
_their_ alternates, recursively).

The reason for this is, there may exist more than one MIDX file in
a repo. The "multi_pack_index" struct is actually designed as a singly
linked list, and if a MIDX file has been already opened successfully,
then the other MIDX files will be skipped and left with a warning
"ignoring extra bitmap file." to the output.

The discussion link of community:

  https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 318edd8e0d..d013ea0277 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -506,15 +506,16 @@ static int open_pack_bitmap(struct repository *r,
 static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
+	int ret = -1;
 	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
 		if (!open_midx_bitmap_1(bitmap_git, midx))
-			return 0;
+			ret = 0;
 	}
-	return -1;
+	return ret;
 }
 
 static int open_bitmap(struct repository *r,
-- 
2.35.0.rc0.679.gc613175da2

