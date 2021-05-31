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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E715C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3681560231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhEaRm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhEaRlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:41:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E16C008758
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so897019wrm.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=z2QAkWPe/W3/W9OEmOY3pCqJyONNyF5xpyTG3jVk494=;
        b=hWWZjYGfQ+z1WN33WJlUVVCAMb6ldBV2QxGqURHubrECr0Bk+779GeeThSA8BydBEr
         pNIplBV5O3sQSqyn+GyeqTzTwiwt8Bxu6UFAsbaaelflPLqVUxysOpyklMQsc+UtoOhz
         8eMw3H8pKqQEn3TdRMUb2BcR/v4hAnwTJvYOqUPrOptLfqjWm8essx6eykXz4Y0T7yfH
         7I8jjvZQRY2ywU2gPiiZdXUReNC+BhJ20FqgIWa4eb8/dtI/2qsxzbLCSk24TS0sLHpW
         GVfu/OPinHls84uiJJtpsyzhl2N4bjBnbIC78S6aCI7b0e9jWSGij6lTsoe6WfOiNsxL
         NXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=z2QAkWPe/W3/W9OEmOY3pCqJyONNyF5xpyTG3jVk494=;
        b=mLxRs4AwiPt6qSMFqItcEtKcnWkKbWSpSQMftQfroTbm/pGH3Fb9fWnERxBhNIAQdo
         12vGOLVbeJbvQ6G+AQdyYxdxHkIVv4chK+1CLW8DZtGqUkOu9Kg0nlX+t4TpLEhbvPAb
         jKqkE8Qp7jHGNAl29gDdSV/z8CYqmbP4x5+uZpssDy5WAAyc9ImhgEpYVScA4jbw5tiN
         4Vz8n3LbO8PLFHEpwaynhikVhb8SIGGngTGY9aryVb/bBjvO1aPHp4MRCVPrLKsX3tZr
         0vXM4c/aHQROoREsAxq3AjIMcgslE5jl0VJ/PBQJVfQ7DkAiBuDr0rJi+W+WynPfSRKi
         6SYg==
X-Gm-Message-State: AOAM530LLsBBKfn8C6iITqU+/l4I5icUUaH1Eop5a87OurCZreH5aD5p
        kow7Em6S3Wko4RGgwbvkLHYfkM8WvNU=
X-Google-Smtp-Source: ABdhPJz6he0YaIERH5EJ6zvDyMuwCzNHfzSR6JOSakcTICKlC0etyrmwIp0QrCEXMiaRPjZVXq6eoQ==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr23255383wrq.112.1622480210134;
        Mon, 31 May 2021 09:56:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm15520007wmk.8.2021.05.31.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:49 -0700 (PDT)
Message-Id: <ff86cf916943e188e6d4324ad0e35932b743c0e4.1622480198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:36 +0000
Subject: [PATCH v3 21/22] t4202: mark bogus head hash test with REFFILES
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In reftable, hashes are correctly formed by design.

Split off test for git-log in empty repo.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 327991fcea49..39e746fbcbe2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,14 +1834,20 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD hash' '
+test_expect_success 'log on empty repo fails' '
 	git init empty &&
 	test_when_finished "rm -rf empty" &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep does.not.have.any.commits stderr &&
+	test_i18ngrep does.not.have.any.commits stderr
+'
+
+test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
+	git init empty &&
+	test_when_finished "rm -rf empty" &&
 	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr'
+	test_i18ngrep broken stderr
+'
 
 test_expect_success 'log diagnoses bogus HEAD symref' '
 	git init empty &&
-- 
gitgitgadget

