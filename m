Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAACCC43461
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF456135B
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhETVsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhETVsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D8C061763
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r5so26618507lfr.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWzMs0tJfbY+VxvskRfJ3SIb+kYcTuW3zF2PoyGOtmc=;
        b=gtxgDWCzCvv48iPbO+uWtt5dqYTwuBPMA4k1sI5QHVxGWdIL8XjD/UG3jEfuBXVseS
         shFkLPxZkBk+p5YgIyb709mI4zVkqnamKy19eYBqh96s7ulJ6cEBEI8h+F7qkKZ68q4U
         BoNpuvONApL0/6IAhex+DmL2t3RSbENy7BjcmM6QbiTETWtvzezKF+mFLAJBSd7et8Jg
         Ty/e7E8cTiY21PSU7DU8by1bnO51DoWwbkK1p9oR+/vUBUQv1mQPapX874OoYwN0CT48
         S+G5nlAEChs2WwIUhbteSP3q64peP8QOm7ncl3V3pVNZ2HqVlUsf77Y9mLvJwfv5RcjU
         WVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWzMs0tJfbY+VxvskRfJ3SIb+kYcTuW3zF2PoyGOtmc=;
        b=FzvpSxk+3ke5ltNdoNDtnwlIw7BbYAP6Ic8mQKFV0e4ypMwXJZbcYnv/C2fprycw4N
         aPJnT6XJl7ez0+tl8nXzdy35Ufsrf8M/rAG6KNZciWDfzZfZplUL+ScSdA/Sux8qkbVJ
         VoTCeVTb3fBx1xCKlvwwdbMivJSsEktvFZA2hz7ToPYw3KUjXlnOmITRXfb8OnD7Z6i6
         0VhQ3Fu+sZrLrdXY0EmBaBggOh4thbp36PSzHcACNpiXZ5UrxpW9ol1tfHUifRIidWBS
         L4yX3XwEuk7IPyddnL6nXmHdbSb3rG2EqcBVqJ0WLbp71Vj6eW16xqE1hShhYIhPQt7M
         5KDQ==
X-Gm-Message-State: AOAM531XoFwPRdlL2IUqHRyMhEcrSswyLHpgq+sFReCFQ/dpK7MHk+E4
        PKYR962bbrHTsFkiPSMk1ts=
X-Google-Smtp-Source: ABdhPJxDt7UpZYku/rpyiZSEVFdOycHGhPZjjfyOsSQzEYLcRiyD72PvKCpW2QkI4tx6N/HhD3Cr3Q==
X-Received: by 2002:ac2:5f97:: with SMTP id r23mr4448276lfe.337.1621547237406;
        Thu, 20 May 2021 14:47:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 01/10] t4013: test that "-m" alone has no effect in "git log"
Date:   Fri, 21 May 2021 00:46:54 +0300
Message-Id: <20210520214703.27323-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to notice current behavior that we are going to change when we
start to imply "-p" by "-m".

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

