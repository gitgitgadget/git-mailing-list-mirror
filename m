Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB1C1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbdBCCtc (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:32 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35191 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdBCCt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so1170807wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPeyX59nZE9AVtyzWQSXa0eDwLCrPGyI0Rks2uWdZho=;
        b=NCZIETxp9iyI5YA7wF3uTuAnmT1bglDpGRxwUVSdzcnsIk76k1STC/n8sU7tkjrelj
         q89KA2Aclqq2woCICHCjGnQA0lK8x3PVPCrgMHLjQK5riUDFYJPvqfE7ZIx+YGE5l2Bv
         HLGUlK/zt0ce+WHYxYFD58uOnyHcIoyy6PrdGOOWrHnpt0c1y9A5oNw3fiAFgFWWri14
         XZFRGVpmrrBce3Cm28xKNJc/LtPMq/kwU01JSWzCCOQQqfVUJmJupyr6KrPEkReK7rFC
         GU6FG6yui9Ul5+xfsg7Xot6nhFyE1ZkM89pqOJDpExfVxa4Oym8GEiJrZdkjB+xolzDD
         BFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPeyX59nZE9AVtyzWQSXa0eDwLCrPGyI0Rks2uWdZho=;
        b=pTJTcPOU72csSsWUKwkFvyT5LD8q4G1kqPiK/VmUJepvq71ahAg9IyihtXCHml3Ne4
         DnxPBPecFnj1LD0aixwOBw37R9sgZDAJKg9bYxBwNgg1nOSYFD5sa2s5tzb7Vumy7Cjc
         ZsNozmeRLBEJv1RZi261cP+Wrtn0kx4pWAG25Im/YnaQCNpmKEB+ukyr+VTwQq1c7zOw
         rr/ps6Gr2HvXX+ztBSRXjuvY27pviMWfGmfBMaM+lgjFbLKcGGRoSQOE/wruCrlS+fkT
         c2BjRJpTgJ1GHJ1Xr3sHU7IY0fAvDTDX7Tt9awSFaatxglUz58/efDlIbjeXaC49jSX8
         6qhg==
X-Gm-Message-State: AIkVDXJhw2raXHmAsXZtwQLSQWIDqQK8e+mK3QPyMAcYVaVepXfYyerbf/mMuu/ECgtqeQ==
X-Received: by 10.223.176.175 with SMTP id i44mr10147597wra.3.1486090168238;
        Thu, 02 Feb 2017 18:49:28 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 16/21] completion: respect 'git -C <path>'
Date:   Fri,  3 Feb 2017 03:48:24 +0100
Message-Id: <20170203024829.8071-17-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git -C <path>' option(s) on the command line should be taken into
account during completion, because

  - like '--git-dir=<path>', it can lead us to a different repository,

  - a few git commands executed in the completion script do care about
    in which directory they are executed, and

  - the command for which we are providing completion might care about
    in which directory it will be executed.

However, unlike '--git-dir=<path>', the '-C <path>' option can be
specified multiple times and their effect is cumulative, so we can't
just store a single '<path>' in a variable.  Nor can we simply
concatenate a path from '-C <path1> -C <path2> ...', because e.g. (in
an arguably pathological corner case) a relative path might be
followed by an absolute path.

Instead, store all '-C <path>' options word by word in the
$__git_C_args array in the main git completion function, and pass this
array, if present, to 'git rev-parse --absolute-git-dir' when
discovering the repository in __gitdir(), and let it take care of
multiple options, relative paths, absolute paths and everything.

Also pass all '-C <path> options via the $__git_C_args array to those
git executions which require a worktree and for which it matters from
which directory they are executed from.  There are only three such
cases:

  - 'git diff-index' and 'git ls-files' in __git_ls_files_helper()
    used for git-aware filename completion, and

  - the 'git ls-tree' used for completing the 'ref:path' notation.

The other git commands executed in the completion script don't need
these '-C <path>' options, because __gitdir() already took those
options into account.  It would not hurt them, either, but let's not
induce unnecessary code churn.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++--
 t/t9902-completion.sh                  | 87 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ac5eb9ced..e003afd54 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -39,7 +39,11 @@ esac
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
+		if [ -n "${__git_C_args-}" ]; then
+			git "${__git_C_args[@]}" \
+				${__git_dir:+--git-dir="$__git_dir"} \
+				rev-parse --absolute-git-dir 2>/dev/null
+		elif [ -n "${__git_dir-}" ]; then
 			test -d "$__git_dir" || return 1
 			echo "$__git_dir"
 		elif [ -n "${GIT_DIR-}" ]; then
@@ -286,10 +290,10 @@ __git_ls_files_helper ()
 	local dir="$(__gitdir)"
 
 	if [ "$2" == "--committable" ]; then
-		git --git-dir="$dir" -C "$1" diff-index --name-only --relative HEAD
+		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$dir" -C "$1" diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git --git-dir="$dir" -C "$1" ls-files --exclude-standard $2
+		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$dir" -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
 
@@ -519,7 +523,7 @@ __git_complete_revlist_file ()
 		*)   pfx="$ref:$pfx" ;;
 		esac
 
-		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -2792,6 +2796,7 @@ _git_worktree ()
 __git_main ()
 {
 	local i c=1 command __git_dir
+	local __git_C_args C_args_count=0
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -2800,7 +2805,11 @@ __git_main ()
 		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
 		--bare)      __git_dir="." ;;
 		--help) command="help"; break ;;
-		-c|-C|--work-tree|--namespace) ((c++)) ;;
+		-c|--work-tree|--namespace) ((c++)) ;;
+		-C)	__git_C_args[C_args_count++]=-C
+			((c++))
+			__git_C_args[C_args_count++]="${words[c]}"
+			;;
 		-*) ;;
 		*) command="$i"; break ;;
 		esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index be2ed8704..984df05b2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -211,6 +211,87 @@ test_expect_success '__gitdir - $GIT_DIR set while .git directory in parent' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__gitdir - from command line while "git -C"' '
+	echo "$ROOT/.git" >expected &&
+	(
+		__git_dir="$ROOT/.git" &&
+		__git_C_args=(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - relative dir from command line and "git -C"' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		__git_dir="otherrepo/.git" &&
+		__git_C_args=(-C ..) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - $GIT_DIR set while "git -C"' '
+	echo "$ROOT/.git" >expected &&
+	(
+		GIT_DIR="$ROOT/.git" &&
+		export GIT_DIR &&
+		__git_C_args=(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - relative dir in $GIT_DIR and "git -C"' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		GIT_DIR="otherrepo/.git" &&
+		export GIT_DIR &&
+		__git_C_args=(-C ..) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while .git directory in cwd' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		__git_C_args=(-C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while cwd is a .git directory' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd .git &&
+		__git_C_args=(-C .. -C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - "git -C" while .git directory in parent' '
+	echo "$ROOT/otherrepo/.git" >expected &&
+	(
+		cd subdir &&
+		__git_C_args=(-C .. -C otherrepo) &&
+		__gitdir >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - non-existing path in "git -C"' '
+	(
+		__git_C_args=(-C non-existing) &&
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
 test_expect_success '__gitdir - non-existing path in $__git_dir' '
 	(
 		__git_dir="non-existing" &&
@@ -785,6 +866,12 @@ test_expect_success 'checkout completes ref names' '
 	EOF
 '
 
+test_expect_success 'git -C <path> checkout uses the right repo' '
+	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
+	branch-in-other Z
+	EOF
+'
+
 test_expect_success 'show completes all refs' '
 	test_completion "git show m" <<-\EOF
 	master Z
-- 
2.11.0.555.g967c1bcb3

