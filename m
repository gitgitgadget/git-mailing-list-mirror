From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout_entry: only try to create directories when no
 file existed there
Date: Wed, 8 Aug 2007 22:42:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708082239120.21857@racer.site>
References: <Pine.LNX.4.64.0708082200240.14781@racer.site>
 <7v4pj93evc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItJD-0000lx-1B
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936322AbXHHVnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936021AbXHHVnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:43:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:37219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934903AbXHHVnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:43:08 -0400
Received: (qmail invoked by alias); 08 Aug 2007 21:43:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 08 Aug 2007 23:43:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8ONIZUT28NGoTg/ik1+hLbJVdlXBPdZhZdASvWN
	v+mM19GZedf8J5
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pj93evc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55374>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is obvious that we do not have to create directories when the file we
> > want to check out already existed.
> 
> It is not so obvious to me.  In fact I vaguely recall we had
> complaint about opposite case where we did not honor a symlink
> to be checked out as a symlink because an earlier branch had it
> as a directory.

That case is not affected by my patch, AFAICT.  It only affects the case 
when you check out an entry, say "a/b/c/d/e/f/g".  If that file already 
exists, we have to remove it, in order to write over it.  That's the 
"unlink" which is above the hunk of the diff I sent.

Now, if we have to remove it, we did a stat() before that.  It succeeded.  
So we know that "a/b/c/d/e/f/" exists.  It might contain some symlinks, 
but it exists.

So putting the "create_directories()" into the else branch, we avoid doing 
unnecessary work.

Coincidentally, my hackish use case (don't try this at home, kids!) is 
fixed, too.

Ciao,
Dscho
