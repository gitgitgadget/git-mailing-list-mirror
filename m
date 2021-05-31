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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE572C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D249460231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhEaRln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhEaRkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022FC00874B
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so327410wmh.4
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ATdfb54I2lRCZQq2YsdDhMBJbywLehDMgnmrfwhGojg=;
        b=pBILtIhBHQ6F9dx38itu7vLtB/pOrj0M6ddvJgjyMTme1dzs7HDdIL9ErKNFOxjf6d
         WUFjQ6Rzz1WkkUoRVsY8Q/IQX2dFyAqmiHbFV69lymwRdfiUFvaAXQh43OcHsfGCGXHr
         CfMKVvZes40HMGJLA7SjU4CLIeUEgoEl7AbSzf/K+BPmmYVqAVaoLAWLfPUypK+aYm/M
         Xpd7zU+oqxmWXHN7ygTEhD5Cm0fZFlEpAmUZVT0fjLnxvxCTdR4DSpR7lKXu7fC5CqFN
         pU2Gpb8o84nhGS9Y0wSjx5GcY7skv/4PbIBZmmrIwr3enq99ukIvPv56dL1f4HKMdSm6
         dM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ATdfb54I2lRCZQq2YsdDhMBJbywLehDMgnmrfwhGojg=;
        b=W1MTyTqLLZUouDNPV4eQRp1f1tl6Chr3scsuxkjPFMAtzxBGj/RqpErSIvBRJlYHC7
         K0mmXrrCDDcbG8aOmJuQrKwhXQ5IHqqISk4DrA+w9zCEkawfm1Z7xeqIcdN32xYf8n9X
         mwDYAKny/0itCacUdw8HmlKzgSedPzaxdJdl7IAkTZIEAg4XLAcF5kDppknKsmiWHtIu
         qjGqLveX2B72dSSUUD2g1qVjehLk4WBgzCOixJ9d1nRCac3/LRHtcjPEIK617RX6ut2w
         E2ocjEO8/aojK2Jok9nVJkoFmKeZA34V6f2dEDZd5gS0qx4l9qtcKBCCcjZZkhd7sZlE
         SZEg==
X-Gm-Message-State: AOAM531btftWc/kZLnLBLnRVdrMsN3z1vZwVv547TTk83SF1sZXn0nKr
        3dJe0IlQ1Xf+4RBjXstH65x5Akcmy6Y=
X-Google-Smtp-Source: ABdhPJzj+J/JBj8rH6iXV7+N6GNTh24Ejpn8onAhbvgTTgGhQ7LI8gQBWwqeOa5ZryYElI79lKmCcA==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr43730wmc.105.1622480204613;
        Mon, 31 May 2021 09:56:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm15366282wmq.30.2021.05.31.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:44 -0700 (PDT)
Message-Id: <3e748285876b41104d54ebc2dd54b103dbaa5385.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:25 +0000
Subject: [PATCH v3 10/22] t5000: inspect HEAD using git-rev-parse
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5000-tar-tree.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 8c5867b6c8ae..2c88d1c15962 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -243,10 +243,11 @@ test_expect_success 'validate file modification time' '
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

