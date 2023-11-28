Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx9G1ZNP"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055696FA8
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 13:17:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40838915cecso42715475e9.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 13:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701206269; x=1701811069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o0RUW84PRlHuT0INqB2vriZCtwp15Al0wkOBr7GheM=;
        b=Qx9G1ZNPa/j4tqy6SQc3MyUsOx6xzqZYIlkOXJ7sUmZcO42tUDCaMcq4AnkZZshta6
         q9bKHLQniGXQRigDzhDdS3gO5JQ7TWsUrVkpPLlU9is0bw6A2E6UxtHckk7ewuJq1rvO
         gAanEm6VcomHvT3oYDeVeY/plmxh4VMZF4/4XOjRkCec4k6d5oHUBBQsb3RwSENmOCC8
         pZR+1DWeMT4bvzX47IaYuJ3epfWokTKqoiWrwc5Vjsuv2bS0A0ODMthCgIdIpczuvoqc
         /Vm8F4cWYi1HiAfUrXI69MY7+rC4iWK1AkV3LkMKIKmM7lmqqjjXjuY97nXbXE6lvMkT
         gBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206269; x=1701811069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o0RUW84PRlHuT0INqB2vriZCtwp15Al0wkOBr7GheM=;
        b=bMJt0rQFm00A8H3sF6/qVTvTlJt6apzVk5EE1ca2vXFbOdd5x9pvRAeIIcbGb7CK79
         WlMcQXHw97ckL/LflLwxZDbdaEm77PiXMaKl3IgiIcAKLoDyyNUpDf8IrDc34/K2ljRT
         +zQOBZLigpJWzB7CglTWLqunDELYuGF0obPbiFfBlU1FFzHFCDRARlfiC/FtJoN4wTbw
         4zf06qt53CDa3u4NJ5Brz15XGTu5sGmfZK/Trtkw6TJ2VgHwZlCQekpGMcQbyLldC+Zw
         8iIFCu4AqhyXNdRTHXElppz+uLPScY7A8sFc4i+WQ6e2tRXLgfh3XLo0LhHCMsU05FSL
         DYyg==
X-Gm-Message-State: AOJu0YxRieJCdLXEDqpwI1xyxFHcVSg7g8yEXKFBY5CNzCrQdYlXh6s1
	GAMxVaFRISN8kmRHbB/pTz0V3dfiHmA=
X-Google-Smtp-Source: AGHT+IEdl6IAOb6acrBDupJLLCxEx1/3jf37NypWvVzrcHKj1zO3CJx8c1Zs2CcK5qMW1JBZQ8RiiA==
X-Received: by 2002:a5d:440a:0:b0:333:db9:47da with SMTP id z10-20020a5d440a000000b003330db947damr2330148wrq.64.1701206268556;
        Tue, 28 Nov 2023 13:17:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b00332c6a52040sm15879244wrt.100.2023.11.28.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:17:48 -0800 (PST)
Message-ID: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
References: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
From: "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Nov 2023 21:17:47 +0000
Subject: [PATCH v5] subtree: fix split processing with multiple subtrees
 present
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
    Zach FettersMoore <zach.fetters@apollographql.com>,
    Zach FettersMoore <zach.fetters@apollographql.com>

From: Zach FettersMoore <zach.fetters@apollographql.com>

When there are multiple subtrees present in a repository and they are
all using 'git subtree split', the 'split' command can take a
significant (and constantly growing) amount of time to run even when
using the '--rejoin' flag. This is due to the fact that when processing
commits to determine the last known split to start from when looking
for changes, if there has been a split/merge done from another subtree
there will be 2 split commits, one mainline and one subtree, for the
second subtree that are part of the processing. The non-mainline
subtree split commit will cause the processing to always need to search
the entire history of the given subtree as part of its processing even
though those commits are totally irrelevant to the current subtree
split being run.

To see this in practice you can use the open source GitHub repo
'apollo-ios-dev' and do the following in order:

-Make a changes to a file in 'apollo-ios'A and 'apollo-ios-codegen'
 directories
-Create a commit containing these changes
-Do a split on apollo-ios-codegen
   - git subtree split --prefix=apollo-ios-codegen --squash --rejoin
-Do a split on apollo-ios
   - git subtree split --prefix=apollo-ios --squash --rejoin
-Make changes to a file in apollo-ios-codegen
-Create a commit containing the change(s)
-Do a split on apollo-ios-codegen
   - git subtree split --prefix=apollo-ios-codegen --squash --rejoin

