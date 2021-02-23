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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B064E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhBWURg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhBWUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:16:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FFC061223
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o16so1657763wmh.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P4I47Z2ArVzg2Th38fIACL5m/fJU0EE7/UI8LGT5lyw=;
        b=QqO8yS7UVDiaD5Cd6jxUCDJsAfZII/oZbtf6u+qqPKdqz0YiGLVDPLc9eq/HXwqBhx
         mdiyKL5fEWe4LNvjWKrDyJT0tZn90F/IMS12eMRAmwyK3x1/USJd3t5JakqmErMBWqzM
         7tB8sGK1sH4HIDXeN8NiSujmJ21n5O4nlQd1EQqtfyEjTZaDzNOgB6I9MzKNbssLIjzx
         zAMaCAoX+Xw35B6C0hU5CpoloeaunVytKP37kv0uSfX68pg7oY90aZVWUud4SV3tCzrR
         AMTf/Nn/0enPh0x03+2JDNi8MrnOfiH/6W/66Pt8yxK65paca+nbQ0HZ2IPTLEC0B7X7
         jCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P4I47Z2ArVzg2Th38fIACL5m/fJU0EE7/UI8LGT5lyw=;
        b=AJVfeM4h1Z3COUA39twiLshmLENwl1G+Fe9/mhiOoZuDF3p9cM7apSt26qhox/aCrr
         ALLsX/4j41TZFGv/exP54bjt6h2T7YohbjwWy0Uw1Zo+yJ0+zjiR/2EY6LNXrg7HvGS1
         f9DNIe2Se4/iahD9zcvBV/tVKMG8Wuf/0wv1nSQu9vxVneqJkiIC9SgR8nrzKJUuwq/S
         41UhUMPejkoJZ2jx0R4zxJAPn92LZdZ9nfe8FOnMGGvQVY+QaEu2fPBEMVFak5ejljQ9
         zLiJV+UAYGPtBZbzQYN2zdnt+aR3hUu3Yvi2os6rTVwMoXOjxRUZrZOgJDNhgrgYjzzJ
         9Nog==
X-Gm-Message-State: AOAM531KdcPz64+QK6KG2EyhiDPmpOvGYVS494pslQAsTN6bYogoAfgM
        BgX6/ZsgMIUHYjLpPg+q+aC4e4M6PR8=
X-Google-Smtp-Source: ABdhPJydkyCOSV6c/zP363VsC/ar3lG9Y0aM404p8rc/xigHnRNOHH2t2bFv39BFJ6GSO+om8BKmQg==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr410742wmi.69.1614111283058;
        Tue, 23 Feb 2021 12:14:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm97088wmd.41.2021.02.23.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:42 -0800 (PST)
Message-Id: <a738b0ba8ab4e0f8a1a5004031db9cc09f17be47.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:29 +0000
Subject: [PATCH 20/20] p2000: add sparse-index repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index 52597683376e..f9c7f3c6e27e 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -62,12 +62,29 @@ test_expect_success 'setup repo and indexes' '
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
