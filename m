Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC59EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2BA24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7jVQvgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLSWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:44 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50987 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLSWVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:40 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so3176301pjb.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISkCmzf91CTIU8RodTdihc1hjhX0gWKk58ZbMkwYFMI=;
        b=V7jVQvgyT4LDFZf8FMY5F743hpvP9tMz8cyi53ZY+v8KNgGk/cf0qfb1alwPeLUwEJ
         plo/tajgPnhETZCqJEDnHsOGiJTLoa5+GaFum2LwwlgG+5j/X+eYQiDNTa9/Ho4sdu69
         4BJ0gh5x0Cd2Y2IBq7wNd6zzZ+z1WwzK7YiEqW9edEKtc1hnFjPZYe+1blM5eZEeEIns
         eOn9EcsZ6zwci1tLvNkcr+3cFUN264IfA8FAxKDxWfWbHwh3vcqf12H7z4NaFNFctMlA
         To3pEv1RLGuF+D+8PPyuwy+snDqLCKYo0XHMsw5olaNMleFKWd7osSt7e2Dw8Gbfg69h
         LrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISkCmzf91CTIU8RodTdihc1hjhX0gWKk58ZbMkwYFMI=;
        b=EHUl1RiP0D1dPEkMiR8bpjx4a/Bv6jnJs07abEjNlkS7AM4/V/xQdFVutlNw25L4jX
         wKi82/nXF9f5ztONRFrDTcIGlNEQm9pEMqXoVTgYnEwhBQT+Wyb75ldDL3Q2hACsJGNa
         /0QnRa5mz9o62j43y+3oAGJcbfScpFvlnw/+v5j7Q+Vw2QHwNgB6yuNOZlAtlto3H8Aw
         Hph/ZmzYeJrDzkza/tN2eqnnbTYaGECOslPccT7UoREnGS2F4Bq6pYZTcmiWLpNRri4z
         Y7OkNgBBtrSjw1mYIS99C/nuNRHznNJ5ypbpmaKHb2ax+krYGd5Ytcl2pH/acL+2CHxZ
         clvQ==
X-Gm-Message-State: APjAAAUlBhI5NE6uhEPHnSSATZJ9CqK9qEIM8mGKSGiFST+LUohIQ5ro
        zopnBFLNISonYlG2POAh25kByhb5
X-Google-Smtp-Source: APXvYqxTXDRTMOKA/iXeERsldYHhPSA6LpbdkmXcPN/NSvXGUUa4LjvHAeJ45NNKOFl2lPZlyjorLA==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr11839245plo.57.1576794099718;
        Thu, 19 Dec 2019 14:21:39 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:39 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/16] t0003: use test_must_be_empty()
Date:   Thu, 19 Dec 2019 14:22:40 -0800
Message-Id: <e06a06cff5206d963d24074bdac06d679540d483.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several places, we used `test_line_count = 0` to check for an empty
file. Although this is correct, it's overkill. Use test_must_be_empty()
instead because it's more suited for this purpose.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3569bef75d..c30c736d3f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -10,7 +10,7 @@ attr_check () {
 	git $git_opts check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 }
 
 attr_check_quote () {
@@ -241,7 +241,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success '"**" with no slashes test' '
@@ -262,7 +262,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'using --git-dir and --work-tree' '
-- 
2.24.1.703.g2f499f1283