You will see that the final split is looking for the last split
on apollo-ios-codegen to use as it's starting point to process
commits. Since there is a split commit from apollo-ios in between the
2 splits run on apollo-ios-codegen, the processing ends up traversing
the entire history of apollo-ios which increases the time it takes to
do a split based on how long of a history apollo-ios has, while none
of these commits are relevant to the split being done on
apollo-ios-codegen.

So this commit makes a change to the processing of commits for the
split command in order to ignore non-mainline commits from other
subtrees such as apollo-ios in the above breakdown by adding a new
function 'should_ignore_subtree_commit' which is called during
'process_split_commit'. This allows the split/rejoin processing to
still function as expected but removes all of the unnecessary
processing that takes place currently which greatly inflates the
processing time. In the above example, previously the final split
would take ~10-12 minutes, while after this fix it takes seconds.

Added a test to validate that the proposed fix
solves the issue.

The test accomplishes this by checking the output
of the split command to ensure the output from
the progress of 'process_split_commit' function
that represents the 'extracount' of commits
processed remains at 0, meaning none of the commits
from the second subtree were processed.

This was tested against the original functionality
to show the test failed, and then with this fix
to show the test passes.

This illustrated that when using multiple subtrees,
A and B, when doing a split on subtree B, the
processing does not traverse the entire history
of subtree A which is unnecessary and would cause
the 'extracount' of processed commits to climb
based on the number of commits in the history of
subtree A.

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
    subtree: fix split processing with multiple subtrees present
    
    When there are multiple subtrees in a repo and git subtree split
    --rejoin is being used for the subtrees, the processing of commits for a
    new split can take a significant (and constantly growing) amount of time
    because the split commits from other subtrees cause the processing to
    have to scan the entire history of the other subtree(s). This patch
    filters out the other subtree split commits that are unnecessary for the
    split commit processing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1587%2FBobaFetters%2Fzf%2Fmulti-subtree-processing-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1587/BobaFetters/zf/multi-subtree-processing-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1587

