From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Thu, 29 Jun 2006 11:23:31 -0700
Message-ID: <7vr717rfbw.fsf@assigned-by-dhcp.cox.net>
References: <200606290301.51657.jnareb@gmail.com>
	<E1FvvuX-0002Lr-Nt@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 29 20:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1Ay-0008Dn-UO
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWF2SXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWF2SXh
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:23:37 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45474 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751247AbWF2SXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:23:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629182334.UQFQ27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 14:23:34 -0400
To: Matthias Lederhofer <matled@gmx.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22883>

Matthias Lederhofer <matled@gmx.net> writes:

>> This is beginning of patch series introducing installation configuration
>> using autoconf (and no other autotools) to git. The idea is to generate
>> config.mak using ./configure (generated from configure.ac) from
>> config.mak.in, so one can use autoconf as an _alternative_ to ordinary
>> Makefile, and creating one's own config.mak.
>
> Are you sure this should be named config.mak? From INSTALL:
>> You can place local settings in config.mak and the Makefile
>> will include them.  Note that config.mak is not distributed;
>> the name is reserved for local settings.
>
> So with another filename either include it
> - before config.mak: the user may override ./configure options with
>   config.mak
> - after config.mak: ./configure overrides config.mak
> At least do not overwrite config.mak if it exists.

Think of it as an incredibly smart editor that you can use to
edit your config.mak.  As far as I understand it, this is an
"opt-in" way for you to manage config.mak without editing it
yourself, so I do not have much objections to the series in
principle.

I think it is fair to say that autoconf is not so bad compared
to its worse friends, but I am biased -- I used to deal with
autoconf quite a lot in old days (before there were automake nor
libtool), and my own changes to autoconf might still be
surviving in a few .m4 files but I doubt it it was so long ago.

Having said that, I am skeptical how well we can keep this
contained only to config.mak and keep it "opt-in", so I am not
enthused to have this series at the toplevel of the tree.

It would have been a bit easier to swallow if this whole
machinery to build config.mk were somewhere under contrib/ (say
in contrib/autoconf), with an instruction to make an "opt-in"
symlink "ln -s contrib/autoconf/config.mk config.mk" for people
who want to use it in the toplevel INSTALL file, perhaps.

The one that touches the Makefile to propagate some variables
down to submakes is probably a desirable change but that is
pretty much independent from the series.
