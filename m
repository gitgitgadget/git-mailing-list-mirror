Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E65C433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FF4207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbhAACRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbhAACRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838FC0617BB
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:17 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d20so19318067otl.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05GNxgnWZWBtdtcgke7oqysPjgqm00JWeAXOgfuL1kU=;
        b=DwZyGsUslSOzqgPbuMRcmhJ67ugKNU9yp7A06lA4Ena9XNngp0L9TdI4HIl8Plqmry
         NvSClt5v6abo2L3lYwILkenOplJkuysU0xUVpozrnbCbqKhbru/fpBWOpSmLGlJ8Ng6h
         o1OMqnoKCaA3EekhJ9CpBYDDE9oCJwmbvSbqzg31S9WNcm+6USQ51/JZn282Ay9AmneU
         c6R9eVrFuXZ3zTrahk9EMaSecC20InrUZOHnQg4mqJXRHvbh/KhJyDOm5iSnWuuhkbZ3
         0+DNTjBiIcnGkZN9W/ODot4+aGncu0p40F94XYCN3A0xVu9PngQ88BzEF/CYaN1gHDFe
         5mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05GNxgnWZWBtdtcgke7oqysPjgqm00JWeAXOgfuL1kU=;
        b=HNCyCrD2uSY8m8HvAgYTL1nskvcHJ0gSHE3CqxmlLDSnSXhQTl/fQ2rQ2Ufn+0q8eL
         sBsnuy5+yDxaOyK2o5URQ3dXktSPPP5GDIj1p70d+TTrkGjv6XPMcorynt/ka/+a1PYc
         bXEEkgva3/fKTucCeD13Iz9pjzZOzRwPRIW9oH+XU1GisPW0lAUaSUy/LQ5UsXaT/F05
         jyP+TU5Xr7ozWcKNQ0joMvr9HPtdFiF0ldTx+jcvQl1kxk6cDvnoAL9yg7lwk2lkYxOX
         rSccd3SfVZusJYNF7C9yJOCg4z2JDzKqk9OOE/Ovk7wRP25BSZXxQuC4x8HiOjz3SohN
         S/OQ==
X-Gm-Message-State: AOAM5314EDl7bmibF2lrDh/NY3R3S9HD9CEP6VCVt24fA/ChYCtT2L3P
        5Van9vLnN080Cbkl9LpQlYLTE3asHP1h9Q==
X-Google-Smtp-Source: ABdhPJwLNoCSOt+KieCSephdN7BqimcdlAZLviK5sM3RRD4I74V2d7SqDTGKE0OfWPNhLcM0d8F9Gg==
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr43059229otl.326.1609467436887;
        Thu, 31 Dec 2020 18:17:16 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m7sm8199925ool.29.2020.12.31.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:16 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 33/47] completion: zsh: shuffle __gitcomp* functions
Date:   Thu, 31 Dec 2020 20:16:08 -0600
Message-Id: <20210101021622.798041-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6afcf1810b..3665167b3f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -87,11 +87,6 @@ __gitcomp_opts ()
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
-__gitcomp_direct ()
-{
-	__gitcomp_nl "$1" "" "" ""
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -106,6 +101,11 @@ __gitcomp_file ()
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
+__gitcomp_direct ()
+{
+	__gitcomp_nl "$1" "" "" ""
+}
+
 __gitcomp_file_direct ()
 {
 	__gitcomp_file "$1" ""
-- 
2.30.0

