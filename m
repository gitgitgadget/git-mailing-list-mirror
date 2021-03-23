Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86093C433EB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AA9619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCWNpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhCWNoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B275C061764
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so20821508wrn.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=CjUsDM7az5Dr8kiWrkQzg4omtbiK/0lCNGE6nC2PCLmQqsdW8TQfftsfH/MZn2NS0K
         nC/4iD+XLa7YNHCRknuco5dENT6tTfXeHv6zEf0Kg9mxbLEAB7dlMkUN5BZB8SRLhJu7
         pN64H/3mjYd3SeejDEsBQM6F+ijo8iVzbN6aN0PeKwmuV1/cR6E60oqByG1gMmmbWMLL
         Xvs3D3CVVYkULWXczHQ3rCqRf8BQc8nFPIqU90s3KgSJuXzjQH54unZRVPut5WjOwGYW
         c6/leUbi9bbEyo6hBZfOZ6lMmm0hqaWyewnbG6IFyrvJnf+yB+hzA9tNjrUq+XAgT2EK
         sgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=KOK4BbaNaXQstbBdIKpD/1zQ/9GT66tbiBsMuVLLwKaBT87xlFISMdX67LLGrFVn+o
         K4HXSwqJbstrFBvgoJQrt8PCAf6JYUXC1ZeFCSrEC97kXFspxtFh/FMi8ES9rf80rZcU
         mnPZC5QWoorUeYG/Gh2Kj2ywEIMYSM97bOFjzSUJk20+s4bHYB/xLJjXGABcJnv9xSvr
         kan1OX4oPjakZGltL50/YBK8f1gXgY3Gq//sSB+AnEG7e4cs+l0scB8Rio3FQixbV7Ll
         97dqJaoFtlIsMygugasksv503TELMCnbSd8QSpXdcGKLM2B/7jcpcl83yxz19uUy8HEA
         al8w==
X-Gm-Message-State: AOAM531WNCarsstR1cfbpecqZN4XlQ+ZV/KoNkCHhfRWIeoH/l4gs1uy
        Fb8CuuUvYF5+OFwJOQMK1mi95zFBRXQ=
X-Google-Smtp-Source: ABdhPJwmPwtniyVT77hl5kd5K2tv9yhSFoTwiTi9KfEZ/jU6AFT/ObnlMlZvqUCUvpo2xuZvgmpVCA==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr4147435wrp.345.1616507082135;
        Tue, 23 Mar 2021 06:44:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm2527443wmq.40.2021.03.23.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:41 -0700 (PDT)
Message-Id: <08d9f5f3c0d126e29ac19b36c87b0c3f43ecfd4a.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:22 +0000
Subject: [PATCH v4 14/20] sparse-index: check index conversion happens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index cba5f89b1e96..47f983217852 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -393,4 +393,22 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+test_expect_success 'sparse-index is expanded and converted back' '
+	init_repos &&
+
+	(
+		GIT_TEST_SPARSE_INDEX=1 &&
+		export GIT_TEST_SPARSE_INDEX &&
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

