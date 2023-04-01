Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BEC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAItY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDAIsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED124435
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso12467402otb.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4DFSXu8Yh6tzVuWv6AAoEDXYX0CgqlwJ2CGJTlsapw=;
        b=ScKqQy2LPvXUkQTKTNLpami7Ink2esvlZt8cVq8/mLatEwWOhY8P94K+IDmAK6SAci
         Uf9VlLmRSJkY3myKintsQccd1NSHFmEYpaQ0rUXUjVg7IC6H51R0kf+GW22Dsrr7a2RM
         XrKj1pCRjS0bDwJ0Tj5zQTwH6BZmG8G0Lj92FGsHz3nHQTYWbl4Ar65ogoBj6hKLgcKA
         IUNZTbsHeOtZhduWSPs1vmpR9Zq/O5ed1iRt1XqPJLm4os98iSLiDYXvmV6WbZJsfhae
         fjdBUHN+wtDFF/SSHslYRrO3zaJBZ/TyGS7ch/4a7ih4TAx2CN9bKwQL/a794h1XZyYn
         eg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4DFSXu8Yh6tzVuWv6AAoEDXYX0CgqlwJ2CGJTlsapw=;
        b=QMnpFfh43a+Jd625th2rhKVM+NUIVpETG6re01gDiaTCCLzfQkkPtutDsMwOkZQ/3s
         TdVLfIc7fm2SWWic6gZuIVv1TenW7MgnlTKInJaTSjP6Q+0hPnLD5sUkucfASYR1tYnU
         2voMqxaOAPUHH/PUAWmjM2d1kh1XoRu4noVq1+Ldw+bUthPFyl7cXNry1/6mwoJNyKMY
         GEQ7UYgBtvXjjD/uGKs/n/qwpdF7x/gNcEiBKxIeYS4dsPqbRTkFnKvk4vUDwpNQrPuY
         g+S7jMXln1ZXmSsaaIZYV3H4t6HXTN2rKQOdJ/08Nh0fnRJJu59oPqjpzvSCiqHjEH0i
         Zcjg==
X-Gm-Message-State: AAQBX9fboVbFPNkc7Z4L+oc8ajrOHtHu+hk5hm3BY+9g/QggD4mkK7aR
        aydtJyyAwdFCrz+GgRflmk67c5g+QPk=
X-Google-Smtp-Source: AKy350afxncUTWsy5T7lleFkLMaQwpnXFcIPmigYqatO+wk+5JtLyCBhJ4T2w0LMj3jGVZTdXy9Eyg==
X-Received: by 2002:a9d:6206:0:b0:6a1:6eda:53ba with SMTP id g6-20020a9d6206000000b006a16eda53bamr4860609otj.27.1680338842570;
        Sat, 01 Apr 2023 01:47:22 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k21-20020a0568301bf500b006a17bffbc61sm2086611otb.38.2023.04.01.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 40/49] completion: zsh: shuffle __gitcomp* functions
Date:   Sat,  1 Apr 2023 02:46:17 -0600
Message-Id: <20230401084626.304356-41-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index 170f3d7f5e..dc04c5b703 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -88,11 +88,6 @@ __gitcomp_opts ()
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
@@ -107,6 +102,11 @@ __gitcomp_file ()
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
2.33.0

