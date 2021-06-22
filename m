Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE013C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1D600D1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhFVKpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFVKpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 06:45:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA3C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:42:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m18so23063272wrv.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=oU4XyiZb0f+7XsW6mAS9ziK2ep8uWHKhxXeIHLWNqbI=;
        b=piia1C94n0giiJ163/5zfADJ2slUb92FRCUpU+nRpcKPgySGjlvm3T4NuNT0Tz78J7
         wTY5UbqwBZdowZL2LUn4Ny2MS6mefgGtnvBk2fq7xjVXY+ELZ7jdbMdixgj4GtnbTEgY
         GU5JhNGGHy4r8xkNIFhSWNdV5xsJrYPC34bRo252WnKdJXvvefga/UmQetCI0xh9CSH9
         We/rWV70wERSYhEuuotxwXzsagDXs2AX4r304ua62dPKbqJ6RRG092fOKZSTI2U6DdOG
         a8Y/D4A8bVFhUOjV9Xqqeo7zldVMV/70wwUWHwFI/RBUgdwRQAoBo2zHTkazf/71Vg+W
         6gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oU4XyiZb0f+7XsW6mAS9ziK2ep8uWHKhxXeIHLWNqbI=;
        b=dxD94TGjQwpCvd6R18tOmbvdooSWQPDreiGM7zy7XI+cerd9ao/mUXxpeO9u0AM25a
         aTDfQnj1vyIGfgzY4Uoy91vOK/3VSYbr3IgTldm+Ajbc0fpnV/1KCeffkA3Tt/QxbykQ
         +L0iqN2xOqMuK9miW2O4zaV4/NKpaOlyQOgc1RyUB11yIIKfz52b3AgdrP1MwjgsxnUq
         IYFuLbka3KrtYt37ky2DDqw7ZZ13LSjpIYqJEcARfeU/ZpWfOnG0ZdkLOwjeCoAW4g++
         YiQlVyZytTES7+1rhZouLzxBeQ0iXzr34c/4GqbLlp+331pcAs0cbU8Qo1NcntvdxNRS
         ak9A==
X-Gm-Message-State: AOAM531+nJElMPEBFc5cH9kpayUK8y2t0sh8IoYIr5gbwIHPJc5/VxXH
        RnRZ+GttZUzj8MltacaB47bbXE1HDcM=
X-Google-Smtp-Source: ABdhPJxICEDUpfyR/8/WCyrbkWNkN/nXbk4ua3d5pC0TU04KyTgYEdhv2FQyT11XS7hI1MCtO9MMkw==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr3806252wrz.59.1624358563570;
        Tue, 22 Jun 2021 03:42:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20sm1935617wma.19.2021.06.22.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:42:43 -0700 (PDT)
Message-Id: <pull.983.git.1624358562084.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 10:42:41 +0000
Subject: [PATCH] config.mak.uname: PCRE1 cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Style issue: a space was missing.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
    config.mak.uname: PCRE1 cleanup
    
    Git for Windows carried a patch retiring PCRE1 for a long time that was
    superseded by ab/retire-pcre1. This is the surviving remainder of that
    patch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-983%2Fdscho%2Fcarenas%2Fwin-pcre1-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-983/dscho/carenas/win-pcre1-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/983

 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e023a..e8ceaed3d3ed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -668,7 +668,7 @@ else
 		HAVE_LIBCHARSET_H = YesPlease
 		NO_GETTEXT =
 		USE_GETTEXT_SCHEME = fallthrough
-		USE_LIBPCRE= YesPlease
+		USE_LIBPCRE = YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
 	else

base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
-- 
gitgitgadget
