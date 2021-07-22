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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1427C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4061285
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhGVEYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhGVEYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55098C0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f17so4458758wrt.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FatQESMdxjTv017icNsVsMBtN1cbyEjxJj/PZ8GgCvM=;
        b=B08nOhpVDBD5ew+egSRgkwZuEXc0eeYbMSYibkMbSZMFgH6O7UQQgaP3mrM2bu5uwn
         RLOaFcpaTG6MIX5i9/AKN57u/7TR2ZoxIVahGRUdXMp2PTfytUNo6DvptYYzwoWp4nwj
         mz66dA50ullKNnmZLqcmxAH7HrQkif+JFRO9LFGkXvsoPWiwoBrPfWHagwU9xOe33k3N
         +PyO+T1MAfnLhvbkcnJ531072HuKHV4VPmXXN2Giz2orjpRwq7H2jIjj3Avm+8o1dh7y
         w7d6wOrDiYVL4cRuwwJu/d3Gqi356x1TqCegJRFywcoHsAHsXAkvxUl/a3qpr3Pp9t0h
         z34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FatQESMdxjTv017icNsVsMBtN1cbyEjxJj/PZ8GgCvM=;
        b=sMpHZNT5MhOGlf24RfFRxFcXw9eOOqnzyTnG6dXHMxIJXFaZtyKsiq6ZFZoY7JANvL
         0wgwrPzEuz5wE64s44cgiwVQ+t+yNkcVLOeZ4mxPwTiWO/JM9Lot5Gh0+LU4ywKl1e1U
         6jMM6hanS9mI20mEfIblh7LVOcHuR9z1kEKTiJWNtfb9msj58QvZ9Nlc+yprH2V5w7QH
         5tuboi/VxObBtewFV3o+rBerE7UUJi22qWSFRjtOqQKMINZz4NmaI0EH2RZj4N4dID8x
         IZ442wasW8W9VHmutkvNRkV1SaVu3czMA8fP/0eh2twF/xE9vM1h23ujDOCOAEvcDV6U
         PxwA==
X-Gm-Message-State: AOAM5301VXbtHnG70l+9pdPxC6tEYcX/OjUKggzo5xuQYJCpdUOpB9SL
        yMsNQ3BpmK+TIlvE5fgrtv+/Hsdub4s=
X-Google-Smtp-Source: ABdhPJzYpppgz4bsM8huFdczDmqnpn7PMT/L8iQ93NqXt+9ycMNpiCwT09/ysfjssuu6eQFHhmWOmQ==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr24680972wrw.346.1626930292990;
        Wed, 21 Jul 2021 22:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm23340872wmc.42.2021.07.21.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:52 -0700 (PDT)
Message-Id: <66fe7f7f9341c11bc72eaf4cfa7b1d6c658e31a8.1626930290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:44 +0000
Subject: [PATCH v3 2/8] t7601: add tests of interactions with multiple merge
 heads and config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were already code checking that --rebase was incompatible with
a merge of multiple heads.  However, we were sometimes throwing warnings
about lack of specification of rebase vs. merge when given multiple
heads.  Since rebasing is disallowed with multiple merge heads, that
seems like a poor warning to print; we should instead just assume
merging is wanted.

Add a few tests checking multiple merge head behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index a44e6e69f2b..21db1e9e14b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -325,6 +325,28 @@ test_expect_success 'pull.rebase=false and --ff, ff not possible' '
 
 # End of groupings for conflicting merge vs. rebase flags/options
 
+test_expect_failure 'Multiple heads warns about inability to fast forward' '
+	git reset --hard c1 &&
+	test_must_fail git pull . c2 c3 2>err &&
+	test_i18ngrep "Pulling without specifying how to reconcile" err
+'
+
+test_expect_failure 'Multiple can never be fast forwarded' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	# In addition to calling out "cannot fast-forward", we very much
+	# want the "multiple branches" piece to be called out to users.
+	test_i18ngrep "Cannot fast-forward to multiple branches" err
+'
+
+test_expect_success 'Cannot rebase with multiple heads' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep "Cannot rebase onto multiple branches." err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

