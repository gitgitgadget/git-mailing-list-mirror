Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F6C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjDXQvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjDXQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:09 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E157EE9
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:55 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1879e28ab04so3777261fac.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355054; x=1684947054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2iR00bnA59Xj6bxspElbeQgjlgKvCsX/8CO+PU6fcQ=;
        b=oLr6J49wGFnBQ/De+UjNplj96u3EySDW1JPiPPZg7JGp/OB4Q6ygE/dUmyzL/7S1T0
         2JW/oNUPcfSWR5c41emlW57tE0onyCmjUR8uTGyG0tMt1tJsjIxAUOxAC3IkAab2lvb4
         KbYpO+6pGfBDSUi+TAWPGbZZTwRuYxtzBuUfLPTa1LCqBwxh9BA6xyHbGFjkVVCamJl6
         s2tA8Mo84h1gfHO+REEsyHKvcXNMF+3PfFAEN1dk6p6uLMF627XIr/HYeNwnyQYZn+Nf
         dag/17BOdIkqeAUGhW2COTJwTs3B9y5PCIs5xa+iTqY6dRB4vqE1gGbNNAin/RwwGGv/
         iXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355054; x=1684947054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2iR00bnA59Xj6bxspElbeQgjlgKvCsX/8CO+PU6fcQ=;
        b=W7D3okHIluU1k86NBUWUg+QPhmj7oesoBXQrtl/w88I7VTDaezQQFRF82wzF7D6QYa
         hZPeC3SSWEZz5nvo40nxioR+BruDQ7KDMFaAdLg2BfbBeLQvXEavmgTGtrmfvenq/Ypw
         NLOpvn/teIcLagd6nayWC8Ao4cQzGyQFt2Hy5mJ0fshFvyku0hUAXatTSjhaom/QR3FQ
         WS5rSNMkyLhl13NYfhMCTEj/jU07N2IUl9cjb332B89aZ2IBdG36lt7uxpVSYtSHDDrh
         Oyrx9AAkUOX2r8wsKZks8261V6TG+0Pixtj/r3A6gtcRkYPYURj6UE2KSxYy9s8nvHCc
         3mGw==
X-Gm-Message-State: AAQBX9e2vm3/K6vC0STxilo5gZP4TDjwyrgMeRUhmdsYUrlsro0qeY6q
        L8fJdzibQC051ZU947irykQ47lwrscQ=
X-Google-Smtp-Source: AKy350YM4CQ32BuTQyVyFOoDIu1AJTGbX5Wa77kvE0BH0412lPTHPiPqWDw0gi3LA2ZKShZApeHbJg==
X-Received: by 2002:a05:6870:b292:b0:183:cc50:f7e2 with SMTP id c18-20020a056870b29200b00183cc50f7e2mr9399847oao.49.1682355054348;
        Mon, 24 Apr 2023 09:50:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm4644525oak.22.2023.04.24.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/15] version-gen: describe and sed in one go
Date:   Mon, 24 Apr 2023 10:50:35 -0600
Message-Id: <20230424165041.25180-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 7a7a7fc591..c5265cf9ad 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,8 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null) || return 1
-	VN=$(echo "$VN" | sed -e 's/-/./g')
+	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g') || return 1
 }
 
 # First see if there is a version file (included in release tarballs),
-- 
2.40.0+fc1

