From: =?iso-8859-1?Q?Fr=E9d=E9ric_Jolliton?= 
	<gmane@frederic.jolliton.com>
Subject: [PATCH] gitk doesn't handle filenames with space correctly
Date: Sat, 07 Apr 2007 03:22:59 +0200
Message-ID: <86slbd6kr0.fsf@mau.intra.tuxee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 04:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha0Na-0002QF-TA
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbXDGCKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 6 Apr 2007 22:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXDGCKL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:10:11 -0400
Received: from main.gmane.org ([80.91.229.2]:52100 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965085AbXDGCKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:10:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ha0NO-0001pg-Ne
	for git@vger.kernel.org; Sat, 07 Apr 2007 04:10:02 +0200
Received: from tuxee.net ([82.241.80.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Apr 2007 04:10:02 +0200
Received: from gmane by tuxee.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Apr 2007 04:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: tuxee.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:gQfV7+vWm1pFo0GwM/aSQoKJ+t0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43955>

Hi,

Here is an attempt to fix gitk such that it can display filenames with
space correctly, in the right column (Patch/Tree). I don't know TCL, so
probably that a better solution exists.

--- gitk.orig	2007-04-07 02:36:05.000000000 +0200
+++ gitk	2007-04-07 03:13:16.000000000 +0200
@@ -4114,8 +4114,7 @@
=20
     while {[gets $gtf line] >=3D 0} {
 	if {[lindex $line 1] ne "blob"} continue
-	set sha1 [lindex $line 2]
-	set fname [lindex $line 3]
+	regexp {^[^ ]+ [^ ]+ ([^ ]+)\t(.*)} $line -> sha1 fname
 	lappend treefilelist($id) $fname
 	lappend treeidlist($id) $sha1
     }
@@ -4324,7 +4323,7 @@
 	}
 	return
     }
-    set file [lindex $line 5]
+    regexp {^[^ ]+ [^ ]+ [^ ]+ [^ ]+ [^ ]+\t(.*)} $line -> file
     lappend treediff $file
 }

--=20
=46r=E9d=E9ric Jolliton
