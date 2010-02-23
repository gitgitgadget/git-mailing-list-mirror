From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GITK PATCH 3/3] gitk: strip prefix from filenames in
 subdirectories
Date: Tue, 23 Feb 2010 18:12:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231811021.3980@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de> <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com> <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302> <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kirill <kirillathome@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:12:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyJU-0004Di-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0BWRMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:12:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:57319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407Ab0BWRMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:12:42 -0500
Received: (qmail invoked by alias); 23 Feb 2010 17:12:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 23 Feb 2010 18:12:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BZuUKnWoBIqWAFzT6XF5jTZ6i4f19Y949P0+8nR
	gYspIssWtHd8qg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140816>


Again in the lower right panel, where the file names of the files touched
by the current commit are clickable: let's not show the prefix when we
are in a subdirectory, as it wastes precious screen estate conveying
information the user already knows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Sorry, I tested 1/3 only in the gitk-git/ subdirectory. And of 
	course, I was bitten by the fact that this subdirectory is pulled
	using the subtree strategy, so there are files in the history 
	which lack the prefix. Therefore, I saw the files even if the fix
	was incomplete.

 gitk-git/gitk |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bad9ebc..0b2c351 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3203,10 +3203,14 @@ proc unhighlight_filelist {} {
 }
 
 proc add_flist {fl} {
-    global cflist
+    global cflist pathprefix
 
     $cflist conf -state normal
+    set l [string length $pathprefix]
     foreach f $fl {
+        if {$l > 0 && [string compare -length $l $pathprefix $f] == 0} {
+	    set f [string range $f $l end]
+	}
 	$cflist insert end "\n"
 	$cflist insert end $f [highlight_tag $f]
     }
-- 
1.6.4.297.gcb4cc
