Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15F4200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbcLZKXL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34852 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755666AbcLZKWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id l2so26996075wml.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8Iza6yJo1MUWzGE4jXu5SpP4H1JtETLMul2TXpyxeM=;
        b=A7p/MUuMzJGmRGhwLDiL4vmnfh+9BKne5N8s1Y/5Dkascb7GtHgz4LUZjXEZqWNW35
         UPNqEuuBQtXiVAr8MPsorhEHA9RaCm6S9JpfCN3JGB68Db8ZZceDfXDJl59btPtLUeCT
         0qRKHQEV8kffNW3SzRww1TLzEpbh7Bi26D5tgEw6x3fhe+JRm/nPHli1zj4apfCKB3E2
         3ShcvB1b3WUQWugJx3x0Bbwp7fZ4IkaIfF0Gpgybn1VhytNTkKyV1Bugwaiy2KlNbEfo
         QM1jkTSdOKi1+Ls7tzadApKmNH+DyiHbn9yP5R34hqjCnLbEG5vNWFph7N4GrB3uhYmv
         MpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8Iza6yJo1MUWzGE4jXu5SpP4H1JtETLMul2TXpyxeM=;
        b=GzcBo6lrRkme/oea9vt9REJzp8FLNLw/5FbVQX6dJeUO0IbXCw20tEvsPJhV+LDLhK
         5rt0SmcbuIvFYBmPTCr4Ue/iC3RtjNL5kSZkPjoc7+M6IHuCU+TgPE8m8tXCbwDz7AiL
         dhOhyl7lGPLJsDiBlAcz6ZVkyI0DKqK8iwIItXRv4WJTLo60vPkwP/EuIcM2tFuWdYA0
         x+mboW9xgVR50SB+ppgfkSp7S2xcjGR5snx9+R0yBDgKJK74CGkha0/IfF4ysKlX0MS2
         bfvfDuiNa+jg3hwh3XJgQkRXVyrMS/tSOKO86nePoc1wx5RQMCOlW18InYGCuesT6pAO
         kIJw==
X-Gm-Message-State: AIkVDXKC/PWJC3kAMMgU/zgoMSRK6oDKyqHv33BY9NZ60ztm0z79nCa2jlXsRYx05ujPDg==
X-Received: by 10.28.107.77 with SMTP id g74mr24097680wmc.109.1482747773318;
        Mon, 26 Dec 2016 02:22:53 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 17/21] t1700: test shared index file expiration
Date:   Mon, 26 Dec 2016 11:22:18 +0100
Message-Id: <20161226102222.17150-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
2.11.0.209.gda91e66374.dirty

