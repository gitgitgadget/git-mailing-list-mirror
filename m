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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCEFC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55968619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhC3NLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhC3NLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC25C061764
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c8so16173514wrq.11
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Sib70KHcBBpG3tPfAQlzsWFLwlZKFCZNLjdNCTGm0w=;
        b=ooYIbTIgFNvl6okFUlqhzmmAoI7IZOtd05kY/10I7u7ppdkeCgxcaJjyDeV2gPE2Rj
         73s6oDb2WKQJrsmFggfB0ocPLByjqmnkCzTqfc+Wu/0ZdmwMKSA2lR3AU3m5QXsyE1LN
         suXkDcdsZ7FsEeBYXHs+BSYVFo0HgPXFdLz58zWfanPuRi622RhS6WEQv/EbhV8pp1Sl
         K8DwpNyan+XMmRnT/eFEW1e2/lZNwf6O6s5Sx6gdDAPh/rtnQc2/KoB/jlu1jSuStkk8
         hV12/WGhrc5cxZGVeUXBV8o00egoMgS8N9zmPBOZeIpo8qFMwwg3uX2hiv7V1grBUQPK
         VuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3Sib70KHcBBpG3tPfAQlzsWFLwlZKFCZNLjdNCTGm0w=;
        b=W+d49bozU7egdfXh63hEkzX+ieWppzfHb+gntVSeZpU17YHcIwUqly8tuLdTSaMJOp
         JOoBiKrFAZoRn0EuRiEY77bU8ObDPNIrrObmQXozCuYxYUwydtszJIXbB/LpzND83iNu
         LS4YQqRzLtSOsYV2JOJ6cxY6qJnb40e0+WAzbFNEV87iymtkqTwq1dgWq9utBFB5R6l3
         U1FdAATaHRe9hkpp2Mr4Db5TE1yV1zLtDxwRGtQItls4PSlPBjdx3FWL2WM36awvS6LC
         JnccOBS+qzskSJWUAAIUrscbJImnwZnQvE24pJP4pyul03C/ghSZS3rj7jLRPQ8+IDQz
         SgzA==
X-Gm-Message-State: AOAM5302uj7liMuezjceHLVZf4ISbFPI5UOib6n8m7w8y8416lAKl7U6
        wonDZ+bY7BocVpzZDlv7c6hrZfuRMzE=
X-Google-Smtp-Source: ABdhPJxPlyG3nOMyftihHHmGYLA27ScW/J4Sh/c2VO49CGoSE9TNDzB9y2C+sorxPLIRHOETcxy/dg==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr5079698wrt.275.1617109868080;
        Tue, 30 Mar 2021 06:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 64sm3485625wmz.7.2021.03.30.06.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:07 -0700 (PDT)
Message-Id: <202253ec82f34d1302ee7360e4d458ac4af89e82.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:45 +0000
Subject: [PATCH v5 02/21] t/perf: add performance test for sparse operations
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
 t/perf/p2000-sparse-operations.sh | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/perf/p2000-sparse-operations.sh

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
new file mode 100755
index 000000000000..dddd527b6330
--- /dev/null
+++ b/t/perf/p2000-sparse-operations.sh
@@ -0,0 +1,84 @@
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
+
+	# Remove submodules from the example repo, because our
+	# duplication of the entire repo creates an unlikely data shape.
+	if git config --file .gitmodules --get-regexp "submodule.*.path" >modules
+	then
+		git rm $(awk "{print \$2}" modules) &&
+		git commit -m "remove submodules" || return 1
+	fi &&
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

