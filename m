From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 3/4] gitk: Remember time zones from author and commit timestamps
Date: Fri, 19 Nov 2010 02:38:19 -0500
Message-ID: <1290152300-21393-3-git-send-email-andersk@mit.edu>
References: <1290152300-21393-1-git-send-email-andersk@mit.edu>
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 08:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJLYb-0002wQ-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 08:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab0KSHib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 02:38:31 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:44086 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839Ab0KSHiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 02:38:25 -0500
X-AuditID: 12074425-b7c98ae000000a04-d9-4ce62970ca5c
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 5A.BF.02564.07926EC4; Fri, 19 Nov 2010 02:38:24 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id oAJ7cOwS014062;
	Fri, 19 Nov 2010 02:38:24 -0500
Received: from localhost (ET-TWENTY-THREE.MIT.EDU [18.208.1.23])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAJ7cNRZ019341;
	Fri, 19 Nov 2010 02:38:24 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1290152300-21393-1-git-send-email-andersk@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161727>

When resolving a conflicted cherry-pick, this lets us pass
GIT_AUTHOR_DATE to git citool with the correct timezone.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk-git/gitk |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 61f2e95..acdbd21 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -644,7 +644,7 @@ proc newvarc {view id} {
 	if {![info exists commitinfo($id)]} {
 	    parsecommit $id $commitdata($id) 1
 	}
-	set cdate [lindex $commitinfo($id) 4]
+	set cdate [lindex [lindex $commitinfo($id) 4] 0]
 	if {![string is integer -strict $cdate]} {
 	    set cdate 0
 	}
@@ -1626,10 +1626,10 @@ proc parsecommit {id contents listed} {
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
@@ -10957,7 +10957,7 @@ proc prefsok {} {
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	set d [clock format $d -format $datetimeformat]
+	set d [clock format [lindex $d 0] -format $datetimeformat]
     }
     return $d
 }
-- 
1.7.3.2
