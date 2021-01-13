Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B9C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C2623447
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbhANCGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbhAMWZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:52 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA04C0617AA
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:40 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 186so4454105qkj.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SiY02Oy0Xb62PPHOJxVqcbNUHkVa6NVif34C1mP8AM=;
        b=i/JDNs230ykdhR8B94rAEdFuPz2vpAVfquZakoQDcMO7ok75GGvRt+HUR6fnYeicb/
         PSZOSwkQw0Fv35qEk48ZCphwdif9fz9b6QRtKmc2Gq4bJ+3z2TetrAGZ2DaZtCO1sTDL
         TswlNvkv3hN4AgjtIUOrSQhD7V39ruF1BnJhVBydLx/g3HKkAKrAhRTyClNHOOZ1BRGd
         R5EgquP344xIQw9WVU0UnQOPHYtNVEUiOzyxy3+c3Un+0v7gBCtVU2xefR4P+o+mf2oS
         n4eks0fbXEaNwU8d4EKiLr5k3frZ6NFFi34ngUMHTywgwHevQ7opjJQsGFBKijypk6GH
         dBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SiY02Oy0Xb62PPHOJxVqcbNUHkVa6NVif34C1mP8AM=;
        b=MzxANfaw7GYLkH3+cKYg/mdDQN7HQLrVuAlUPtDjNUR4CY1/iq87aD92xSfJoCzGSC
         Y6Emk0lnSUYRF0vuZ8rRPKc04N/KmZ1B9h04EFEdFP9gbVe/WJ80yQPQb8ViMn6Mz+vO
         95eE3LqEQfz5gbaHDNqBRcZMkDn56cQqA+7y1Clg6KKzJyg8NMHJMbAi5f9buOAGXXm3
         hewDj0U3TR35+Ws+/vGWjDnU4gNltIU1LgvdiuhWAPHVYDtNFhk7obHUWR/8XOfKXmDZ
         KGCiK7P4LhYObpKduW5CgoePy5FE9HpNaZ0nEFSSAEqtBe33mud7nehD7bBPdQk790UV
         Qwvg==
X-Gm-Message-State: AOAM533OhhXu/P1fqQzhznDefz+CypBlojmIOGJsI+OY7mKTokXx26ep
        DdRZp+9Xt3M22Y04UHPZfuqSFWgC+9CV0A==
X-Google-Smtp-Source: ABdhPJwsa/U4Y8MkpRBN4BUmfndWzskqbV4DEJV1iy0166/AqK7NW7JU0uJBp+RVvXs2OlF5o5w4RQ==
X-Received: by 2002:a37:9c8a:: with SMTP id f132mr4330669qke.189.1610576679407;
        Wed, 13 Jan 2021 14:24:39 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id f10sm1887705qtg.27.2021.01.13.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:38 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 12/20] retry_bad_packed_offset(): convert to new revindex
 API
Message-ID: <df8bb571a55ae94d85b996326aae8a709d84777c.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perform exactly the same conversion as in the previous commit to another
caller within 'packfile.c'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 3e3f391949..7c37f9ec5c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1256,12 +1256,11 @@ static int retry_bad_packed_offset(struct repository *r,
 				   off_t obj_offset)
 {
 	int type;
-	struct revindex_entry *revidx;
+	uint32_t pos;
 	struct object_id oid;
-	revidx = find_pack_revindex(p, obj_offset);
-	if (!revidx)
+	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
 		return OBJ_BAD;
-	nth_packed_object_id(&oid, p, revidx->nr);
+	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
 	mark_bad_packed_object(p, oid.hash);
 	type = oid_object_info(r, &oid, NULL);
 	if (type <= OBJ_NONE)
-- 
2.30.0.138.g6d7191ea01

