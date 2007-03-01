From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-revert & git-cherry-pick a builtin
Date: Thu, 1 Mar 2007 23:24:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012318020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm6xqj0d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703012230290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070301215123.GB9254@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMthR-0002Dk-3q
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbXCAWYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbXCAWYa
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:24:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:41833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161027AbXCAWY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:24:29 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:24:27 -0000
X-Provags-ID: V01U2FsdGVkX1/qEb5YdmPqyWSsCAGDI4paa8Z4K2+piCCCO9fRlr
	2Om233Z7NJv2nj
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070301215123.GB9254@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41137>

Hi,

On Thu, 1 Mar 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > +static int merge_recursive(const char *base_sha1,
> > > > +		const char *head_sha1, const char *head_name,
> > > > +		const char *next_sha1, const char *next_name)
> > > > +{
> > > > + ...
> > > > +}
> > > 
> > > Somehow I would have expected you to call merge-recursive not spawn, 
> > > but this is saner ;-).
> > 
> > I briefly considered this, until I realized that merge-recursive is no 
> > builtin yet!
> 
> Heh, I expected the same thing as Junio when I first read through the 
> patch.  But then I realized that doing so right now might not be a great 
> idea; normally if merge-recursive aborts we say "fix up and commit" and 
> do a few things still in cherry-pick/revert before giving the shell back 
> to the user.

IIRC merge-recursive does not quit early with an exit(), rather returns 
the exit status from the main() routine. So, it would be a matter of 
making merge-recursive a builtin, separating the main() method in 
merge_recursive() and an option parsing cmd_merge_recursive(), and call it 
from revert.

I admit that I was a little too uneasy to do that, what with the object 
flags and all, but it _should_ work. After all, merge-recursive is 
_recursive_, so we had to make sure that everything was properly cleaned 
up after each iteration.

> > Speaking of this issue: Would it be conceivable to make the 
> > standalones into builtins? (This adds a dependency on libcurl to core 
> > Git programs, but I could live with that... It would make a builtin 
> > fetch easier, too.)
> 
> Please don't make libcurl required.  I don't build with it on Solaris, 
> because its not there, and I don't need it there.

I don't mean to make it required. I mean to link git$X to it. That would 
mean that even a silly git-rev-parse dynamically links to libcurl, iff 
curl support is enabled...

Ciao,
Dscho
