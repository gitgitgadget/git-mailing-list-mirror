Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4688C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981B21D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf5zVVf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLRL0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39217 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRL0O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so1353733wmj.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8M8cZ+gRv/rNN8fFjyF98stzkGZ+D510F0bBH0psTM=;
        b=bf5zVVf9Boxmlyw+Q9rxrvFiNi/SY9wInvo57fxt1TAzze9NuD/MoJfFtqgyOCupIb
         mm0+H3WfiI84ylf87s1IgAD82fSWJSTbYPy5yo/yKGbYw7moQFRaUQeGH1Xb1i6koOeP
         6cym/Pas0mp9kGV3oyf7WhplmC896gZe0+7V16bkgNI9O8iWvW5jMKaECdJdaGJF2cZ4
         r8N2s/QYw+ADfwh749Ve11xarDPj/L4BdWKzVblm9WwhkrpJVCsu2NgO/ZVKuSfEz+pH
         ceKHBlMH/f7sW3JCH6xv7f2Y1BQeVuQAQj+so4H+plt/spS5JNFgCaJ0pucIt9zNXR6r
         r4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8M8cZ+gRv/rNN8fFjyF98stzkGZ+D510F0bBH0psTM=;
        b=mLSpHcFRsdy3Kkn6hTia+j+49tACebdgGGiVPLKb3/0BdtXcWAyg9O81/RoiGmBh3o
         Whh7kqWluvhwrW2/k/rJJDe09hirsfkb4ZjUzrI+M9ll0a+BftF6vGsCjLCksC4IzV0G
         0HTRYG0xiuI6fRXR41REeLbF7h0cqxaPd3sdcCyqAJXuJsPu9pUaxQu01psOSD1XMRkH
         IM68yDWmDNZ7ZCuWG+g49N4sTl20FPhAPV1rNgjeJ+aZJeq46i17gAWJk4u45U60SRm/
         UrnzUa5xtYlDFox+cU4VQmt9lj7PzqEl87uPxceT9ptnuYrLkdiBwUIjv082kwePONNi
         S3Yg==
X-Gm-Message-State: APjAAAX5LUHkpo+urCxFkUbYL5EYSqrxEgnm2Tf68gm6xBx5hUfHGlcJ
        oyt3DjvhfcBgLoLQCPLW1AJW+Zjo
X-Google-Smtp-Source: APXvYqx6U4PcvS3CxdH3mSrHJr0T43Q6UAzTm8RjBZF7iAeQIXS+rfXshQ3MhxcN4F2NJHOE/6UMjg==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr2543724wmj.177.1576668371878;
        Wed, 18 Dec 2019 03:26:11 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 05/12] pack-bitmap: uninteresting oid can be outside bitmapped packfile
Date:   Wed, 18 Dec 2019 12:25:40 +0100
Message-Id: <20191218112547.4974-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

bitmap_has_oid_in_uninteresting() only used bitmap_position_packfile(),
not bitmap_position(). So it wouldn't find objects which weren't in the
bitmapped packfile (i.e., ones where we extended the bitmap to handle
loose objects, or objects in other packs).

As we could reuse a delta against such an object it is suboptimal not
to use bitmap_position(), so let's use it instead of
bitmap_position_packfile().

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fb4f6297f2..de65f2fc36 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1137,7 +1137,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 	if (!bitmap_git->haves)
 		return 0; /* walk had no "haves" */
 
-	pos = bitmap_position_packfile(bitmap_git, oid);
+	pos = bitmap_position(bitmap_git, oid);
 	if (pos < 0)
 		return 0;
 
-- 
2.24.1.498.g561400140f

