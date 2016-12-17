Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE89A1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758167AbcLQO41 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:27 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:32806 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757842AbcLQO4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:24 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so18015474wjc.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//19UzQzIkshDiPbayBIpI/vijp6Q427A/sBwPaRfro=;
        b=NERQbPg0UNKpLYLhDxJmVZWCTV2Vefb7u7VyftLpNK0d05mw87d4qNjsxThYj4477E
         xVPvm6aldliubQGeHfnyPTY/kLf96LJviLOmNMiV6AF/pzqc9EAxwGgp1SeIm5x0Jwh/
         Bf8yIh8EMy9ux9p60VkvhsUleHkxjCFLmim6m1IMS+hdGhJRyjRSoat+z9iRsAa8K/W4
         NmGi3hDxj/rW1KW/Bljg9zLiJWJf4fSqCaihamPiyH1zMj7Xa/TxxZd7xPN9ETrUVMVn
         0U1/rMJlfu8k8Gn1Osp+UoMEe+MSbobCPE6p3PQk8MEyKEo1N9XokA7ShOfWiuhWkUoT
         bgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//19UzQzIkshDiPbayBIpI/vijp6Q427A/sBwPaRfro=;
        b=Wlm/VOYqNLZUU1DhYGmT3oBwWa3g/Ycysh9totB3bMcR+vSqFnTG4tXoYxPqi5VxJ4
         TG4+ia/zwmOzcrXSmdaPdIhaAwAUR0v5Cw0htgUfK6DTAOKQxL3+TU/ckdY94rLtZXKF
         zUoY1NwexoZnaIvsNZk7C881w+h9c4KiEwlh4fUH/t0ESnmEIyRpyLQxirMdFLIul8zg
         fxhaRanHiVh2l+kmT5LXoEd/K4rn8yQ3CSif6v3vfOlnuYNqHOnWq9tilOd4hL98Qp5F
         yHjB7G6nYsBp4LWh3gfcS6WM+McbxVKzICKr2QKhryNavUH5cHCxmFnT2iEO05N6iK3U
         ZukA==
X-Gm-Message-State: AIkVDXKskkHDBLcYCrsxSpN3Ngq4SMc7AeN4wsOX9tBQVIg3QzcQuFo3738J1kjsFy9IxQ==
X-Received: by 10.195.11.229 with SMTP id el5mr8524406wjd.64.1481986582670;
        Sat, 17 Dec 2016 06:56:22 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 17/21] t1700: test shared index file expiration
Date:   Sat, 17 Dec 2016 15:55:43 +0100
Message-Id: <20161217145547.11748-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f03addf654..f448fc13cd 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -310,4 +310,48 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'shared index files expire after 7 days by default' '
+	: >ten &&
+	git update-index --add ten &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_under_7_days_ago=$((1-7*86400)) &&
+	test-chmtime =$just_under_7_days_ago .git/sharedindex.* &&
+	: >eleven &&
+	git update-index --add eleven &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_over_7_days_ago=$((-1-7*86400)) &&
+	test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
+	: >twelve &&
+	git update-index --add twelve &&
+	test $(ls .git/sharedindex.* | wc -l) = 1
+'
+
+test_expect_success 'check splitIndex.sharedIndexExpire set to 8 days' '
+	git config splitIndex.sharedIndexExpire "8.days.ago" &&
+	test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
+	: >thirteen &&
+	git update-index --add thirteen &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_over_8_days_ago=$((-1-8*86400)) &&
+	test-chmtime =$just_over_8_days_ago .git/sharedindex.* &&
+	: >fourteen &&
+	git update-index --add fourteen &&
+	test $(ls .git/sharedindex.* | wc -l) = 1
+'
+
+test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"' '
+	git config splitIndex.sharedIndexExpire never &&
+	just_10_years_ago=$((-365*10*86400)) &&
+	test-chmtime =$just_10_years_ago .git/sharedindex.* &&
+	: >fifteen &&
+	git update-index --add fifteen &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	git config splitIndex.sharedIndexExpire now &&
+	just_1_second_ago=-1 &&
+	test-chmtime =$just_1_second_ago .git/sharedindex.* &&
+	: >sixteen &&
+	git update-index --add sixteen &&
+	test $(ls .git/sharedindex.* | wc -l) = 1
+'
+
 test_done
-- 
2.11.0.49.g2414764.dirty

