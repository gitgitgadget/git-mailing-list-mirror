From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 10:18:24 -0700
Message-ID: <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<E1FwGgm-0006Nc-9a@moooo.ath.cx>
	<7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
	<E1FwMPf-0005XA-N9@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 19:18:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMdT-0001ti-K0
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWF3RS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWF3RS1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:18:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20870 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932477AbWF3RS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 13:18:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630171825.IMIZ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 13:18:25 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FwMPf-0005XA-N9@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 30 Jun 2006 19:04:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23002>

Matthias Lederhofer <matled@gmx.net> writes:

> 1. Should the context of near be the same as -[ABC] or perhaps
>    --near=N / --near=N:M (default could be the same as specified by
>    -[ABC]).

As an end-user, I do not care either way.

> 2. Should it be possible to specify another boolean expression after
>    --near? e.g. --near ( -e foo --or ( -e bar --and -e baz )) to match
>    if the context contains foo or 'bar and baz'.

I would say why not.

> 3. Is --near just another subexpression? e.g. search for foo with
>    either A or B in the context:
>    -e foo --and ( --near A --or --near B )
>    This does not make sense without 1 and 2.

Ah, interesting.  I was thinking --near to be weaker form of --and,
but you made it to be a unary predicate (like --not).  That
would be neater.

> With some or all of those features quite mighty and complex
> expressions can be build:
> -e A --and --near=3:-1 ( -e B --and --near=0:0 ( -e foo --and -e bar ) )
> This could mean: find lines containing A and have B in any of the 3
> lines before A (without the line containing A). Additionally foo and
> bar have to be found on the same line before A.

Having said that, I suspect the above made-up example may not be
so useful in practice.  I think a more realistic usage is "I
want to find lines that contain `made-up' and `realistic' but
the paragraph might have been filled by the editor and they may
be found on separate nearby lines.  Instead of saying `-e
made-up --and -e realistic', I would say `-e made-up --near -e
realistic' to find what I want".  That would find the first two
lines of this paragraph, among others.

> With the new extended expressions it would be really nice if git-grep
> could also be used outside a git repository :)

I am not sure about `outside' but it might be useful to extend
the working tree walker and glob filter used there to match what
ls-files uses so that it can do untracked files as well.
