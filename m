Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC7920958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965137AbdCWP35 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36147 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964964AbdCWP3p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so17314104wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5f5VV46SofyFJxkW0YCuL/acrkwNsOhpegcQPYfT+c=;
        b=MR1XNk49+V/giZjVVdCROZXBrZQrfDY166LMck6LISmpcZefSmqZ74uMgyMdxGXON1
         NtnDOLbTy925PLEfV/OCoEzWImu6wrqZF7Nh85h00fYypODzOWfImy4TPxK3M7us09FZ
         ZODrEVTa6N2eTddzoy+On8fuwEVJniZNToSkZuN7VrzVKekTVpfnKZnMu7SHqxPmB3LE
         1XX/enSDKxhfWHQleM4bMy9trwfCW2zCNkjOCNB1att7gRR3+8FPqgrWUtZdo2AM+7ly
         va+doMWNVibEH/JnGIZkD1JXwlvHtoC3rUcTcsslLA5vjVMDoDd51yXU3FCCiXXucsoG
         zbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5f5VV46SofyFJxkW0YCuL/acrkwNsOhpegcQPYfT+c=;
        b=uZb56LH5qPISJ3+BeZHatlQbQwjSa6+oKiuSuEKaZCkxj+YKZ2JnmqR7NUlPdYzEtY
         Gv9vWiXm7m+jKE56V0YYrqC3FiX3UNMwTC3yq1ilwSnvqp0TVNz+Hb69PipP3zDSgVR4
         YbqvOarrkSk20YBX0w0PyIp/H3TkPE2hOGW8LJe18NyzSQyG4lzDn4b0PvoRc108Rcp4
         6AE/hZgZ4yC4pEIsIeFS67ITF/65ly4OyTxrrjHQz7EMYaeisnfOYI6aJwRszBY+jwrG
         VEgWE1+o8fC7UWzMXJ2DPnt+QOLKpycmIhidsD9GPSLQsgxPOGEp1hedfyV6ebcGeS/1
         AL2Q==
X-Gm-Message-State: AFeK/H0uryw7BdVjxIxf8S+vYNkWudK4lDa5/+XVY0PvTQXXHQz1DxdrzUnCjGrvNiQAxg==
X-Received: by 10.28.187.213 with SMTP id l204mr12828204wmf.104.1490282983095;
        Thu, 23 Mar 2017 08:29:43 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 08/14] completion: let 'for-each-ref' and 'ls-remote' filter matching refs
Date:   Thu, 23 Mar 2017 16:29:18 +0100
Message-Id: <20170323152924.23944-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When completing refs, several __git_refs() code paths list all the
refs from the refs/{heads,tags,remotes}/ hierarchy and then
__gitcomp_nl() iterates over those refs in a shell loop to filter out
refs not matching the current ref to be completed.  This comes with a
considerable performance penalty when a repository contains a lot of
refs but the current ref can be uniquely completed or when only a
handful of refs match the current ref.

Reduce the number of iterations in __gitcomp_nl() from the number of
refs to the number of matching refs by specifying appropriate globbing
patterns to 'git for-each-ref' and 'git ls-remote' to list only those
refs that match the current ref to be completed.  However, do so only
when the ref to match is explicitly given as parameter, because the
current word on the command line might contain a prefix like
'--option=' or 'branch..'.  The __git_complete_refs() and
__git_complete_fetch_refspecs() helpers introduced previously in this
patch series already call __git_refs() specifying this current ref
parameter, so all their callsites, i.e. all places in the completion
script doing refs completion, can benefit from this optimization.

Furthermore, list only those symbolic and pseudo refs that match the
current ref to be completed.  Though it doesn't matter at all in
itself performance-wise, it will allow us further significant
optimizations later in this series.

This speeds up refs completion considerably when there are a lot of
non-matching refs to be filtered out.  Uniquely completing a branch in
a repository with 100k local branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --cur=maste

    real    0m0.831s
    user    0m0.808s
    sys     0m0.028s

  After:

    real    0m0.119s
    user    0m0.104s
    sys     0m0.008s

  On Windows, before:

    real    0m1.480s
    user    0m1.031s
    sys     0m0.060s

  After:

    real    0m0.377s
    user    0m0.015s
    sys     0m0.030s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash |  41 ++++++++---
 t/t9902-completion.sh                  | 124 +++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5ee35d530..976f80598 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,7 +355,8 @@ __git_tags ()
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 # 3: Currently ignored.
-# 4: The current ref to be completed (optional).
+# 4: List only refs matching this word (optional; list all refs if unset or
+#    empty).
 #
 # Use __git_complete_refs() instead.
 __git_refs ()
@@ -364,6 +365,7 @@ __git_refs ()
 	local list_refs_from=path remote="${1-}"
 	local format refs pfx
 	local cur_="${4-$cur}"
