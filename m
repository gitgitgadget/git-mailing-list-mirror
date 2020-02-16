Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E03CC2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215B6206E2
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqOFKjjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBPNsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:48:50 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33308 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgBPNsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:48:50 -0500
Received: by mail-pl1-f179.google.com with SMTP id ay11so5668098plb.0
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ch8DAzCAJNn7naIx5r87yR81G/cwFQYt++WyCnvrzS0=;
        b=fqOFKjjLJoDkvYQfYPD8TiX+gbaHe3xJToMGCXyD98byyHzoq1tYxERS9fNo8gni9P
         xOFRXK6goVWP9q+pKIjuhzV/KfRzt9Mwa5dQySx36r688TSuXvj/COWlr+Lrp+k1P2rO
         5M/vs+xu5zjii9Nsstzv36zVn/FmKcoHykpQRT8AssUh7LzN9/kWrfqROhGjEn4V4zxK
         FBkizSXDZ3MRSEDzVHsmwMCu7svdJB1vZYJYIvRnbbIDVQoqG00E+RUFNFQH5Rc3baR8
         XvCs1ofqPBvByBucgCxEtaAE0Meqm84ikXq9wp7TyEyB9KLOBxBtyBsfwKYJ3Vky35lw
         BreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ch8DAzCAJNn7naIx5r87yR81G/cwFQYt++WyCnvrzS0=;
        b=Dn2siOhrNZWUDJQ/4EsynwPwrMn1p95s3kxxvH3h8SqTPgqqw1nHF2Vcof/lJvOfaZ
         MorcEFYnEZo0Qqbku8/ko59rD8yFf3gbZLopegBzx1IBNQCvAxnKYdNyKp4fgnA3gGja
         Z0Gzarayi7FB9g0YC4unl6q9f1i3RJoR4MVkaa5wJtTykfrtvGINtIfAf5uDIEKwWQe1
         QDtFwkw8HehZURPjDnXbpOYvCaDkZJ4X1ZLCD27fbIcmnJQGtq0UzX5IgXkRlSkkJTcZ
         TpZgGri2KZgDPJ2lHwLv2locDxj7nGgFwTgVmPv0fghnmQH3fri5ZUHd9b23dvC7ZinI
         DMhQ==
X-Gm-Message-State: APjAAAVlUavaiAYTkP4S91lC7nf4ZZhlEcQZEuP7hmaCsGE/x8O0usfp
        flmmN4rXwpDhd89GYPwmwfrPIkfHDL8=
X-Google-Smtp-Source: APXvYqw5fsiZkTh+08IioKC6EPbF2suRpm3zMyr6lS461Uywu8XtPVPi66BxIARqHUGtcSaDS5HCLQ==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr14457288pjq.133.1581860928426;
        Sun, 16 Feb 2020 05:48:48 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id m12sm13302006pjf.25.2020.02.16.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:48:48 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC Patch 4/5] t4214: use lib-log-graph functions
Date:   Sun, 16 Feb 2020 19:17:49 +0530
Message-Id: <20200216134750.18947-4-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 86 ++++++++----------------------------
 1 file changed, 19 insertions(+), 67 deletions(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 40d27db674..e85cf07d2c 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -3,6 +3,7 @@
 test_description='git log --graph of skewed left octopus merge.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
 
 test_expect_success 'set up merge history' '
 	test_commit initial &&
@@ -24,7 +25,7 @@ test_expect_success 'set up merge history' '
 '
 
 test_expect_success 'log --graph with tricky octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order left octopus-merge <<-\EOF
 	* left
 	| *-.   octopus-merge
 	|/|\ \
@@ -37,14 +38,11 @@ test_expect_success 'log --graph with tricky octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s left octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with tricky octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order left octopus-merge <<-\EOF
 	* left
 	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
 	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET>
@@ -57,16 +55,13 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 # Repeat the previous two tests with "normal" octopus merge (i.e.,
 # without the first parent skewing to the "left" branch column).
 
 test_expect_success 'log --graph with normal octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order octopus-merge <<-\EOF
 	*---.   octopus-merge
 	|\ \ \
 	| | | * 4
@@ -78,13 +73,11 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with normal octopus merge with colors' '
-	cat >expect.colors <<-\EOF &&
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order octopus-merge <<-\EOF
 	*<YELLOW>-<RESET><YELLOW>-<RESET><BLUE>-<RESET><BLUE>.<RESET>   octopus-merge
 	<RED>|<RESET><GREEN>\<RESET> <YELLOW>\<RESET> <BLUE>\<RESET>
 	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 4
@@ -96,14 +89,10 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	<BLUE>|<RESET><BLUE>/<RESET>
 	* initial
 	EOF
-	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with normal octopus merge and child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order after-merge <<-\EOF
 	* after-merge
 	*---.   octopus-merge
 	|\ \ \
@@ -116,13 +105,11 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with normal octopus and child merge with colors' '
-	cat >expect.colors <<-\EOF &&
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order after-merge <<-\EOF
 	* after-merge
 	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
 	<GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
@@ -135,14 +122,10 @@ test_expect_success 'log --graph with normal octopus and child merge with colors
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order left after-merge <<-\EOF
 	* left
 	| * after-merge
 	| *-.   octopus-merge
@@ -156,14 +139,10 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s left after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child with colors' '
-	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order left after-merge <<-\EOF
 	* left
 	<RED>|<RESET> * after-merge
 	<RED>|<RESET> *<CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
@@ -177,13 +156,10 @@ test_expect_success 'log --graph with tricky octopus merge and its child with co
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with crossover in octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --date-order after-4 octopus-merge <<-\EOF
 	* after-4
 	| *---.   octopus-merge
 	| |\ \ \
@@ -200,14 +176,11 @@ test_expect_success 'log --graph with crossover in octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order after-4 octopus-merge <<-\EOF
 	* after-4
 	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
 	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <RED>\<RESET>
@@ -224,13 +197,10 @@ test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --date-order after-4 after-merge <<-\EOF
 	* after-4
 	| * after-merge
 	| *---.   octopus-merge
@@ -248,14 +218,11 @@ test_expect_success 'log --graph with crossover in octopus merge and its child,
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order after-4 after-merge <<-\EOF
 	* after-4
 	<RED>|<RESET> * after-merge
 	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
@@ -273,13 +240,10 @@ test_expect_success 'log --graph with crossover in octopus merge and its child w
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order --pretty=tformat:%s after-initial octopus-merge <<-\EOF
 	* after-initial
 	| *---.   octopus-merge
 	| |\ \ \
@@ -296,14 +260,11 @@ test_expect_success 'log --graph with unrelated commit and octopus tip, no color
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order after-initial octopus-merge <<-\EOF
 	* after-initial
 	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
 	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
@@ -320,13 +281,10 @@ test_expect_success 'log --graph with unrelated commit and octopus tip with colo
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --color=never --date-order after-initial after-merge <<-\EOF
 	* after-initial
 	| * after-merge
 	| *---.   octopus-merge
@@ -344,14 +302,11 @@ test_expect_success 'log --graph with unrelated commit and octopus child, no col
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	cat >expect.colors <<-\EOF &&
+	test_cmp_colored_graph --pretty=tformat:%s --date-order after-initial after-merge <<-\EOF
 	* after-initial
 	<RED>|<RESET> * after-merge
 	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
@@ -369,9 +324,6 @@ test_expect_success 'log --graph with unrelated commit and octopus child with co
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
 '
 
 test_done
-- 
2.25.0

