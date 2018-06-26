Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329411F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFZHbN (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45785 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeFZHbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:09 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so14979046ioh.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NFFitx3cB2ZUmKWm/7gzh90Qaj3AYHF8GCMbz6PiLfQ=;
        b=pX/CdZvVsQsL4t0gNMjHk1XH9fgD+oG4A9UeTg44PYNzpDK47wu+xzzaUouRftGApZ
         gO47gIDQjZPtoepqLHXpMlImk0yWSjimWyiu6oMFmefL/ViaO3p2fWnlUVSa6Hcl3MQK
         ZMQpwQVcDOuE7cEhElDPXr6poNLzH+1L42QlmV0bKpk7ZGfWRsG6RLaO5x23MHuSH+HZ
         6IHfi1l43MobhdKnjRzXa9NIPhLN+V/0P1gwbYSOOh4JwvQgrwY0K2HL2Bcwm4KWQE+t
         KrN/MtC/zF352QHOAnLYvYFIWSPwNiMsJt1ueIGkNhBtYJgZ3a75darqFlqTBKXK5NIu
         upcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NFFitx3cB2ZUmKWm/7gzh90Qaj3AYHF8GCMbz6PiLfQ=;
        b=ajMUMqBafNLAouCH9nwLlKZAEGxK/6coau1fLSjfn1m4udtuORNcjSI+8m8ShgFbOV
         WydhYmdygs1B76LS/UJQD5k9lEcDBNArPrSNRmp3SgkOdqMVdT67/FJ0GRcv6T+7IKB1
         2wKmsBvVQdgF1kzkqhhYaSFZ+2wVOs5TgXKlOB9Iwdd9hsv7yIw4uYSmbJTopG++xRze
         z6FK6IoHI2noXpjRUbNW39xkhYXZ2xoMaSWdLK+eg353J57FSVFv5ccQDul5Ec26+t/m
         vuFVNq6hAbRt0aFWDeJOTBFEqcw9+SciCtn5XyHCpeTj0Doh3GVCPtq6Dr7WhYkgpewh
         1xoQ==
X-Gm-Message-State: APt69E2GnSsbJipXYLUUfgmnV+VOrlxy2cWjLLfK/e2iDb8jrR+walBH
        ffok+L4pn8xxpXnhOi4ZFGgdVA==
X-Google-Smtp-Source: AAOMgpcG3joxQwc+qgDRId3gIUg9efgLIts7vz7444sv/sUuPIvmmX52qNc/NpEfQnupwhK+tSyk9Q==
X-Received: by 2002:a6b:ca81:: with SMTP id a123-v6mr300875iog.262.1529998268706;
        Tue, 26 Jun 2018 00:31:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 19/29] t1000-t1999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:51 -0400
Message-Id: <20180626073001.6555-20-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1004-read-tree-m-u-wf.sh         |  8 ++++----
 t/t1005-read-tree-reset.sh          | 10 +++++-----
 t/t1008-read-tree-overlay.sh        |  2 +-
 t/t1020-subdirectory.sh             |  2 +-
 t/t1050-large.sh                    |  6 +++---
 t/t1411-reflog-show.sh              |  6 +++---
 t/t1512-rev-parse-disambiguation.sh |  6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c7ce5d8bb5..a479549fb6 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -212,10 +212,10 @@ test_expect_success 'D/F' '
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
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index 4c50ed955e..e74b185b6c 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 
 test_expect_success 'multi-read' '
 	read_tree_must_succeed initial master side &&
-	(echo a; echo b/c) >expect &&
+	(echo a && echo b/c) >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
 '
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
2.18.0.419.gfe4b301394

