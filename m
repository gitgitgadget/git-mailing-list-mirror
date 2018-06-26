Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003B71F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeFZHc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38409 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeFZHbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:12 -0400
Received: by mail-io0-f194.google.com with SMTP id l19-v6so15008891ioj.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kYEXzHiQTg1HH45cVSUXRuwJwN3z4Q6ZgK7zDzB2eY=;
        b=VgXIBsixciyjB4Wz5V/2+Linm8ZOYR44A1pYMRlpSPowZvx19aOTDScqxYgfBAMTXK
         XBXknhZI7Qt5ylByoYNI0/iQRnWRj4nE+t5CbFvTu9Ffc4xe9Ef4NUCbqpJg+1+6HcpC
         WPMx5ipIBjNn/OsMVZKo1jt6LuE+GGdqcIrMqozdezDBHvzv4f8H2fZYjnszvUMf5OqO
         uDYOy9CHWCFbHXbxhX+io2kKCVMMMOoSR3DNCg7lkiJ0rssJEry++H2351TfKqxDMNzS
         dNmV0S4QpL076PwXb8Clu6DsXzEk24TLP2XwaG3TWYla7JEBplu+7uvLCyUbbv4IT7VQ
         dP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7kYEXzHiQTg1HH45cVSUXRuwJwN3z4Q6ZgK7zDzB2eY=;
        b=XLZoKvGpnGTU4npjJp/bqhB1NQiLnt3BOi0LZ2ZLSo5Jc/PPQD1v9O4FjDdnRTa0k/
         gamxkbIN8MNS81eHxJIqxNW4uE4kx6luC/eiU/BMlNK8h5+YL8P/EReabUvcMvoLVKcR
         //+XYz+xATBM7/abiZTfLnmZh663BZkQynhRNW+r9k5x2zOHJFgZpaDEZ+zWY4nXiXRi
         fqLWaapbTOJ4F2ZZgIMHLBdLnpbWYLoY2IIHFzXv6Jw8R8ojMP4tiBmzwtHxJVSRAbQ8
         YfScRh0cSGIsIpRZANiRt4x+EgzJOujqNPvopT0iR95h0Rh50FRRVp1AnRtskUkqfOIQ
         KkDA==
X-Gm-Message-State: APt69E1uZlQqhFylIYSYES81A1wDAVdgwwpE+EACMs1eRzeV75wkXxir
        SrsMOKQ9b/m6F9aplArTZEQe7A==
X-Google-Smtp-Source: AAOMgpf6IKaL5UqzvH26zBjqKWyw/rd6Gj5C/rfWNjNyN86DHh1eAKqAVk+6seDpZylSYfVP8+78WA==
X-Received: by 2002:a6b:ec12:: with SMTP id c18-v6mr306210ioh.128.1529998270923;
        Tue, 26 Jun 2018 00:31:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:10 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 21/29] t3000-t3999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:53 -0400
Message-Id: <20180626073001.6555-22-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3000-ls-files-others.sh              | 2 +-
 t/t3006-ls-files-long.sh                | 2 +-
 t/t3008-ls-files-lazy-init-name-hash.sh | 8 ++++----
 t/t3050-subprojects-fetch.sh            | 8 ++++----
 t/t3301-notes.sh                        | 8 ++++----
 t/t3400-rebase.sh                       | 8 ++++----
 t/t3402-rebase-merge.sh                 | 4 ++--
 t/t3418-rebase-continue.sh              | 4 ++--
 t/t3700-add.sh                          | 8 ++++----
 9 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index c525656b2c..afd4756134 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -84,7 +84,7 @@ test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
 	) &&
 	(
 		cd super &&
-		"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub
+		"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub &&
 		git ls-files --others --exclude-standard >../actual
 	) &&
 	echo sub/ >expect &&
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index 202ad658b8..e109c3fbfb 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -29,7 +29,7 @@ test_expect_success 'overly-long path does not replace another by mistake' '
 	printf "$pat" "$blob_a" "$path_a" "$blob_z" "$path_z" |
 	git update-index --add --index-info &&
 	(
-		echo "$path_a"
+		echo "$path_a" &&
 		echo "$path_z"
 	) >expect &&
 	git ls-files >actual &&
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 08af596ba6..64f047332b 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -14,10 +14,10 @@ LAZY_THREAD_COST=2000
 
 test_expect_success 'no buffer overflow in lazy_init_name_hash' '
 	(
-	    test_seq $LAZY_THREAD_COST | sed "s/^/a_/"
-	    echo b/b/b
-	    test_seq $LAZY_THREAD_COST | sed "s/^/c_/"
-	    test_seq 50 | sed "s/^/d_/" | tr "\n" "/"; echo d
+	    test_seq $LAZY_THREAD_COST | sed "s/^/a_/" &&
+	    echo b/b/b &&
+	    test_seq $LAZY_THREAD_COST | sed "s/^/c_/" &&
+	    test_seq 50 | sed "s/^/d_/" | tr "\n" "/" && echo d
 	) |
 	sed "s/^/100644 $EMPTY_BLOB	/" |
 	git update-index --index-info &&
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 2f5f41a012..f1f09abdd9 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -21,10 +21,10 @@ test_expect_success setup '
 
 test_expect_success clone '
 	git clone "file://$(pwd)/.git" cloned &&
