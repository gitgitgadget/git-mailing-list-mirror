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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAACC4345C
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A245619F7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhC3NL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhC3NLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F20C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so8371488wmf.5
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9y5dD+98QXMbGi6i1SxBzC8O8jQQKZVAIqARbUBgiE=;
        b=aJX8coU/RbTAwvk64xy5MlWufPYYMI3W4XOJ/IE6SyPojLpSK9BW+onb7A6oy1VJCr
         3oUfuDPZsrZz2xW44VX8fbRxIHI+a4bamlRFOktCR4mdMLbkOM/92iBkTMVBsl9ERp3l
         V2Ah2jplytWhN5u9XiI0drfj3Jf3MidVxSX8FCdPOBewEPsiQhk9pq0lQSsdHmp88LbD
         wQyLDlsYOGhNaYXqyUotXDZt60h4BSO8rBNW8+hf0l6/jKN/IP317uve6o/4QxifiuFy
         XV+rnnlFz+8gV+ZPc+qwo1JhHPFu1Nl/LNShhG+Bbw6uYIUPyzRsRC2aQ74RwzfYw/SR
         8CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9y5dD+98QXMbGi6i1SxBzC8O8jQQKZVAIqARbUBgiE=;
        b=lLKiSU4bUBzANEybruPOrBQ0QxqQw/tWBzTpbCVRPL/pOfZI7Kh6Vo3raDnl2/Xm38
         XWMKr+smEuZLAOp1yCF1qWn1xoCuk3NZidXdb7SHM3hlgzXXJfS1yQRg2a2MCpnHB9Eo
         Xpftq3ThDJp3+Vrp/qjfQ33WubNcxJjiW11aNszjypCoPPREkOZdA8ZAqqpQehN3to64
         LINx0ygBacnpdvR/JTx410Nug18rX16qmuNGOvds6ASifUhVjnMXs3wHQWt3BBpSH7OI
         P53phGst1CHcRlGqQGKUixFu0WPFGHxjIzpw/vlxXPHRsKecCcjSnoJk1KvQRjcsOqIj
         S4TQ==
X-Gm-Message-State: AOAM533fzIC+nd0QcPufwuNryeFbHJwSZYYyTvr6gIvTgHb9m3WwxaqL
        Hw7BMvg3waFQQ0aBFzv8Rgttyk/B1Wc=
X-Google-Smtp-Source: ABdhPJzMX8WplzqlINGiYjGLCI4/pWc7cJJe9vzFC205J4XFfkHpFtae2pY7UnXSyoNuiXkvI8qDYw==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr4111382wml.4.1617109882580;
        Tue, 30 Mar 2021 06:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm2544056wrv.80.2021.03.30.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:22 -0700 (PDT)
Message-Id: <66602733cc95d9a53594520cd8b28d3338e258ea.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:11:04 +0000
Subject: [PATCH v5 21/21] p2000: add sparse-index repos
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
