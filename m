From: Junio C Hamano <junkio@cox.net>
Subject: Re: "freezing" gitk geometry
Date: Wed, 14 Feb 2007 09:53:26 -0800
Message-ID: <7vsld8pqw9.fsf@assigned-by-dhcp.cox.net>
References: <e1dab3980702140923m1e4e430ci28f8ed246c5fe786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOKB-0006Jj-M0
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbXBNRx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXBNRx2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:53:28 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56274 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbXBNRx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:53:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214175327.TMSX1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:53:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVtS1W00b1kojtg0000000; Wed, 14 Feb 2007 12:53:27 -0500
In-Reply-To: <e1dab3980702140923m1e4e430ci28f8ed246c5fe786@mail.gmail.com>
	(David Tweed's message of "Wed, 14 Feb 2007 17:23:51 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39706>

"David Tweed" <david.tweed@gmail.com> writes:

> now I've installed 1.5.0, I've discovered gitk is still the
> visualisation tool for graphically browsing history. I think gitk is a
> good program, but one thing I'd like to be able to change is to have a
> way to force gitk not to update its saved internal geometry (position
> of internal dividers, etc) when it exits. I tried making ~/.gitk not
> writable but that didn't work. I don't know tcl: is there a simple way
> to prevent gitk updating this upon quitting?

I do not talk Tcl, but I think you can apply this patch and then
if you add

	set dontsave 1

at the end of ~/.gitk with your editor, it would stop updating
your geometry (or anything else for that matter).

diff --git a/gitk b/gitk
index 9ddff3e..cd0d68d 100755
--- a/gitk
+++ b/gitk
@@ -813,9 +813,10 @@ proc savestuff {w} {
     global maxwidth showneartags
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment
-    global colors bgcolor fgcolor diffcolors
+    global colors bgcolor fgcolor diffcolors dontsave
 
     if {$stuffsaved} return
+    if {$dontsave} return
     if {![winfo viewable .]} return
     catch {
 	set f [open "~/.gitk-new" w]
@@ -6251,6 +6252,7 @@ set bgcolor white
 set fgcolor black
 set diffcolors {red "#00a000" blue}
 
+set dontsave 0
 catch {source ~/.gitk}
 
 font create optionfont -family sans-serif -size -12
