From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Fix abort command when resolving symlinks and deleted files
Date: Thu, 29 Mar 2007 11:44:22 -0400
Message-ID: <11751830653835-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu> <11751830651361-git-send-email-tytso@mit.edu> <11751830654112-git-send-email-tytso@mit.edu> <11751830652803-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwnj-0003tu-2z
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbXC2Pob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXC2Poa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:30 -0400
Received: from thunk.org ([69.25.196.29]:36578 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbXC2Po3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:29 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtd-0007J5-Q6; Thu, 29 Mar 2007 11:50:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xt-IZ; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830652803-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43441>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5de2433..f73072a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -73,13 +73,13 @@ resolve_symlink_merge () {
 		cleanup_temp_files --save-backup
 		return
 		;;
-	   [rR]*)
+	    [rR]*)
 		git-checkout-index -f --stage=3 -- "$path"
 		git-add -- "$path"
 		cleanup_temp_files --save-backup
 		return
 		;;
-	    [qQ]*)
+	    [aA]*)
 		exit 1
 		;;
 	    esac
@@ -96,12 +96,12 @@ resolve_deleted_merge () {
 		cleanup_temp_files --save-backup
 		return
 		;;
-	   [dD]*)
+	    [dD]*)
 		git-rm -- "$path"
 		cleanup_temp_files
 		return
 		;;
-	    [qQ]*)
+	    [aA]*)
 		exit 1
 		;;
 	    esac
-- 
1.5.1.rc2.1.g8afe-dirty
