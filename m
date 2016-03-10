From: Nicola Paolucci <npaolucci@atlassian.com>
Subject: [PATCH 3/3] contrib/subtree: list --resolve gets symbolic refs
Date: Thu, 10 Mar 2016 10:44:12 +0100
Message-ID: <1457603052-53963-4-git-send-email-npaolucci@atlassian.com>
References: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Cc: Dave <davidw@realtimegenomics.com>,
	"David A . Greene" <greened@obbligato.org>,
	Mathias Nyman <mathias.nyman@iki.fi>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 10:45:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adx9m-0001oY-B9
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 10:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbcCJJpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 04:45:15 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38230 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbcCJJpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 04:45:04 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so20644545wml.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wftAg6v7lTqq7Scx9Jt25cfuhWbjSB+t367/3FyPl3w=;
        b=Z+DfWpSBKtceJFQsUL3l86uNaKMUtRjTC8xf4qtClJggpbgwWimiwEAtZ5ZlUuwScX
         UBcF/o2mW6k038t2QKxfs1jYdpNOGB9dr/EassH+vcP2vcb4pDnn4Pt1atdaO5kS0G/k
         epjjKTlI4XEmcICU88DLjLRrT1O8fl8zn7/kzbj1GMJ0cKMmsR2BBsGmOp50ZjSzyxR9
         LUvAE6T8lDPytJzv2kFbp11IppA1JTKecYLlP9fYNvWMUPIBkFJkJIsPcoyirq2fBAvW
         g73QMXTr7JVgxbpfeJRnFeN+nD212aZkfr9v4vnB7EKb4H+wF8s2TRgb+PQNnj7eh1HP
         MZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wftAg6v7lTqq7Scx9Jt25cfuhWbjSB+t367/3FyPl3w=;
        b=YTcmHJPcGhqkguYDlAhP1QnylxZYbT5cFHHwVRHwW4q86jweEPZQLwlT1twm8GpmiP
         MGvWiRwVbFr0XjxHhQrqfqXh8lMK1hZa+SlKX5lcTj7f1mNScVbzwYBtf4fxt3X2fIkL
         NSqaK0TwKVICdxF7azj2MBeDJ9qV1DwX3JIPgpi+XNIxPV7DOJcrK1zgVuN3MprEunc2
         9XeqpZGHxIMI7OPRNZ6TTnTieKoFkNvH51gbmFfSu1NLyATcnjo0Jtn5X4bxRt5pLylr
         qILbyg2OM67ygf8/pDFW+n8KhXrEoPEAmwA/9Ood8jH6unyMSIgiugaiz0xRusEXw4Q1
         Y/NQ==
X-Gm-Message-State: AD7BkJJNz5Jl93lFErnnKid60q26LvNBm5I1PwJKdV+QW0zalSRn2QhTRKPJYUiw5MuohFjy
X-Received: by 10.194.200.225 with SMTP id jv1mr2680508wjc.49.1457603102892;
        Thu, 10 Mar 2016 01:45:02 -0800 (PST)
Received: from reborn.ams.atlassian.com ([46.243.25.78])
        by smtp.gmail.com with ESMTPSA id q139sm2684747wmd.2.2016.03.10.01.45.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 01:45:02 -0800 (PST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288609>

As the 'list' command finds commit ids for subtrees injected into the
checked out branch the --resolve flag tries to look up the repositories
at 'git-subtree-repo' and retrive the symbolic refs associated with the
commit ids found.

Example:

    $ git-subtree.sh list --resolve

    vim-airline  https://repo/bling/vim-airline.git 4fa37e5e[...]
    vim-airline  https://repo/bling/vim-airline.git HEAD
    vim-airline  https://repo/bling/vim-airline.git refs/heads/master

Signed-off-by: Nicola Paolucci <npaolucci@atlassian.com>
---
 contrib/subtree/git-subtree.sh     | 21 +++++++++++++++++----
 contrib/subtree/git-subtree.txt    | 31 +++++++++++++++++++++++++++++++
 contrib/subtree/t/t7900-subtree.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 82f3fce..fe62151 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,7 +14,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
 git subtree split --prefix=<prefix> <commit...>
-git subtree list
+git subtree list  [--resolve]
 --
 h,help        show the help
 q             quiet
@@ -29,6 +29,7 @@ onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
+resolve       resolves ids to refs when possible
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
@@ -48,6 +49,7 @@ annotate=
 squash=
 message=
 prefix=
+resolve=
 
 debug()
 {
@@ -102,6 +104,8 @@ while [ $# -gt 0 ]; do
 		--no-ignore-joins) ignore_joins= ;;
 		--squash) squash=1 ;;
 		--no-squash) squash= ;;
