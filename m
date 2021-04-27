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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E67C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5062661168
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhD0Kjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbhD0KjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1DC061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so6788916wmq.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JSuaS6Lx86aZL6ybUpWJM1gl/n2a0RFSQZV13ZjattY=;
        b=kQk5QXNDMoKrs+qdfEEZ3YsU/HmNGvKJj99X9GqgfJIiIvV0ZlKBKNKyc/d6wLNOIr
         NVfu5uXqEbJ/YPr+KfHJwcm+XCIC0ETPP1wixIgSCQT85VU7b6gJcGJHPJwo8517RKPo
         AHP6wkw6ITNdLFqqiI+9pcmOXZ1kyMX2mzgJ0Q+NmQPsHrPf1ObVvfZDiE3peYdk950k
         VZITQ4w11j1Kg3U7edls2yew+xe6XPk2Im20WPStncraDugpt7JdsxSFI9XJbcTNt55t
         HSrkoz4+NMLGNP4uzjyKd/SxLUA7cxTS7u8UZdGEeHm6TfJgOs8t3WCnvFVx+etuXLBt
         BQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JSuaS6Lx86aZL6ybUpWJM1gl/n2a0RFSQZV13ZjattY=;
        b=o0IqRCxwypYqGHrgPbD5l0npbVFFNgO/dud/WLOPbv4W3Ji/kcdsLV3/NzcldR1nkZ
         fvekC0HBzrTz2GjRs/VkDPyglFy1e1nwYUXLA42cESCbWj13m+Oxp0IFwKGd0UGyTNEG
         FE35L7Wyt5QwxFQiQs31Y/thNgOv6r8BAa8GfA49LoGuX0rBjU9i4w1y8tudKVh8LIJG
         6xhRdnkWxzcgvDGLJgwMKDR50viWtMTt2bIc5kuPKjAKBmEoLbIUaaKaSMFdfS2RODTN
         Ifx2zh8eTGo1aVPcYRoMf93UiJ8ZRDzaaR/xIDcE+N3GFIHRuCsYW/wOjcYXX6ejNoaN
         hgPw==
X-Gm-Message-State: AOAM531QFKnsqvIP6dQ4ddSiQLGqnJfL7jzTrSHqpFbm7G5nIlF7uw/G
        7CuIN2OwUxKPcU43XsUnhwiChv8JQYs=
X-Google-Smtp-Source: ABdhPJxnHg+DobNbPlThhBS3cPAh8JF1CFw5sOd/tpKZnU+zUsmUdgQV7kWVj8R8KH4QWFLm5MJ4eg==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr16602514wma.182.1619519909715;
        Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm175406wrt.51.2021.04.27.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
Message-Id: <d6072a70ae7d75382d30d1239c218e4e58207c20.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:10 +0000
Subject: [PATCH v2 09/21] t5000: inspect HEAD using git-rev-parse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5000-tar-tree.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b6734cba7e65..153f8400035a 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -234,10 +234,11 @@ test_expect_success 'validate file modification time' '
 	test_cmp expected.mtime b.mtime
 '
 
-test_expect_success \
-    'git get-tar-commit-id' \
-    'git get-tar-commit-id <b.tar >b.commitid &&
-     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
+test_expect_success 'git get-tar-commit-id' '
+	git get-tar-commit-id <b.tar >actual &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
 
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
-- 
gitgitgadget

