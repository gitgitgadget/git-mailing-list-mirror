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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65DDC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11E3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhAACRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbhAACRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:40 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F77C0617A0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:23 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b24so19329243otj.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb93OWbhg3QegfWNbnbRV28+nqE4nY0GoJhxBtzwV00=;
        b=CbmAIT3qE3Yy3cOwY0qQVIzmHBYtJQS84b0SgztVZrg7nBi1+wgp4gGPNNwPQdLdNW
         9qEtPHST1HU4Z/GTdLWesT624nLQQT1JNyTQ2VO6fotnql8O0SCTV0rQ63rd64iK7ewp
         azvyC89pZmNlNqorZiGUHrj5vO4MrOHWnr1vzvqkbUB7h64nBPdcS2H0BVNXc93Q1kiN
         C4/cCoF/lNHIBKejtleJ+u69ry8lYgSaGeTwcYpJ4xTE08W0EMMfNFtKmSNTCfHQH4sq
         706mKWWQPK4n85p3dR694z9fWKywdgfAXs8fdbAUEe9is3/hofxSvdYHSYnBx29Aj4pt
         WdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb93OWbhg3QegfWNbnbRV28+nqE4nY0GoJhxBtzwV00=;
        b=DhiH2nkIBPPkcFTzMKXRA4/bdn1nmbc4tnNLBAVpZxYEBEcgrt6ROJHKhAGrOxFb+s
         0d0csW27F0vzXdYa1A/2NMxaV3D2rxAAZGbcl363VMpDAlyalepDN35Zuj11G6+1mFZs
         VgVnNelTDqXdRrYrnBYZIEwuY66BQyM13c0UbCcPnU2BcYIKXF8xaQ+D7Yrnvl7ehXEt
         qDMcMUdzu3lk29Z2/hiuVHHBA9GLGK+MKDg6XWGpq01Bc5PNo7SEDDRpYEYpwfy1NcsJ
         /4T6MdlurzEU2U+u5d7RvqeS4oksa9A7ldRKSGz5mvwxeMWkH/IMFzYVuRvVowlD5U9g
         VoUg==
X-Gm-Message-State: AOAM531RKM38g4vGgiQ75Q29IsoitUj1RFuOq0mE3hSxc8XaZ2Ofiy96
        0PVwYbJVn7uy9hE+ed0xQbF9xoHhu0UKXQ==
X-Google-Smtp-Source: ABdhPJyPirXF69MqTrzS7Z7ZhoGJx0+mXWPQ9WsCu0qRq9e0jQ2N3LDVrNLkBEYJ+Y9IiXHYg411/w==
X-Received: by 2002:a9d:c01:: with SMTP id 1mr28818037otr.107.1609467443064;
        Thu, 31 Dec 2020 18:17:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z9sm11672998otj.67.2020.12.31.18.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:22 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 37/47] completion: zsh: add correct removable suffix
Date:   Thu, 31 Dec 2020 20:16:12 -0600
Message-Id: <20210101021622.798041-38-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zsh has a nice feature that allows a suffix to be automatically removed
if followed by a space.

For example:

  git log --prety=

If a space is typed, the suffix '=' is removed.

But we have to set the correct prefix first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4e9699f542..43b7c1b210 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -51,7 +51,7 @@ functions[complete]="$old_complete"
 
 __gitcompadd ()
 {
-	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+	compadd -p "${2-}" -S "${3- }" -q -- ${=1} && _ret=0
 }
 
 __gitcomp ()
@@ -79,7 +79,8 @@ __gitcomp_opts ()
 
 		if [[ -z "${4+set}" ]]; then
 			case $c in
-			*=|*.) sfx="" ;;
+			*=) c="${c%=}"; sfx="=" ;;
+			*.) sfx="" ;;
 			*) sfx=" " ;;
 			esac
 		else
-- 
2.30.0

