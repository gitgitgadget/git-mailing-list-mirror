From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: gitk: Failure of new tabbed preferences dialog
Date: Thu, 29 Mar 2012 18:31:29 +0100
Message-ID: <4F749C71.7050201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Thu Mar 29 20:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJrD-0002Jw-Iq
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 20:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933675Ab2C2SNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 14:13:54 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:45762 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933464Ab2C2SNx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 14:13:53 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SDJr5-0001ic-nE; Thu, 29 Mar 2012 18:13:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194283>

Hi Pat,

I just tried the new gitk (master @fae9d76) and, since I don't have
themed widgets, the preferences menu item uses the emulated tabbed
dialog code, which fails like so:

    can't read "col": no such variable
    can't read "col": no such variable
        (reading value of variable to increment)
        invoked from within
    "incr col"
        (procedure "doprefs" line 36)
        invoked from within
    "doprefs"
        (menu invoke)

I tried the following (maybe *too* obvious) fix:

-- >8 --
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 651b740..68cd1a1 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11012,6 +11012,7 @@ proc doprefs {} {
     lappend pages [prefspage_general $notebook] [mc "General"]
     lappend pages [prefspage_colors $notebook] [mc "Colors"]
     lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
+    set col 0
     foreach {page title} $pages {
 	if {$use_notebook} {
 	    $notebook add $page -text $title
-- 8< --

which seems to work.

HTH

ATB,
Ramsay Jones
