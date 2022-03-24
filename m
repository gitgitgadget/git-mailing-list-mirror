Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54559C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbiCXLpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiCXLpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:45:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAEF6E352
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so3791321pfh.8
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJzEtHX2QuTBamoNxZsgJYyppn1/6QH5epI6qzns43s=;
        b=M3XxdPXR6xef5k+BQzttzRSDD50u3bQgbzw4uh9C+6w+FKeksipgF+sxSag9HcvdWk
         23GTPR+YNF5WIP7k/CCXGvkUV1vDtdn9BvgU8T9LJo/Ptw4bnZOXnh0nxXsIWUlIvIoB
         z1yzjYnqizYW3q1M1szt572EuOFdvchiAuk8QOcPKwJR5dxu8PijDbZCnp2tkLeV0H9U
         7Hz613+/UwUazAjTnGVBAgZt77E/XPDuaIm4h9lmUvwFt9IIQHJ7gNvXJtpfw0WEDtf3
         bfkYU6g4cL5tPxKLX6LDv16YqzyGn+itiln2XV6nyn2UBvgjOMTm4noPLVxbZMoRc2aA
         HblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJzEtHX2QuTBamoNxZsgJYyppn1/6QH5epI6qzns43s=;
        b=hpgNI0uYlZFUbwdRjH0k5FiumTG4yfWczXJJykg/qEuUfuQi9BTb7H0ObT0CbLWML+
         jToIQSid6O/zTmNunhb5Tu0NfTpm58YHRMze/USCt2P2KXQqxWGxX+idtPjRKL34uBIo
         LveZI2rtbpwwM6JMFno53aeng5zc/JGdBeh8A16/7sp9dkV+MkleDLJnZmmPyiDpNYZF
         kq9JYX0AhwgxzULEfQe2jse4JD5fPwFPyHfUeWu1zYv1rXIRE4Pqw1vJ7XnUZYkH0TBG
         fe/AdW2QTZthzLIaqJsotp5TCe2enAoaNKLKRv6DJ0G44Ag56/Yu8yjW9rFQnIEwYN1L
         wBBA==
X-Gm-Message-State: AOAM532aTZwNmYTJfujoJygpnSJ5VLm94k50F3r0mF4Fu23IrersFz0i
        wt2izjEX3fx2mqpUVJsIZg/drR/bzFrMEwbx
X-Google-Smtp-Source: ABdhPJywumscA32mYs3YV/o8JNW+Tey59lAYR9CM3lluXDh7f/DqWVd4sHrPfD0MoM5mtS6ojglNoQ==
X-Received: by 2002:aa7:9253:0:b0:4fa:6974:3260 with SMTP id 19-20020aa79253000000b004fa69743260mr4573568pfp.8.1648122249650;
        Thu, 24 Mar 2022 04:44:09 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm9717498pjb.16.2022.03.24.04.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:44:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 1/3] pack-bitmap.c: use "ret" in "open_midx_bitmap()"
Date:   Thu, 24 Mar 2022 19:43:59 +0800
Message-Id: <3048b4dd2982932fa11ba8393895fa33a00a5b58.1648119652.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.579.g70500b6343.dirty
In-Reply-To: <cover.1648119652.git.dyroneteng@gmail.com>
References: <cover.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's use "ret" value for "return" statement in "open_midx_bitmap()"
just as the same way as int "open_pack_bitmap()".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8b..931219adf0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -494,15 +494,18 @@ static int open_pack_bitmap(struct repository *r,
 static int open_midx_bitmap(struct repository *r,
 			    struct bitmap_index *bitmap_git)
 {
+	int ret = -1;
 	struct multi_pack_index *midx;
 
 	assert(!bitmap_git->map);
 
 	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
-		if (!open_midx_bitmap_1(bitmap_git, midx))
-			return 0;
+		if (!open_midx_bitmap_1(bitmap_git, midx)) {
+			ret = 0;
+			break;
+		}
 	}
-	return -1;
+	return ret;
 }
 
 static int open_bitmap(struct repository *r,
-- 
2.35.1.579.g70500b6343.dirty

