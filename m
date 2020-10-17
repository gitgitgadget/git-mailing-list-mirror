Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC76C43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29881207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMajH7zS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439461AbgJQVEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439457AbgJQVEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 17:04:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C0C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so7275247wrn.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=cMajH7zSdkLm+qZ3cqVzIE/O99bZnVFntcmBYKAy+C0273QNvaywsPsJaXqTgXH/U7
         fsyoBgZMorSfjWFbY5kq4Ma18G7ezjtrn8dVKeVinyH//J/1K9hjQWYWAYiGch65tMQK
         fYGhicIaQEUNUyd5sBV+bktujA9eX8zxRx8pTJQM2G8p3jFpZtBBXuR/foC3abexJuTP
         rbS5YF6mJej2V7+F+2Ld/gkMHKEA2m6f6ak/4j8FRK0AHFMocIie6i37t+zR8wl0SgCj
         XXbrAeDQQN43p4BwINzgeAVDSH2u3kpgwGoFahCQywCfNOd4zqzTob1GZaRTRcTXFUf3
         yJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=RxihFwZaYHU4mrORGsCiteTcbKPGdxK8VCKOOW3dvoJJPUIaY0oDa5QYVpYo6n9asZ
         P/onBZPGYUQrcqp8s+q4FmN2BQPLUzyjo3N5hFI9x/xwwCKJ/bDIxCZAto2cLiE4Psaj
         0YHgLUKFaz1Kew8pkKvoJSGctrJidoA8NLpcwcSnu6crIPwUn3YMATLJuYiiOhNvKhIB
         2icTscIIyJ6MHoNLLPemkN1xnAD9ILci6ea7p3tdREetfvoa2SBSZ2G6VjaaiX8OVEwD
         3zS0wSUTq3LtysSf2DueHEg2HY38UjlwqvZ+cTcpnucSWGAVL1f+xDOc5yvhxnweU/0e
         YFsQ==
X-Gm-Message-State: AOAM532/EBwBVbqtExlAFbvHg7YpScUEpScNw0hNyQ6hXTZNgg64hHek
        STnfFfnyb2ojtjnKhYcEke2YwkPo+s4=
X-Google-Smtp-Source: ABdhPJwaawTfLf1VZ9fAGOGghd01LCNREe8hhdxV4icQ0RvCa/ZAAulrws3+9vOzXb5SOW1dwvG0iA==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr12332501wrs.198.1602968680238;
        Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm9825884wmi.3.2020.10.17.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:04:39 -0700 (PDT)
Message-Id: <024cd079654a0f0ecf6fe29976f8274efff58e49.1602968677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.1602968677.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 21:04:34 +0000
Subject: [PATCH 2/4] t/perf/README: elaborate on output format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/README b/t/perf/README
index bd649afa97..fb9127a66f 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -28,6 +28,8 @@ the tests on the current git repository.
     7810.3: grep --cached, cheap regex       3.07(3.02+0.25)
     7810.4: grep --cached, expensive regex   9.39(30.57+0.24)
 
+Output format is in seconds "Elapsed(User + System)"
+
 You can compare multiple repositories and even git revisions with the
 'run' script:
 
-- 
gitgitgadget

