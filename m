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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C2C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F0E65109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhCPQnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbhCPQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E9C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d15so10820977wrv.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwMXD/n7BP4Kel8wxBvjV38W0PSA0EVBJLFSQGh4bX8=;
        b=SrmibYJE/sY5cq1x+1+yeUqMYvkcUVvMfVXh6HyeoyGy3GnY44UOFXEgLT8ATzBiid
         +YnxLd0mKBguDjy+RYeUQ/NfK2zHgq+ttgfgiU+BbLkr1LtMyz78EnVhr1XUK49+crlR
         nO6orZ12BBIMllpzGYevcpqrcC3iUpws506bXeRnRquE5FsSgonECqIcjh900rtqDKpB
         pUR6kBgMxTnkvFvi+v8V/1jjG3lCltWtmXnBNMmIgHkEnrnfip3ANRRPKEWlR66vONKW
         LvkLy1fZOph68rgNrRe25oIzrDz3KDuYqyCDNxyWQ4LhaaMJY79MzwFhU5DTEc41Jvtz
         rXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwMXD/n7BP4Kel8wxBvjV38W0PSA0EVBJLFSQGh4bX8=;
        b=hbJNfpVxj725ruIix9VxOxO2Rlti/EHGSO9VKojZevTra1gSEyAMnGIa7L+UPgqv9L
         Gil8r7AycWR5oN0fl/mOPMv0J412X7Cgwy6p4x0E0QK+r/Cxwm1okBX6ZSw5+pRZhJD+
         7pqiU6RrntUkW9Cg+PHDOONNwLVS9alXW9wMZ5tt9uOxEJDEIz9LMPFBFTOA3+9o2FaJ
         P+Jt8pkNXDUv8yP1Ek9le+bG+AN6tgPIE/a4rdLvRgIivOK6uuYcB/oQBlkWEZHFQcWk
         I/x1cX6O96dly804CQh42Jy7z1aRtCbrDvpbpyboH57D7PJqI4lLOFbZlY8A0w0furFK
         U+Zg==
X-Gm-Message-State: AOAM533kH/bQ3PrBdX/d5pLp2B8U9zzSJiCDx8lgmJzP6Cg5+vt+KhnQ
        tnjnvuED9lko4P8YY8dnDV1xF1evmDk=
X-Google-Smtp-Source: ABdhPJxtOCyNGHjktgIivVQZT/UuIjFiL0XaqNo4i05pxn4EApUYdgdP/Z/mZqurRNfQYihtHilssw==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr5762384wru.78.1615912986472;
        Tue, 16 Mar 2021 09:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm27824wmm.19.2021.03.16.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:06 -0700 (PDT)
Message-Id: <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:45 +0000
Subject: [PATCH v3 02/20] t/perf: add performance test for sparse operations
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

