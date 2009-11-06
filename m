From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix blob linenr links in pathinfo mode
Date: Fri,  6 Nov 2009 16:08:41 +0100
Message-ID: <1257520121-17282-1-git-send-email-pasky@suse.cz>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Qao-00069Y-B3
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759353AbZKFPTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759358AbZKFPTA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:19:00 -0500
Received: from rover.dkm.cz ([62.24.64.27]:60244 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759353AbZKFPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:18:59 -0500
Received: by rover.dkm.cz (Postfix, from userid 1001)
	id 8BE61165EAE; Fri,  6 Nov 2009 16:08:41 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132303>

In pathinfo mode, we use <base href> that refers to the base location
of gitweb in order for various external media links to work well.
However, this means that for the page to refer to itself, it must
regenerate full link, and this is exactly what the blob view page
did not do for line numbers.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4cbfc3..62325ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5127,7 +5127,8 @@ sub git_blob {
 			chomp $line;
 			$nr++;
 			$line = untabify($line);
-			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
+			printf "<div class=\"pre\"><a id=\"l%i\" href=\"" . href(-replay => 1)
+				. "#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
 			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
 		}
 	}
-- 
tg: (8cc62c1..) t/blob/pathinfo (depends on: vanilla/master)
