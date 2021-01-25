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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECBC433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EB922D50
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbhAYR4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbhAYRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE7C0612F2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so13808691wrx.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eUgXhnq3iSGakbidVqTrAi+YK05jsh83OknbN9FyXNM=;
        b=qsABUqoxSzqbjUePubAyvOfnNUEDzgQyNW9U0Yk88Vj1+Bzjq6mv6/r2+8394wxZ5n
         cLBOKzbeAQUj+VxC1AWFoS4OfbxyBBFwGUIQIhAVSUq3hq0/6EQwody0BC7Xv8gmJPIB
         0Kv/Q5xcVn0w0HoukBWe0o1k1+l5VDOCv9bzihzVGU4H0rMQZTJH6X1oDGfuOV9meCGp
         ZxQbzboRmF3iAjOiC6kt4dr/WbCNx5XRTOZ2qTwRPwQOaN+zp+8YIM62bVnHNerHNklv
         EFvWOiy0dpGvrT3tN0RxD/SoA3i+ElXCx4R/37wJ/39dIb9kJs3JPFtf1ic9kAr+6h8U
         O7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eUgXhnq3iSGakbidVqTrAi+YK05jsh83OknbN9FyXNM=;
        b=dORG3BianPmGkDUyfJWnAb8rGphtl2V2WZlyFzkkLBltROXQm2Aw9k3NTbHridsMh9
         v1eUDKFe4QIakWD56D2SrntL88gV5+yUkgFesC6P0B4ym1vzHIbGUzAKHDTy5gLQEnU+
         18m4yB6PSvEfaeFQR4h8oHmD6z38KJi3+g76aoMWEBhUYKXHmARCWB9iRu5usPMQVzEt
         W+oqp/taLnA9VkfPKY9W/+atxnd8SvCbX6a5fBg93T3S3EkOYld+kaSRYs9GauePdwvo
         fcUiBS+R/rjusQH8CNM6tf7n6Llv702Ei80WmJa3ZeD2R0DMh/r2py4e+RfgI01sj0nK
         BLig==
X-Gm-Message-State: AOAM530nYh1dJULhGpZu7lGJkSPsi2dOtrX9/61xIO8p2ZaFEaAyPICx
        6pbV9OUU+n8mY0kLcAQP5QHOm+oMG5E=
X-Google-Smtp-Source: ABdhPJxD6XR3M35MJ2dF3vyEh7DFYA6Lc070UNuRRFI4+68R7LqrMyZv4XQ6ZGL4KVc5wYdBnq3eug==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr2216169wra.370.1611596546601;
        Mon, 25 Jan 2021 09:42:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm23445753wrn.68.2021.01.25.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:26 -0800 (PST)
Message-Id: <9b2ae1bb6c49b67cc17691d58044bbb8efb114a3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:58 +0000
Subject: [PATCH 12/27] sparse-index: check index conversion happens
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

Add a test case that uses test_region to ensure that we are truly
expanding a sparse index to a full one, then converting back to sparse
when writing the index. As we integrate more Git commands with the
sparse index, we will convert these commands to check that we do _not_
convert the sparse index to a full index and instead stay sparse the
entire time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 22becbaca2e..a22def89e37 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -374,4 +374,21 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
+test_expect_success 'sparse-index is expanded and converted back' '
+	init_repos &&
+
+	(
+		(GIT_TEST_SPARSE_INDEX=1 && export GIT_TEST_SPARSE_INDEX) &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		test_region index convert_to_sparse trace2.txt &&
+		test_region index ensure_full_index trace2.txt &&
+
+		rm trace2.txt &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" status -uno &&
+		test_region index ensure_full_index trace2.txt
+	)
+'
+
 test_done
-- 
gitgitgadget

