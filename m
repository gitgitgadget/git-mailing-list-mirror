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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB18C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E996105A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhDZQQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhDZQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6281C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so239248otp.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gjc2iTirAk06PW4Equ5G1GqwAUmddUKPB7Ru4CksQQg=;
        b=vYuWBQRO1bBvq1F+YRPrCf4X/chMAeqOjuN08RXWWzdJtUfFta+N//9kqWCf55ZTB/
         n8vfxbbwzHlg58CLFkzq2547FY0rar8MxiirjcuYAbkMdyEzS7yByQIUdfvUGvLSmEte
         Ljg40t8fXV77V/W3MYkpPxQ01mSHV7gUk6JhHVZTUX5uO/44xmQnHUOtUTULywLxxcDg
         +wyQelOfl64Y/F1SuLdX96DakIjp6onlXGd8ow6XZNBny8PmIIyk+F+Xcx0rvpIPLg4m
         hSseQgCaniVI6IgX6GIea44Rsm/lVr0DoIhp5ozhoY+R3NRDtehNHAamHDz8dPOZZusd
         NlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gjc2iTirAk06PW4Equ5G1GqwAUmddUKPB7Ru4CksQQg=;
        b=RARrWEY9CHUvT6TLwVNqF3PJqmcGIavPNv7WCYcntby/1iA66xTp2hf6ufv3V1QfdO
         jgYv8Vzl5z5znfXt6nbB1XSvK1cMisTWKbftuJktyydvdh4z1xAsobzoBRkTmF5s8EEZ
         KGDJ67vRR0CGUX0NJu0jxzBb/1GsLnwnfrVPKERGTvL16Ytpiq7QysT3uVK2p1kaDMLD
         /to1EaeoFsPxqVb8AE4QM2wwpjP4t5iml9pqhr2Y/6IucVKxntkz/jSjR6c3mEUaPFSR
         hlIVeKBvwzBoBWz1mk06ZKu7sWFWq4v/gd3kATVo+nP+JRzkeDeicSe/3CMGe+gQlh3A
         iLfw==
X-Gm-Message-State: AOAM530tf7Du12rzTP+ljBKqQZWZjrHdPIopFfgsT/Bg1XdI0EJuNyMq
        8thIY66EuwF5O9hVkJ5/7yZWNtYmgt3OLw==
X-Google-Smtp-Source: ABdhPJzrWn4zufsyiwETuT2l9G+rVQX59bUJJwgtbTBp1aBSu1nRILNK1PhWbSyQuhf68ctcG+3rUA==
X-Received: by 2002:a9d:7453:: with SMTP id p19mr15200228otk.271.1619453735914;
        Mon, 26 Apr 2021 09:15:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id r19sm3097968oie.58.2021.04.26.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 07/43] test: completion: switch __gitcomp_nl prefix test
Date:   Mon, 26 Apr 2021 11:14:22 -0500
Message-Id: <20210426161458.49860-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4d4bee20b4..13bdf634a6 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -568,9 +568,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.31.0