+	local match="${4-}"
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -390,23 +392,32 @@ __git_refs ()
 		if [[ "$cur_" == ^* ]]; then
 			pfx="^"
 			cur_=${cur_#^}
+			match=${match#^}
 		fi
 		case "$cur_" in
 		refs|refs/*)
 			format="refname"
-			refs="${cur_%/*}"
+			refs=("$match*" "$match*/**")
 			track=""
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
-				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
+				case "$i" in
+				$match*)
+					if [ -e "$dir/$i" ]; then
+						echo $pfx$i
+					fi
+					;;
+				esac
 			done
 			format="refname:strip=2"
-			refs="refs/tags refs/heads refs/remotes"
+			refs=("refs/tags/$match*" "refs/tags/$match*/**"
+				"refs/heads/$match*" "refs/heads/$match*/**"
+				"refs/remotes/$match*" "refs/remotes/$match*/**")
 			;;
 		esac
 		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)" \
-			$refs
+			"${refs[@]}"
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
@@ -417,7 +428,7 @@ __git_refs ()
 			while read -r entry; do
 				eval "$entry"
 				ref="${ref#*/}"
-				if [[ "$ref" == "$cur_"* ]]; then
+				if [[ "$ref" == "$match"* ]]; then
 					echo "$ref"
 				fi
 			done | sort | uniq -u
@@ -426,7 +437,7 @@ __git_refs ()
 	fi
 	case "$cur_" in
 	refs|refs/*)
-		__git ls-remote "$remote" "$cur_*" | \
+		__git ls-remote "$remote" "$match*" | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -436,12 +447,20 @@ __git_refs ()
 		;;
 	*)
 		if [ "$list_refs_from" = remote ]; then
-			echo "HEAD"
+			case "HEAD" in
+			$match*)	echo "HEAD" ;;
+			esac
 			__git for-each-ref --format="%(refname:strip=2)" \
-				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
+				"refs/remotes/$remote/$match*" \
+				"refs/remotes/$remote/$match*/**" | sed -e "s#^$remote/##"
 		else
-			__git ls-remote "$remote" HEAD \
-				"refs/tags/*" "refs/heads/*" "refs/remotes/*" |
+			local query_symref
+			case "HEAD" in
+			$match*)	query_symref="HEAD" ;;
+			esac
+			__git ls-remote "$remote" $query_symref \
+				"refs/tags/$match*" "refs/heads/$match*" \
+				"refs/remotes/$match*" |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e2b45f625..cc9e741f9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -555,6 +555,9 @@ test_expect_success '__git_refs - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/master
 	refs/heads/matching-branch
+	refs/remotes/other/branch-in-other
+	refs/remotes/other/master-in-other
+	refs/tags/matching-tag
 	EOF
 	(
 		cur=refs/heads/ &&
@@ -620,6 +623,7 @@ test_expect_success '__git_refs - configured remote' '
 
 test_expect_success '__git_refs - configured remote - full refs' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -648,6 +652,7 @@ test_expect_success '__git_refs - configured remote - repo given on the command
 
 test_expect_success '__git_refs - configured remote - full refs - repo given on the command line' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -692,6 +697,7 @@ test_expect_success '__git_refs - URL remote' '
 
 test_expect_success '__git_refs - URL remote - full refs' '
 	cat >expected <<-EOF &&
+	HEAD
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
 	refs/tags/tag-in-other
@@ -837,6 +843,124 @@ test_expect_success '__git refs - exluding full refs' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'setup for filtering matching refs' '
+	git branch matching/branch &&
+	git tag matching/tag &&
+	git -C otherrepo branch matching/branch-in-other &&
+	git fetch --no-tags other &&
+	rm -f .git/FETCH_HEAD
+'
+
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
+test_expect_success '__git_refs - only matching refs' '
+	cat >expected <<-EOF &&
+	matching-branch
+	matching/branch
+	matching-tag
+	matching/tag
+	EOF
+	(
+		cur=mat &&
+		__git_refs "" "" "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/matching-branch
+	refs/heads/matching/branch
+	EOF
+	(
+		cur=refs/heads/mat &&
+		__git_refs "" "" "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - remote on local file system' '
+	cat >expected <<-EOF &&
+	master-in-other
+	matching/branch-in-other
+	EOF
+	(
+		cur=ma &&
+		__git_refs otherrepo "" "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - configured remote' '
+	cat >expected <<-EOF &&
+	master-in-other
+	matching/branch-in-other
+	EOF
+	(
+		cur=ma &&
+		__git_refs other "" "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/master-in-other
+	refs/heads/matching/branch-in-other
+	EOF
+	(
+		cur=refs/heads/ma &&
+		__git_refs other "" "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
+	cat >expected <<-EOF &&
+	matching-branch
+	matching/branch
+	matching-tag
+	matching/tag
+	matching/branch-in-other
+	EOF
+	for remote_ref in refs/remotes/other/ambiguous \
+		refs/remotes/remote/ambiguous \
+		refs/remotes/remote/branch-in-remote
+	do
+		git update-ref $remote_ref master &&
+		test_when_finished "git update-ref -d $remote_ref"
+	done &&
+	(
+		cur=mat &&
+		__git_refs "" 1 "" "$cur" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'teardown after filtering matching refs' '
+	git branch -d matching/branch &&
+	git tag -d matching/tag &&
+	git update-ref -d refs/remotes/other/matching/branch-in-other &&
+	git -C otherrepo branch -D matching/branch-in-other
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-- 
2.12.1.485.g1616aa492

