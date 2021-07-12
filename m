Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19808C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB91611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhGLR6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhGLR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC5C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so20482101wrc.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SwlaGGwBDbfHE4py4v0EAuLYGfp6NsDfmCTHdty/pqQ=;
        b=AR/8gyz3BDAza+IGR0U3FDlRuc7lu60dSIZbwQpaYo0gz90Tjt7XovZHhQktv3pNKo
         vK4YWlLMYBEZEL1Kfc04ox90NX2FS/acL5CNfG35l/9iUGSy8Oo+LofFH8vo9fMMgSis
         yGRVDp9fHA5GT+WikhBJARwhkHPoFQJxCAmLOukgdaPYyFvUvh5V59wB7g0embFZ7LFJ
         8PHdPaIme1rrpVQsuCIFcTkdNW29/YEZ3ObuTyzFFCk0X0IQV/jyXOQpk1vzqQ0QaQ79
         CjM5CYQ1suGwWim5LH9aq1XROxmbmCKyylwLqYFXuJOOEx/n1ryFCWysCOMAeWg7gLyO
         fNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SwlaGGwBDbfHE4py4v0EAuLYGfp6NsDfmCTHdty/pqQ=;
        b=AnlBrZT2y9mqZYHEcLLcij85o7sEhhYXa7aWNhI0kwnn0JBv1RbKh/OoHxL3jYdqhv
         COHdATCKLp1n4V+tfxfDHxPWBWOrqgmnOuNUO9cbo8v8ugoKbba2urAVJ816Wao0UCMT
         LzEcKAm/wx8zrY4rmLEeVcqCFH/Ju5je2L+aLjUpjjevxHMK+HrCe1vwnn95RO0AJ6Vz
         4gPHVF92zYJyToyKXz2suhg5ENBGnjvNH/TGoKrWPcSq0wVvjGDYumD5jCp7zSVZkxI8
         StwoKJexG82unnHiwBTdCW2btAV9W62LB4pjCadhFJrjZPQetdCDfKOD98NQU/sQXfq+
         3yVw==
X-Gm-Message-State: AOAM531R67feDJZdPW61awhRy9QOFeCDgaRnz9yvr4X40egpmpl6LWkG
        2y+ocMF8zPPtUpTRmJanXoDU6LLCnPM=
X-Google-Smtp-Source: ABdhPJwXdN9WSCx1cq+C+HxmD2WNtAfNH/sHlLMo+67yTpWtN46vBK3gY6XZb2dtlt9Ui03/HGwafA==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr268493wrw.110.1626112560012;
        Mon, 12 Jul 2021 10:56:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm14787300wrs.4.2021.07.12.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:55:59 -0700 (PDT)
Message-Id: <05981e30b97a3e668b3a9675508135d42f15450f.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:44 +0000
Subject: [PATCH v8 03/15] t1092: replace incorrect 'echo' with 'cat'
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
index b8617ceef71..87f1014a1c9 100755
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

