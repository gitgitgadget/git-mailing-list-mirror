X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git tag: don't complain of empty messages
Date: Sun, 26 Nov 2006 17:42:49 +0100
Message-ID: <4569C409.5080509@xs4all.nl>
References: <ejfc1t$6am$1@sea.gmane.org> <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 16:43:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 65
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32356>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoN68-0006Mv-5o for gcvg-git@gmane.org; Sun, 26 Nov
 2006 17:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935429AbWKZQmz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935432AbWKZQmz
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 11:42:55 -0500
Received: from main.gmane.org ([80.91.229.2]:16262 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935429AbWKZQmz (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 11:42:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GoN5d-0006GJ-PI for git@vger.kernel.org; Sun, 26 Nov 2006 17:42:49 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 17:42:49 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 26 Nov 2006
 17:42:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> Please follow Documentation/SubmittingPatches.

See below, hope I didn't mess up.



From be40730d19592f9db8f07f619f5723060c2f4f0c Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@lilypond.org>
Date: Sun, 26 Nov 2006 17:41:30 +0100
Subject: [PATCH] allow empty tag message if -m is given explicitly.

---
 git-tag.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index ac269e3..d53f94c 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -5,6 +5,7 @@ USAGE='-l [<pattern>] | [-a | -s | -u <k
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+message_given=
 annotate=
 signed=
 force=
@@ -37,6 +38,12 @@ do
     	annotate=1
 	shift
 	message="$1"
+	if test "$#" = "0"; then
+	    die "error: option -m needs an argument"
+	    exit 2
+	else
+	    message_given=1
+	fi
 	;;
     -u)
 	annotate=1
@@ -83,7 +90,7 @@ tagger=$(git-var GIT_COMMITTER_IDENT) ||
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 
 if [ "$annotate" ]; then
-    if [ -z "$message" ]; then
+    if [ -z "$message_given" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
@@ -95,7 +102,7 @@ if [ "$annotate" ]; then
     grep -v '^#' <"$GIT_DIR"/TAG_EDITMSG |
     git-stripspace >"$GIT_DIR"/TAG_FINALMSG
 
-    [ -s "$GIT_DIR"/TAG_FINALMSG ] || {
+    [ -s "$GIT_DIR"/TAG_FINALMSG -o -n "$message_given" ] || {
 	echo >&2 "No tag message?"
 	exit 1
     }
-- 
1.4.2.4


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