Range-diff vs v4:

 1:  353152910eb ! 1:  e7445a95f30 subtree: fix split processing with multiple subtrees present
     @@ Commit message
          though those commits are totally irrelevant to the current subtree
          split being run.
      
     -    In the diagram below, 'M' represents the mainline repo branch, 'A'
     -    represents one subtree, and 'B' represents another. M3 and B1 represent
     -    a split commit for subtree B that was created from commit M4. M2 and A1
     -    represent a split commit made from subtree A that was also created
     -    based on changes back to and including M4. M1 represents new changes to
     -    the repo, in this scenario if you try to run a 'git subtree split
     -    --rejoin' for subtree B, commits M1, M2, and A1, will be included in
     -    the processing of changes for the new split commit since the last
     -    split/rejoin for subtree B was at M3. The issue is that by having A1
     -    included in this processing the command ends up needing to processing
     -    every commit down tree A even though none of that is needed or relevant
     -    to the current command and result.
     +    To see this in practice you can use the open source GitHub repo
     +    'apollo-ios-dev' and do the following in order:
      
     -    M1
     -     |        \       \
     -    M2         |       |
     -     |        A1       |
     -    M3         |       |
     -     |         |      B1
     -    M4         |       |
     +    -Make a changes to a file in 'apollo-ios'A and 'apollo-ios-codegen'
     +     directories
     +    -Create a commit containing these changes
     +    -Do a split on apollo-ios-codegen
     +       - git subtree split --prefix=apollo-ios-codegen --squash --rejoin
     +    -Do a split on apollo-ios
     +       - git subtree split --prefix=apollo-ios --squash --rejoin
     +    -Make changes to a file in apollo-ios-codegen
     +    -Create a commit containing the change(s)
     +    -Do a split on apollo-ios-codegen
     +       - git subtree split --prefix=apollo-ios-codegen --squash --rejoin
      
     -    So this commit makes a change to the processing of commits for the split
     -    command in order to ignore non-mainline commits from other subtrees such
     -    as A1 in the diagram by adding a new function
     -    'should_ignore_subtree_commit' which is called during
     -    'process_split_commit'. This allows the split/rejoin processing to still
     -    function as expected but removes all of the unnecessary processing that
     -    takes place currently which greatly inflates the processing time.
     +    You will see that the final split is looking for the last split
     +    on apollo-ios-codegen to use as it's starting point to process
     +    commits. Since there is a split commit from apollo-ios in between the
     +    2 splits run on apollo-ios-codegen, the processing ends up traversing
     +    the entire history of apollo-ios which increases the time it takes to
     +    do a split based on how long of a history apollo-ios has, while none
     +    of these commits are relevant to the split being done on
     +    apollo-ios-codegen.
     +
     +    So this commit makes a change to the processing of commits for the
     +    split command in order to ignore non-mainline commits from other
     +    subtrees such as apollo-ios in the above breakdown by adding a new
     +    function 'should_ignore_subtree_commit' which is called during
     +    'process_split_commit'. This allows the split/rejoin processing to
     +    still function as expected but removes all of the unnecessary
     +    processing that takes place currently which greatly inflates the
     +    processing time. In the above example, previously the final split
     +    would take ~10-12 minutes, while after this fix it takes seconds.
      
          Added a test to validate that the proposed fix
          solves the issue.
     @@ Commit message
          of the split command to ensure the output from
          the progress of 'process_split_commit' function
          that represents the 'extracount' of commits
     -    processed does not increment.
     +    processed remains at 0, meaning none of the commits
     +    from the second subtree were processed.
      
          This was tested against the original functionality
          to show the test failed, and then with this fix
     @@ contrib/subtree/git-subtree.sh: ensure_valid_ref_format () {
      +# Usage: check if a commit from another subtree should be
      +# ignored from processing for splits
      +should_ignore_subtree_split_commit () {
     -+  if test -n "$(git log -1 --grep="git-subtree-dir:" $1)"
     -+  then
     -+    if test -z "$(git log -1 --grep="git-subtree-mainline:" $1)" &&
     -+			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $1)"
     -+    then
     -+      return 0
     -+    fi
     -+  fi
     -+  return 1
     ++	assert test $# = 1
     ++	local rev="$1"
     ++	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
     ++	then
     ++		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
     ++			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
     ++		then
     ++			return 0
     ++		fi
     ++	fi
     ++	return 1
      +}
      +
       # Usage: process_split_commit REV PARENTS
     @@ contrib/subtree/git-subtree.sh: cmd_split () {
      +		then
      +			continue
      +		fi
     -+		parsedParents=''
     ++		parsedparents=''
      +		for parent in $parents
      +		do
     -+			should_ignore_subtree_split_commit "$parent"
     -+			if test $? -eq 1
     ++			if ! should_ignore_subtree_split_commit "$parent"
      +			then
     -+				parsedParents+="$parent "
     ++				parsedparents="$parsedparents$parent "
      +			fi
      +		done
     -+		process_split_commit "$rev" "$parsedParents"
     ++		process_split_commit "$rev" "$parsedparents"
       	done || exit $?
       
       	latest_new=$(cache_get latest_new) || exit $?
     @@ contrib/subtree/t/t7900-subtree.sh: test_expect_success 'split sub dir/ with --r
       	)
       '
       
     ++# Tests that commits from other subtrees are not processed as
     ++# part of a split.
     ++#
     ++# This test performs the following:
     ++# - Creates Repo with subtrees 'subA' and 'subB'
     ++# - Creates commits in the repo including changes to subtrees
     ++# - Runs the following 'split' and commit' commands in order:
     ++# 	- Perform 'split' on subtree A
     ++# 	- Perform 'split' on subtree B
     ++# 	- Create new commits with changes to subtree A and B
     ++# 	- Perform split on subtree A
     ++# 	- Check that the commits in subtree B are not processed
     ++#			as part of the subtree A split
      +test_expect_success 'split with multiple subtrees' '
      +	subtree_test_create_repo "$test_count" &&
      +	subtree_test_create_repo "$test_count/subA" &&
     @@ contrib/subtree/t/t7900-subtree.sh: test_expect_success 'split sub dir/ with --r
      +	test_create_commit "$test_count/subA" subA2 &&
      +	test_create_commit "$test_count/subA" subA3 &&
      +	test_create_commit "$test_count/subB" subB1 &&
     -+	(
     -+		cd "$test_count" &&
     -+		git fetch ./subA HEAD &&
     -+		git subtree add --prefix=subADir FETCH_HEAD
     -+	) &&
     -+	(
     -+		cd "$test_count" &&
     -+		git fetch ./subB HEAD &&
     -+		git subtree add --prefix=subBDir FETCH_HEAD
     -+	) &&
     ++	git -C "$test_count" fetch ./subA HEAD &&
     ++	git -C "$test_count" subtree add --prefix=subADir FETCH_HEAD &&
     ++	git -C "$test_count" fetch ./subB HEAD &&
     ++	git -C "$test_count" subtree add --prefix=subBDir FETCH_HEAD &&
      +	test_create_commit "$test_count" subADir/main-subA1 &&
      +	test_create_commit "$test_count" subBDir/main-subB1 &&
     -+	(
     -+		cd "$test_count" &&
     -+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 1"
     -+	) &&
     -+	(
     -+		cd "$test_count" &&
     -+		git subtree split --prefix=subBDir --squash --rejoin -m "Sub B Split 1"
     -+	) &&
     ++	git -C "$test_count" subtree split --prefix=subADir \
     ++		--squash --rejoin -m "Sub A Split 1" &&
     ++	git -C "$test_count" subtree split --prefix=subBDir \
     ++		--squash --rejoin -m "Sub B Split 1" &&
      +	test_create_commit "$test_count" subADir/main-subA2 &&
      +	test_create_commit "$test_count" subBDir/main-subB2 &&
     -+	(
     -+		cd "$test_count" &&
     -+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 2"
     -+	) &&
     -+	(
     -+		cd "$test_count" &&
     -+		test "$(git subtree split --prefix=subBDir --squash --rejoin \
     -+		 -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
     -+	)
     ++	git -C "$test_count" subtree split --prefix=subADir \
     ++		--squash --rejoin -m "Sub A Split 2" &&
     ++	test "$(git -C "$test_count" subtree split --prefix=subBDir \
     ++		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
      +'
      +
       test_expect_success 'split sub dir/ with --rejoin from scratch' '


 contrib/subtree/git-subtree.sh     | 30 +++++++++++++++++++++-
 contrib/subtree/t/t7900-subtree.sh | 40 ++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e0c5d3b0de6..a0bf958ea66 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -778,6 +778,22 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
