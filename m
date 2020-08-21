Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CF5C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDB620656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfOxD+2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgHUKLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgHUKLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 06:11:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0904C061386
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so1413061wrc.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RtHmFdUygzahr63EplhuUWi4GrSbkocacAhyc4+oI5E=;
        b=pfOxD+2nWtFqQo1t254aXChWxy1YEoUEvzD5IqAQHRhh5Uuos3N/4+PgsX9kgUVfmY
         rCjUox9JG+sM2nrJP7HlDQGLowW0zDEvjbj4/wRmjJO5zONC4T6L5b1V1p5h0ZjX08K1
         uJoZGaYF3kETC4rs5HWkx9s0HPbmctTvAWFUju89gFWwzwKKr90+uh0Rj5ODtJrvDfxU
         9ITB/Iotgh7rnZCNhyQpGWc60K20i8iEeYGdEZuovUrz6igOBbSPi377yAPYPY//ODV3
         D02YRz6edgrGdO6FrRWDCrwoV/UdqEc395FXjwVyc4L9PLlGAe0CyJeJkN7BWgERLeDc
         BBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RtHmFdUygzahr63EplhuUWi4GrSbkocacAhyc4+oI5E=;
        b=PrB4KJ/sUPME2kYMTtSuRMjLkPeJiCm4HMlYCmd9UcUyADp7cOywmSJT/Y4kpYopoz
         RYnCIm78ffRiX2pbmZkmztlQRdqz5N4jIdwsLZD41SmicVyB5oYeXDcCRvALlZCaaz8U
         9ld1EUJYemAB1MCbDpXgir1NOn28+69iPbC0IaRzsT2ZUY4vbUKr27cjyMORxGajdQPS
         75b3KSunQlpseYLkvTH0hrbQrxA0+QbTNBrdA40KgvGiesJHv9W18PlVNWAd+DZKbMI0
         GQZZFWgPTyj++6oVH4ojjQNd6uRcFD1wyvBLajXdFGK/JNJ3IMK6ZIzk6eVbAvoZKS9m
         22sQ==
X-Gm-Message-State: AOAM532sbgxYWui+sN04DQF4mTXvXr0co5iKnK3UH1JzPsvbVGOTlMnb
        wcqZVnifP8IgBIgaOzm6qlkQqBvsNXo=
X-Google-Smtp-Source: ABdhPJzjg/7D+7Hrnum+4z5aadj429/Dtuu4G6BzFmLvy2k6+Ue8lIMt68vip1cNqK9rJFa1fl4S4g==
X-Received: by 2002:adf:f248:: with SMTP id b8mr2163665wrp.247.1598004665420;
        Fri, 21 Aug 2020 03:11:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z207sm4611553wmc.2.2020.08.21.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:11:04 -0700 (PDT)
Message-Id: <4816aa3cfa04093c3b6c845eb914817e97b126b0.1598004663.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 10:11:01 +0000
Subject: [PATCH v2 1/2] t6300: unify %(trailers) and %(contents:trailers)
 tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Currently, there are different tests for testing %(trailers) and
%(contents:trailers) causing redundant copy.

Its time to get rid of duplicate code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t6300-for-each-ref.sh | 56 +++++++++++------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a83579fbdf..0570380344 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -776,61 +776,40 @@ test_expect_success 'set up trailers for next test' '
 '
 
 test_expect_success '%(trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
 	{
 		unfold <trailers
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
 	{
 		grep -v patch.description <trailers &&
 		echo
 	} >expect &&
+	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
-	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
-	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
-	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&
 		echo
 	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
-	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
-	{
-		unfold <trailers
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) shows only "key: value" trailers' '
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
-	{
-		grep -v patch.description <trailers &&
-		echo
-	} >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) work together' '
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >actual &&
+	test_cmp actual actual &&
 	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
-	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
-	test_cmp actual reverse &&
-	{
-		grep -v patch.description <trailers | unfold &&
-		echo
-	} >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >actual &&
+	test_cmp actual actual
 '
 
 test_expect_success '%(trailers) rejects unknown trailers arguments' '
@@ -839,14 +818,7 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual
-'
-
-test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
-	# error message cannot be checked under i18n
-	cat >expect <<-EOF &&
-	fatal: unknown %(trailers) argument: unsupported
-	EOF
+	test_i18ncmp expect actual &&
 	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
 	test_i18ncmp expect actual
 '
-- 
gitgitgadget

