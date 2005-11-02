From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 2/2] Add support for git-http-push to git-push script
Date: Wed, 2 Nov 2005 11:19:31 -0800
Message-ID: <20051102191930.GD3928@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 02 20:19:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXO91-0006xh-7T
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 20:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVKBTTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 14:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVKBTTc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 14:19:32 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:18849 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965190AbVKBTTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 14:19:31 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA2JJVMf023686
	for <git@vger.kernel.org>; Wed, 2 Nov 2005 11:19:31 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA2JJVnt023684
	for git@vger.kernel.org; Wed, 2 Nov 2005 11:19:31 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11029>

Add support for git-http-push to git-push script

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

This probably doesn't make sense until git-http-push has undergone some
testing.

 git-push.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

applies-to: e7d656bb2608ae924a78750bbd3d01bf4f6c2e9a
a374b962104899cfe39b21fc2fbef64d1e1fdbd8
diff --git a/git-push.sh b/git-push.sh
index 5aa6531..edc0b83 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -46,7 +46,7 @@ esac
 shift
 
 case "$remote" in
-http://* | https://* | git://*)
+git://*)
 	die "Cannot use READ-ONLY transport to push to $remote" ;;
 rsync://*)
         die "Pushing with rsync transport is deprecated" ;;
@@ -57,4 +57,9 @@ test "$has_all" && set x "$has_all" "$@"
 test "$has_force" && set x "$has_force" "$@" && shift
 test "$has_exec" && set x "$has_exec" "$@" && shift
 
-exec git-send-pack "$@"
+case "$remote" in
+http://* | https://*)
+	exec git-http-push "$@";;
+*)
+	exec git-send-pack "$@";;
+esac
---
0.99.9.GIT
