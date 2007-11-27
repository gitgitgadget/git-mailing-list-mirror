From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Tue, 27 Nov 2007 10:48:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271045430.27959@racer.site>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
 <20071127015248.GK14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 11:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwxzQ-0003k5-Kt
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXK0KsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 05:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbXK0KsI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:48:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:51878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbXK0KsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:48:07 -0500
Received: (qmail invoked by alias); 27 Nov 2007 10:48:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp037) with SMTP; 27 Nov 2007 11:48:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g3LgpE3Kg6I95+M0QwXTSUCvtVZ49nQ5RlwmZDv
	f23ryENSTi1iT5
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127015248.GK14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66182>

Hi,

On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

> Marco Costalba <mcostalba@gmail.com> wrote:
> > Now instead of --pretty=raw a custom made --pretty=format is given,
> > this shrinks loaded data of 30% (17MB less on Linux tree) and gives a
> > good speed up when you are low on memory (especially on big repos)
> > 
> > Next step _would_ be to load log message body on demand (another 50%
> > reduction) but this has two drawbacks:
> > 
> > (1) Text search/filter on log message would be broken
> > 
> > (2) Slower to browse through revisions because for each revision an
> > additional git-rev-list /git-log command should be executed to read
> > the body
> > 
> > The second point is worsted by the fact that it is not possible to
> > keep a command running and "open" like as example git-diff-tree
> > --stdin and feed with additional revision's sha when needed. Avoiding
> > the burden to startup a new process each time to read a new log
> > message given an sha would let the answer much more quick especially
> > on lesser OS's
> > 
> > Indeed there is a git-rev-list --stdin option but with different
> > behaviour from git-diff-tree --stdin and not suitable for this.
> 
> There was a proposed patch for git-cat-file that would let you run
> it in a --stdin mode; the git-svn folks wanted this to speed up
> fetching raw objects from the repository.  That may help as you
> could get commit bodies (in raw format - not reencoded format!)
> quite efficiently.
> 
> Otherwise I think what you really want here is a libgit that you can
> link into your process and that can efficiently inflate an object
> on demand for you.  Like the work Luiz was working on this past
> summer for GSOC.  Lots of downsides to that current tree though...
> like die() kills the GUI...

But then, die() calls die_routine, which you can override.  And C++ has 
this funny exception mechanism which just begs to be used here.  The only 
thing you need to add is a way to flush all singletons like the object 
array.

Ciao,
Dscho
