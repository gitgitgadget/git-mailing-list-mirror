Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720116199F
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCWNp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhCWNos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F6C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 12so11078702wmf.5
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9y5dD+98QXMbGi6i1SxBzC8O8jQQKZVAIqARbUBgiE=;
        b=vS4G6o16yo3JpxjFjPzTnIi+u0zRN3ucrrzIRp3PMDJFvTmJAC1Zsa8YMP8YfXmume
         pktSszCWOB+OdAUi3e+sT1rcZbOttvD4GhOIP78dv7fDQs9bemI0l8ga8NzsaFn6xgJC
         Ffdw4bi60Yp+V3w3oX8vGfyM4UA2MrRJEjKhstVm+NG8IH4nR6sUCIF32lKOPAcOgcYp
         Z7B5OVwLpuDrsa3CjPgJ44YX2J5fJb2QGeZ6ffrcSZXyaENGdP8YRnrCzcvV5lu2KVUp
         yY8Xg3i/Nyd9EU/jpAnkzgjcWS7FqNiY7Tc+WkVfspe26cUMKah0H/ZO1tH/GVYDkc/J
         A0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9y5dD+98QXMbGi6i1SxBzC8O8jQQKZVAIqARbUBgiE=;
        b=J7/jK5SXRLl3aQc1KCYZtsAGj86whVQxagB9hKt4x3vx8VscEiRZkk8gskAERMpngt
         8JYL8HyZbmg1kyxMFF3zl8KDKyhk3VtQzUmkO5pIm4FmCbGBdfX33jGnoOQGh6VHK5p4
         +VI/uU92dat/ZkAh3jg4V7/HBdhG4WO6yaMLo4zTL78pnACcSB1Qp3ZBC8HJTmGS8WZ5
         eJyjHURPV3oboqRnIiWKbA2IYc15F2pmzY5zNIpm5esMn7XBPfMIoAKEF23XdJIlTK7Q
         6/4kKcJfs7IxH1fww3/Rfkbfw+7H7pw0lkJYIXykPtm+kSG34kvT+Y+43ZJijbGY5MXJ
         hQAg==
X-Gm-Message-State: AOAM53356aKMeJ1Xa1wIGr9e9hXNSqZZT7yCCwpfGQCF8MG8BcYBMtkk
        MENmbIPSIVaZBnFC4RCTimzKdJaDkjU=
X-Google-Smtp-Source: ABdhPJzVaA21ecbwnswB1VNhDokkdw4xuTJCwreSWi9znc1QWB32JdH8zpIWNy5QBrRZr4mJgcZVgg==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr3368721wme.138.1616507086751;
        Tue, 23 Mar 2021 06:44:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm2539790wmq.3.2021.03.23.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:46 -0700 (PDT)
Message-Id: <bcf0a58eb38c22c9a3b6fbcc4fabfad572ae9bd6.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:28 +0000
Subject: [PATCH v4 20/20] p2000: add sparse-index repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

p2000-sparse-operations.sh compares different Git commands in
repositories with many files at HEAD but using sparse-checkout to focus
on a small portion of those files.

Add extra copies of the repository that use the sparse-index format so
we can track how that affects the performance of different commands.

At this point in time, the sparse-index is 100% overhead from the CPU
front, and this is measurable in these tests:

Test
---------------------------------------------------------------
2000.2: git status (full-index-v3)              0.59(0.51+0.12)
2000.3: git status (full-index-v4)              0.59(0.52+0.11)
2000.4: git status (sparse-index-v3)            1.40(1.32+0.12)
2000.5: git status (sparse-index-v4)            1.41(1.36+0.08)
2000.6: git add -A (full-index-v3)              2.32(1.97+0.19)
2000.7: git add -A (full-index-v4)              2.17(1.92+0.14)
2000.8: git add -A (sparse-index-v3)            2.31(2.21+0.15)
2000.9: git add -A (sparse-index-v4)            2.30(2.20+0.13)
2000.10: git add . (full-index-v3)              2.39(2.02+0.20)
2000.11: git add . (full-index-v4)              2.20(1.94+0.16)
2000.12: git add . (sparse-index-v3)            2.36(2.27+0.12)
2000.13: git add . (sparse-index-v4)            2.33(2.21+0.16)
2000.14: git commit -a -m A (full-index-v3)     2.47(2.12+0.20)
2000.15: git commit -a -m A (full-index-v4)     2.26(2.00+0.17)
2000.16: git commit -a -m A (sparse-index-v3)   3.01(2.92+0.16)
2000.17: git commit -a -m A (sparse-index-v4)   3.01(2.94+0.15)

Note that there is very little difference between the v3 and v4 index
formats when the sparse-index is enabled. This is primarily due to the
fact that the relative file sizes are the same, and the command time is
mostly taken up by parsing tree objects to expand the sparse index into
a full one.

With the current file layout, the index file sizes are given by this
table:

       |  full index | sparse index |
       +-------------+--------------+
    v3 |     108 MiB |      1.6 MiB |
    v4 |      80 MiB |      1.2 MiB |

Future updates will improve the performance of Git commands when the
index is sparse.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p2000-sparse-operations.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index dddd527b6330..94513c977489 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -59,12 +59,29 @@ test_expect_success 'setup repo and indexes' '
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
 		git update-index --index-version=4
+	) &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v3 &&
+	(
+		cd sparse-index-v3 &&
+		git sparse-checkout init --cone --sparse-index &&
+		git sparse-checkout set $SPARSE_CONE &&
+		git config index.version 3 &&
+		git update-index --index-version=3
+	) &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v4 &&
+	(
+		cd sparse-index-v4 &&
+		git sparse-checkout init --cone --sparse-index &&
+		git sparse-checkout set $SPARSE_CONE &&
+		git config index.version 4 &&
+		git update-index --index-version=4
 	)
 '
 
 test_perf_on_all () {
 	command="$@"
-	for repo in full-index-v3 full-index-v4
+	for repo in full-index-v3 full-index-v4 \
+		    sparse-index-v3 sparse-index-v4
 	do
 		test_perf "$command ($repo)" "
 			(
-- 
gitgitgadget
