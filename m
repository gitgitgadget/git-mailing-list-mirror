Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA82620958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964849AbdCWP3k (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34139 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbdCWP3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id y90so7894705wrb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Jx3uA3P0GUJy/9wPuMjIrvj/v6UJN9CZ/+EvwNs+oo=;
        b=XcPdeyvQug9pIZLnKHbOqSDU1eXfK1SYamJnixhb1SX0c8zegyluKX5Ij+S6iDRf6q
         IDUElLzoclaFg3B61J7pVs3h8SQXyNqrVTgUx5zPiRHSLIHxw0vj1o81fa5XiLB+29AU
         nvaJHvMnZ7DpcCKXHC22aYVZw1J8FZhF7HDFu3BMFCK72dsBJavVfUyuC+PcIXzRyGgs
         151QiYWFCYzopOZ/83Bb48eZ+rSofZP0BdLS3Iu833kCQXyZocNFovnsiroauGQ/GkK1
         XsPS4kif+b27SW8NH1U1mkFV+T/qSsZ8P3gZDrfFhEAP6MMHseyUXfaY8GMAi/+wf/CC
         RGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Jx3uA3P0GUJy/9wPuMjIrvj/v6UJN9CZ/+EvwNs+oo=;
        b=PufVbSqkhIbXQY+DA/aHJprRFHCqC2GWXwrYoAeAvQvfnHuYu7J3EYvdIg5WLHWsQ3
         xNQUuydgywWwEjQajYW6MiRxxwzlcIwrHEhGPgcj+gvsw8S9Nfn8ccZRlW1FFq14O7L8
         0Nam2/7SSiR6CSdmvm177lz34U7KwtrrE3iogqlvJUHuFHJgXuoBS9rrgY7ixQTNuk6x
         oRoVaOhoh/f/lk8CKrX1vHjGtNSUTxjO/QNfjf+7S20+eupLZdqjONrQMejNyEFhAPSu
         8R+izjZkdbSPUL8/Geop8HCw/0gkt35AMlr8lvGUg0ouW/sUulSE6qJIt3qGKvWxRc7a
         UUiQ==
X-Gm-Message-State: AFeK/H2rOnP1+AXLlp2Iz/G8+18Y1CkF0kPYzzKs44dazeh6LMGSvODjdLLmdLgSOHB1zA==
X-Received: by 10.223.175.103 with SMTP id z94mr3196003wrc.3.1490282976116;
        Thu, 23 Mar 2017 08:29:36 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 00/14] completion: speed up refs completion
Date:   Thu, 23 Mar 2017 16:29:10 +0100
Message-Id: <20170323152924.23944-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is the updated version of 'sg/completion-refs-speedup'.
It speeds up refs completion for large number of refs, partly by
giving up disambiguating ambiguous refs and partly by eliminating most
of the shell processing between 'git for-each-ref' and 'ls-remote' and
Bash's completion facility.  The rest is a bit of preparatory
reorganization, cleanup and bugfixes.

Changes since v1:

  - Patch 8 (let 'for-each-ref' and 'ls-remote' filter matching refs;
    it was patch 7 in v1) was modified in two ways:
    
    * __git_refs() now does that filtering only when the ref to match
      was explicitly given as parameter, as opposed to falling back to
      the current word to be completed.  The current word might be
      something like '--opt=maste', and in the fallback case we would
      then list only refs matching '--opt=maste', which is of course
      wrong.  Most of the subsequent patches had to be adjusted
      because of conflicts.

    * patch 11 (list only matching symbolic and pseudorefs when
      completing refs) was squashed into patch 8.  There was no reason
      to keep the two patches separate, and the docstring was
      inconsistent between the two patches.

  - Patch 12 now incorporates the squash! patch I sent out earlier
    [1].

  - Patch 4 (support completing fully qualified non-fast-forward
    refspecs) is new, to fix a bug that is similar in nature to the
    one fixed in patch 3.

  - Patches 13 and 14 are new and make use of the new and faster
    __gitcomp_direct() for branches, tags, and fetch refspecs.

  - Some new tests run 'sed s/Z$//g'.  Remove that 'g', because there
    is no point to ask to replace all instances of the match, when it
    matches only at the end of line.

  - A teardown test forgot to delete a branch.

[1] - http://public-inbox.org/git/20170206181545.12869-1-szeder.dev@gmail.com/

