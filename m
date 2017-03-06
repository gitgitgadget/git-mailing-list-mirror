Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACCD1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbdCFJvr (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:47 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35609 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so17014077wrb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1GVT5avL8PH6wfx0JQYLRZUOsAGlehl/UY/NJiDric=;
        b=PdKjO+KLnp63atM4NoI0pj6J4bKjoKA8FFNGkveipAIrQbxb2MQZioMpwGJXdXLDjR
         rLSgZ/jM7D73xjRG5P0uOGYxDxvubnfocvqdkAJJySBNy0Xc+jTylUhDG1DYu3TszqWM
         FcD13bz7QnWq5/9vMxmVP7gE/LoWrut3azkfEZ1W8MKT0WzSmhF0hmD7AHjsnmS8kSL5
         gj6y5nF+4nT3hegnTgG54wdafeCM7xhe7yDL/hkcAdBbqhkRPwkcB6NG/xcaiH4DYe5U
         m672b3/9KfYV9y3JfBtgCgR3LfdFFJl+ceM3RJhKMXenORVoeZD6jb7M40BsWx86+V/U
         yWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1GVT5avL8PH6wfx0JQYLRZUOsAGlehl/UY/NJiDric=;
        b=SzsdH82hVfp/M1OSp5jU0NHrEfZGvvoVY5PJWznOGU6pAmcv8cIX1pL3dOl36vjuIQ
         BP3nnODQ98knTY778pa6wvvh2muuk2w/cukrq8cq1kFclq5ZH+XLIc6lqweBMm3/p4ao
         J/kb2vSfFvBdl3RKKmL9JmhA6AhaoKi9Mkv2YH0cz4UJSKne4Nq+NhbFWZNfkVPN6HAp
         h1ZB3/6XaxKQq41FXF3c02Nt//afmoczSOpaP5CUNwa58kEWt4ezsQdFqkGJmQM6gogC
         VWqysY5bV/dcbkDNNXJj9qBg4HF5JV+coMJwoZaXtIDteUD0AKl64i/027VI+DyyW3jm
         Wsow==
X-Gm-Message-State: AMke39me2EGlfwbzuDmrBdCFL0SOprq47w4OiBdx/5YU1+1xGU+cf1Ynks1ezHJ8EpbYbw==
X-Received: by 10.223.149.66 with SMTP id 60mr13072350wrs.29.1488793362324;
        Mon, 06 Mar 2017 01:42:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:41 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 18/22] t1700: test shared index file expiration
Date:   Mon,  6 Mar 2017 10:41:59 +0100
Message-Id: <20170306094203.28250-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 00a64bed97..f5a95a6c28 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -326,4 +326,48 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shared index files expire after 2 weeks by default' '
+	: >ten &&
+	git update-index --add ten &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_under_2_weeks_ago=$((5-14*86400)) &&
+	test-chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
+	: >eleven &&
+	git update-index --add eleven &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_over_2_weeks_ago=$((-1-14*86400)) &&
+	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	: >twelve &&
+	git update-index --add twelve &&
+	test $(ls .git/sharedindex.* | wc -l) = 1
+'
+
+test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
+	git config splitIndex.sharedIndexExpire "16.days.ago" &&
+	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	: >thirteen &&
+	git update-index --add thirteen &&
+	test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+	just_over_16_days_ago=$((-1-16*86400)) &&
+	test-chmtime =$just_over_16_days_ago .git/sharedindex.* &&
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
2.12.0.206.g74921e51d6.dirty