+# Usage: check if a commit from another subtree should be
+# ignored from processing for splits
+should_ignore_subtree_split_commit () {
+	assert test $# = 1
+	local rev="$1"
+	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
+	then
+		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
+			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
+		then
+			return 0
+		fi
+	fi
+	return 1
+}
+
 # Usage: process_split_commit REV PARENTS
 process_split_commit () {
 	assert test $# = 2
@@ -963,7 +979,19 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents"
+		if should_ignore_subtree_split_commit "$rev"
+		then
+			continue
+		fi
+		parsedparents=''
+		for parent in $parents
+		do
+			if ! should_ignore_subtree_split_commit "$parent"
+			then
+				parsedparents="$parsedparents$parent "
+			fi
+		done
+		process_split_commit "$rev" "$parsedparents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 49a21dd7c9c..ca4df5be832 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -385,6 +385,46 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	)
 '
 
+# Tests that commits from other subtrees are not processed as
+# part of a split.
+#
+# This test performs the following:
+# - Creates Repo with subtrees 'subA' and 'subB'
+# - Creates commits in the repo including changes to subtrees
+# - Runs the following 'split' and commit' commands in order:
+# 	- Perform 'split' on subtree A
+# 	- Perform 'split' on subtree B
+# 	- Create new commits with changes to subtree A and B
+# 	- Perform split on subtree A
+# 	- Check that the commits in subtree B are not processed
+#			as part of the subtree A split
+test_expect_success 'split with multiple subtrees' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/subA" &&
+	subtree_test_create_repo "$test_count/subB" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subA" subA1 &&
+	test_create_commit "$test_count/subA" subA2 &&
+	test_create_commit "$test_count/subA" subA3 &&
+	test_create_commit "$test_count/subB" subB1 &&
+	git -C "$test_count" fetch ./subA HEAD &&
+	git -C "$test_count" subtree add --prefix=subADir FETCH_HEAD &&
+	git -C "$test_count" fetch ./subB HEAD &&
+	git -C "$test_count" subtree add --prefix=subBDir FETCH_HEAD &&
+	test_create_commit "$test_count" subADir/main-subA1 &&
+	test_create_commit "$test_count" subBDir/main-subB1 &&
+	git -C "$test_count" subtree split --prefix=subADir \
+		--squash --rejoin -m "Sub A Split 1" &&
+	git -C "$test_count" subtree split --prefix=subBDir \
+		--squash --rejoin -m "Sub B Split 1" &&
+	test_create_commit "$test_count" subADir/main-subA2 &&
+	test_create_commit "$test_count" subBDir/main-subB2 &&
+	git -C "$test_count" subtree split --prefix=subADir \
+		--squash --rejoin -m "Sub A Split 2" &&
+	test "$(git -C "$test_count" subtree split --prefix=subBDir \
+		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
+'
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
-- 
gitgitgadget
