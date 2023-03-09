Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA91C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCIRak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCIRai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:30:38 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D44F8E5B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:30:36 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-176eae36feaso3046902fac.6
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678383036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNsDRoG1iQdeF/tucxQuoFoYiitYQw/u7fK6LC7gkbw=;
        b=jQ3GeLrG7azH08iGg3RLdhrKMjyVY4dnXD5+eWTwIutPZaXe+3/TakR2Mo04w1vylc
         dxruk1nKxl8M7pAYg2f9s+Lu/j3MNu7exaND4ZffHgQ9sPTJRsIuCj8ML/tTuCRaOt2R
         m6H2egRWiDyubs/uM88mmbRuQ91tjSlX/bpocCn9C755zkMbjO0uhxZ+aHI7Se7/oYDe
         dMy8fiLrQhXQVU/oRL+QxW0WljSnKUJbDQu1hgS29OUURfrHQn2u8Py8CZ4UIK1JrfKJ
         XvnjZUx3dBqWF34uPXJKQifPnV2bnN7C3noghf2ZMdv8+d456UZFWiIqy3Za9b+Vh+UG
         VK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNsDRoG1iQdeF/tucxQuoFoYiitYQw/u7fK6LC7gkbw=;
        b=Tog/boBcyIdD5PudX2W1+0SKvafYrbsmjLc0WSyYew/x6BaDT9C09LcRUCOgeomDfp
         viYY7jEH7lWKzzz9lrCaBSdhTPB9TQkArbBgrYAr8ytv6XamjHBZm4U7xO0xsKoYiJXc
         B877GHtuIk2/JJ2kBuuVMZ2xMC6qxpgiZaU0q/I7+M0KXEyrbecsGhIWvcDAjwiJYYqE
         zbeX3O4NtTcnoLYLH/OFCCmVKOzfBtIbxsj8ogBgszDuXwldtd9w1D47P1dmDPPgJHwX
         1WyWxfUKi/PT0wRI8PnsqvXpiJoDl7lnDy/QGHi3D6UQ2nafiBPwrcCv0WHFjvh3C02y
         nO/Q==
X-Gm-Message-State: AO0yUKWt1cISUcZnzD/zy+Ytowc7EWsVG1RbDFOjyXzgOs+M56dKgP/L
        Lh6OxNdmKRrVvjRSes0VhBOKc9Pl+9s=
X-Google-Smtp-Source: AK7set9dfS/9r6yuv2Aj1kf/w24x6CcgrU9EglUw+H/ScvLhu2TV9lvOoL5HLdW2SlpqpKU6qb4GwA==
X-Received: by 2002:a05:6870:5b1d:b0:16e:ac1:c644 with SMTP id ds29-20020a0568705b1d00b0016e0ac1c644mr864009oab.21.1678383035989;
        Thu, 09 Mar 2023 09:30:35 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h4-20020a05687003c400b001764f55398bsm7460561oaf.20.2023.03.09.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:30:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] test: simplify counts aggregation
Date:   Thu,  9 Mar 2023 11:30:31 -0600
Message-Id: <20230309173032.959968-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309173032.959968-1-felipe.contreras@gmail.com>
References: <20230309173032.959968-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the list of files as input was implemented in 6508eedf67
(t/aggregate-results: accomodate systems with small max argument list
length, 2010-06-01), a much simpler solution wasn't considered.

Let's just pass the directory as an argument.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/subtree/t/Makefile | 4 +---
 t/Makefile                 | 4 +---
 t/aggregate-results.sh     | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 4655e0987b..aa204d43b6 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -74,9 +74,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
+	'$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
diff --git a/t/Makefile b/t/Makefile
index 2c2b252240..6ce79849e1 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -140,9 +140,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
+	'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 7f2b83bdc8..6e3bcc4aec 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -8,7 +8,7 @@ broken=0
 total=0
 missing_prereq=
 
-while read file
+for file in "$1"/t*-*.counts
 do
 	while read type value
 	do
-- 
2.39.2

