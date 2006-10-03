From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] git-rebase: Add a -v option to show a diffstat of the changes
 upstream at the start of a rebase.
Date: Tue, 03 Oct 2006 17:29:31 +0100
Organization: CodeWeavers
Message-ID: <45228FEB.10602@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000203000707030501030109"
X-From: git-owner@vger.kernel.org Tue Oct 03 18:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUn9l-0002zb-1i
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWJCQaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWJCQaG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:30:06 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:22934 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932085AbWJCQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 12:30:04 -0400
Received: from host86-139-249-184.range86-139.btcentralplus.com ([86.139.249.184] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GUn9f-00077m-E9
	for git@vger.kernel.org; Tue, 03 Oct 2006 11:30:03 -0500
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28275>

This is a multi-part message in MIME format.
--------------000203000707030501030109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  Documentation/git-rebase.txt |    5 ++++-
  git-rebase.sh                |   12 +++++++++++-
  2 files changed, 15 insertions(+), 2 deletions(-)

--------------000203000707030501030109
Content-Type: text/x-patch;
 name="fa9469c0860b24ea50036973e5c53b4da19041cf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fa9469c0860b24ea50036973e5c53b4da19041cf.diff"

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9d7bcaa..10f2924 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -7,7 +7,7 @@ git-rebase - Rebase local commits to a n
 
 SYNOPSIS
 --------
-'git-rebase' [--merge] [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [-v] [--merge] [--onto <newbase>] <upstream> [<branch>]
 
 'git-rebase' --continue | --skip | --abort
 
@@ -121,6 +121,9 @@ OPTIONS
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).  This implies --merge.
 
+-v, \--verbose::
+	Display a diffstat of what changed upstream since the last rebase.
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/git-rebase.sh b/git-rebase.sh
index 413636e..546fa44 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--onto <newbase>] <upstream> [<branch>]'
+USAGE='[-v] [--onto <newbase>] <upstream> [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -39,6 +39,7 @@ strategy=recursive
 do_merge=
 dotest=$GIT_DIR/.dotest-merge
 prec=4
+verbose=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -190,6 +191,9 @@ do
 		esac
 		do_merge=t
 		;;
+	-v|--verbose)
+		verbose=t
+		;;
 	-*)
 		usage
 		;;
@@ -273,6 +277,12 @@ then
 	exit 0
 fi
 
+if test -n "$verbose"
+then
+	echo "Changes from $mb to $onto:"
+	git-diff-tree --stat --summary "$mb" "$onto"
+fi
+
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
 git-reset --hard "$onto"
 


--------------000203000707030501030109--
