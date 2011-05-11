From: David Pisoni <dpisoni@gmail.com>
Subject: [PATCH] Adds 'stash.index' configuration option
Date: Wed, 11 May 2011 15:57:33 -0700
Message-ID: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 00:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKILg-0003lC-9U
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 00:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab1EKW5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 18:57:39 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:51885 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565Ab1EKW5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 18:57:38 -0400
Received: by pxi16 with SMTP id 16so639041pxi.4
        for <git@vger.kernel.org>; Wed, 11 May 2011 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:to:content-type
         :content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=0iEiENZucEhTC45swAHtQBjfvkw7/i6+zVzM+w6mNkY=;
        b=VPxMFIt7XH+lVKG2/N7h1Ch7MMWYf3s7LCcD8le1HVIS6mSPZkTzqLF1RHaM+eJYhN
         YHSscQvzk89BrMTpIs/+Thgk13XcQfama2Wx8NKxMf/MmUFHHZyL4t5FslXAuwPZvI8t
         nkAX7kBAjrIfM6LE1BSwhyynR8Q43QWR57PHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=spTTQ/cR3epZsJuz0gZ81CuVEOrhth5nYtAmRf9B9+Weeka9jojknamRbamm5+or1b
         d04X/YtQBEjDy+zq9jV030cLAH67oPL/nGANg9GuYkmql4Y99NSpOlL/nQzOABz7fbDo
         RKRXmfWcSwnBD7wMT66GBxWd+VszXdK8aUTlA=
Received: by 10.68.16.167 with SMTP id h7mr14171998pbd.398.1305154658110;
        Wed, 11 May 2011 15:57:38 -0700 (PDT)
Received: from [192.168.0.28] (ip-64-32-149-57.lax.megapath.net [64.32.149.57])
        by mx.google.com with ESMTPS id i10sm257519pbd.28.2011.05.11.15.57.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 15:57:36 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173433>


Setting 'stash.index' config option changes 'git-stash pop|apply' to  
behave
as if '--index' switch is always supplied.
'git-stash pop|apply' provides a --no-index switch to circumvent  
config default.

Signed-off-by: David Pisoni <dpisoni@gmail.com>
---
Documentation/config.txt    |    5 +++++
Documentation/git-stash.txt |   10 +++++++---
git-stash.sh                |    7 ++++++-
t/t3903-stash.sh            |   28 ++++++++++++++++++++++++++++
4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f7..d794c40 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1746,6 +1746,11 @@ showbranch.default::
	The default set of branches for linkgit:git-show-branch[1].
	See linkgit:git-show-branch[1].

+stash.index::
+    A boolean to make linkgit:git-stash[1] default to the behavior of  
--index
+	when applying a stash to the working copy.  Can be circumvented by  
using
+	--no-index switch to linkgit:git-stash[1].  Defaults to false.
+
status.relativePaths::
	By default, linkgit:git-status[1] shows paths relative to the
	current directory. Setting this variable to `false` shows paths
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 15f051f..de086ee 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -11,7 +11,7 @@ SYNOPSIS
'git stash' list [<options>]
'git stash' show [<stash>]
'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+'git stash' ( pop | apply ) [--[no-]index] [-q|--quiet] [<stash>]
'git stash' branch <branchname> [<stash>]
'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]  
[<message>]]
'git stash' clear
@@ -89,7 +89,7 @@ show [<stash>]::
	it will accept any format known to 'git diff' (e.g., `git stash show
	-p stash@\{1}` to view the second most recent stash in patch form).

-pop [--index] [-q|--quiet] [<stash>]::
+pop [--[no-]index] [-q|--quiet] [<stash>]::

	Remove a single stashed state from the stash list and apply it
	on top of the current working tree state, i.e., do the inverse
@@ -105,10 +105,14 @@ tree's changes, but also the index's ones.  
However, this can fail, when you
have conflicts (which are stored in the index, where you therefore can  
no
longer apply the changes as they were originally).
+
+If the configuration option `stash.index` is set `pop` will behave as  
if the
+`--index` option is always in use, unless explicitly overridden with
+`--no-index`.
++
When no `<stash>` is given, `stash@\{0}` is assumed, otherwise  
`<stash>` must
be a reference of the form `stash@\{<revision>}`.

-apply [--index] [-q|--quiet] [<stash>]::
+apply [--[no-]index] [-q|--quiet] [<stash>]::

	Like `pop`, but do not remove the state from the stash list. Unlike  
`pop`,
	`<stash>` may be any commit that looks like a commit created by
diff --git a/git-stash.sh b/git-stash.sh
index 0a94036..7711bf6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -31,6 +31,8 @@ else
        reset_color=
fi

+CONFIG_INDEX="$(git config stash.index)"
+
no_changes () {
	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
	git diff-files --quiet --ignore-submodules
@@ -256,7 +258,7 @@ parse_flags_and_rev()

	IS_STASH_LIKE=
	IS_STASH_REF=
-	INDEX_OPTION=
+	INDEX_OPTION=$CONFIG_INDEX
	s=
	w_commit=
	b_commit=
@@ -277,6 +279,9 @@ parse_flags_and_rev()
			--index)
				INDEX_OPTION=--index
			;;
+			--no-index)
+				unset INDEX_OPTION
+			;;
			-*)
				FLAGS="${FLAGS}${FLAGS:+ }$opt"
			;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5c72540..4999682 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -84,6 +84,34 @@ test_expect_success 'apply stashed changes  
(including index)' '
	test 1 = $(git show HEAD:file)
'

+test_expect_success 'apply stashed changes (including index) with  
index config set' '
+    git config stash.index yes &&
+	git reset --hard HEAD^ &&
+	echo 7 > other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git config --unset stash.index
+'
+
+test_expect_success 'apply stashed changes (excluding index) with  
index config set' '
+    git config stash.index yes &&
+	git reset --hard &&
+	echo 8 >other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply --no-index &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git config --unset stash.index
+'
+
test_expect_success 'unstashing in a subdirectory' '
	git reset --hard HEAD &&
	mkdir subdir &&
-- 
1.7.5
