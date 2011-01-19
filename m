From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 2/3] gitk: Remember time zones from author and commit
 timestamps
Date: Wed, 19 Jan 2011 14:47:25 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101191447040.23868@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfe0F-0000RN-KY
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1ASTr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:47:29 -0500
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:50852 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754012Ab1ASTr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:47:29 -0500
X-AuditID: 12074423-b7bd0ae000000a00-34-4d373fd03240
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 84.48.02560.0DF373D4; Wed, 19 Jan 2011 14:47:28 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p0JJlRwu015793;
	Wed, 19 Jan 2011 14:47:28 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p0JJlQ9N020392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Jan 2011 14:47:27 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165287>

When resolving a conflicted cherry-pick, this lets us pass
GIT_AUTHOR_DATE to git citool with the correct timezone.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index bf68959..5c6058a 100755
--- a/gitk
+++ b/gitk
@@ -659,7 +659,7 @@ proc newvarc {view id} {
 	if {![info exists commitinfo($id)]} {
 	    parsecommit $id $commitdata($id) 1
 	}
-	set cdate [lindex $commitinfo($id) 4]
+	set cdate [lindex [lindex $commitinfo($id) 4] 0]
 	if {![string is integer -strict $cdate]} {
 	    set cdate 0
 	}
@@ -1641,10 +1641,10 @@ proc parsecommit {id contents listed} {
 	set line [split $line " "]
 	set tag [lindex $line 0]
 	if {$tag == "author"} {
-	    set audate [lindex $line end-1]
+	    set audate [lrange $line end-1 end]
 	    set auname [join [lrange $line 1 end-2] " "]
 	} elseif {$tag == "committer"} {
-	    set comdate [lindex $line end-1]
+	    set comdate [lrange $line end-1 end]
 	    set comname [join [lrange $line 1 end-2] " "]
 	}
     }
@@ -11018,7 +11018,7 @@ proc prefsok {} {
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	set d [clock format $d -format $datetimeformat]
+	set d [clock format [lindex $d 0] -format $datetimeformat]
     }
     return $d
 }
-- 
1.7.4.rc1
