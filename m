From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 23:26:37 -0400
Message-ID: <20080625032636.GS11793@spearce.org>
References: <20080624160224.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLfk-0003U5-5d
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYFYD04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbYFYD04
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:26:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57612 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYFYD0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:26:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBLeM-0001gH-ME; Tue, 24 Jun 2008 23:26:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3327120FBAE; Tue, 24 Jun 2008 23:26:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080625120832.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86209>

 <nanako3@lavabit.com> wrote:
> Quoting Junio C Hamano <gitster@pobox.com>:
> > Miklos Vajna <vmiklos@frugalware.org> writes:
> >> On Tue, Jun 24, 2008 at 04:16:36PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> >>> It most likely makes sense to do (3) anyway.  upload-pack, receive-pack,
> >>> anything else?
> >>
> >> I think that's all.
> >
> > Then that would be this patch on top of nd/dashless topic.
> >
> >  Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 929136b..babf16b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1268,7 +1268,7 @@ install: all
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> >  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> > -	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
> > +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
> >  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> >  ifndef NO_TCLTK
> 
> Doesn't "git archive --remote=<repo>" also execute git program on a remote machine?

Yes, it runs git-upload-archive on the remote side.  The three
primary services for the remote side are documented in daemon.c:

    403 static struct daemon_service daemon_service[] = {
    404     { "upload-archive", "uploadarch", upload_archive, 0, 1 },
    405     { "upload-pack", "uploadpack", upload_pack, 1, 1 },
    406     { "receive-pack", "receivepack", receive_pack, 0, 1 },
    407 };

(with git- prefixes).

IMHO all three need to be in $PATH, along with git and gitk, through
at least a major revision release cycle to give clients a chance to
upgrade to something that uses "git foo" rather than "git-foo" when
talking to the remote.

-- 
Shawn.
