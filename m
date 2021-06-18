Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B49C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063AA61279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhFRWNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhFRWNS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 18:13:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D3C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:11:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so18114690ejt.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8zI6ti0aBVA7L2kiMf1qK9XqqmLMfgBJo8qiFCoMXY=;
        b=ajut10meZBz7e9esSCAHYDosJB2c2rMN2sLj9McBdD2Kgk/YSrMQl5NZ+72fCS1gCT
         xNAixgoz2t4ca8j+QfgW8PQgHM/gyFGdr/niAma6/VZH8ztPj5sKsbvRxBA9MUgII7X7
         BxbDiZobnBP2UsDzgn5flVzWr7c8gixefLWkyFjvxPxpLFfizmOE00cnWpb1sLW7+7DL
         rtZrON6cVQVmwC/q4DhPmaRe2/h7RIjvhGVvsti9KxgyQ5RM7IjSMlnSHP2srU0kzOil
         XIcy8e0IpQY88fohUVtWUA8gU0hHbRtX/UOZ5Lb5mJwQxcCNOsoEuZ7/umrI0Ydn6O2A
         6+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8zI6ti0aBVA7L2kiMf1qK9XqqmLMfgBJo8qiFCoMXY=;
        b=GgOhmUcKkrdkIaAzJFJConnFtMRlHHVmtqC91QPDUDkpsgCRxz17hfdlIjQ9SV2spC
         0SrM0wfZZwGRct7U+cdbyAE6FMlMBmGapKX54h12hqllTxpAOinEk0XeRHe61XllVQiZ
         W/zWTk9elsw87k7d4OmecIT3A8N+Y7Jd+L9O55eun1QsSEL1syHtmAC8If/On4fxjPKA
         lD4cSxuqjmg6Nzdp+zzlir/LTs5k4BsIo9M2ryfaaCGv7yyFd2PgUlTJx/6D/YmzcJAr
         8oIFbgJmG/xTLa81nGLTxkm4nNigNm0JG4vd3UWFn3cZo6CLVF1aavIC9UX9eIntGWbl
         4LNA==
X-Gm-Message-State: AOAM530UqMOhPx40eOeig+MpqWo0k2cTK1Qp3Q0+f42lxRB9ZaWKW226
        fY5Kvbd0SoqP74jHVYkgLmoo1OICghPrSkBVC+k=
X-Google-Smtp-Source: ABdhPJxz0mHGu+e6YtVGxYFl/ATb1oWY4YvrZgGwz7zP8B2HsaRslhmS+B6u9LeNb7mE2HH93ZJtaw==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr12731869ejd.171.1624054267295;
        Fri, 18 Jun 2021 15:11:07 -0700 (PDT)
Received: from localhost.localdomain ([212.102.57.166])
        by smtp.gmail.com with ESMTPSA id d17sm1496109ejp.90.2021.06.18.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:11:06 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Barret Rhoden <brho@google.com>
Subject: [PATCH] blame: fix typo in documentation
Date:   Sat, 19 Jun 2021 00:11:04 +0200
Message-Id: <20210618221104.42260-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As can be seen in files "Documentation/blame-options.txt" and
"builtin/blame.c", the name of this configuration variable is
"blame.markUnblamableLines".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/config/blame.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 9468e8599c..4d047c1790 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -27,7 +27,7 @@ blame.ignoreRevsFile::
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
 
-blame.markUnblamables::
+blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
 	attribute to another commit with a '*' in the output of
 	linkgit:git-blame[1].
-- 
2.32.0

