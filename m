Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636FC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535A860FF3
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGTT7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5576C0613DF
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k4so27297890wrc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CjCwvYNfaftKNON/5Qnsv7Bb6epxLgdnNa3qG/hBIJI=;
        b=g4v/yXOGprvv3FFNnBbZT6eSuz8b9tq2Hx9XhoqRRaChyXtx+T02SZ3g08L4+Wktuk
         9yCt1eC3dtDqnq1bfPFhEndu9NsBHQQXjsP/m+WyRWiLpQsC3ZQmViW/u8q6TJm78vBW
         f5q1VojsQTVOkHtUUQ3VJ6C59XMBmk4bqXmdAIV2WrJEiynDOH3KprknszsThBAD4FZz
         WQOFM+C+YfYw/HkGzsScdpjLjKx0XzFlejM2azcnJbDl1xh2ORDfvfLAaf/LHByXKDIb
         fkjcVGaeuFppB5mY+w4l5WbF8mbtHz0NMegwYX8w6TSH/r3dYT4P1K+xxaD5rao1q+uN
         3Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CjCwvYNfaftKNON/5Qnsv7Bb6epxLgdnNa3qG/hBIJI=;
        b=cDM66SejQOa47lFLsF53aKJ/REkbhQYYoVOzaYELTQHxY8JkUJeYT3YF1xo/zgsuVB
         qZgGx5VN3QsgTdD7qrwDJiGw+LD5jQvWzhK7NfLHZvvx+g0GBy0No5rdB+gdCyk+tT8v
         PUsl892bp37HkK7J1C2DpYVkHPEDT7loV95UajZjX/T/ljaqwdUSIHxAcHvNQrmtbH3F
         B3JmFvRQoYhqRGow3llVAenidsIZBMp+VcqVnMB69UARxJSZbPQdmN04pUEP/+vSLXlu
         R0TlX5Fl1v2T5erir5HNj1jS2IRbuHPF13i8mmD6+3a4rYPjBeP3ZhDSpcoZWYCieABV
         dDKw==
X-Gm-Message-State: AOAM5330CNXF8AsbUixMHgZ3v2xd9rla/C/xrnEuY/8nb++dstWtTQqd
        T1Alz6/U07gHdZEJfFdKYgaJ2bKxJ58=
X-Google-Smtp-Source: ABdhPJyCDqidatuc3Yf9cMYzsNVbZgd1aFh3LQu3pUvrMsOuM+7yEbyjT+lRQ85cjCn8T1y46Kl2HQ==
X-Received: by 2002:adf:c849:: with SMTP id e9mr38581865wrh.348.1626812083364;
        Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm23528123wrs.22.2021.07.20.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
Message-Id: <3e1d03c41be9701c2cd518afc6ebc2797bca4398.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:36 +0000
Subject: [PATCH v2 2/7] p2000: compress repo names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

By using shorter names for the test repos, we will get a slightly more
compressed performance summary without comprimising clarity.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p2000-sparse-operations.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index f7f8c012103..597626276fb 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -52,36 +52,36 @@ test_expect_success 'setup repo and indexes' '
 		git commit -a -m "edit $SPARSE_CONE/$l2/a" || return 1
 	done &&
 
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v3 &&
 	(
-		cd full-index-v3 &&
+		cd full-v3 &&
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
 		git update-index --index-version=3 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v4 &&
 	(
-		cd full-index-v4 &&
+		cd full-v4 &&
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
 		git update-index --index-version=4 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v3 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v3 &&
 	(
-		cd sparse-index-v3 &&
+		cd sparse-v3 &&
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
 		git update-index --index-version=3 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v4 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v4 &&
 	(
-		cd sparse-index-v4 &&
+		cd sparse-v4 &&
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
@@ -92,8 +92,8 @@ test_expect_success 'setup repo and indexes' '
 
 test_perf_on_all () {
 	command="$@"
-	for repo in full-index-v3 full-index-v4 \
-		    sparse-index-v3 sparse-index-v4
+	for repo in full-v3 full-v4 \
+		    sparse-v3 sparse-v4
 	do
 		test_perf "$command ($repo)" "
 			(
-- 
gitgitgadget

