From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [PATCH] gitk: Preserve Entry class key bindings for SHA id
Date: Thu, 27 Jan 2011 17:06:25 +0100
Message-ID: <20110127160625.GC519@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jan 27 17:38:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiUrE-0008J2-0R
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 17:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab1A0Qh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 11:37:58 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:35418 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab1A0Qh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 11:37:57 -0500
X-Greylist: delayed 1884 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2011 11:37:56 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 41F675F0048;
	Thu, 27 Jan 2011 17:06:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AKJF5i+Wcy8z; Thu, 27 Jan 2011 17:06:26 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id F0C0D5F0046;
	Thu, 27 Jan 2011 17:06:25 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id D99D080F6C; Thu, 27 Jan 2011 17:06:25 +0100 (CET)
Mail-Followup-To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165582>

If bind is specified for key without any modifier, then any combination
of modifiers may be present in the event. So bind $e $ev "$escript;
break" breaks some useful bindings from Entry class (for example
Ctrl+k).

Signed-off-by: Kacper Kornet <kornet@camk.edu.pl>
---
 gitk |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 9cbc09d..71eebb2 100755
--- a/gitk
+++ b/gitk
@@ -2389,6 +2389,10 @@ proc makewindow {} {
         }
     }
 
+    foreach e $entries {
+        bindtags $e [linsert [bindtags $e] 2 entrybind]
+    }
+
     bind .pwbottom <Configure> {resizecdetpanes %W %w}
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
@@ -2588,12 +2592,8 @@ proc scrollcanv {cscroll f0 f1} {
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
1.7.3.5

-- 
  Kacper Kornet
