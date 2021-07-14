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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D12C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D4613C1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhGNNPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhGNNPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A459C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g16so3173985wrw.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kqshqthKoxuKKA7T4uCHFhlp9QClBQyw7N5hgnbwbOM=;
        b=jPo4IFmxONLTn5RBsT3CLNZXHb1MaSVODrMYvkOAe9rmIoFg7MbGNug+5Ctex+JkuN
         HaZ4v7sNEKxwmEp5+GvZLBYi7wMUXyXV7uRtSXT3htin1OEVb/A1cXV/kJQ0kH7/1c2f
         TOo6Dug1H2tjzH3XqN8vQA4HVhGvVZ5iAgbo5HpfS0P15bI9TzXx5rOKrnqtVNFYU/XV
         /HWbULXvtZ4B4e7eyFXUiXnsZ70JnesOTYgCeTwTkSiTQ0O8V2rG3bvX7CYVFtuMK4uo
         4ZZRTMEnobKiktUIlxg32AMh0d6FKluNHC3Xsu9a+uRnuqiefcMkKMHPq9RZPfgkw+Jd
         Osag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kqshqthKoxuKKA7T4uCHFhlp9QClBQyw7N5hgnbwbOM=;
        b=FgOiwyr1yagmEnr6UEtjuaCA2hm/GaOkpG+7gnfIWAtoyFPIWoqAViZtzxZGIJQzxO
         oOP8DFDNZCMHOV6rGAJfBz5iPK6tbPRzDPPED6bSX2X6uH62QFjcfhyRRwd+REBhX8ne
         Da/hO0soBGbfVHIcGWriMXHcWsKqtTKI35qbRnzXE2dC6qwfymf9+iKQAZy+PpdD4vBQ
         PxF2nKlv55I4FhmLbq+Q8QXCCviFheyA+LwEgozhEIqP9w3dbmlp0dzdChsXjb7RJGMI
         q6zlLs7o0yG+niJGfzMm9DwLCX02c9gMJ3Va7iRgEd1SeU7sPJ0Oz8jxSt+qUqnYoavi
         fZGQ==
X-Gm-Message-State: AOAM531QH5VxMpfZvlv/k2BFECuoWQ4t/FGCumo8o20Kn4b5ze5uA8Kv
        GuU88GS6jfXrG9h5mwiGFCYNTytwvBE=
X-Google-Smtp-Source: ABdhPJwI7/EuyWbDgLjaLpYyM6KDUSB/I6ociObp+nX6zN2NLrUAfSpzHM6R10DLUE904EvEgtpk+A==
X-Received: by 2002:adf:c5d2:: with SMTP id v18mr12933225wrg.386.1626268364746;
        Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm2548535wrv.37.2021.07.14.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
Message-Id: <5b59436011c0ba8a86cbbc28954166a79e49a4eb.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:27 +0000
Subject: [PATCH v9 03/16] t1092: replace incorrect 'echo' with 'cat'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This fixes the test data shape to be as expected, allowing rename
detection to work properly now that the 'larger-content' file actually
has meaningful lines.

Reviewed-by: Elijah Newren <newren@gmail.com>
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

