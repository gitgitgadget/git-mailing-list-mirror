Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563BC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A061059
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhEQQoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbhEQQon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F1C026CF8
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i22so9499964lfl.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dkgZsX2HyqQXzwicqV1ASn7xJG4Xe9wKAEfsARmcx0=;
        b=MqNCTh0yuTk0/E2KxRwll9aa0b7MLMZn1uA1/KWZbo3sLLmKEqwVWzus1SADlmqlRh
         BuVfaV5vEQvNR0HlD/mFTIOALDkKXh9eUxkuR8fBk96RmJf0DdOdEpb6BSSkA339XFVR
         T3HxVv+um3AEvUESTw9FVeHvfljaj6NgJnOMKPxw0v+9kA167DDrVafl+t1YMfIk1imy
         cKo6Phb1tszbh2vRjQfdiNzc8H313DkeSam52SdlNCIHlKaTFoJxB2j38LnN5ebcBgDH
         jCdox0mCBKGwzg8nVgopmnG9Vpqb2T+yStOJYYvoNBf3bq1Xll5Tap2wLDSaCvk56Dkt
         86+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dkgZsX2HyqQXzwicqV1ASn7xJG4Xe9wKAEfsARmcx0=;
        b=eQ5TEehUL6YvlnAotoUmcInWHaQcP5UPhFrn3wADji+akm5GVP937jSIDLQ9+7Bc8U
         1pzjP+6E5geX4Ti6EOnysDzi17XMydqNSZ+bfZOGCMMfZZ2nq6Qpu/jGEGN7zmGg5yn1
         49eD/WyQOJaol+IY26dIw+fpSDaOOQQI6erQLOwXi03GGfz6IAPKA70X9nR9MW4mqeos
         yapqvMYAfdH3/BcSTbXma+fTQvAGASSj2wi81BxaA542pFyJbr5ohLxYmSQmumkSvZx0
         Tx90gxgCJwv3Twlp0cLx+gT5S9+4k+NMVlMzkjnGrCXihaGiiN5lRV2s5/rZcCevellK
         QBfg==
X-Gm-Message-State: AOAM53163J82nv4Sl4zajGLd62VIf/T3zNZPET0YdSEBP5fq3T1PpSp1
        /vswTxDJIdZpKreeAOvDdL8=
X-Google-Smtp-Source: ABdhPJzCXiOE2zO5cs+OIWvJRX2Cp7GQmlnkekeJR2GXT/JDRnBLX6HyT6Kjp5x38TUJkPjC3h7mLA==
X-Received: by 2002:a05:6512:1093:: with SMTP id j19mr401406lfg.508.1621267118790;
        Mon, 17 May 2021 08:58:38 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 1/9] t4013: test that "-m" alone has no effect in "git log"
Date:   Mon, 17 May 2021 18:58:10 +0300
Message-Id: <20210517155818.32224-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to notice current behavior that we are going to change when
when we start to imply "-p" by "-m".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87def81699bf..e9f67cd24351 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log -m matches pure log' '
+	git log master >result &&
+	process_diffs result >expected &&
+	git log -m >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	git log -p --diff-merges=separate master >result &&
 	process_diffs result >expected &&
-- 
2.25.1

