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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE1C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EAA61CD7
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhF2ByU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhF2ByO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F5C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y3so4253618wrq.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M5y7V+S57JkqDlEiYCsuFlFYkP2WRg1BWKCFbReDZCs=;
        b=SQbbAw2BI1W2Mrli/0l+ZwhzppYYdfgjRS1NdB2o5a9tb7M7bVJUGkuqj5f7zfuToM
         PhE6ISQAaF8hYBHaitIymHpilxQNaEF7MSDCNHtuiSX2U6f8HQWvDoknybPKWzqvN1oZ
         v+t57oHJRFYO9S2J71+Utrz351UCYNuhPWqUvAiTOZ02AcEkpjjlEuqZI77wGvGo3xFw
         5kXwgV22WJx5c41qtTv96E/Xoz8dWi48e9OmQbPo78QPXR9IKGA5WsJy04zfWenwDUQb
         0xdxlMKHh6D1VfcI6I9I2SLhl8CFCYuTRw25iijWchATRah7o4qgtqusQRR5mKZDU0AA
         iwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M5y7V+S57JkqDlEiYCsuFlFYkP2WRg1BWKCFbReDZCs=;
        b=SaCVq1IPlyYztadyPJjH8NQ24shLMiHnYF0I3DJWgTBSXBy9RILI9Ed4KBZAUSSNQs
         8CxP2jkpCD9m7vyHxZl9h9GzslzjZaSG/X2DCBV7KHKQxeJa5Jvxze0/kakx664qPatq
         M/bE9uwwL4TkSX+xkOcvYwUjzQgyzRqVYFywKHzrHjoSS7Z8Xc4JWWFlAnEXi3q5oI0v
         SEcc03mp5lTydLgyrnxk5ORPcwy3JfMYkJybRpevHI9IS7WHejBopD3YOHZXTR/GvH4p
         uENkg7742gIm7ktf1CuOk8fwhoq6nHVUnfYPtgT1nLWyhGblIoiQon478f0MAQIB+aOt
         c6AA==
X-Gm-Message-State: AOAM533hfWbBSs/N9j6s9BCyLLbaEXd2r38Jv4ykVDAZ5OITtxC3tWDL
        Q6UuLboSX5tcPXI6aSROHwrX5i8s4xA=
X-Google-Smtp-Source: ABdhPJwcACBok9UoygOYoiFcTNKz/Rgy/3ve1PQzdowwT/Qq9MRCBoik7bOa7Ai8MEYqk8OBrOVoXQ==
X-Received: by 2002:a5d:58c1:: with SMTP id o1mr29836140wrf.367.1624931505748;
        Mon, 28 Jun 2021 18:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm16340522wru.3.2021.06.28.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:45 -0700 (PDT)
Message-Id: <d965669c76663ebe6b172c4046c9c517ba9102f0.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:31 +0000
Subject: [PATCH v6 03/14] t1092: replace incorrect 'echo' with 'cat'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This fixes the test data shape to be as expected, allowing rename
detection to work properly now that the 'larger-content' file actually
has meaningful lines.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ba2fd94adaf..ebbba044f77 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 		done &&
 
 		git checkout -b rename-base base &&
-		echo >folder1/larger-content <<-\EOF &&
+		cat >folder1/larger-content <<-\EOF &&
 		matching
 		lines
 		help
-- 
gitgitgadget

