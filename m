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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A54EC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369C961108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhEaRmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEaRlD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:41:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F9C008756
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so9224613wmk.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Kz7Ad/tLVOBDrM5Ch9kTOh5dZ3P5MrWcssYmDd0evkM=;
        b=ugCfRqeEYxt/thR0MII15kRNGVYCdqbHPohtBp327wqYmk1MU2pCetA0DTkq5hnKgm
         uyZ07KRBlSrlc+TXEj9czaLJWKjB2E2SP1tFc0FHFG9v4Vx3GtkSVphtrNwvucN0G/EG
         FgULhvEROSJ0dPgp729goRqnpwPxtiK5Pd7TS+rX5BibZxpP/jE6yJyQpR1gl7pExqBt
         o3XGfX7axf5kp5GtCD6qRbbev2JFY8q1WHUGZQx4tPkAQz5BQfaxbBQNDUO0h9oL5JPU
         FJ0Zx9T2AzKnSzRlrjtHHMXTbtNWDT3eWN15O35cA6pwfVKfgq9bg5ibbTKOAGZT4sGm
         adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Kz7Ad/tLVOBDrM5Ch9kTOh5dZ3P5MrWcssYmDd0evkM=;
        b=aeKgpX94LMyWL2xXIh9l7dr57Sa1aHMNoaJzCMh9K8Zel9MIyXogc1gNFInUAAOWmx
         KCEo2XbI0AxF52ImmdZpj9MnlzNarOZGppdUC6Xfq2vPD4K7kOs8Lr76gctt04bEIwiB
         oHAMbpZW+1Lcm65bmwk4nv5rPZvXny1CFYxxauWZYurgNv0OGTn+FK5QPt/EhUO96o2c
         WyvIfIhLJLm1VI07aYizuzq8kZP6l/gkL3EIG0cC114pfEgZsB9rzec91bR6rWDzqBFp
         9m7zVQlezLS3P8StAJ48fGvHyyejfCIQQBDQSJx+Vs+C226fPnXj6oOuE+/4Ev1pkgBg
         5QxQ==
X-Gm-Message-State: AOAM533XZbQFwY35rhRRFmHsxZb2bWUbEcR2JapZJkl+jYYmt1e8vE0I
        CPZF6zwXoGU5veEmPu/GnJV95a1cpE0=
X-Google-Smtp-Source: ABdhPJxnRRYWQUwwe/HNKJbkOFkin85m4FdVCBCXalAbX9NOuko1MXIW6fdYA1nk4PQz4oueG6/8kg==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr23112123wmq.119.1622480209605;
        Mon, 31 May 2021 09:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 32sm345695wrs.5.2021.05.31.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:49 -0700 (PDT)
Message-Id: <73f89faa3b0a45cf4ab7388b6dfeaf4d7bd881c6.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:35 +0000
Subject: [PATCH v3 20/22] t7003: check reflog existence only for REFFILES
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
 t/t7003-filter-branch.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index cf30055c88dd..e18a21895238 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -396,7 +396,10 @@ test_expect_success '--prune-empty is able to prune entire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
 	test_must_fail git rev-parse refs/heads/prune-entire &&
-	test_must_fail git reflog exists refs/heads/prune-entire
+	if test_have_prereq REFFILES
+	then
+		test_must_fail git reflog exists refs/heads/prune-entire
+	fi
 '
 
 test_expect_success '--remap-to-ancestor with filename filters' '
-- 
gitgitgadget

