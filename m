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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6EC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B027E64D99
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhBWUPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhBWUPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2297C06178B
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x16so3628228wmk.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NVPCR6yPnG+zSxv1JkAaAXu15R9XfnzPKEj5XxAvU5k=;
        b=U1HqW+TeWxls+DF/XejDO7/mR1AqDa+VCHJqDluM0YDZaHnRQKoHGUzVjJs09M6tGQ
         Ld93L2yzeayJaOyWgXZBAnvErOyZroa+k03D2qUe7O/NFbPIrY8XygYQq9EHI9axM+m7
         kqaZeqQtDMpRFSqQLuWEshmj1LdPobOz4MpkZ4hy0MTlerF6p/9CSMPvUrqDIJ/FvQdW
         B5kMVc3/9NQzLxUc8VDtDuLvNBum5VgIHMAc/FCOl8uLwElTFl3mIAQL7/NVw3osOeGI
         xOrg/rdTVt9EyOrSM8pcwEZhW2wLfNxiBYxMalHvo+oqxAx1UEBiQnGvzBNGWd46TDha
         U5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NVPCR6yPnG+zSxv1JkAaAXu15R9XfnzPKEj5XxAvU5k=;
        b=pfyqj1YyyV0lcScbZ1Krec4Hrl+kYRkQszOHDtSRrjjGkcHt9um/G41hDz99Oa6Sf9
         5PpmgMAwAkF0B47OR0BAKddxx96CCUWU8Ncc1K540ZAXdZjOyZM3f8d6aIh2lYPyFixv
         KybYVOLHjqD+Ec5WLYwQHIC8pQgSxnkS5GBxMnVLozKcz2kLrKxl7SRhYxNPs92ixqzs
         i0tqWInzBuR3qf11LN1zOov70D1VGvYjeNFxGxr6bwsu/NH05M+UgsPqhKl1RB5zRYtG
         hQjjR0TEiOiPLL7TPYQ/euHT/FViKxlO51esEwS9ev5Yg7iOLquPWr9GAnbLHOhJZylg
         aWgQ==
X-Gm-Message-State: AOAM533P3IfN+mUzME+lNN9wjMoY2ofCcT1HVN8EAjKOdFGCQV/EZqIn
        50afSlveI3piyfLMqRultzH8DJeExf4=
X-Google-Smtp-Source: ABdhPJwbbX4OTGgvcF3xYoMJtFziMLfaBCoX6ytaUbSzIUenDC4NCh1xlJpM+xTS0lCpvPboVOuFFQ==
X-Received: by 2002:a1c:2311:: with SMTP id j17mr453393wmj.38.1614111272483;
        Tue, 23 Feb 2021 12:14:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm3893892wmj.23.2021.02.23.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:32 -0800 (PST)
Message-Id: <a8c6322a3dbe1130dd2026b600a896e86d54a95d.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:11 +0000
Subject: [PATCH 02/20] t/perf: add performance test for sparse operations
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
 t/perf/p2000-sparse-operations.sh | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 t/perf/p2000-sparse-operations.sh

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
new file mode 100755
index 000000000000..52597683376e
--- /dev/null
+++ b/t/perf/p2000-sparse-operations.sh
@@ -0,0 +1,87 @@
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
+	rm -f .gitmodules &&
+	git add .gitmodules &&
+	for module in $(awk "{print \$2}" modules)
+	do
+		git rm $module || return 1
+	done &&
+	git add . &&
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

