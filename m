From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-tag: support -F <file> option
Date: Thu, 21 Dec 2006 15:13:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211512160.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <emdsi9$ecm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 15:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOfU-0004Yn-SC
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 15:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWLUONF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 09:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWLUONF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 09:13:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:55080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964967AbWLUONE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 09:13:04 -0500
Received: (qmail invoked by alias); 21 Dec 2006 14:13:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 21 Dec 2006 15:13:02 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
In-Reply-To: <emdsi9$ecm$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35069>


This imitates the behaviour of git-commit.

Noticed by Han-Wen Nienhuys.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Thu, 21 Dec 2006, Han-Wen Nienhuys wrote:

	> Working on a little darcs2git script, I found the following 
	> inconsistency
	> 
	> git-commit supports -m and -F 
	> git-tag supports only -m

	How about this?

 Documentation/git-tag.txt |    6 +++++-
 git-tag.sh                |   11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 45476c2..48b82b8 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,8 @@ git-tag - Create a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <name> [<head>]
+'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg> | -F <file>]
+	 <name> [<head>]
 'git-tag' -l [<pattern>]
 
 DESCRIPTION
@@ -60,6 +61,9 @@ OPTIONS
 -m <msg>::
 	Use the given tag message (instead of prompting)
 
+-F <file>::
+	Take the tag message from the given file.  Use '-' to
+	read the message from the standard input.
 
 Author
 ------
diff --git a/git-tag.sh b/git-tag.sh
index d53f94c..36cd6aa 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -45,6 +45,17 @@ do
 	    message_given=1
 	fi
 	;;
+    -F)
+	annotate=1
+	shift
+	if test "$#" = "0"; then
+	    die "error: option -F needs an argument"
+	    exit 2
+	else
+	    message="$(cat "$1")"
+	    message_given=1
+	fi
+	;;
     -u)
 	annotate=1
 	signed=1
-- 
1.4.4.3.g0ba4
