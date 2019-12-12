Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D88C2D0CA
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDD7214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLpeatYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfLLOgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:42 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52693 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfLLOgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:39 -0500
Received: by mail-wm1-f49.google.com with SMTP id p9so2624329wmc.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=ZLpeatYQ6SmGQ0B79eiZjX7qmB1zAF7mhikKCFgMXHdzXfq32lWyLxqROL+84KKrmG
         Dam52wR1NgLdQLKYpXePevmdXyQTaCJeBS1341UHHa93i2h2kxWiG1Lqd4uls0kzHdQq
         mfji1ZbdpmN3I8zYid7MvMNdJjV/V1AEpzUVdC8iAB8GiggmrZS+0GG7S05n85jvmWOT
         +3NJ/ZgrIZTgZaMSilUjSUAyMPtiewLYrCdvMTc5xDsl/QWbWKOm9xkbkKYcwOYsV1eJ
         swX+uA0qgSAcb09VD2mIUQR6Zf3pk00ZyCcuBlev2ez3Q3+IH1kpash55mcanm3RopGM
         RhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=KJKlPfE0/yOxKzF4Pf3A5gIVdnzmiZNnOFlFqrr0Ouz32pqJokxDZikDf8H9cQIzEa
         QSyarELZODJNNmLe37jTbUXS/5o/gBLDbrwu/P7d7oRTGzEaJ2bWfbExu+Axaey/cLq2
         39V9Ijuh4LjZwKsLd/0wGpPChRFpnJd6gExJgK1D+GVCbEyU2RKtT1Nn2LHCoP5diZYj
         vNXWWUSROmSEavFLlpTKmbHIqy+jH8I+Ro9xQfzoRBV1m9dW3PrC4CuHSEdi67UioOOv
         nODd8DYNc7b0VnhBjGPZ6PpcIfU1XJFNjc1DV3wKqZlDluPE93xvM+JWS4Yxre6kuvDH
         xFSQ==
X-Gm-Message-State: APjAAAUAnWX4frmCDq7U/bkXt94XFcQr7saRVjQCA9qFiRAxvlGzODT2
        xA5twQN/MS2HiKPQMwXBd8rXORb5
X-Google-Smtp-Source: APXvYqxLN/TUQF9opqBDdsUQJIggwBbJxRGd7NqozSaBy8YMfEuaPQAMhWtBxVcYHIiN/m0SoipgNQ==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr3976873wml.134.1576161397599;
        Thu, 12 Dec 2019 06:36:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm6384899wrt.45.2019.12.12.06.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:37 -0800 (PST)
Message-Id: <ffbc4059200bda33f8a5fece28b5baf93e465770.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:24 +0000
Subject: [PATCH 15/16] t2024: cover more cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

After working on `parse_branchname_arg()` I think that these cases are
worth testing.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2024-checkout-dwim.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index c35d67b697..fd993bf45d 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -156,6 +156,33 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_branch_upstream baz repo_b baz
 '
 
+test_expect_success 'checkout of branch from a single remote succeeds with --' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	git checkout baz -- &&
+	status_uno_is_clean &&
+	test_branch baz &&
+	test_cmp_rev remotes/other_b/baz HEAD &&
+	test_branch_upstream baz repo_b baz
+'
+
+test_expect_success 'dont DWIM with pathspec #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz nonExistingFile 2>err &&
+	test_i18ngrep "did not match any file(s) known to git" err
+'
+
+test_expect_success 'dont DWIM with pathspec #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz -- nonExistingFile 2>err &&
+	test_i18ngrep "fatal: invalid reference: baz" err
+'
+
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
 	status_uno_is_clean &&
-- 
gitgitgadget

