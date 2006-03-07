From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitk : fix missing lines when displaying diff.
Date: Tue, 7 Mar 2006 20:46:48 +0000
Message-ID: <20060307204648.GA13620@localhost>
References: <440DE262.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 21:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGizo-0003wf-Ol
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 21:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWCGUlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCGUlX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 15:41:23 -0500
Received: from igraine.blacknight.ie ([217.114.173.147]:36546 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751336AbWCGUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 15:41:22 -0500
Received: from [87.192.245.67] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.42)
	id 1FGizU-0008Ku-Jw; Tue, 07 Mar 2006 20:41:08 +0000
To: Jacob Kroon <jacob.kroon@gmail.com>
Content-Disposition: inline
In-Reply-To: <440DE262.7020007@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17351>

Lines which are added (removed) and begin with +++ (---) are not shown
correctly when displaying in the diff panel.

The +++ and --- lines are part of the diff header, with the +++
indicating the end of the header.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>


---

 gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

d0da9f04cf565df64a954e1bfd4c5c0913b83322
diff --git a/gitk b/gitk
index f4c6624..5e3c34c 100755
--- a/gitk
+++ b/gitk
@@ -2595,8 +2595,10 @@ proc getblobdiffline {bdf ids} {
        set pad [string range "----------------------------------------" 1 $l]
        $ctext insert end "$pad $header $pad\n" filesep
        set diffinhdr 1
-    } elseif {[regexp {^(---|\+\+\+)} $line]} {
-       set diffinhdr 0
+    } elseif {$diffinhdr == 1 && [regexp {^(---|\+\+\+) } $line]} {
+       if {[regexp {^\+\+\+ } $line]} {
+           set diffinhdr 0
+       }
     } elseif {[regexp {^@@ -([0-9]+),([0-9]+) \+([0-9]+),([0-9]+) @@(.*)} \
                   $line match f1l f1c f2l f2c rest]} {
        $ctext insert end "$line\n" hunksep
--
1.2.3.g20d2
