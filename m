From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Date: Fri, 25 Jul 2008 17:05:44 -0500
Message-ID: <20080725220544.GD23202@spearce.org>
References: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com> <20080724132853.GA25313@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Murphy, John" <john.murphy@bankofamerica.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVQz-0006he-JS
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 00:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYGYWFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 18:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYGYWFp
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 18:05:45 -0400
Received: from george.spearce.org ([209.20.77.23]:42286 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYGYWFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 18:05:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 41314383A5; Fri, 25 Jul 2008 22:05:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080724132853.GA25313@toroid.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90128>

Abhijit Menon-Sen <ams@toroid.org> wrote:
> At 2008-07-24 09:01:48 -0400, john.murphy@bankofamerica.com wrote:
> >
> > I presume this was just an oversight when git- commands were removed
> > from the bin directory.
> 
> Looks like it. The following patch fixes it for me. Does it work for
> you on Windows?

Thanks.

This patch is obviously correct on any platform except Mac OS X.
On Mac OS X it gets confusing because [info nameofexecutable] is
a wrapper .app which loads its own main script.  That main script
needs to use the gitk location it receives from git-gui, and not
the location it computes from gitexecdir.  So I'm following up
your patch with this:

diff --git a/macosx/AppMain.tcl b/macosx/AppMain.tcl
index 41ca08e..ddbe633 100644
--- a/macosx/AppMain.tcl
+++ b/macosx/AppMain.tcl
@@ -7,7 +7,7 @@ if {[string first -psn [lindex $argv 0]] == 0} {
 }
 
 if {[file tail [lindex $argv 0]] eq {gitk}} {
-	set argv0 [file join $gitexecdir gitk]
+	set argv0 [lindex $argv 0]
 	set AppMain_source $argv0
 } else {
 	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]
 
-- 
Shawn.
