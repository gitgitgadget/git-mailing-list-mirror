From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 20:17:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806022012510.13507@racer.site.net>
References: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806021545340.13507@racer.site.net> <20080602154320.GK12896@spearce.org> <alpine.DEB.1.00.0806021659480.13507@racer.site.net>
 <7vej7f7lj5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:20:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3FZX-0006RJ-Qv
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 21:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbYFBTTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYFBTTF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 15:19:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:49297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbYFBTTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 15:19:03 -0400
Received: (qmail invoked by alias); 02 Jun 2008 19:18:59 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 02 Jun 2008 21:18:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199bohfHoJ9Xh0mWB0JL4qmaHgvmIUspK1+UJI4F7
	OVQzsiHNGXmZlq
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vej7f7lj5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83555>

Hi,

On Mon, 2 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > After sending the mail, I actually got an idea:
> >
> > 	.git/logs/attic/<timestamp>/<refname>
> >
> > I think this should work without problems.  In that case, git-gc also 
> > handles the garbage collection.
> 
> I do not like that particular color of the bikeshed, but I'd agree that 
> it certainly is the easiest route from both the implementation and the 
> design point of view.

Okay, how about "deleted-%d.%m.%Y-%H:%M:%S" instead of "attic/%s"?

> All of the "hard stuff" Shawn mentions goes away, and you are left with 
> only one new "hard stuff", which is much easier to solve:
> 
>  - Should there be a way to really remove the archived reflog?
> 
> And my answer is "yes, a new subcommand to 'git-reflog' to list and
> another subcommand to remove one".

You mean a subcommand to list just the refs that exist in the deleted-* 
namespace?

As to remove one, how about:

	 git reflog --expire=now --expire-unreachable=now \
		deleted-<date>/<refname>

Hmm?

> As to default behaviour, probably we would by default archive any local 
> branches, and _not_ archive other things like remote trackers and tags.  

Unfortunately, this is exactly what I need: remote trackers and tags.  
Since I have to delete branches from repo.or.cz as long as the pruning of 
forked projects' objects does not work correctly.

> A new configuration variable reflog.archive = {none,heads,all} would be 
> honored and absense of it defaults to reflog.archive = heads.

Sure, that makes sense.  I'd just "git config --global reflog.archive 
all".

Ciao,
Dscho
