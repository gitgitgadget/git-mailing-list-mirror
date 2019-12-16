Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49438C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CFC20717
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjh7UYYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfLPPsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfLPPsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so7269191wmb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DQ2eGuP+iM2s02E2HkXytysJUPRhIcOh0Uk/p0Rz6co=;
        b=Gjh7UYYZz1wlzipp9giy6n4OYVCaUXgvMhOpA6alRggN83bcMWKP0b4MF/nQcryVnA
         dPI9EUP1WHr+XtKLZEiN+DWm4qyQ2jirawB3HmMjHASZM3q1ja8MyDucDCTlhbT2YmSU
         3t1PUQRJMGhAcmAWS427WRwL3KymWLvz1jHPar1DwaEXTGR8jlxBG8ze6aBdnPDORvw2
         cfyTsZI1ttDJJL/7Dyb4PWlzohICs+myuT4vK81dGKNQzYq+S9c4leJ1ayVXpE5DFXOL
         qPAo302MHqOWJmvQtXR0Uw9nF43c5yLjShiMA2bvKo9AF3zzfhYt/Eiv6Qrd1iBdP7/C
         si1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DQ2eGuP+iM2s02E2HkXytysJUPRhIcOh0Uk/p0Rz6co=;
        b=jzW3e0zyexKopCLtDyY8qphugJD9LgFreSCYxMdWej1Nbejo/wrFXROkY867QQue7d
         6FkxARab+5zVrgNb1QAyxPJ8WrRta9A3m8K+WXw9FpFEfWmow/9zlXIhEinfQWFHxdFc
         Q4G6PMeyO8bnQVLZ4r+sJLY2EkEUr8ZZVuKBgD5UWI8/El1L5IWMZm92myNYnOQ1DSXh
         OWd+9PrunYHnlxzMNzGlWFqbkR//vSziNE6Y+CO3k+Y+BttO9KdjSFbf8L5paGC2jImU
         djiL7qmyOTND8W1fDEVslSrVC2H1YXt7KsH7UHRBZIWIpsokKEYZuulGw04qFWZhgyY0
         SBqA==
X-Gm-Message-State: APjAAAUMuc0CHyQvvAUrGQta1Hx+y5ybGcSdZNqKlMO4bjEfYhC2Qf4w
        rlKiAfhsV8/9J/rdZfn/T54AGcU8
X-Google-Smtp-Source: APXvYqxSO4a4KBbZ43uBrtGW4dKmRLmAHKMNXaOtrq9/DasSekJC2lusD7dKP3C5N77FvAPNYMA3kA==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr25646126wme.40.1576511290237;
        Mon, 16 Dec 2019 07:48:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm22497233wrj.23.2019.12.16.07.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:09 -0800 (PST)
Message-Id: <b09d74c34783235f90f284af77da565e305d0b6d.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:51 +0000
Subject: [PATCH v2 03/18] t7107: add tests for error conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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

Suggested-By: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t7107-reset-pathspec-file.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index f36fce27b9..da833925a6 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -74,4 +74,18 @@ test_expect_success '--pathspec-from-file is not compatible with --soft or --har
 	test_must_fail git reset --hard --pathspec-from-file=list
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git reset --pathspec-from-file=- --patch <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-patch" err &&
+
+	test_must_fail git reset --pathspec-from-file=- -- fileA.t <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git reset --pathspec-file-nul 2>err &&
+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err
+'
+
 test_done
-- 
gitgitgadget

