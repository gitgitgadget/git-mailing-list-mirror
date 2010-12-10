From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [PATCH] Preserve Entry class key bindings for SHA id
Date: Fri, 10 Dec 2010 14:34:57 +0100
Message-ID: <20101210133456.GA8517@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 15:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR3eP-0007Yb-AC
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 15:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0LJOIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 09:08:40 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:36001 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393Ab0LJOIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 09:08:39 -0500
X-Greylist: delayed 2015 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2010 09:08:39 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 83A045F004E;
	Fri, 10 Dec 2010 14:35:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id H6Xcr2u2eCWY; Fri, 10 Dec 2010 14:34:57 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2F2D05F0049;
	Fri, 10 Dec 2010 14:34:57 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 1C87880DF1; Fri, 10 Dec 2010 14:34:57 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org, paulus@samba.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163414>

If bind is specified for key without any modifier, then any combination
of modifiers may be present in the event. So bind $e $ev "$escript;
break" breaks some useful bindings from Entry class (for example
Ctrl+k).
---
 gitk |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..0c6f3af 100755
--- a/gitk
+++ b/gitk
@@ -2365,6 +2365,10 @@ proc makewindow {} {
         }
     }
 
+    foreach e $entries {
+        bindtags $e [linsert [bindtags $e] 2 entrybind]
+    }
+
     bind .pwbottom <Configure> {resizecdetpanes %W %w}
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
@@ -2563,12 +2567,8 @@ proc scrollcanv {cscroll f0 f1} {
 proc bindkey {ev script} {
     global entries
     bind . $ev $script
-    set escript [bind Entry $ev]
-    if {$escript == {}} {
-	set escript [bind Entry <Key>]
-    }
     foreach e $entries {
-	bind $e $ev "$escript; break"
+	bind entrybind $ev "break"
     }
 }
 
-- 
1.7.3.3


-- 
  Kacper Kornet
