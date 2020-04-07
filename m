Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90602C2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734A2078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwGZzAez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgDGO2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34005 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgDGO2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so2805327qtp.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3JpD1BmGlEgxfNhigHedIBI5YZ1431gBF8qqQU816M=;
        b=dwGZzAezgKF0Jii3S4JsVy1aslt1nQj+jL+6g52mlBVhwubTyLmJnWnhA/QXcIXG8D
         Mc3dGwkd1RR5WRGFonhgMSiS1WVL0+HDQWBLWTDrRN8GqKfSi/nttdq3IjP1COyQjVJ7
         FGba1im2wBJ6U/sOjzQCfgomKeOqEKq8JNeYXb6Ff6pKw2HeIhIWj04JdPrBDZciex2k
         Fcr5io/jXr1nx46LBWV+hIpwqLWGYRMDRSUoEjjOdNCOS+rgYL6TRtHGPtvoBkcfvn1a
         mJYN7iPUUIatGTP427Igv5YwJTsyV17vKIAoAgwwebCWp+1JqA++RIM50Iu1kp0qZBng
         QKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3JpD1BmGlEgxfNhigHedIBI5YZ1431gBF8qqQU816M=;
        b=lnu85eBCqgI1pGOrztNm/9lc9jhjQePiQl4jZejDrhOgT3jdK9VVocDdgxWnfiEfYJ
         xQJIpVC0r6qsJzGlo+bnvSsl4Ydz7adUmLUmqvAVe3j00uverr0uJKdAzXBrNH37SzWO
         tsIGreDSzU6Faz95+QBUW55/vaUgHuOYgNw/T4Iq/xAPGzPyjwEChhZHtr1G5WbDbHF4
         F/Jn31cq2Cm+Gh+heEjs22alCb1IoTq4kdApoZKzDZbrqfwFb7gzlkF03ZXdwus6a/Hi
         86NEPkiizkA9a3l7Yt1EqHaVPmxxuL4JFgg8Z6KZxDPFRlZXlAJ3HygXeEUQJGonD4gF
         QNqg==
X-Gm-Message-State: AGi0Pub9L8pwpK9Xzb/d35myV8h4T06Sqry7X15xAqwJUvu9qmX4UVOl
        97e5qD7o0SpEAI/VCw54bJXLRZ4s
X-Google-Smtp-Source: APiQypJCVnyJ8qEFNM2xMnuntZ7rQBa8WVrsKU/7Iq6xNi+DrmgqUKldSTe3++v7zMJi+9Lbv/JSWQ==
X-Received: by 2002:ac8:7752:: with SMTP id g18mr2464230qtu.125.1586269725071;
        Tue, 07 Apr 2020 07:28:45 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:44 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 21/22] t5520: make test_pull_autostash() accept expect_parent_num
Date:   Tue,  7 Apr 2020 10:28:08 -0400
Message-Id: <13f3fadbef41476a7a7715574621729eb8f6e200.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, test_pull_autostash() was hardcoded to run
`test_cmp_rev HEAD^ copy` to test that a rebase happened. However, in a
future patch, we plan on testing merging as well. Make
test_pull_autostash() accept a parent number as an argument so that, in
the future, we can test if a merge happened in addition to a rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2f86fca042..f610dc14de 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -10,11 +10,13 @@ modify () {
 }
 
 test_pull_autostash () {
+	expect_parent_num="$1" &&
+	shift &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
 	git pull "$@" . copy &&
-	test_cmp_rev HEAD^ copy &&
+	test_cmp_rev HEAD^"$expect_parent_num" copy &&
 	echo dirty >expect &&
 	test_cmp expect new_file &&
 	echo "modified again" >expect &&
@@ -369,22 +371,22 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase
+	test_pull_autostash 1 --rebase
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
@@ -422,7 +424,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	test_pull_autostash --autostash
+	test_pull_autostash 1 --autostash
 '
 
 test_expect_success 'pull --no-autostash & pull.rebase=true' '
-- 
2.26.0.159.g23e2136ad0

