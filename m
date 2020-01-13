Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19972C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927121556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uv6ZJ4tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMU2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:28:31 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39813 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 15:28:31 -0500
Received: by mail-pf1-f202.google.com with SMTP id i196so7314436pfe.6
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bgj+O2oTQ1O6C2tBUkXz15AE4y9m7DfysRr8jCioSCo=;
        b=uv6ZJ4tS8gfD+GcTefPaXi1Ub6iGksxOXalr4/+1Im66N6RpICWL5E90gzfC5zk+iZ
         LzmgnH0kvArTmhRdPBptejbQUttw9t6vzg3IyYF+dZibxR9yBnRG7LRIML5EmWVUZd/z
         GeV/IqQ4c778ThfbJ5y3tLB9rsbxS25Umqcn3Y7Pj60TvIfB167t69qo0GcvmNUNulp3
         R+l4XjNnJM8l061VVq/t+hP90Y0t5ZacLZ1JhoMk5cti7G5+az8WjTOY4tNtVHlH3EHo
         xRKQ2r2bXUwW4H040gkKCKYRojA665WiD42y23K64cuZVNSo4WeQIni7xy7xt95Hs42z
         DpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bgj+O2oTQ1O6C2tBUkXz15AE4y9m7DfysRr8jCioSCo=;
        b=CQsn5yzr+l+chwD6lz/QfOkyym5SaJC0A+Wsz31x36KqjzkdNC+6GoHAAT7PFqKI+5
         ucfSwPbLsq1BSOL75XVb3gFdtu4sSo1NBpqhHuuzshbQM1dsvnh5mdcOIdjtwBi4frx4
         +vC0K5+4umTRwNAxbS5WzwddnlsSme7GJXqQaDBRm34bOQC79TMrct62/eOhrnP6IYBO
         5P5oU6Nnd+5Ub6DTuu8JaGoqhvt9lx5ktLyHeLe1dnOZQHXuGXcbTI2ywd8EMqkP40lR
         qiV9e2jzhxNMk2m7/GYyiS+1byM9bPggo98AAV16L/cxLjSOqMp/diAvHG8w+hHHrPlK
         EbiA==
X-Gm-Message-State: APjAAAVVVG/bxaUib5vO/0OCl+dQ/5uWOCyYTEqUKWR/Ma4l2oBO5vmd
        3N751J9G6uxeiNMuVk7YKV8xS/jinr+2t6UfNFdX6qe9/rLam+OaFWkZWccjS2xqfzNFyjUXCkB
        Xpkcw9tP6whzQ2viw8MpQjytzrKPG44+X4vNagsKUupdMNkGTJAFzi4Yl+nT3roWXE22JKEO/JD
        dc
X-Google-Smtp-Source: APXvYqw1zt2SjOdaYpU+a4jZP/uCBHoCd804RHFGSxyXXgixxlD2m9tzRKAS7ZkbezKOsRcGaCZ1cUy2TOUuzGwzowAS
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr22285631pgd.231.1578947310252;
 Mon, 13 Jan 2020 12:28:30 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:28:23 -0800
In-Reply-To: <20200113123857.3684632-19-sandals@crustytoothpaste.net>
Message-Id: <20200113202823.228062-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200113123857.3684632-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] t5616: make robust to delta base change
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08)
contains a test that relies on having to lazily fetch the delta base of
a blob, but assumes that the tree being fetched (as part of the test) is
sent as a non-delta object. This assumption may not hold in the future;
for example, a change in the length of the object hash might result in
the tree being sent as a delta instead.

Make the test more robust by relying on having to lazily fetch the delta
base of the tree instead, and by making no assumptions on whether the
blobs are sent as delta or non-delta.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, brian, for bringing this to my attention. I think that the
change in the length of the object hash made the tree a delta and thus
require a lazy-fetch of its delta base. Can you see if this patch
eliminates the need for your t5616 patch?

In any case, this change passes at master and I think should go in
independent of brian's changes - if the delta base algorithm changes for
whatever reason, this is still needed to make the test more robust.
---
 t/t5616-partial-clone.sh | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index fea56cda6d..9a9178fd28 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -309,26 +309,36 @@ setup_triangle () {
 
 	printf "line %d\n" $(test_seq 1 100) >big-blob.txt &&
 
-	# Create a server with 2 commits: a commit with a big blob and a child
+	# Create a server with 2 commits: a commit with a big tree and a child
 	# commit with an incremental change. Also, create a partial clone
 	# client that only contains the first commit.
 	git init server &&
 	git -C server config --local uploadpack.allowfilter 1 &&
-	cp big-blob.txt server &&
-	git -C server add big-blob.txt &&
+	for i in $(test_seq 1 100)
+	do
+		echo "make the tree big" >server/file$i &&
+		git -C server add file$i
+	done &&
 	git -C server commit -m "initial" &&
 	git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
-	echo another line >>server/big-blob.txt &&
-	git -C server commit -am "append line to big blob" &&
+	echo another line >>server/file1 &&
+	git -C server commit -am "incremental change" &&
 
-	# Create a promisor remote that only contains the blob from the first
-	# commit, and set it as the promisor remote of client. Thus, whenever
-	# the client lazy fetches, the lazy fetch will succeed only if it is
-	# for this blob.
+	# Create a promisor remote that only contains the tree and blob from
+	# the first commit.
 	git init promisor-remote &&
+	git -C server config --local uploadpack.allowanysha1inwant 1 &&
+	TREE_HASH=$(git -C server rev-parse HEAD~1^{tree}) &&
+	git -C promisor-remote fetch --keep "file://$(pwd)/server" "$TREE_HASH" &&
+	git -C promisor-remote count-objects -v >object-count &&
+	test_i18ngrep "count: 0" object-count &&
+	test_i18ngrep "in-pack: 2" object-count &&
+
+	# Set it as the promisor remote of client. Thus, whenever
+	# the client lazy fetches, the lazy fetch will succeed only if it is
+	# for this tree or blob.
 	test_commit -C promisor-remote one && # so that ref advertisement is not empty
 	git -C promisor-remote config --local uploadpack.allowanysha1inwant 1 &&
-	git -C promisor-remote hash-object -w --stdin <big-blob.txt &&
 	git -C client remote set-url origin "file://$(pwd)/promisor-remote"
 }
 
@@ -341,14 +351,14 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	setup_triangle &&
 
 	# Exercise to make sure it works. Git will not fetch anything from the
-	# promisor remote other than for the big blob (because it needs to
+	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
 		fetch "file://$(pwd)/server" master &&
 
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
-	git hash-object big-blob.txt >hash &&
+	git -C server rev-parse HEAD~1^{tree} >hash &&
 	grep "want $(cat hash)" trace
 '
 
@@ -370,7 +380,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
-	git hash-object big-blob.txt >hash &&
+	git -C server rev-parse HEAD~1^{tree} >hash &&
 	grep "want $(cat hash)" trace
 '
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

