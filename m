From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Thu, 31 Jul 2008 14:53:02 +0200
Message-ID: <20080731125302.GB18106@leksak.fem-net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness> <20080730121454.GA8767@leksak.fem-net> <alpine.LSU.1.00.0807301556140.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXfU-0005rS-09
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbYGaMxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYGaMxF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:53:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:45834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752524AbYGaMxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:53:04 -0400
Received: (qmail invoked by alias); 31 Jul 2008 12:53:03 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 31 Jul 2008 14:53:03 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/pofZ7miDpLeXIh8SGVGbvMOcqpdrymzQYtf1wyU
	d1js2TnJlG8vm1
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOXeQ-0004jj-8H; Thu, 31 Jul 2008 14:53:02 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807301556140.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90942>

Hi,

Johannes Schindelin wrote:
> > > > +--onto=<base>::
> > > > +	Checkout given commit or branch before sequencing.
> > > > +	If you provide a branch, sequencer will make the provided
> > > > +	changes on the branch, i.e. the branch will be changed.
> > > 
> > > Whoa, does that mean that
> > > 
> > > 	$ git checkout my-private-branch
> > > 	$ git sequencer --onto=master
> > > 
> > > will change _master_?
> > 
> > Exactly.
> 
> /me does not like that.  I could see a new porcelain doing that, but not 
> the thing that will be called by rebase.

$ git sequencer --onto=master todofile

is equal to:

$ git checkout $(git rev-parse master)          # detached HEAD
$ git sequencer todofile
And when successfully finished:
	$ git update-ref refs/heads/master HEAD # reattach branch

Yet this seemed to be useful.
(But perhaps the name --onto is wrong...)

> > > > +	--include-merges;;
> > > > +		Sanity check does not fail if you have merges
> > > > +		between HEAD and <mark>.
> > > 
> > > It may be a commit, too, right?  And why does it make sense to check that 
> > > there are no merges?  I mean, it is just as if I did two cherry-picks, the 
> > > second with -n, and then commit --amend it.  Can make tons of sense...
> > 
> > I think I mean something different. With "merges" I am talking about
> > commits having more than one parent.
> 
> Yes, I read "merges" the same way.  My comment still stands.

If you really mean that it's the same as doing two cherry-picks and
squashing the second into the first, I don't get what your comment has
in common with merges.

If you mean squashing a merge and some cherry-picks on top of that merge
into one merge commit: that is possible. It's only checked that no merges
are *in between* currently.

In graphics: squashing

           ..--M--X--Y-                   ..-A--M--X--Y
              /                                /
           ..-                              ..-

            is allowed                 is only allowed with
                                       --include-merges

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