SZEDER Gábor (14):
  completion: remove redundant __gitcomp_nl() options from _git_commit()
  completion: wrap __git_refs() for better option parsing
  completion: support completing full refs after '--option=refs/<TAB>'
  completion: support completing fully qualified non-fast-forward
    refspecs
  completion: support excluding full refs
  completion: don't disambiguate tags and branches
  completion: don't disambiguate short refs
  completion: let 'for-each-ref' and 'ls-remote' filter matching refs
  completion: let 'for-each-ref' strip the remote name from remote
    branches
  completion: let 'for-each-ref' filter remote branches for 'checkout'
    DWIMery
  completion: let 'for-each-ref' sort remote branches for 'checkout'
    DWIMery
  completion: fill COMPREPLY directly when completing refs
  completion: fill COMPREPLY directly when completing fetch refspecs
  completion: speed up branch and tag completion

 contrib/completion/git-completion.bash | 252 +++++++++++++++------
 contrib/completion/git-completion.zsh  |   9 +
 t/t9902-completion.sh                  | 387 +++++++++++++++++++++++++++++++++
 3 files changed, 577 insertions(+), 71 deletions(-)

-- 
2.12.1.485.g1616aa492

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 56ededb09..bd07d9a74 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -352,14 +352,27 @@ __git_index_files ()
 	done | sort | uniq
 }
 
+# Lists branches from the local repository.
+# 1: A prefix to be added to each listed branch (optional).
+# 2: List only branches matching this word (optional; list all branches if
+#    unset or empty).
+# 3: A suffix to be appended to each listed branch (optional).
 __git_heads ()
 {
-	__git for-each-ref --format='%(refname:strip=2)' refs/heads
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+
+	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
 
+# Lists tags from the local repository.
+# Accepts the same positional parameters as __git_heads() above.
 __git_tags ()
 {
-	__git for-each-ref --format='%(refname:strip=2)' refs/tags
+	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+
+	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
 
 # Lists refs from the local (by default) or from a remote repository.
@@ -369,8 +382,8 @@ __git_tags ()
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 # 3: A prefix to be added to each listed ref (optional).
-# 4: List only refs matching this word instead of the current word being
-#    completed (optional; NOT ignored, if empty, but lists all refs).
+# 4: List only refs matching this word (optional; list all refs if unset or
+#    empty).
 # 5: A suffix to be appended to each listed ref (optional; ignored, if set
 #    but empty).
 #
@@ -381,7 +394,8 @@ __git_refs ()
 	local list_refs_from=path remote="${1-}"
 	local format refs
 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
-	local fer_pfx="${pfx//\%/%%}"
+	local match="${4-}"
+	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -409,26 +423,28 @@ __git_refs ()
 			pfx="$pfx^"
 			fer_pfx="$fer_pfx^"
 			cur_=${cur_#^}
+			match=${match#^}
 		fi
 		case "$cur_" in
 		refs|refs/*)
 			format="refname"
-			refs=("$cur_*" "$cur_*/**")
+			refs=("$match*" "$match*/**")
 			track=""
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				case "$i" in
-				$cur_*)	if [ -e "$dir/$i" ]; then
+				$match*)
+					if [ -e "$dir/$i" ]; then
 						echo "$pfx$i$sfx"
 					fi
 					;;
 				esac
 			done
 			format="refname:strip=2"
-			refs=("refs/tags/$cur_*" "refs/tags/$cur_*/**"
-				"refs/heads/$cur_*" "refs/heads/$cur_*/**"
-				"refs/remotes/$cur_*" "refs/remotes/$cur_*/**")
+			refs=("refs/tags/$match*" "refs/tags/$match*/**"
+				"refs/heads/$match*" "refs/heads/$match*/**"
+				"refs/remotes/$match*" "refs/remotes/$match*/**")
 			;;
 		esac
 		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
@@ -439,14 +455,14 @@ __git_refs ()
 			# but only output if the branch name is unique
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				--sort="refname:strip=3" \
-				"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
+				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
 			uniq -u
 		fi
 		return
 	fi
 	case "$cur_" in
 	refs|refs/*)
-		__git ls-remote "$remote" "$cur_*" | \
+		__git ls-remote "$remote" "$match*" | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -457,19 +473,19 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			case "HEAD" in
-			$cur_*)	echo "${pfx}HEAD$sfx" ;;
+			$match*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
-				"refs/remotes/$remote/$cur_*" \
-				"refs/remotes/$remote/$cur_*/**"
+				"refs/remotes/$remote/$match*" \
+				"refs/remotes/$remote/$match*/**"
 		else
 			local query_symref
 			case "HEAD" in
-			$cur_*)	query_symref="HEAD" ;;
+			$match*)	query_symref="HEAD" ;;
 			esac
 			__git ls-remote "$remote" $query_symref \
