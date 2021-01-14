Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCECFC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF01723A5E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbhANXDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbhANXDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:03:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E4C0613C1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:03:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so3706505plp.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVpg8BFip/aSnwCHR8iIU/rc9XD5L1M1J9zAje3yOcg=;
        b=T6MFBYYW2NdXNrJOpguIUAQaU0K4S0pKmTD+ezjvwcVQI8WFa/E0ArZq3K+d9DYGUC
         pGrtXof5DtED95NQIy8zagrQvQ4UWCKFd+ENxavmB7cUNsVSf/jIylJUkmpoz1rw2x6u
         hdYVXfsyZuPbaUrV9p0GeOeOF4haNIEmVYZset9vM10GBeegMp9aOlm3rVc9idHKj7mx
         b0ILszuMFA3xV1/7rTW/BeN4UG9N/g10vuX7t6+N0mG4CUnd7AvNqbbNEFCcse/Q/ejX
         VSw4P+5j2JLxUJilykQLb/25yBG4pEdNdHtPmCdNZlENGRfxVRsGwF7M2dTYQfKg1Qw1
         peug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVpg8BFip/aSnwCHR8iIU/rc9XD5L1M1J9zAje3yOcg=;
        b=ek/5AIiQNxuYIX+PFE6oR6RBeBeCtwsXbpDaGlv4jCDKfAzOd/Iw7/Eh6eH2ijmv+l
         485oSGBu3+qknuh5gog4fGhLorrQQhh11kuO0yL2aVlmHjzQ0+y2r9OccZbEQ4v2c07T
         qNWQSNuig72D3Vtrg3NMoyzF10RVzUIE54ZDAJ9Jexnpb5PRTBsbrz9rlV7lv1iFQekX
         h/h5mxNDjYTCmDWKVPOR8NvJbZfYAQdfCDz8Vkhq0fnMG3rCPy0KhNEtVANFiykN3sXJ
         /oitugv7Id3NBukczicjPXGedq2dG2eVpoaEJSRvpvMp+CwmY650sf0CkQGFBfby7tqq
         gqLw==
X-Gm-Message-State: AOAM531Mir7Q9M8ezAJiOCo14rq5DQcY8GNKT8i/JfiHM5y6jwji82tD
        guQ9XqR6Pon+7Do1uL+UHa/kHZMkAJI=
X-Google-Smtp-Source: ABdhPJzmGXZGwZ2ZahQsCZOpJyPgoT1C49WprPNA0m3auz2wJa/EFOCyNaPI7bvbz5aG/ovdKndxeA==
X-Received: by 2002:a17:90a:4bc3:: with SMTP id u3mr7368678pjl.56.1610665381284;
        Thu, 14 Jan 2021 15:03:01 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id n1sm6030261pfu.28.2021.01.14.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:03:00 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] t4203: stop losing return codes of git commands
Date:   Thu, 14 Jan 2021 15:02:41 -0800
Message-Id: <b31347c9f5d70fd8479ba37d82c75d5131bc1ca0.1610665323.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <cover.1610665323.git.liu.denton@gmail.com>
References: <20210112201806.13284-1-avarab@gmail.com> <cover.1610665323.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that their failure is
reported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4203-mailmap.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 89cb300f28..c9cb1aa127 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -634,7 +634,8 @@ test_expect_success 'Log output with --use-mailmap' '
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
 
-	git log --use-mailmap | grep Author >actual &&
+	git log --use-mailmap >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
@@ -651,7 +652,8 @@ test_expect_success 'Log output with log.mailmap' '
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
 
-	git -c log.mailmap=True log | grep Author >actual &&
+	git -c log.mailmap=True log >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
@@ -665,7 +667,8 @@ test_expect_success 'log.mailmap=false disables mailmap' '
 	Author: nick1 <bugs@company.xx>
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
-	git -c log.mailmap=false log | grep Author >actual &&
+	git -c log.mailmap=false log >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
@@ -679,7 +682,8 @@ test_expect_success '--no-use-mailmap disables mailmap' '
 	Author: nick1 <bugs@company.xx>
 	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 	EOF
-	git log --no-use-mailmap | grep Author > actual &&
+	git log --no-use-mailmap >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
@@ -690,7 +694,8 @@ test_expect_success 'Grep author with --use-mailmap' '
 	Author: Santa Claus <santa.claus@northpole.xx>
 	Author: Santa Claus <santa.claus@northpole.xx>
 	EOF
-	git log --use-mailmap --author Santa | grep Author >actual &&
+	git log --use-mailmap --author Santa >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
@@ -702,13 +707,15 @@ test_expect_success 'Grep author with log.mailmap' '
 	Author: Santa Claus <santa.claus@northpole.xx>
 	EOF
 
-	git -c log.mailmap=True log --author Santa | grep Author >actual &&
+	git -c log.mailmap=True log --author Santa >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log.mailmap is true by default these days' '
 	test_config mailmap.file complex.map &&
-	git log --author Santa | grep Author >actual &&
+	git log --author Santa >log &&
+	grep Author log >actual &&
 	test_cmp expect actual
 '
 
-- 
2.30.0.284.gd98b1dd5ea

