From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Allow git-repack to optionally run git-prune-packed.
Date: Tue, 7 Mar 2006 18:16:12 +0300
Message-ID: <11417445722524-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Mar 07 16:17:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGdvX-0000FK-10
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 16:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCGPQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 10:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWCGPQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 10:16:29 -0500
Received: from mail1.starcom.co.ug ([217.113.72.31]:40743 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP
	id S1751170AbWCGPQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 10:16:29 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 07 Mar 2006 18:16:17 +0300
  id 000F9CA9.440DA3C1.00006918
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 0BC865167; Tue,  7 Mar 2006 18:18:24 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo.ds.co.ug)
	by igloo.ds.co.ug with smtp (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1FGdv2-0006Pn-Tu; Tue, 07 Mar 2006 18:16:13 +0300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17337>

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>

---

 Documentation/git-repack.txt |    6 +++++-
 git-repack.sh                |    9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

84104979482df25e6c70e17f8bf2307cdad1faff
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d2f9a44..835e698 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q]
+'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [-p]
 
 DESCRIPTION
 -----------
@@ -55,6 +55,10 @@ OPTIONS
         Do not update the server information with
         `git update-server-info`.
 
+-p::
+	Run `git-prune-packed` after packing, see
+	gitlink:git-prune-packed[1]
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/git-repack.sh b/git-repack.sh
index 3d6fec1..970f4ca 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,11 +3,11 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [-p]'
 . git-sh-setup
 	
 no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse_delta=
+local= quiet= no_reuse_delta= run_prune=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -17,6 +17,7 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
 	-l)	local=--local ;;
+	-p)	run_prune=t;;
 	*)	usage ;;
 	esac
 	shift
@@ -77,6 +78,10 @@ then
 	fi
 fi
 
+case "$run_prune" in
+t) git-prune-packed;;
+esac
+
 case "$no_update_info" in
 t) : ;;
 *) git-update-server-info ;;
-- 
1.2.4.g84104
