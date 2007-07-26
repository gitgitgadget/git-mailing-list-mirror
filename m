From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 15:34:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261527040.14781@racer.site>
References: <Pine.LNX.4.64.0707260630570.14781@racer.site> <85ir8790lj.fsf@lola.goethe.zz>
 <20070726070744.GD18114@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE4QB-0006BI-6M
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760404AbXGZOe2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759649AbXGZOe2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:34:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:35734 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759629AbXGZOe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 10:34:27 -0400
Received: (qmail invoked by alias); 26 Jul 2007 14:34:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 26 Jul 2007 16:34:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kiJoO+fpk5GQZdcT7S+YJ++oI2FwFdrTX/v7B6O
	JiDNVHxCDwqk7N
X-X-Sender: gene099@racer.site
In-Reply-To: <20070726070744.GD18114@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53835>

Hi,

On Thu, 26 Jul 2007, Shawn O. Pearce wrote:

> [talk about the --unidiff-zero stuff]
> 
> Yea, there's context there.  Junio and I talked about this patch on #git 
> a few minutes ago.  I really appreciate that Dscho wrote it, especially 
> given that he hasn't really been into Tcl hacking for Git much before.

Heh.  I did my share of Tcl hacking.  In one (closed source) project, I 
was in constant awe why the devs chose Tcl as a scripting language, but Qt 
as windowing library (back when it was pretty expensive for a startup to 
use Qt).

> But I'd really like to save/create context, like `git add -i` does, so 
> that we don't have to use --unidiff-zero here.

See below.

> It won't matter if git-apply rejected overlapping context in this case.  
> git-gui will only ever feed one hunk at a time to git-apply. And if 
> things get really f'd in the diff buffer the user can easily regenerate 
> it (right click, Refresh).

But you're right, the other hunk headers should be updated.  I'll have a 
look at it this weekend.

> Right now git-gui's apply doesn't correctly update the other hunk 
> headers when you apply a hunk.  I've seen git-apply fail on some hunks 
> just for this reason.  Refreshing the diff (so git recomputes the 
> headers) works around the issue.  So I'm a little worried about using 
> --unidiff-zero here.

Okay, but just using more context means that you also have to _update_ the 
context of another hunk.  Imagine this:

--- a/x
+++ a/x
 one line
-a removed one
+an added one
 another line

Now you split between the "-" and "+" line.  If you stage the first hunk, 
not only do you have to update the hunk header of the second hunk (now the 
only one shown), which you already hinted should be done; you _also_ have 
to update the context in the second hunk, since it changed.

This is just tricky enough that I am tempted to have a go at it.  Not 
today, though, since I have other work to do, and the issues are easier to 
work around for the moment than to work around the lack of "Split Hunk" 
for me.

BTW did you think about any kind of integrity checking, i.e. see if the 
files involved still have the same hashes as when the diff was generated?  
It _is_ possible to use git-gui _and_ the command line...

Ciao,
Dscho
