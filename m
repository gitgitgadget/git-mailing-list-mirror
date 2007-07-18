From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Tue, 17 Jul 2007 23:29:07 -0400
Message-ID: <20070718032907.GY32566@spearce.org>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site> <Pine.LNX.4.64.0707172216420.14596@iabervon.org> <Pine.LNX.4.64.0707172302560.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 05:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB0E1-0007sA-Ek
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 05:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbXGRD3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 23:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbXGRD3O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 23:29:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50600 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXGRD3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 23:29:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IB0Dh-00075j-Vm; Tue, 17 Jul 2007 23:28:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8337320FBAE; Tue, 17 Jul 2007 23:29:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707172302560.14596@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52826>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> (Someday, I'd like to have a diff that can show that a substantial block 
> of '+' lines matches a block of lines from somewhere in the "before" 
> content, so reviewers can verify that the patch reorders code but doesn't 
> change it, or changes it in certain ways. But, of course, that's both hard 
> to generate and hard to display usefully.)

I just moved a huge block in git-gui so I have a great example...

What about a patch format like this?  I doubt people move more than
26 blocks in the same patch of the same file, so using a single
character block prefix when the before/after images are identical
might work OK.

diff --git a/git-gui.sh b/git-gui.sh
index 0443129..f13fa80 100755
--- a/git-gui.sh
+++ b/git-gui.sh
a@@ -632,6 +632,43 a@@ You are using [git-version]:
  
  ######################################################################
  ##
a+## feature option selection
a+
a+if {[regexp {^git-(.+)$} [appname] _junk subcommand]} {
a+	unset _junk
a+} else {
a+	set subcommand gui
a+}
a+if {$subcommand eq {gui.sh}} {
a+	set subcommand gui
a+}
a+if {$subcommand eq {gui} && [llength $argv] > 0} {
a+	set subcommand [lindex $argv 0]
a+	set argv [lrange $argv 1 end]
a+}
a+
a+enable_option multicommit
a+enable_option branch
a+enable_option transport
a+
a+switch -- $subcommand {
a+browser -
a+blame {
a+	disable_option multicommit
a+	disable_option branch
a+	disable_option transport
a+}
a+citool {
a+	enable_option singlecommit
a+
a+	disable_option multicommit
a+	disable_option branch
a+	disable_option transport
a+}
a+}
a+
a+######################################################################
a+##
  ## repository setup
  
  if {[catch {
a@@ -1598,43 +1635,6 a@@ apply_config
  
  ######################################################################
  ##
a-## feature option selection
a-
a-if {[regexp {^git-(.+)$} [appname] _junk subcommand]} {
a-	unset _junk
a-} else {
a-	set subcommand gui
a-}
a-if {$subcommand eq {gui.sh}} {
a-	set subcommand gui
a-}
a-if {$subcommand eq {gui} && [llength $argv] > 0} {
a-	set subcommand [lindex $argv 0]
a-	set argv [lrange $argv 1 end]
a-}
a-
a-enable_option multicommit
a-enable_option branch
a-enable_option transport
a-
a-switch -- $subcommand {
a-browser -
a-blame {
a-	disable_option multicommit
a-	disable_option branch
a-	disable_option transport
a-}
a-citool {
a-	enable_option singlecommit
a-
a-	disable_option multicommit
a-	disable_option branch
a-	disable_option transport
a-}
a-}
a-
a-######################################################################
a-##
  ## ui construction
  
  set ui_comm {}
-- 
1.5.3.rc1.818.g84b7


-- 
Shawn.
