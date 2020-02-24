Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA922080D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 13:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPANJaYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBXNjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:39:16 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:35914 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXNjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 08:39:16 -0500
Received: by mail-pg1-f169.google.com with SMTP id d9so5193597pgu.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 05:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsJBUk+SrAewm1e4fniHtZhqVD/H6WLyTkIFIQTfb/Q=;
        b=vPANJaYw43snqzjz8miYbegsCwcseAsh7pk3pECpbRh9FO4y6UniVhbGiWir4e5bBS
         fqcy1R+nk55/S/UlsuPAmvxIDHbJeEAHGorahzwxW6OUScJpPnn5xHHgOViv4S36EQJc
         brzeoloTo8wxNIpK3tWN0lEp8WMh7gv+RWcNuHipnM9xoSFjDyK3owzzYGkbAIoTaVlM
         zPVvuMjjObsF8Id6hmFgaoxSDP4cvy9AMc+dkSrMUYgpdQ50yDE3eTHLDm+v4i05itdK
         hB77YmA5zyzDqLdeZSDN1LeB73CPqOdqU1+KE1MBroqL2cvw8y2maqLtXnNtPGgHmUPu
         fBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsJBUk+SrAewm1e4fniHtZhqVD/H6WLyTkIFIQTfb/Q=;
        b=jQo58z41Ur+xWFQ1h0MSLtliDp6TKbRvu7Edb7wd/QPcfEnTAH2Po2NSMxDbu0BK2E
         8uhayUvFeuDiBHYNwx1H05BVChjKmTMQbrHf0OjNhRd0yI52yXG9bZxSrxInpDjeazMv
         HfCabbAo4rVUbZXut7d5GVmg8q/Q7MwKYqrUJe3XtrucmehEn638Yiakqbg9EA0fz/dX
         uXcqZHlsBAfZuSJfOmxY42hDb1DO3jc7DaujfLnD7fv1/PWCzdbkMqFLySjOvrY3vQWx
         HYSII4k4U6x/rg95kszNkUODZu3CvUb2oIHQ/enzxjPNq2j3CRZrNHDiQxqOFji6GTmV
         iilA==
X-Gm-Message-State: APjAAAWWDNuB7uBlY7CKi1cMeBe76RL/v8p67f2rww0P2zsT0u7pmhrz
        DAW21HjhclWwkvziMRcYnO2Wh62P/s0vxg==
X-Google-Smtp-Source: APXvYqy42UitlRC0QDo2n1wwEGaKMXuBh1nZLwZS1oTfZKPA22egW1eysTGjGZCQ/wVMr2BnMG7kYw==
X-Received: by 2002:a63:4555:: with SMTP id u21mr16605242pgk.66.1582551555264;
        Mon, 24 Feb 2020 05:39:15 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id o6sm12945774pgg.37.2020.02.24.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:39:14 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     abhishekkumar8222@gmail.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [GSoC Patch v3 2/2] lib-log-graph: consolidate colored graph cmp logic
Date:   Mon, 24 Feb 2020 19:08:14 +0530
Message-Id: <20200224133814.100150-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224133814.100150-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
 <20200224133814.100150-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/lib-log-graph.sh           |  6 ++++++
 t/t4202-log.sh               |  4 +---
 t/t4214-log-graph-octopus.sh | 36 ++++++++++++------------------------
 t/t4215-log-skewed-merges.sh |  4 +---
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index f9c6526eff..1184cceef2 100755
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -20,3 +20,9 @@ lib_test_cmp_short_graph () {
 	sanitize_log_output >output.sanitized <output &&
 	test_i18ncmp expect output.sanitized
 }
+
+lib_test_cmp_colored_graph () {
+	git log --graph --color=always "$@" >output.colors.raw &&
+	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
+	test_cmp expect.colors output.colors
+}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e025a9cfc2..4694b6d0ce 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -537,9 +537,7 @@ EOF
 
 test_expect_success 'log --graph with merge with log.graphColors' '
 	test_config log.graphColors " blue,invalid-color, cyan, red  , " &&
-	git log --color=always --graph --date-order --pretty=tformat:%s |
-		test_decode_color | sed "s/ *\$//" >actual &&
-	test_cmp expect.colors actual
+	lib_test_cmp_colored_graph --date-order --format=%s
 '
 
 test_expect_success 'log --raw --graph -m with merge' '
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index dedb72ace6..a080325098 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -10,6 +10,10 @@ test_cmp_graph () {
 	lib_test_cmp_graph --color=never --date-order --format=%s "$@"
 }
 
+test_cmp_colored_graph () {
+	lib_test_cmp_colored_graph --date-order --format=%s "$@"
+}
+
 test_expect_success 'set up merge history' '
 	test_commit initial &&
 	for i in 1 2 3 4 ; do
@@ -60,9 +64,7 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph left octopus-merge
 '
 
 # Repeat the previous two tests with "normal" octopus merge (i.e.,
@@ -97,9 +99,7 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	* initial
 	EOF
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph octopus-merge
 '
 
 test_expect_success 'log --graph with normal octopus merge and child, no color' '
@@ -133,9 +133,7 @@ test_expect_success 'log --graph with normal octopus and child merge with colors
 	* initial
 	EOF
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-merge
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
@@ -171,9 +169,7 @@ test_expect_success 'log --graph with tricky octopus merge and its child with co
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph left after-merge
 '
 
 test_expect_success 'log --graph with crossover in octopus merge, no color' '
@@ -215,9 +211,7 @@ test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-4 octopus-merge
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
@@ -261,9 +255,7 @@ test_expect_success 'log --graph with crossover in octopus merge and its child w
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-4 after-merge
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
@@ -305,9 +297,7 @@ test_expect_success 'log --graph with unrelated commit and octopus tip with colo
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-initial octopus-merge
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
@@ -351,9 +341,7 @@ test_expect_success 'log --graph with unrelated commit and octopus child with co
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-initial after-merge
 '
 
 test_done
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index e1e94176da..28d0779a8c 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -305,9 +305,7 @@ test_expect_success 'log --graph with multiple tips and colors' '
 	<BLUE>|<RESET><BLUE>/<RESET>
 	* 6_A
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s 6_1 6_3 6_5 >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	lib_test_cmp_colored_graph --date-order --pretty=tformat:%s 6_1 6_3 6_5
 '
 
 test_expect_success 'log --graph with multiple tips' '
-- 
2.25.1

