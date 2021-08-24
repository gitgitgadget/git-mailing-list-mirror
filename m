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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CBAC4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2524613CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhHXVzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhHXVzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42905C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3214938wmi.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=svIO42vGlZwIuflOGzN7ll+SM7YSJGkuU6Z4a3rxGeY=;
        b=oNMIFh3gOXyRMvAaijnTqjQikaDOIaqwwiTZGnJveeGoQyq638BGBtBIiVSsOybLjX
         2Dsg8pCJPclQ4nE73WxUba52pP/7Q6+6lN/ePCplWKV24oTfn1r/ygcWCd3f6RRqC+RY
         mhIgw+G087b6ocDtVE+Dwff3d7UYyiHBZZRR/lH7Y8+woUxJQXk6oCLgycGQ7Gx3uB1B
         udfZLWDXbml4XApUia5utJe9g8MDffAdlG1yA6QSNgtjuRnbHoY3JW6DNbmQo/qci+s3
         t5RhuL4Gl6c3eRSEUoTC4tWJKVclanFCeqMPOXWU3vR3vJdkxI1hhkdyY9sx8YaB6nH1
         4fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=svIO42vGlZwIuflOGzN7ll+SM7YSJGkuU6Z4a3rxGeY=;
        b=HhOkndsofOvxIrVwAHneUX/R6nR1uXTodaBNrXM+03oZLxTG/DH7PHmd/qe2eHMAfY
         e6lR65iDBFmX/C9s0ZocH9KEYc7/yim1T3vJ+674O4KaQrXOFyGqPSxAyHjXezQcYo58
         gkDsd/RVXBI9BQRiCnoOjVEYFffLPLP/+F5cm1JveWyJax6HT6KJQbnHdMfSTeNllWt0
         Dlbfirdq4KGYNWzf6gFJQ4n5H2hUFkMQA82hxyLk6VAOiX00yV/Wp9vpBU14P/Y+2o1b
         BJ55ntjXbqslDsvUgDJQl1F0On+NijFz8LrjXja6FURIE2fLEWCRzLYowelGfggMIKP/
         h3fA==
X-Gm-Message-State: AOAM531LZQmGzPcBzhntXeXbEDiKkuxcidtOsOujb9Jh9I7OsE4bAmb/
        EvcVFlbtOZe0zAfmfiB3tZ3Ulgyl4aI=
X-Google-Smtp-Source: ABdhPJzXhrUEemVMLYi7m7emKL1VgchmiiY1UAwUVRGghmAdw4Uu7xt5UokSCJm9/NGwEEtC/eZKEg==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr6116091wmr.168.1629842086915;
        Tue, 24 Aug 2021 14:54:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm3188703wmq.34.2021.08.24.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:46 -0700 (PDT)
Message-Id: <69ca54877b4eac5c85195a1061f0d72ba6fca313.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:33 +0000
Subject: [PATCH 01/13] t1092: behavior for adding sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add some tests to demonstrate the current behavior around adding files
outside of the sparse-checkout cone. Currently, untracked files are
handled differently from tracked files. A futuer change will make these
cases be handled the same way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index bbc6de712c4..23bee918260 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -291,6 +291,18 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+# NEEDSWORK: This documents current behavior, but is not a desirable
+# behavior (untracked files are handled differently than tracked).
+test_expect_success 'add outside sparse cone' '
+	init_repos &&
+
+	run_on_sparse mkdir folder1 &&
+	run_on_sparse ../edit-contents folder1/a &&
+	run_on_sparse ../edit-contents folder1/newfile &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_sparse_match git add folder1/newfile
+'
+
 test_expect_success 'commit including unstaged changes' '
 	init_repos &&
 
-- 
gitgitgadget

