From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] gitk: Allow unbalanced quotes/braces in commit headers
Date: Thu, 18 Dec 2008 01:26:48 -0800
Message-ID: <1229592408-15206-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>
To: Paul Mackerras <paulus@samba.org>, demerphq@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 10:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDFBy-00010V-1H
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 10:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbYLRJ16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 04:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYLRJ16
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 04:27:58 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:52978 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYLRJ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 04:27:57 -0500
Received: from randymail-a8.g.dreamhost.com (sd-green-bigip-66.dreamhost.com [208.97.132.66])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 3ABF217E554
	for <git@vger.kernel.org>; Thu, 18 Dec 2008 01:27:56 -0800 (PST)
Received: from localhost.localdomain (c-76-103-250-131.hsd1.ca.comcast.net [76.103.250.131])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 95EA0AEA0F;
	Thu, 18 Dec 2008 01:26:48 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc3.334.g7365d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103449>

When parsing commits, gitk treats the headers of the commit as tcl lists.
This causes errors if the header contains an unbalanced quote or open brace.
Splitting the line on spaces allows us to treat it as a set of words instead
of as a tcl list, which prevents errors.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index a5e24e4..83b45cd 100755
--- a/gitk
+++ b/gitk
@@ -1601,13 +1601,14 @@ proc parsecommit {id contents listed} {
     set header [string range $contents 0 [expr {$hdrend - 1}]]
     set comment [string range $contents [expr {$hdrend + 2}] end]
     foreach line [split $header "\n"] {
+	set line [split $line " "]
 	set tag [lindex $line 0]
 	if {$tag == "author"} {
 	    set audate [lindex $line end-1]
-	    set auname [lrange $line 1 end-2]
+	    set auname [join [lrange $line 1 end-2] " "]
 	} elseif {$tag == "committer"} {
 	    set comdate [lindex $line end-1]
-	    set comname [lrange $line 1 end-2]
+	    set comname [join [lrange $line 1 end-2] " "]
 	}
     }
     set headline {}
-- 
1.6.1.rc3.334.g7365d