-				"refs/tags/$cur_*" "refs/heads/$cur_*" \
-				"refs/remotes/$cur_*" |
+				"refs/tags/$match*" "refs/heads/$match*" \
+				"refs/remotes/$match*" |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
@@ -513,6 +529,7 @@ __git_complete_refs ()
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
+# Deprecated: use __git_complete_fetch_refspecs() instead.
 __git_refs2 ()
 {
 	local i
@@ -521,6 +538,24 @@ __git_refs2 ()
 	done
 }
 
+# Completes refspecs for fetching from a remote repository.
+# 1: The remote repository.
+# 2: A prefix to be added to each listed refspec (optional).
+# 3: The ref to be completed as a refspec instead of the current word to be
+#    completed (optional)
+# 4: A suffix to be appended to each listed refspec instead of the default
+#    space (optional).
+__git_complete_fetch_refspecs ()
+{
+	local i remote="$1" pfx="${2-}" cur_="${3-$cur}" sfx="${4- }"
+
+	__gitcomp_direct "$(
+		for i in $(__git_refs "$remote" "" "" "$cur_") ; do
+			echo "$pfx$i:$i$sfx"
+		done
+		)"
+}
+
 # __git_refs_remotes requires 1 argument (to pass to ls-remote)
 __git_refs_remotes ()
 {
@@ -713,7 +748,7 @@ __git_complete_remote_or_refspec ()
 	case "$cmd" in
 	fetch)
 		if [ $lhs = 1 ]; then
-			__gitcomp_nl "$(__git_refs2 "$remote")" "$pfx" "$cur_"
+			__git_complete_fetch_refspecs "$remote" "$pfx" "$cur_"
 		else
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
@@ -1161,7 +1196,7 @@ _git_branch ()
 		;;
 	*)
 		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
-			__gitcomp_nl "$(__git_heads)"
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
 		else
 			__git_complete_refs
 		fi
@@ -2156,7 +2191,7 @@ _git_config ()
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autosetupmerge\nautosetuprebase\n' "$pfx" "$cur_"
 		return
 		;;
@@ -2802,7 +2837,7 @@ _git_tag ()
 		i="${words[c]}"
 		case "$i" in
 		-d|-v)
-			__gitcomp_nl "$(__git_tags)"
+			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 			return
 			;;
 		-f)
@@ -2817,7 +2852,7 @@ _git_tag ()
 		;;
 	-*|tag)
 		if [ $f = 1 ]; then
-			__gitcomp_nl "$(__git_tags)"
+			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
 		fi
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index be584c069..5ed28135b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -571,6 +571,9 @@ test_expect_success '__git_refs - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/master
 	refs/heads/matching-branch
