From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: instead of defaulting to home directory use
	working directory
Date: Sun, 6 Feb 2011 18:22:46 +0100
Message-ID: <20110206172244.GC47941@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm8K7-00070e-LA
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1BFRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 12:22:50 -0500
Received: from darksea.de ([83.133.111.250]:58124 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752744Ab1BFRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 12:22:49 -0500
Received: (qmail 7990 invoked from network); 6 Feb 2011 18:22:47 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Feb 2011 18:22:47 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166155>

When starting git gui in a non-git directory it presents the user a
dialog which asks to create, clone or open a repository. The filedialogs
used to choose the path(s) would always default to the home directory of
the user. This patch changes this behavior and uses the current working
directory in which git gui was started as default.

This is useful in various cases. First being that the user starts the
gui in some directory and can go search to create, open or clone a
repository from there. Another use case is that tools like filemanager
context menues can transport a natural default when selected from a
folder.

Users who like to have their home folder as a default can fall back on
starting git gui with its working directory set to the home folder.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 lib/choose_repository.tcl |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index fae1192..657f7d5 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -214,14 +214,6 @@ constructor pick {} {
 	}
 }
 
-proc _home {} {
-	if {[catch {set h $::env(HOME)}]
-		|| ![file isdirectory $h]} {
-		set h .
-	}
-	return $h
-}
-
 method _center {} {
 	set nx [winfo reqwidth $top]
 	set ny [winfo reqheight $top]
@@ -420,7 +412,7 @@ method _new_local_path {} {
 	if {$local_path ne {}} {
 		set p [file dirname $local_path]
 	} else {
-		set p [_home]
+		set p [pwd]
 	}
 
 	set p [tk_chooseDirectory \
@@ -541,7 +533,7 @@ method _open_origin {} {
 	if {$origin_url ne {} && [file isdirectory $origin_url]} {
 		set p $origin_url
 	} else {
-		set p [_home]
+		set p [pwd]
 	}
 
 	set p [tk_chooseDirectory \
@@ -1042,7 +1034,7 @@ method _open_local_path {} {
 	if {$local_path ne {}} {
 		set p $local_path
 	} else {
-		set p [_home]
+		set p [pwd]
 	}
 
 	set p [tk_chooseDirectory \
-- 
1.7.4.34.gd2cb1
