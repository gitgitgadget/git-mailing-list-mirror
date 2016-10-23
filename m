Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC3120229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756404AbcJWJ1i (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35026 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756338AbcJWJ1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so5223254wma.2
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/rv5MUwRlnczKQznkyZrrljFwydbPz6+cx+kIx7m4OQ=;
        b=r2GUagzpnu+csGjVSj+Iv+1Eptoj3AA9+DtYgachW6aO054n71VUpKkfA53bWia5EE
         pAjjMigEdD8/A1AYaQj6ckJXY0BASGP/bMBIQoaEMIieQ4oZZjGuejGRxhaDTiqYq1UC
         +mc6986WiTddBn8bGgMjpJglQYCTQp8NBMQ4qNz81JBhB8so8Q0HtHpH4O3a9C4IBesb
         YjwTQ9U4cyC88Xdkt0BNoH3YR4QlwxVMKgVeKZd7bpsJSL9A/du4M2Lu8FO1gGZwxkK5
         eIiJGXjdlgaUM+2uV5GJZi9nUm77WlQywQRez7T87JHdyJZTA3kH5CC7DaT2mbcGzEUq
         UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/rv5MUwRlnczKQznkyZrrljFwydbPz6+cx+kIx7m4OQ=;
        b=Xz5otPEIiS/yc0TaLujBWVsh9w8coOT5NoWnl1uMYOCIqZR41bwj+BGiHua3kBhBGz
         CKIdEwCFWS/MJOv1LHKCQczH9l5yVe95Emy+0eWRKraVDdTl3Z2IoT61LksQ1/ZZfxM5
         SSpVQVkhi9nyi+dqHaI5mMmV37JZdvN+HHrPFUuZZuGitnA/SPxXlx3RwrJfu9UH4O8v
         xf7nvsnNjaCDSDqT9UuXuVUpUF9LJ7uFvdUkHTpYsH83UYgJYkJH5KUSxdPPy+DsO77x
         8z4e115M2cMlFV6lU+SfluIbiccjnE88spZqT1Kwnpe/H6typDLX0yw2xQwPEGCOgtlY
         MtDQ==
X-Gm-Message-State: AA6/9RlXlVK3pz+3IaauKRcJFKmIlkmO9LFM4yRxBQ83gyG/Vyg93AR/BpAqj7ryxcW1DA==
X-Received: by 10.28.187.87 with SMTP id l84mr17758378wmf.60.1477214848928;
        Sun, 23 Oct 2016 02:27:28 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 17/19] t1700: test shared index file expiration
Date:   Sun, 23 Oct 2016 11:26:46 +0200
Message-Id: <20161023092648.12086-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f03addf..f448fc1 100755
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
2.10.1.462.g7e1e03a