+	refs/remotes/other/branch-in-other
+	refs/remotes/other/master-in-other
+	refs/tags/matching-tag
 	EOF
 	(
 		cur=refs/heads/ &&
@@ -636,6 +639,7 @@ test_expect_success '__git_refs - configured remote' '
 
 test_expect_success '__git_refs - configured remote - full refs' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -664,6 +668,7 @@ test_expect_success '__git_refs - configured remote - repo given on the command
 
 test_expect_success '__git_refs - configured remote - full refs - repo given on the command line' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -708,6 +713,7 @@ test_expect_success '__git_refs - URL remote' '
 
 test_expect_success '__git_refs - URL remote - full refs' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -861,6 +867,25 @@ test_expect_success 'setup for filtering matching refs' '
 	rm -f .git/FETCH_HEAD
 '
 
+test_expect_success '__git_refs - dont filter refs unless told so' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	matching-branch
+	matching/branch
+	other/branch-in-other
+	other/master-in-other
+	other/matching/branch-in-other
+	matching-tag
+	matching/tag
+	EOF
+	(
+		cur=master &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_refs - only matching refs' '
 	cat >expected <<-EOF &&
 	matching-branch
@@ -870,7 +895,7 @@ test_expect_success '__git_refs - only matching refs' '
 	EOF
 	(
 		cur=mat &&
-		__git_refs >"$actual"
+		__git_refs "" "" "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -882,7 +907,7 @@ test_expect_success '__git_refs - only matching refs - full refs' '
 	EOF
 	(
 		cur=refs/heads/mat &&
-		__git_refs >"$actual"
+		__git_refs "" "" "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -894,7 +919,7 @@ test_expect_success '__git_refs - only matching refs - remote on local file syst
 	EOF
 	(
 		cur=ma &&
-		__git_refs otherrepo >"$actual"
+		__git_refs otherrepo "" "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -906,7 +931,7 @@ test_expect_success '__git_refs - only matching refs - configured remote' '
 	EOF
 	(
 		cur=ma &&
-		__git_refs other >"$actual"
+		__git_refs other "" "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -918,7 +943,7 @@ test_expect_success '__git_refs - only matching refs - remote - full refs' '
 	EOF
 	(
 		cur=refs/heads/ma &&
-		__git_refs other >"$actual"
+		__git_refs other "" "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -940,7 +965,7 @@ test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
 	done &&
 	(
 		cur=mat &&
-		__git_refs "" 1 >"$actual"
+		__git_refs "" 1 "" "$cur" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -948,7 +973,8 @@ test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
 test_expect_success 'teardown after filtering matching refs' '
 	git branch -d matching/branch &&
 	git tag -d matching/tag &&
-	git update-ref -d refs/remotes/other/matching/branch-in-other
+	git update-ref -d refs/remotes/other/matching/branch-in-other &&
+	git -C otherrepo branch -D matching/branch-in-other
 '
 
 test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
@@ -963,7 +989,7 @@ test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
 '
 
 test_expect_success '__git_complete_refs - simple' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
 	master Z
 	matching-branch Z
@@ -980,7 +1006,7 @@ test_expect_success '__git_complete_refs - simple' '
 '
 
 test_expect_success '__git_complete_refs - matching' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	matching-branch Z
 	matching-tag Z
 	EOF
@@ -993,7 +1019,7 @@ test_expect_success '__git_complete_refs - matching' '
 '
 
 test_expect_success '__git_complete_refs - remote' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
 	branch-in-other Z
 	master-in-other Z
@@ -1007,7 +1033,7 @@ test_expect_success '__git_complete_refs - remote' '
 '
 
 test_expect_success '__git_complete_refs - track' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
 	master Z
 	matching-branch Z
@@ -1026,7 +1052,7 @@ test_expect_success '__git_complete_refs - track' '
 '
 
 test_expect_success '__git_complete_refs - current word' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	matching-branch Z
 	matching-tag Z
 	EOF
@@ -1039,7 +1065,7 @@ test_expect_success '__git_complete_refs - current word' '
 '
 
 test_expect_success '__git_complete_refs - prefix' '
-	sed -e "s/Z$//g" >expected <<-EOF &&
+	sed -e "s/Z$//" >expected <<-EOF &&
 	v1.0..matching-branch Z
 	v1.0..matching-tag Z
 	EOF
@@ -1068,6 +1094,74 @@ test_expect_success '__git_complete_refs - suffix' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_fetch_refspecs - simple' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	HEAD:HEAD Z
+	branch-in-other:branch-in-other Z
+	master-in-other:master-in-other Z
+	EOF
+	(
+		cur= &&
+		__git_complete_fetch_refspecs other &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - matching' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	branch-in-other:branch-in-other Z
+	EOF
+	(
+		cur=br &&
+		__git_complete_fetch_refspecs other "" br &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - prefix' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	+HEAD:HEAD Z
+	+branch-in-other:branch-in-other Z
+	+master-in-other:master-in-other Z
+	EOF
+	(
+		cur="+" &&
+		__git_complete_fetch_refspecs other "+" ""  &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	refs/heads/branch-in-other:refs/heads/branch-in-other Z
+	refs/heads/master-in-other:refs/heads/master-in-other Z
+	refs/tags/tag-in-other:refs/tags/tag-in-other Z
+	EOF
+	(
+		cur=refs/ &&
+		__git_complete_fetch_refspecs other "" refs/ &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	+refs/heads/branch-in-other:refs/heads/branch-in-other Z
+	+refs/heads/master-in-other:refs/heads/master-in-other Z
+	+refs/tags/tag-in-other:refs/tags/tag-in-other Z
+	EOF
+	(
+		cur=+refs/ &&
+		__git_complete_fetch_refspecs other + refs/ &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
