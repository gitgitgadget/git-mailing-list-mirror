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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB5C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D7E611CB
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhEaRlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhEaRks (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEEC008742
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j14so11534139wrq.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FLjVIHhQkrTKjbeDnB4tva7i7DDxIWusrGVC8yzjvCQ=;
        b=RyrfAjx2ld+Zye5TgUC1dyYeb3AQhkpzSdpPtJnNQ97aA9uBx+L96SQPl6Egk3YK3k
         3C0pL2weS2RZP+sOkfTU7lYAYVXX0ZvZareFWVHkyfE51wx2mrK2VL7WYD+G2hnKEOw9
         l/T+15frgByLmknT4yQc2LPwPkv55X7bASgIW95T0m3TLpxhyLBdqxdSVSmmtTCHlVHQ
         9Hydn1W/ZNifPM1nWC4k/vu3jIzZpfRVQQ8QDD7Qn62AeCnZ9Yp9GBWh0PvUIfMmJWb2
         yGDmWhcJ/I09WEPI9OhYPaSOrPeUkQHrg5uGaj7z+06zwuPwUTo92b9PEPxOcv0XVVfm
         jrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FLjVIHhQkrTKjbeDnB4tva7i7DDxIWusrGVC8yzjvCQ=;
        b=CyOaKQfhLbh7us7zWmQbsQ73eTtJoTp23+FTqSf9s2lMMViToihFxwWPm4ulg+SbkN
         +kLnF6r78zg98LmV6pkySUuJqXM7NzmQYdAS87NqbTb3lAp5+2aZ0RkRBW86UxEdW2hj
         yla+vRdtGu/MoNcRctBE7YYExAy84mfhB+K+RJCEu2CplL61TAZkSObwJv1bH7Hsto04
         Fl7tafeeRjIuODvppOzKCZ9SLbZ/bqBEbBWuzrt7+V0Z80Ab/ZnxI+/B+aS4NqwlnXZM
         JTRISPTuipocSSCluoBd3Hk70uygqe7gooFaBvzimF0aAx9rqRK9DRYmic6+4OwBv4Xv
         gZZw==
X-Gm-Message-State: AOAM531A6u1dpoxVS2Y66/E6p9aOkTQNgEi32i2+2xZ1G2eQBueyyPw4
        gFrcLYfuFj2zNgqPmr8qkxH+fQWht4o=
X-Google-Smtp-Source: ABdhPJy93Oa4eV36w9y2RXW0SxPvYagwBWM/O5n6wDbD3JW8Dw4p5MzW9llOyz3sS++heB6VzcOhgA==
X-Received: by 2002:a5d:64c7:: with SMTP id f7mr3757464wri.36.1622480202131;
        Mon, 31 May 2021 09:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm8351wmc.41.2021.05.31.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:41 -0700 (PDT)
Message-Id: <12d43ff6a9e534f3c57f2f811b8b7e1c85e26bdf.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:20 +0000
Subject: [PATCH v3 05/22] t1401: use tar to snapshot and restore repo state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

This is agnostic to the ref storage format

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a4ebb0b65fec..7a9629fb9f0e 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -7,9 +7,16 @@ test_description='basic symbolic-ref tests'
 # the git repo, meaning that further tests will operate on
 # the surrounding git repo instead of the trash directory.
 reset_to_sane() {
-	echo ref: refs/heads/foo >.git/HEAD
+	rm -rf .git &&
+	"$TAR" xf .git.tar
 }
 
+test_expect_success 'setup' '
+	git symbolic-ref HEAD refs/heads/foo &&
+	test_commit file &&
+	"$TAR" cf .git.tar .git/
+'
+
 test_expect_success 'symbolic-ref writes HEAD' '
 	git symbolic-ref HEAD refs/heads/foo &&
 	echo ref: refs/heads/foo >expect &&
-- 
gitgitgadget

