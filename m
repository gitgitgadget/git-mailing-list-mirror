From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 04:15:50 +0200
Message-ID: <20060726021550.GX13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060726010358.20964.80443.stgit@machine> <7vhd15cfaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L.Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Jul 26 04:16:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5YwG-00032A-23
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 04:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWGZCPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 22:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWGZCPx
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 22:15:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52121 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030362AbWGZCPw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 22:15:52 -0400
Received: (qmail 26075 invoked by uid 2001); 26 Jul 2006 04:15:50 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd15cfaj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24201>

Dear diary, on Wed, Jul 26, 2006 at 03:42:44AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/perl/private-Error.pm b/perl/private-Error.pm
> > index ebd0749..8fff866 100644
> > --- a/perl/private-Error.pm
> > +++ b/perl/private-Error.pm
> > @@ -290,6 +288,14 @@ use vars qw(@EXPORT_OK @ISA %EXPORT_TAGS
> >  
> >  @ISA = qw(Exporter);
> >  
> > +
> > +sub blessed {
> > +	my $item = shift;
> > +	local $@; # don't kill an outer $@
> > +	ref $item and eval { $item->can('can') };
> > +}
> 
> Hmmm.  I wonder how this relates to what Merlyn actually said?
> 
>         From: merlyn@stonehenge.com (Randal L. Schwartz)
>         Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
>         Date: 10 Jul 2006 18:42:35 -0700
>         Message-ID: <863bd8nchg.fsf@blue.stonehenge.com>
>         Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
>         To: Petr Baudis <pasky@suse.cz>
> 
>         >>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
>         Randal> sub blessed {
>         Randal> my $item = shift;
>         Randal> local $@; # don't kill an outer $@
>         Randal> ref $item and eval { $item->can('can') };
>         Randal> }
> 
>         Randal> Oops, lose the local $@ line.  Just found out this is a
>         Randal> broken thing in current Perls.  The rest is good though.
> 
>         And thirdly, ignore what I *just* said, and concentrate on what
>         I *previously* said, becaused my testing was off.
> 
> My reading is that (1) the part of the patch should read
> something like this:
> 
>         sub blessed {
>                 my $item = shift;
>                 ref $item and eval { $item->can('can') };
>         }

I don't know, from my late-night understanding it should have the local
line... :-)

> and (2) Merlyn thinks there is a bigger problem than using Scalar::Util
> which should be dealt with first.  Was the use of try{}catch{}
> syntax sugar (and it is easy to leak memory) the issue?  How was
> that resolved?

We never got to producing anything that could trigger the memleak, at
least I wasn't able to reproduce it based on the rather vague
description.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
