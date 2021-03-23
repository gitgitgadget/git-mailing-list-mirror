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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD5C433E5
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB42619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhCWNo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhCWNoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65552C061765
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id 61so20799745wrm.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Sib70KHcBBpG3tPfAQlzsWFLwlZKFCZNLjdNCTGm0w=;
        b=ioJZ0Zo7ErIVWxhF9S3tNtLYq1Dw9qIGNuABitMVQlITfTGMJcE8Z/IyhKzhBFibiX
         lxnJbtbuwLdddchLQj6HZOeYaacRTBTrKe3sKWa2fwHfFtWkX5AgKAsotHKHTkhB7EUF
         WPppTDSsluk2Kj0tM8Pyg6R81Syvgkit5TGEj06EvL3xUjZ8lYPHjFVgsai/JFAuHVTb
         RXak4VHqb7GWlzhZ7cfYqakKJ7b3NMmODYbgmO0cbemMyTeB27LAGmbZqpyk/SL8jfkM
         7ReNbITYJzDTFfE07cNGY89AG9EJWUjEXSmyFxWFN8A8DOGuQFiv7RB8kNUuInLAcnNK
         aIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3Sib70KHcBBpG3tPfAQlzsWFLwlZKFCZNLjdNCTGm0w=;
        b=NSFC8FQZJf2jXyZZxGV4NKcIScOBbeM8RMEjZdaRG29KWTpjqjQl8CgFb8X8p8zVSO
         aL2rJ4CsypNBTRqYpF9+78HA/r8LWMDud+807HC2u6PMkIn5Dx/9krQ2C526fZTBRbpa
         SJNIEl9+YPHFDlKQCqTDuWdXS5IZN/zoehbpI24sCHFQb/8GtiofzZEPQQL0ugS3BzLb
         407mJYXn4KqfVN2I1GnIVW23riCwwgYOUBLvgcoh/cPzKcUUkRm0L6oYcvvoYrEdKXSF
         /DGz3N8t78qhVS3CoMzStpCGEhV3eDKD3psbEJyqdwZ5zuHydLrVVWhl9/k6HsDET/qv
         myoA==
X-Gm-Message-State: AOAM5322hQYYsLRWnM+b9gWXLxneoV42fztgC2XW+7NeJe0lbgl4b5hV
        04BPcXGCj9K5xjJ6HZYb1/Tv2LbyE0A=
X-Google-Smtp-Source: ABdhPJzX8sM08l7zkZkMbLneuOLl544ArUSSZWiqktLSWeNMXL8gTCiBy+R/40Z9Cd1wgM8ofcEsXA==
X-Received: by 2002:adf:90f0:: with SMTP id i103mr3993162wri.318.1616507073169;
        Tue, 23 Mar 2021 06:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm23534943wrx.37.2021.03.23.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:32 -0700 (PDT)
Message-Id: <7eabc1d0586cfd2d6526b5b6e40b7a42f2495e06.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:10 +0000
Subject: [PATCH v4 02/20] t/perf: add performance test for sparse operations
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

