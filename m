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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BAC4360C
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5926964FDE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhCJTbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhCJTbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5AC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u187so74384wmg.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LHUKWFc377nClgW8+NNh7YinD6CTjnUd3Jh5YVvBApg=;
        b=i8an8dOW1huuJDanb/CpaWCUzBSVGMnmh2jiAckHZ7hG5lcThHYLaBUQ0e30NIvIEl
         GcSkJWCqPZOhTUPaNPb3DNou7nETdqoCAtYDSpPkhjGBRtPKomT1NbdMTcU0HbmvfaV9
         dSD41CHwNfdfU5JwF+vpQcD6WhzjDd46UpLka3qZrNIa9F9681EF4lhjh1TP8FX9PPaw
         v80Rio4t9KNyLn43Ogea8ZIgwqdFB7YMQoKBao+GlCC5/qz6hbANQFWG/wfiOAMW5mW3
         CW7ayaS7tiXNxs4cmQGIl8ntfJxWcAKjB7F8YxfKj0uB1nqZAj/GZ3wxtc120DIv0Nnb
         jL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LHUKWFc377nClgW8+NNh7YinD6CTjnUd3Jh5YVvBApg=;
        b=IqpD1GmoVmw1Lo6CvDxWpfrvOajCcul5lbY/5cPgWAL9bV2JUhnciDE30Abi7VZJKj
         xsA/pGzzEbm9G2+cguKHeC0l4AwnFWkaEFzuxuES2V/9r2/IILx9lCPMVn2A+KNvuPP+
         /GryyKiRd7bveKBKR64aTFMEWacBgDgu9mdvcduaqoe41+6SuDUjkKV/fjb35SybQsB6
         nLrKhJPDUx+U5M/fs7TvqAc8e/Qm1Esx6mi4dB9JR7ap5hR0Kyi2eaQEaUX1tMc1vkw6
         0D0wa/X+Ggvf9Tyg4N/GKd5L7NpJEs3I5Z8B/RMgx8y4rNcdayPlZv0V1YHVm+RS4h4l
         3X5g==
X-Gm-Message-State: AOAM530kERR0HHr3RIinrjbG7nolGActIIsHXR88IOvW0O7t58ORIief
        keC9QXQdMA7gamIzx+oaF3AD6+qqfNE=
X-Google-Smtp-Source: ABdhPJxKiKkwdVwMsr51BCAiSISUC0Qx/DK7fny1JrxAS70jAQ6+Yb02Y3pxocSfvv5dhaLbUBS53w==
X-Received: by 2002:a05:600c:4ca9:: with SMTP id g41mr4899688wmp.150.1615404679532;
        Wed, 10 Mar 2021 11:31:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm464012wme.6.2021.03.10.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:19 -0800 (PST)
Message-Id: <41e3b56b9c17d3c30b7a7fe79abfc43e9c45ecee.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:31:03 +0000
Subject: [PATCH v2 20/20] p2000: add sparse-index repos
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
        Derrick Stolee <derrickstolee@github.com>,
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
index 2fbc81b22119..e527316e66d6 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -60,12 +60,29 @@ test_expect_success 'setup repo and indexes' '
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