+		--resolve) resolve=1 ;;
+		--no-resolve) resolve= ;;
 		--) break ;;
 		*) die "Unexpected option: $opt" ;;
 	esac
@@ -254,12 +258,21 @@ find_subtree_repos()
 			END)
 				if [ -n "$sub" ]; then
 					if [ -n "$main" ]; then
-						# a rejoin commit?
-						# Pretend its sub was a squash.
 						sq="$sub"
 					fi
 					debug "Subtree found: $dir $repo $sub"
-					echo "$dir" "$repo" "$sub"
+					# Strip potential space at the end in repo
+					repo=$(echo $repo)
+					if [ -n "$resolve" ] && [ -n "$repo" ]; then
+						echo "$dir" "$repo" "$sub"
+						# Retrieve remote refs if repo is available
+						resolved_refs=$(git ls-remote "$repo" | grep "$sub" | cut -c 42- | xargs)
+						for r in $resolved_refs; do
+							echo "$dir" "$repo" "$r"
+						done
+					else
+						echo "$dir" "$repo" "$sub"
+					fi
 				fi
 				sq=
 				main=
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 60d76cd..ab36951 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git subtree' push  -P <prefix> <repository> <ref>
 'git subtree' merge -P <prefix> <commit>
 'git subtree' split -P <prefix> [OPTIONS] [<commit>]
+'git subtree' list [--resolve]
 
 
 DESCRIPTION
@@ -106,6 +107,12 @@ split::
 	contents of <prefix> at the root of the project instead
 	of in a subdirectory.  Thus, the newly created history
 	is suitable for export as a separate git repository.
+
+list::
+	List all subtrees injected in checked out branch. Run
+	with optional `--resolve` to retrieve remote symbolic refs
+	associated with the subtree. Address of subtree repo is stored
+	in commits as `git-subtree-repo` at the time of `git subtree add`.
 +
 After splitting successfully, a single commit id is printed to stdout.
 This corresponds to the HEAD of the newly created tree, which you can
@@ -240,6 +247,13 @@ split, because you don't want the subproject's history to be part of
 your project anyway.
 
 
+OPTIONS FOR list
+----------------------------------
+--resolve::
+	Resolves 'git-subtree-split' refs by looking up symbolic refs at
+	'git-subtree-repo'.
+
+
 EXAMPLE 1. Add command
 ----------------------
 Let's assume that you have a local repository that you would like
@@ -341,6 +355,23 @@ Then push the new branch onto the new empty repository:
 	$ git push <new-repo> split:master
 
 
+EXAMPLE 3. List subtrees
+-----------------------------------------
+Suppose you add a subtree with:
+
+	$ git subtree add --prefix dependency https://host/repo.git master --squash
+
+You can list all subtrees in the current branch resolving the refs with:
+
+	$ git subtree list --resolve
+
+Which would output something like:
+
+	depenency  https://host/repo.git 4fa37e5e20b5ae9b[...]
+	depenency  https://host/repo.git HEAD
+	depenency  https://host/repo.git refs/heads/master
+
+
 AUTHOR
 ------
 Written by Avery Pennarun <apenwarr@gmail.com>
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ce97446..d100001 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -81,6 +81,19 @@ test_create_commit() (
 	git commit -m "$commit" || error "Could not commit"
 )
 
+test_create_commit_and_tag() (
+	repo=$1
+	commit=$2
+    tag=$3
+	cd "$repo"
+	mkdir -p $(dirname "$commit") \
+	|| error "Could not create directory for commit"
+	echo "$commit" >"$commit"
+	git add "$commit" || error "Could not add commit"
+	git commit -m "$commit" || error "Could not commit"
+	git tag -m "$commit tag: $tag" $tag || error "Could not tag"
+)
+
 last_commit_message()
 {
 	git log --pretty=format:%s -1
@@ -212,6 +225,19 @@ test_expect_success 'list outputs list of subtrees' '
 		check_equal "$(git subtree list | cut -c -19)" "sub dir ./sub proj "
 	)
 '
+next_test
+test_expect_success 'list --resolve resolves refs' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	subtree_test_create_repo "$subtree_test_count/sub proj" &&
+	test_create_commit_and_tag "$subtree_test_count/sub proj" sub1 test-v0.1 &&
+	test_create_commit "$subtree_test_count" main1 &&
+	(
+		cd "$subtree_test_count" &&
+		git fetch ./"sub proj" master &&
+		git subtree add --prefix="sub dir" "./sub proj" HEAD --squash &&
+		check_equal "$(git subtree -d list --resolve | grep HEAD)" "sub dir ./sub proj HEAD"
+	)
+'
 
 #
 # Tests for 'git subtree merge'
-- 
2.7.1