-	(git rev-parse HEAD; git ls-files -s) >expected &&
+	(git rev-parse HEAD && git ls-files -s) >expected &&
 	(
 		cd cloned &&
-		(git rev-parse HEAD; git ls-files -s) >../actual
+		(git rev-parse HEAD && git ls-files -s) >../actual
 	) &&
 	test_cmp expected actual
 '
@@ -40,11 +40,11 @@ test_expect_success advance '
 '
 
 test_expect_success fetch '
-	(git rev-parse HEAD; git ls-files -s) >expected &&
+	(git rev-parse HEAD && git ls-files -s) >expected &&
 	(
 		cd cloned &&
 		git pull &&
-		(git rev-parse HEAD; git ls-files -s) >../actual
+		(git rev-parse HEAD && git ls-files -s) >../actual
 	) &&
 	test_cmp expected actual
 '
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2d200fdf36..ac62dc0e8f 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -914,7 +914,7 @@ test_expect_success 'git notes copy --stdin' '
 		${indent}
 		${indent}yet another note
 	EOF
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --stdin &&
 	git log -2 >actual &&
@@ -939,7 +939,7 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 	EOF
 	test_commit 14th &&
 	test_commit 15th &&
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
 	git log -2 >actual &&
@@ -972,7 +972,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 	EOF
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
 	git log -2 >actual &&
@@ -1059,7 +1059,7 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 	git notes add -f -m"append 2" HEAD^^ &&
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD);
+	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD) &&
 	echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
 	git log -1 >actual &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 72d9564747..3996ee0135 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -200,10 +200,10 @@ test_expect_success 'rebase -q is quiet' '
 
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
-		echo "One"
-		echo "TwoQ"
-		echo "Three"
-		echo "FQur"
+		echo "One" &&
+		echo "TwoQ" &&
+		echo "Three" &&
+		echo "FQur" &&
 		echo "Five"
 	) | q_to_cr >CR &&
 	git add CR &&
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 488945e007..a1ec501a87 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	git commit -a -m"master updates a bit more." &&
 
 	git checkout side &&
-	(echo "0 $T" ; cat original) >renamed &&
+	(echo "0 $T" && cat original) >renamed &&
 	git add renamed &&
 	git update-index --force-remove original &&
 	git commit -a -m"side renames and edits." &&
@@ -143,7 +143,7 @@ test_expect_success 'rebase -s funny -Xopt' '
 	git checkout -b test-funny master^ &&
 	test_commit funny &&
 	(
-		PATH=./test-bin:$PATH
+		PATH=./test-bin:$PATH &&
 		git rebase -s funny -Xopt master
 	) &&
 	test -f funny.was.run
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 03bf1b8a3b..853e015839 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -60,7 +60,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	EOF
 	chmod +x test-bin/git-merge-funny &&
 	(
-		PATH=./test-bin:$PATH
+		PATH=./test-bin:$PATH &&
 		test_must_fail git rebase -s funny -Xopt master topic
 	) &&
 	test -f funny.was.run &&
@@ -68,7 +68,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	(
-		PATH=./test-bin:$PATH
+		PATH=./test-bin:$PATH &&
 		git rebase --continue
 	) &&
 	test -f funny.was.run
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 07af05d7ae..618750167a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -156,9 +156,9 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over stage 1' '
 	git rm --cached -f file symlink &&
 	(
-		echo "100644 $(git hash-object -w stage1) 1	file"
-		echo "100755 $(git hash-object -w stage2) 2	file"
-		echo "100644 $(printf 1 | git hash-object -w -t blob --stdin) 1	symlink"
+		echo "100644 $(git hash-object -w stage1) 1	file" &&
+		echo "100755 $(git hash-object -w stage2) 2	file" &&
+		echo "100644 $(printf 1 | git hash-object -w -t blob --stdin) 1	symlink" &&
 		echo "120000 $(printf 2 | git hash-object -w -t blob --stdin) 2	symlink"
 	) | git update-index --index-info &&
 	git config core.filemode 0 &&
@@ -265,7 +265,7 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 	git reset --hard &&
 	H=$(git rev-parse :1/2/a) &&
 	(
-		echo "100644 $H 1	track-this"
+		echo "100644 $H 1	track-this" &&
 		echo "100644 $H 3	track-this"
 	) | git update-index --index-info &&
 	echo track-this >>.gitignore &&
-- 
2.18.0.419.gfe4b301394

