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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC5FC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD68322B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbhAYR5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbhAYRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442EAC0617A9
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m2so63342wmm.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ACG9h4H0pFWVZC1W+bCjnciJP/rNO8RkdW8tGnDOLZY=;
        b=LLYQYh7gMbprME1/kbN1dNhNApHzLy0Q7nme0zOqiyXBgumYppDE54DozHuhIe8kyq
         NJQIcUixCmpnVsWb9dEV1NUnnNVJwNcIa2tZ0B87LcGT4JL+p1axL7zHtkCHbk/Od1jS
         EdxWM/8k6wnZMT2C22tftcT6KLIzFzdbdKi3Ni2aASTyStOdjucx/3EspHpWH2fNRYjs
         yHtr6J1YsCY6iFfyA6DJxaITCNfxCiN0FaGmR3RGCi9ma6BgyWrMqpov+Zcl5n/nlJDF
         ppLf/BB4OT4lBwP01k7/mSe7q8zaxYil+FubA3zKpeYg2ml7OZsPL5n39lFdeUhF4qtd
         zoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ACG9h4H0pFWVZC1W+bCjnciJP/rNO8RkdW8tGnDOLZY=;
        b=OVn8VazJIFZATGmHDeBUjbb0FWQfksdgnRRrxAVjwrHxUKcrBsKLDi+nQV+Pe0XnQW
         UHRPbdVsgG8OjXsVQM1xryJlEE8rb7uAWh0VNc/sjtKz9iERk8xFiVD75HqA5gE4VQ87
         A4nhb+ZvYUNzet24Y8l0HF66yod+sw+HS6/9RXEW4I+YlvhT6V7i/g7Qp1H8vych3Qbq
         iIYv0Jd7fGYAgLUx7zrDUwEw9xLBN7OHgInNCR8He0b46maPDYoCHpcqfdA5gZ39+By7
         4Zxrm9T9HAeYaeRThKtZgWM0orbdy2ydSUh/ltEqDp3wbjWLItfC1IxIZtZokyXLu8UN
         HBjA==
X-Gm-Message-State: AOAM5325EAv3xIzbwOx+wVwEtBIEe2IHOOi5YQ6S+Z/4ECqw4Ok9Y+8Z
        rDuoM0eliWuh+tQtZyr4y67DC9xre4A=
X-Google-Smtp-Source: ABdhPJwTSa5fvixQhHsEhLsaCNsW/1qq1/YMSn97NJCEeNlk00O1FGGGE7M/Q04mBdhmXl9Ex5kUtA==
X-Received: by 2002:a1c:b7d6:: with SMTP id h205mr1188893wmf.182.1611596538831;
        Mon, 25 Jan 2021 09:42:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm24283113wrm.14.2021.01.25.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:18 -0800 (PST)
Message-Id: <b3696c823a24547be391c4ee35b99ba76cce42af.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:49 +0000
Subject: [PATCH 03/27] t1092: compare sparse-checkout to sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new 'sparse-index' repo alongside the 'full-checkout' and
'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
add run_on_sparse and test_sparse_match helpers. These helpers will be
used when the sparse index is implemented.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8cd3e5a8d22..8876eae0fe3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
 test_expect_success 'setup' '
 	git init initial-repo &&
 	(
+		(GIT_TEST_SPARSE_INDEX=0 && export GIT_TEST_SPARSE_INDEX) &&
 		cd initial-repo &&
 		echo a >a &&
 		echo "after deep" >e &&
@@ -87,23 +88,32 @@ init_repos () {
 
 	cp -r initial-repo sparse-checkout &&
 	git -C sparse-checkout reset --hard &&
-	git -C sparse-checkout sparse-checkout init --cone &&
+
+	cp -r initial-repo sparse-index &&
+	git -C sparse-index reset --hard &&
 
 	# initialize sparse-checkout definitions
-	git -C sparse-checkout sparse-checkout set deep
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set deep &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
+	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
 }
 
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		$* >../sparse-checkout-out 2>../sparse-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 $* >../sparse-checkout-out 2>../sparse-checkout-err
+	) &&
+	(
+		cd sparse-index &&
+		$* >../sparse-index-out 2>../sparse-index-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		$* >../full-checkout-out 2>../full-checkout-err
+		GIT_TEST_SPARSE_INDEX=0 $* >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse $*
 }
@@ -114,6 +124,17 @@ test_all_match () {
 	test_cmp full-checkout-err sparse-checkout-err
 }
 
+test_sparse_match () {
+	run_on_sparse $* &&
+	test_cmp sparse-checkout-out sparse-index-out &&
+	test_cmp sparse-checkout-err sparse-index-err
+}
+
+test_expect_success 'expanded in-memory index matches full index' '
+	init_repos &&
+	test_sparse_match test-tool read-cache --expand --table-no-stat
+'
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_all_match git status --porcelain=v2 &&
-- 
gitgitgadget

