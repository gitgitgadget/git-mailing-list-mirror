Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC6DC77B7D
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDNMTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDNMTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:07 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A442AF32
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id bu14-20020a0568300d0e00b0069fab3f4cafso8608195otb.9
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474739; x=1684066739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soR+1ypC2E+7I8G+THTcY9msjZ7MRLONoIcxNIyOs1c=;
        b=LExe9IoQuF/jGi+t9VUND2qItfsYADFG+1NkGzkTe/M3G5AZBBEWJGiBVepyWH3Pp9
         8Dr8AnVP1LIJUbxPOxW/L+fE6931RHxTM9tkFfD6LPeI8Lyz279eL2bSyvoZUsU78jZ9
         xR1XL9eDFmBFH27k8d74hO5qVKD9Fv99lcno8yckJMIupUkmFAXzIm02xTL3qf+GaqAi
         SRO9CG1AbZssVE4xXBI8FvxNztwWfsHr/Iz75phtkhCyea8i2ar7jBBfFXZ/AMaqt9v+
         nleCHwnKwABpvo387ejJWTLN2wG8UFx+ZBjtZAZc6kkJREkYYChiioIcIoj3rARfnGlj
         3+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474739; x=1684066739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soR+1ypC2E+7I8G+THTcY9msjZ7MRLONoIcxNIyOs1c=;
        b=UiT2xB+VW7oFcvsdKyyRMpHM7hE1pFpfNrKWhOqNrUS4Nofrc1RvYIfmOnZ+iZ+yLX
         3fVCDVGRIYJnnO422ol8KP/yWCJlfDGxwa2cq5lD0XP9eZI+jIZg4VqBvpkQmCC6HpUC
         LynTNIDPlk6Xz7MYnUxaOndEforHXgDwpdRBxzLtFK+Cxl4KYZ6iRvuqEhrsFu8DKPLL
         iTvWK/mXuaoUo26w7XGEBoirp1CnX4D/eziMHVZxyE4L75C3FGW9i45QK7A4IaPvAF2/
         e+9d76nO0rqATtriD8p2/UWbBrmzLZZiVBRIX9GnknykN0uymV6dkFY8G4h4LW2j3G/v
         zppA==
X-Gm-Message-State: AAQBX9fc1yXCURSCJeZ7Ar0FNnrTwc1cV/JQCG/hRMMYE/pLC1fkAV+R
        pvgGdx86PKjFavgOFh34anS38eeb1u8=
X-Google-Smtp-Source: AKy350Z06Gvt8GSndmUQMN8ExlDSi5qpn8ml/UHcBwYuC3kytLJqC8mgMgQ7/ctw5usUHjiMAQRizA==
X-Received: by 2002:a05:6830:112:b0:69b:98a:30ba with SMTP id i18-20020a056830011200b0069b098a30bamr2658834otp.2.1681474739511;
        Fri, 14 Apr 2023 05:18:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j23-20020a9d7d97000000b006a332cb18c6sm1626044otn.17.2023.04.14.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/18] version-gen: describe and sed in one go
Date:   Fri, 14 Apr 2023 06:18:33 -0600
Message-Id: <20230414121841.373980-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
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
index b7d2b8758e..962b9441e4 100755
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

