From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining
 conflicts
Date: Sat, 30 Dec 2006 19:53:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612301944350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org>
 <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyb11ouy.fsf@wine.dyndns.org> <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061229041626.GA12072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexandre Julliard <julliard@winehq.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 19:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jKe-00055c-2z
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 19:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWL3SxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWL3SxV
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 13:53:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:44085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030286AbWL3SxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 13:53:20 -0500
Received: (qmail invoked by alias); 30 Dec 2006 18:53:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 30 Dec 2006 19:53:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061229041626.GA12072@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35624>

Hi,

On Thu, 28 Dec 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 	Thank you Alexandre! I looked for the bug for quite some time, but 
> > 	was never close to the real culprit.
> 
> Thanks for fixing this!
>  
> > +<<<<<<< orig.txt
> > +=======
> > +Nam et si ambulavero in medio umbrae mortis,
> > +non timebo mala, quoniam TU mecum es:
> > +virga tua et baculus tuus ipsa me consolata sunt.
> > +>>>>>>> new5.txt
> 
> As a side note I lately have noticed that xdl_merge is producing a
> conflict like the above when one branch added the lower half and
> the other branch didn't change anything in the area.
> 
> I haven't spent any time to try to reproduce it, or to see if RCS'
> merge utility would automatically merge the file without producing
> a conflict.  But right now it does seem like xdl_merge is producing
> conflicts when I didn't think it should be.

I thought very long about that problem. It looks like a bug, but it is 
not. At least in my humble opinion.

If you touched the same spot in two different versions, say you added a 
fix in one branch, and that fix and a comment in the other one, you might 
be tempted to automatically resolve that conflict, taking the version with 
the comment.

But it helps you catch mismerges: If you add a chunk of identical code in 
the two branches, but with an increment _before_ it in one branch, and 
_after_ it in the other branch, both should be marked as a conflict. 

Of course, you can hit mismerges like the illustrated one _without_ being 
marked as conflict (e.g. if the chunk of identical code is _not_ added, 
but only the increments), but we should at least avoid them where 
possible.

Ciao,
Dscho
