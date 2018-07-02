Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872271F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeGBAZV (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:21 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:55799 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeGBAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:05 -0400
Received: by mail-it0-f42.google.com with SMTP id 16-v6so9851059itl.5
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FRJSidCWbTu5z1nUArmn1d7UcGdgeT21vhZnmw5XSkY=;
        b=rlPDUus3Qh45Ivr2UbVV2IgJzSWDEOz4LN/ODoeQBU27iOUqk0uBnDFI8AtvpIRTUN
         4ylzfbDrlVSEuHtD8bYhwfk2141W84OYWSIqzaVFe2M/UQoFeNKU8dY2Rl3enOrtCMlq
         Bc79N5aQpAfQRLFI80Uo6duP4Vx3xDzOXjunYZIh8J9Ux/XyROBQTjwFkuX7UJYLKQp/
         qEi+/YQYvlKU30p+Phy4vHmXGD+xziahqQz9M54PpuHVy1WNkZMokp/f9x1gJAQifx3t
         8JGPDU6z+2xH0upL77I1ZYOEuZpSQgpvy1QsmNSQVKR/GNqdlxJsNak/TCxjUo+Ulrzk
         QYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FRJSidCWbTu5z1nUArmn1d7UcGdgeT21vhZnmw5XSkY=;
        b=QVmdaqZeq/csxeyafD+qG4AFzG/kTUPR0wI/08i8rNxjM+vOUHjx5Jlo8FhEEwPUWD
         HgsWFhqpInSL6te9Oc6IRxIB3xeD0WDEnZrhzz3Frc3MNd1C/NF2O+VrOWL6zbGuiJ5C
         jv8lbus7bHoVaYyrGuPQHi+bZ3Kw7ahRtxFOXQKKLG/uIEqwhmEDMIBPorvL+RImxE6h
         SZP5LW5DngEKCZXKXFfxUM/aq3683hW80DRaHED+gSEtSZmkNesIv6FN3ZEXjbM11t54
         eRefqLgPnL8bnROmgbpVbeiTAvkMhP/c3iaMrwpQYr16h4dhoo4iWGeJ6q6BOdUiewmL
         Ee6w==
X-Gm-Message-State: APt69E2xfM1QjSDPHxiA3Lw/yc3KgFiWH9Fgp0HTjpCppogX3r/e9E6N
        LLbumRrlhsP6cER14JcZeXWHxw==
X-Google-Smtp-Source: AAOMgpensnvStL2O62qtGwlHQa34Mi3UYl7t9pcclGO+UwQNV0HKahy1ziJ4fFO9EDHloLtLIo4pKA==
X-Received: by 2002:a24:9194:: with SMTP id i142-v6mr6737316ite.122.1530491104694;
        Sun, 01 Jul 2018 17:25:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/25] t1000-t1999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:23:56 -0400
Message-Id: <20180702002405.3042-17-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1004-read-tree-m-u-wf.sh         |  8 ++++----
 t/t1005-read-tree-reset.sh          | 10 +++++-----
 t/t1020-subdirectory.sh             |  2 +-
 t/t1050-large.sh                    |  6 +++---
 t/t1411-reflog-show.sh              |  6 +++---
 t/t1512-rev-parse-disambiguation.sh |  6 +++---
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 826cd32e23..c13578a635 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -210,10 +210,10 @@ test_expect_success 'D/F' '
 	read_tree_u_must_succeed -m -u branch-point side-b side-a &&
 	git ls-files -u >actual &&
 	(
-		a=$(git rev-parse branch-point:subdir/file2)
-		b=$(git rev-parse side-a:subdir/file2/another)
-		echo "100644 $a 1	subdir/file2"
-		echo "100644 $a 2	subdir/file2"
+		a=$(git rev-parse branch-point:subdir/file2) &&
+		b=$(git rev-parse side-a:subdir/file2/another) &&
+		echo "100644 $a 1	subdir/file2" &&
+		echo "100644 $a 2	subdir/file2" &&
 		echo "100644 $b 3	subdir/file2/another"
 	) >expect &&
 	test_cmp expect actual
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 074568500a..83b09e1310 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -33,7 +33,7 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s >expect &&
 	sha1=$(git rev-parse :new) &&
 	(
-		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 1	old" &&
 		echo "100644 $sha1 3	old"
 	) | git update-index --index-info &&
 	>old &&
