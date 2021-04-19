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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F80C43461
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FC61077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbhDSKyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbhDSKxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4BC06138A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y204so16519731wmg.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wod2A27fy11LyRODnuCxhNiKLVgYgInfwpEit4Of9S0=;
        b=sYCcJtriNxSWDpXbnaCuDDFJxL1Q0bxqiHa8UMxqe418PWJXJknwwUF0djozMNETDP
         Oj3J88UWtZSqWE56co57gPb5uvtlAQjdP2B2MbmdW0Jf5Yg0byaSwW6QaF6Gc+1K8NU2
         YFE5a5oR70XlE7fW3YntE1lDmlAwloBfsaGwF40ylDM6B8LRXN9TC18N0PwttpNE2WaP
         OxaQNyWBLQc/nzXIEcq0oySckOOAEMQaA7tY/oCGji4ET4BVApxT09v/Cj8CzwIzB0SQ
         2qZQTp2wlEuTkPCkH8M19DMOJ75v0spO/lsQ5tSagNULXkRvj35TrPRF/IZWmrEQ7TDi
         a9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wod2A27fy11LyRODnuCxhNiKLVgYgInfwpEit4Of9S0=;
        b=Kl84pzm2IHRoEYDCIqWVO5fPOyj4odpiepcE0Pyj9mXqZ8nwjBhXyDTNN6tuNOaYBF
         x7Xn/3O3YWpIFTnQubdPNoN9yFHHlVfnsLVhwX8t1FmOnq/XCNLVySA3E2qnE+6OuGfq
         GpBjAZ63zIhcZ0YdJwKsQQxQ7A8a2jJCanuz3TWZGbEdGEt1QwgKy1EBR605Hz1gFZ/A
         tmkkBFoXqay7mhkUOjWQsboR42o86+xSP3SmpbH51YTm5RM9Q6pw3i/BO1PjDVNwNWyu
         EBqtbXIF/HhX4ilo8wqKRJHDmXOcZdANXnEB1ApEFNP4ag/qjZksDCKuj/s9yc9+3NS9
         t3gw==
X-Gm-Message-State: AOAM531jsgc8OL2Gtqg0B4E4Iaw4cq75LlXVunsecT+VMFFcss4shjGx
        oGs3ZjGJOLhkJmh9HoDtf/eF6dE88Rw=
X-Google-Smtp-Source: ABdhPJxIMsDcSLpB6AYRrhG1Rq4N9GjhFFBBDqbBbkq/DcKDwxnpOTWFsG6TIhxiejIqFCZKR144Dw==
X-Received: by 2002:a1c:64c4:: with SMTP id y187mr20832743wmb.162.1618829591224;
        Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm9838079wrr.62.2021.04.19.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Message-Id: <86951eb39cb65d4928cf03964afc28e06e1f9166.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:57 +0000
Subject: [PATCH 12/18] t1414: mark corruption test with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format guarantees that reflog entries are well-formed

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1414-reflog-walk.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 80d94704d012..72a5ac61a520 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -119,7 +119,7 @@ test_expect_success 'min/max age uses entry date to limit' '
 	test_cmp expect actual
 '
 
-test_expect_success 'walk prefers reflog to ref tip' '
+test_expect_success REFFILES 'walk prefers reflog to ref tip' '
 	head=$(git rev-parse HEAD) &&
 	one=$(git rev-parse one) &&
 	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-- 
gitgitgadget

