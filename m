Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D921F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbdB0SgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:36:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34015 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdB0SgD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:36:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id m70so14755572wma.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bp8BVXSfYWzhaGNn5ApXI3MhQbGr53IIcO1F/eVgyTE=;
        b=Ki0aTyEDY6GiVLuPzJPQ5cjkKcmxnE4uFgOo7ZQIYXy77iL6YA9/CRhMCo82dgvd55
         buWQzrh6UK2PRDZKXVr2rQ0zknwSM3gawITGqSOl5yn8kcKSym7Fi7TJQqz1GGAVMwOH
         qABZ05d6eTuyshhsT0w3fTrBgYsUES4DhjcgTzL1gYy39hfN8ndf0t/yFxS45Wic0/0m
         EwZt5+zjwJhhrLxrp7yTThwGBKfALU5ybpEyVElswpWiOs5BQUqYXKL4TBF2rGI73SvQ
         ZDBdPKx/iDwPc7VARQgsxcinHoUIFCxs5fcSiHoGw3TUykGaeO6H2TBVsDpabyJ2+xKf
         +tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bp8BVXSfYWzhaGNn5ApXI3MhQbGr53IIcO1F/eVgyTE=;
        b=JVF6BPZK+BCnqALTG5E6Kdr66RtjJKQU2InSSolL7ubM8YbnGOSSZN80iDM7sRTdJ6
         IDLC9jHwQ+aqOYo1Gy2PD5SQR1uRd5zi62HlwGoFy2J4t/iZpg8wNvzhuCKMwsd9zhwu
         GMX6I9YdBLGFuKc0K9aY93xqp043SpKyfR+KFK64M11lbSvKwO9E1lb0viIoxFycTb6g
         A9clVZS3mlNVlb61fmJG1iOpnPJwMxeQZQMgtL5CHBwVX3mIBzw/lZ38v6TyXlpewlos
         nBp+xvAYLdR5mKcAbS98KIlIuz83cqiFF5rN7QeSUs6by8UOTSBBmcKXPgWcIXGCzJ29
         B/IQ==
X-Gm-Message-State: AMke39nRr99J4grtdu+9wQSnpCJ+QsaNiPH1Sl/PB++pff4597qPXrN1+dtLkOm4o4ZW1A==
X-Received: by 10.28.152.212 with SMTP id a203mr8857771wme.7.1488218461726;
        Mon, 27 Feb 2017 10:01:01 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:01:00 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 18/22] t1700: test shared index file expiration
Date:   Mon, 27 Feb 2017 19:00:15 +0100
Message-Id: <20170227180019.18666-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 21f43903f8..480d3a8dc3 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -310,4 +310,48 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
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
2.12.0.22.g0672473d40

