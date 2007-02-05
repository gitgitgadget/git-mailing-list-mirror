From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 5 Feb 2007 12:51:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702051245050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070201234706.GP17617@mellanox.co.il>
 <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 12:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE2O5-0003T0-MV
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXBELvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXBELvg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:51:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:52834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932157AbXBELvf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:51:35 -0500
Received: (qmail invoked by alias); 05 Feb 2007 11:51:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 05 Feb 2007 12:51:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38745>

Hi,

On Fri, 2 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 1 Feb 2007, Junio C Hamano wrote:
> > ...
> >> I am not against the general idea of tracking a subset of
> >> branches, but issues include:
> >>
> >> [explains why git-remote is a better place for this]
> >
> > Seeing your patch to git-remote, it feels more natural, too. 
> > Especially since that (or which? :-D) does not give the term "clone" a 
> > Microsoft'esque completely new meaning.
> 
> I did not find anything MS'esque in what MST did in his patch, though.  
> I think it is a reasonable thing to ask for from a clone.  For example, 
> if you are coming from CVS or have used Cogito, cloning a single branch 
> is not an unusual operation at all.

Oh? Well, to me, "clone" meant something like the genetics thing, i.e. get 
a copy of the repository. Since a "branch" is not the complete repository, 
but only part of it, I would have expected "engraft" instead of "clone" 
there.

But I can learn! So (post-1.5.0, maybe?) I'd be perfectly d'accord with 
something like this

	git clone git://.../git.git#html

to mean "just fetch the branch html, and check it out".

> The real point of my 'remote add -f -t -m' patch is that I think we are 
> much better off to do it in a bottom up way, by having a tool that can 
> be used in any repository first.  Then we could even rewrite 'git clone' 
> along these lines:
> 
> 	#/bin/sh
> 	track="*" ;# command line parameter to override...
> 	... decide what $name to use ...
> 	mkdir "$name"
> 	cd "$name"
> 	git init-db
>         git remote add -f -t "$track" origin $url
> 	git branch -f master remotes/origin/master
> 
> Of course you would need to deal with -n, --bare and stuff, but
> that is a minor detail.

Yeah, that makes sense.

> While I am talking about post 1.5.0 git-clone changes, one thing I've 
> always hated about git-clone is that the cloner always has to guess 
> where the HEAD pointer at the other side points at. This comes from a 
> shortcoming in the fetch-pack protocol (it simply does not tell).  A 
> stupid consequence of this is that cloning over dumb protocols also have 
> to guess, although they are _capable_ of letting the cloner know this 
> information.
> 
> I think the logic to decide where to point remotes/$origin/HEAD to 
> should be moved to "git-remote add -m" when we eventually rewrite 
> "git-clone" to use "git-remote add -f".  And while we would do so, we 
> can make a trivial extension to fetch-pack protocol to carry the HEAD 
> symref information.  All will be good once that happens.

Would you like this as a multi_ack-like extension?

But then how to teach the dumb protocols in a backwards-compatible 
fashion?

Ciao,
Dscho
