From: Tom Anderson <thomasanderson@google.com>
Subject: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Sun, 1 May 2016 14:57:18 -0700
Message-ID: <57267BBE.9010707@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, thomasanderson@google.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:57:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awzMj-0002GE-NQ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcEAV5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 17:57:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32875 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbcEAV5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 17:57:20 -0400
Received: by mail-pa0-f42.google.com with SMTP id zm5so74469502pac.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=h3LNT/hSdB30EfKX/Bid230f9Oyd6RMZDkxmtGE9YRg=;
        b=LtA4VFGD9re2+TsEdwhLoclR/Ajw9p4Cuj4PBbg8WyIAWC024Q3DhrHvk/zOX1PPn2
         4fwz6DfD1OatrASzvnNIcMb6uh+826awVOgNkAO9mSb4gqgKb6rhpMjKHQchYXHlUzhD
         JRfEgUDQ3T/D3ZzEULwF3Yn0Jupg/aoLZdlvJ3FpYOmSSYJfIx+hcgKIny1YD9rLLGCs
         97h2Yo/pCdDx5IbLzGC1nhQBJoLzX258BrIYgtYqccJAPMg0XhVRKAN6tfwv0yLunzXd
         4pP3WdpzsU9ti0lxRSzCNaRtdHsDhdXJuE7u9yHPg16q1Ep9EVo0L75x7yuit34OQr+O
         JLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=h3LNT/hSdB30EfKX/Bid230f9Oyd6RMZDkxmtGE9YRg=;
        b=lwGohCNHWwy+GZUYwb7QikIJXxKeNHFElOGVqHHWzpXxY7/MC+gsKB9pfJLheuCtnN
         PwoIl3nUpXoPqWTIOPuXO1gBijERctKItW0rc/v2vmisZ7PVDqWH40QOjIernf9f8FsX
         zxw6NF/eA6yWy10i2jMOVEPmugsGOZi6cesd5YFsd8mYLIlaiXUBXUD95Mtnf5KAKqC/
         5bb8NRAwEF359yNsXo2Zdicz3C6p+WGbo/Fq8Dt9dLSgYWQ36uE3UXLMtAMaVK0ok/2Y
         GF7sj4C+kwTPPis5EjYyoeUO/fmJUcISEpcVhuYfvozcqlUo4Yw1ZHDytntgHTGgbhdx
         4oug==
X-Gm-Message-State: AOPr4FWbwll+EUwXzQDEAIqrMlYa6UPB/e/2J7+fzg/4Sjdys8/mR5hLq/gcIhWIh/htOlsp
X-Received: by 10.66.41.107 with SMTP id e11mr47112698pal.15.1462139839805;
        Sun, 01 May 2016 14:57:19 -0700 (PDT)
Received: from thomasanderson.mtv.corp.google.com ([2620:0:1000:1600:9ce1:bc02:4db9:55e2])
        by smtp.gmail.com with ESMTPSA id h5sm46781250pat.0.2016.05.01.14.57.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 May 2016 14:57:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293216>

Add the "--no-reset" (same as "-r") flag to git-stash.sh.  A common
workflow is to use "git-stash save" and "git-stash apply" to save your
work without modifying your changed files.  This forces users to
reload their changed files in text editors like emacs, and touches the
modify time on all changed files, potentially making incremental
builds slower if many files in the build depend on your changed files.

Add documentation in Documentation/git-stash.txt and tests in
t/t3903-stash.sh.

Signed-off-by: Thomas Anderson <thomasanderson@google.com>
---
  Documentation/git-stash.txt |  9 ++++++---
  git-stash.sh                | 15 ++++++++++-----
  t/t3903-stash.sh            | 27 +++++++++++++++++++++++++++
  3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 92df596..ba5ecf2 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,8 +13,8 @@ SYNOPSIS
  'git stash' drop [-q|--quiet] [<stash>]
  'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
  'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' [save [-p|--patch] [-r|--no-reset] [-k|--[no-]keep-index]
+	     [-q|--quiet] [-u|--include-untracked] [-a|--all] [<message>]]
  'git stash' clear
  'git stash' create [<message>]
  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -44,7 +44,7 @@ is also possible).
  OPTIONS
  -------
  -save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] 
[-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [-r|--no-reset] [-k|--[no-]keep-index] 
[-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
   	Save your local modifications to a new 'stash', and run `git reset
  	--hard` to revert them.  The <message> part is optional and gives
@@ -61,6 +61,9 @@ stashed and then cleaned up with `git clean`, leaving 
the working directory
  in a very clean state. If the `--all` option is used instead then the
  ignored files are stashed and cleaned in addition to the untracked files.
  +
+If the `--no-reset` option is used, `git reset --hard` is skipped and the
+`--[no-]keep-index`, `--include-untracked`, and `--all` flags are ignored.
++
  With `--patch`, you can interactively select hunks from the diff
  between HEAD and the working tree to be stashed.  The stash entry is
  constructed such that its index state is the same as the index state
diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..aebebb0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,8 +7,9 @@ USAGE="list [<options>]
     or: $dashless drop [-q|--quiet] [<stash>]
     or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
     or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [<message>]]
+   or: $dashless [save [--patch] [-r|--no-reset] [-k|--[no-]keep-index]
+		       [-q|--quiet] [-u|--include-untracked] [-a|--all]
+		       [<message>]]
     or: $dashless clear"
   SUBDIRECTORY_OK=Yes
@@ -194,9 +195,13 @@ save_stash () {
  	keep_index=
  	patch_mode=
  	untracked=
+	no_reset=
  	while test $# != 0
  	do
  		case "$1" in
+		-r|--no-reset)
+			no_reset=t
+			;;
  		-k|--keep-index)
  			keep_index=t
  			;;
@@ -268,7 +273,7 @@ save_stash () {
  	die "$(gettext "Cannot save the current status")"
  	say Saved working directory and index state "$stash_msg"
  -	if test -z "$patch_mode"
+	if test -z "$patch_mode" -a -z "$no_reset"
  	then
  		git reset --hard ${GIT_QUIET:+-q}
  		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
@@ -276,12 +281,12 @@ save_stash () {
  		then
  			git clean --force --quiet -d $CLEAN_X_OPTION
  		fi
-
  		if test "$keep_index" = "t" && test -n $i_tree
  		then
  			git read-tree --reset -u $i_tree
  		fi
-	else
+	elif -n "$patch_mode"
+	then
  		git apply -R < "$TMP-patch" ||
  		die "$(gettext "Cannot remove worktree changes")"
  diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..3eba19a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -248,6 +248,33 @@ test_expect_success 'stash --no-keep-index' '
  	test bar,bar2 = $(cat file),$(cat file2)
  '
  +test_expect_success 'stash -r' '
+	git reset &&
+	echo foo420 > file &&
+	echo bar420 > file2 &&
+	git add file2 &&
+	git stash -r &&
+	test foo420,bar420 = $(cat file),$(cat file2)
+'
+
+test_expect_success 'stash --no-reset' '
+	git reset &&
+	echo bar33 > file &&
+	echo bar44 > file2 &&
+	git add file2 &&
+	git stash --no-reset &&
+	test bar33,bar44 = $(cat file),$(cat file2)
+'
+
+test_expect_success 'stash -r with ignored options -k -u -a' '
+	git reset &&
+	echo foo55 > file &&
+	echo bar66 > file2 &&
+	git add file2 &&
+	git stash -r &&
+	test foo55,bar66 = $(cat file),$(cat file2)
+'
+
  test_expect_success 'stash --invalid-option' '
  	echo bar5 > file &&
  	echo bar6 > file2 &&
-- 
2.8.0.rc2
