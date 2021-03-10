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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA0C433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03DA64FE2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhCJTbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhCJTbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC7C061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j2so24612231wrx.9
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwMXD/n7BP4Kel8wxBvjV38W0PSA0EVBJLFSQGh4bX8=;
        b=GD1LTDj++dxtvcJzq+vKfnaS/3zOupHbwhrTj67A6x8zF+G83I0k9tS2vHlR+LyOZJ
         AKvJgifj1H68XpwBmdBL5HEL94ov0KVf1wePLhc84hYF3rUHCP2kkz5MYIt+b+RjKaYp
         IDHCbXfHMsGz4lk/SW5dWM3z33tbsaDWxyy1w39EDyHv3TRdpie905S3tshKhkGJKVJ8
         63yuUobDEjtkyK/z5+90o4/hBYFO0MGPKSM93Fd1sHqsG262JDAm7clIvFgx7ubb8DuF
         37Tidsd3puRf0FfIBOT/QvuY17IphRmaCwuaz0oeWRgV+BmX3lV6OqtJPic/wK17Z6SX
         mMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwMXD/n7BP4Kel8wxBvjV38W0PSA0EVBJLFSQGh4bX8=;
        b=ANCxhtJxiTPHUTv53Q3m0jxL9WR3cwRIpHi35Tx65IJWxQv7dKcSIK3fFG6RTncSQf
         +mCdG8fOcoZltpz13JxjZpkg3cIiegHQJH5odOo/mAEp7/s97fKz/hyhZmEfpKlPDx6g
         ut8eUlAgKsq5L/iDO+1wzEgC+nDF5unKYTjXu6hYEjKEmgPKtqddq9FTre4zPvux0emh
         Yf4EcesXhhdbChqnkWk40oC1wxK6TUFW78u/qNoAyyGxGyYnB0XTw67vMPqqSW9fA3iF
         SxbBKjyqso5HCDpXIBVdZqEjv7j+Cd9H9K4C0tWnLND+8XWxYgLylkFx4/hkKJg3lKKb
         0Vrg==
X-Gm-Message-State: AOAM5305XXwrYkBO+QRg2ql+RTfhsIlQp6tWD4ZstH/9QzfNlsZmGlcd
        E6IQJlDD7RpRlznB2KyvaoGCc93R28Y=
X-Google-Smtp-Source: ABdhPJyWdtRDgwgKFxxPXmMVbvK9ShxrSNcAThENiIMmKmO5zJD6DyQ36Bkdo91QadGRELdAFwgvTw==
X-Received: by 2002:adf:e391:: with SMTP id e17mr5018905wrm.285.1615404668513;
        Wed, 10 Mar 2021 11:31:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm451855wmh.2.2021.03.10.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:08 -0800 (PST)
Message-Id: <540ab5495065805fbac5b5f782937e29fe4a4398.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:45 +0000
Subject: [PATCH v2 02/20] t/perf: add performance test for sparse operations
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

Create a test script that takes the default performance test (the Git
codebase) and multiplies it by 256 using four layers of duplicated
trees of width four. This results in nearly one million blob entries in
the index. Then, we can clone this repository with sparse-checkout
patterns that demonstrate four copies of the initial repository. Each
clone will use a different index format or mode so peformance can be
tested across the different options.

Note that the initial repo is stripped of submodules before doing the
copies. This preserves the expected data shape of the sparse index,
because directories containing submodules are not collapsed to a sparse
directory entry.

Run a few Git commands on these clones, especially those that use the
index (status, add, commit).

Here are the results on my Linux machine:

Test
--------------------------------------------------------------
2000.2: git status (full-index-v3)             0.37(0.30+0.09)
2000.3: git status (full-index-v4)             0.39(0.32+0.10)
2000.4: git add -A (full-index-v3)             1.42(1.06+0.20)
2000.5: git add -A (full-index-v4)             1.26(0.98+0.16)
2000.6: git add . (full-index-v3)              1.40(1.04+0.18)
2000.7: git add . (full-index-v4)              1.26(0.98+0.17)
2000.8: git commit -a -m A (full-index-v3)     1.42(1.11+0.16)
2000.9: git commit -a -m A (full-index-v4)     1.33(1.08+0.16)

It is perhaps noteworthy that there is an improvement when using index
version 4. This is because the v3 index uses 108 MiB while the v4
index uses 80 MiB. Since the repeated portions of the directories are
very short (f3/f1/f2, for example) this ratio is less pronounced than in
similarly-sized real repositories.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p2000-sparse-operations.sh | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/perf/p2000-sparse-operations.sh

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
new file mode 100755
index 000000000000..2fbc81b22119
--- /dev/null
+++ b/t/perf/p2000-sparse-operations.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description="test performance of Git operations using the index"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+SPARSE_CONE=f2/f4/f1
+
+test_expect_success 'setup repo and indexes' '
+	git reset --hard HEAD &&
+	# Remove submodules from the example repo, because our
+	# duplication of the entire repo creates an unlikly data shape.
+	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
+	git rm -f .gitmodules &&
+	for module in $(awk "{print \$2}" modules)
+	do
+		git rm $module || return 1
+	done &&
+	git commit -m "remove submodules" &&
+
+	echo bogus >a &&
+	cp a b &&
+	git add a b &&
+	git commit -m "level 0" &&
+	BLOB=$(git rev-parse HEAD:a) &&
+	OLD_COMMIT=$(git rev-parse HEAD) &&
+	OLD_TREE=$(git rev-parse HEAD^{tree}) &&
+
+	for i in $(test_seq 1 4)
+	do
+		cat >in <<-EOF &&
+			100755 blob $BLOB	a
+			040000 tree $OLD_TREE	f1
+			040000 tree $OLD_TREE	f2
+			040000 tree $OLD_TREE	f3
+			040000 tree $OLD_TREE	f4
+		EOF
+		NEW_TREE=$(git mktree <in) &&
+		NEW_COMMIT=$(git commit-tree $NEW_TREE -p $OLD_COMMIT -m "level $i") &&
+		OLD_TREE=$NEW_TREE &&
+		OLD_COMMIT=$NEW_COMMIT || return 1
+	done &&
+
+	git sparse-checkout init --cone &&
+	git branch -f wide $OLD_COMMIT &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
+	(
+		cd full-index-v3 &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set $SPARSE_CONE &&
+		git config index.version 3 &&
+		git update-index --index-version=3
+	) &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
+	(
+		cd full-index-v4 &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set $SPARSE_CONE &&
+		git config index.version 4 &&
+		git update-index --index-version=4
+	)
+'
+
+test_perf_on_all () {
+	command="$@"
+	for repo in full-index-v3 full-index-v4
+	do
+		test_perf "$command ($repo)" "
+			(
+				cd $repo &&
+				echo >>$SPARSE_CONE/a &&
+				$command
+			)
+		"
+	done
+}
+
+test_perf_on_all git status
+test_perf_on_all git add -A
+test_perf_on_all git add .
+test_perf_on_all git commit -a -m A
+
+test_done
-- 
gitgitgadget

