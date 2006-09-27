From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 17:36:07 -0400
Message-ID: <20060927213607.GA21839@spearce.org>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <20060927033459.GA27622@coredump.intra.peff.net> <20060926234309.b16aa44e.seanlkml@sympatico.ca> <20060927042850.GB9460@spearce.org> <7vfyedd3bw.fsf@assigned-by-dhcp.cox.net> <20060927151102.GC20705@spearce.org> <7v1wpx9gwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 23:36:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSh4h-0007SF-J9
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030889AbWI0VgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030891AbWI0VgM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:36:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:11959 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030889AbWI0VgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 17:36:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSh4S-0007w5-P8; Wed, 27 Sep 2006 17:36:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 957E820FB28; Wed, 27 Sep 2006 17:36:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wpx9gwk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27935>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > You are missing:
> > +	setup_ident();
> >
> > Without that reflog can't get the proper committer data from the
> > host's gecos information.  This is probably what is desired for
> > most pushes over SSH.
> 
> What's even more interesting is when there is .git/config file
> and you do not override it with environment variables; the log
> entry will be made under the name of the repository user.name in
> such a case.

Yes.  :-)

Shared repository owners might want to not set user.name in their
config files.

Another way around this would be to create a variation of
git_default_config for use in receive-pack.c that doesn't recognize
user.name/user.email.
 
> >> +	git_config(git_default_config);
> >> +
> >>  	write_head_info();
> 
> Often setup_ident() needs to go together with git_config(), and
> you need to remember that setup must come before config.  These
> rules are a bit cumbersome to follow and I often forget.
> 
> I wonder if we can have a simpler start-up sequence perhaps to
> avoid future mistakes like this?

I think most places we are "starting up" we invoke both, in that
order.  Which sort of implies maybe we could just fold setup_ident
into git_config.

-- 
Shawn.
