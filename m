Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76329C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbiDUNaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385095AbiDUN34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997C381A4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:27:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k14so4681075pga.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gQ04he4FIs29CR1kBBdEOTLfTc84+wd3OhbAYRruPk=;
        b=cZS3hguNYZzi6wVsjUE42lNwGj2AZ9VKphQu1Q6/8DScJEhDZxrcbQxCn2AgLHZF28
         kcJ14QHRIe7HRpCzPpFTQCoLmsqrF6kyMiPp+lug1TGtv/BSHlc1+Byfo5a89CzJFllI
         Me665nsQdct3CNmwwN8MTo2LGuw59JgKPHPB0v4ys3/I1Bifq8kKWKnrWUJvNdxm8uSs
         4tVSQvDuKD8nMTHn9u6a9SzOUU8G2ihLOWcJbGBGp6DJwGfseaHuYCirOTZSn1Y1Znq7
         AFhDwUwj900Jx5kNhbf/IpDFB9luIXXEnOJ+ieh63/dkwZyb44SSXT87YkDNvLUgbEFM
         7QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gQ04he4FIs29CR1kBBdEOTLfTc84+wd3OhbAYRruPk=;
        b=5yENnpKqNqgtG+44KY+VYaYfAUkaLEa/g7LPzNOpmrAT5OUrukQ7Xs55BPzNGd2tAU
         2dHdvro3ZKKFdZoS8xZjo6SV+G+wRyMTiqkLBL/IDIe76I7Ccyz0m6kyoFTQSQnJWrMZ
         rPSVG7aBUXi6V4OJytAlI7NI7nvxeM9Cf0h+btAfq2dNBt02aoxx7KyCo+jvg2Zs346M
         P+DygDFAGJhIBEcjRWOGBVsEW5GSh7L9PbJouEEp5RtzKIthOoDWmOt0JgNC/G0Nt6TG
         jSmLJ3C0bSuc9qwQQdDGPMjrf4fVPuu59QdMkZjSHYnf2VuObv3UR2XvkyZI47Dg5kuc
         MvjQ==
X-Gm-Message-State: AOAM531HVV/TpBQgBEi5pmfP3uBrPHJgso9W3DwTcpgZMXYXNS8y8QBv
        W9rFMxhVgk9+9NvPS9OMZ5E=
X-Google-Smtp-Source: ABdhPJxn2I1q+64DUvuf/Cdss6YPJv6z/3/RJCVJS2TsWc25/ln/c5MiRw//ibf4vyOE6DaxHJ7Ycg==
X-Received: by 2002:a63:b20a:0:b0:398:9e3e:d581 with SMTP id x10-20020a63b20a000000b003989e3ed581mr24705298pge.236.1650547621646;
        Thu, 21 Apr 2022 06:27:01 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:27:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 5/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Thu, 21 Apr 2022 21:26:40 +0800
Message-Id: <1a169d7b5ea4b6aec030a48f718dc2c4e922a9f4.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1650547400.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
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
index a1d06c4252..e0dcd06db3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -328,7 +328,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		trace2_data_string("midx", the_repository, "stat bitmap file",
 				   "failed");
 		close(fd);
-		return -1;
+		return error("cannot stat bitmap file");
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -374,7 +374,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	bitmap_git->map_pos = 0;
 	bitmap_git->map = NULL;
 	bitmap_git->midx = NULL;
-	return -1;
+	return error("cannot open midx bitmap file");
 }
 
 static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
@@ -399,7 +399,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		trace2_data_string("bitmap", the_repository, "stat bitmap file",
 				   "failed");
 		close(fd);
-		return -1;
+		return error("cannot stat bitmap file");
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -413,7 +413,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	if (!is_pack_valid(packfile)) {
 		trace2_data_string("bitmap", the_repository, "packfile", "invalid");
 		close(fd);
-		return -1;
+		return error("packfile is invalid");
 	}
 
 	bitmap_git->pack = packfile;
@@ -430,7 +430,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		bitmap_git->map_size = 0;
 		bitmap_git->map_pos = 0;
 		bitmap_git->pack = NULL;
-		return -1;
+		return error("bitmap header is invalid");
 	}
 
 	return 0;
-- 
2.35.1.583.g30faa5f068