@@ -48,7 +48,7 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s >expect &&
 	sha1=$(git rev-parse :new) &&
 	(
-		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 1	old" &&
 		echo "100644 $sha1 3	old"
 	) | git update-index --index-info &&
 	>old &&
@@ -63,7 +63,7 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s >expect &&
 	sha1=$(git rev-parse :new) &&
 	(
-		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 1	old" &&
 		echo "100644 $sha1 3	old"
 	) | git update-index --index-info &&
 	>old &&
@@ -78,7 +78,7 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s >expect &&
 	sha1=$(git rev-parse :new) &&
 	(
-		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 1	old" &&
 		echo "100644 $sha1 3	old"
 	) | git update-index --index-info &&
 	>old &&
@@ -93,7 +93,7 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s >expect &&
 	sha1=$(git rev-parse :new) &&
 	(
-		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 1	old" &&
 		echo "100644 $sha1 3	old"
 	) | git update-index --index-info &&
 	>old &&
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index df3183ea1a..c2df75e495 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -148,7 +148,7 @@ test_expect_success 'GIT_PREFIX for built-ins' '
 	(
 		cd dir &&
 		echo "change" >two &&
-		GIT_EXTERNAL_DIFF=./diff git diff >../actual
+		GIT_EXTERNAL_DIFF=./diff git diff >../actual &&
 		git checkout -- two
 	) &&
 	test_cmp expect actual
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f9eb143f43..1a9b21b293 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -108,7 +108,7 @@ test_expect_success 'packsize limit' '
 		test-tool genrandom "c" $(( 128 * 1024 )) >mid3 &&
 		git add mid1 mid2 mid3 &&
 
-		count=0
+		count=0 &&
 		for pi in .git/objects/pack/pack-*.idx
 		do
 			test -f "$pi" && count=$(( $count + 1 ))
@@ -116,8 +116,8 @@ test_expect_success 'packsize limit' '
 		test $count = 2 &&
 
 		(
-			git hash-object --stdin <mid1
-			git hash-object --stdin <mid2
+			git hash-object --stdin <mid1 &&
+			git hash-object --stdin <mid2 &&
 			git hash-object --stdin <mid3
 		) |
 		sort >expect &&
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 596907758d..4d62ceef9c 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -159,9 +159,9 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	git log -1 -p HEAD^ >log.one &&
 	git log -1 -p HEAD >log.two &&
 	(
-		cat log.one; echo
-		cat log.two; echo
-		cat log.one; echo
+		cat log.one && echo &&
+		cat log.two && echo &&
+		cat log.one && echo &&
 		cat log.two
 	) >expect &&
 	test_cmp expect actual
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 96fe3754c8..e4d5b56014 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -34,8 +34,8 @@ test_expect_success 'blob and tree' '
 		for i in 0 1 2 3 4 5 6 7 8 9
 		do
 			echo $i
-		done
-		echo
+		done &&
+		echo &&
 		echo b1rwzyc3
 	) >a0blgqsjc &&
 
@@ -222,7 +222,7 @@ test_expect_success 'more history' '
 
 	test_might_fail git rm -f a0blgqsjc &&
 	(
-		git cat-file blob $side:f5518nwu
+		git cat-file blob $side:f5518nwu &&
 		echo j3l0i9s6
 	) >ab2gs879 &&
 	git add ab2gs879 &&
-- 
2.18.0.203.gfac676dfb9

