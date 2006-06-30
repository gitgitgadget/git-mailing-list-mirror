From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 19:04:15 +0200
Message-ID: <E1FwMPf-0005XA-N9@moooo.ath.cx>
References: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 19:04:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMPo-000058-6o
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWF3REV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWF3REU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:04:20 -0400
Received: from moooo.ath.cx ([85.116.203.178]:40089 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751810AbWF3REU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 13:04:20 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22999>

> Side note.  It would be interesting to have a slightly different
> form of --and called --near.  You would use it like this:
> 
> 	git grep -C -e AND --near -e OR
> 
> to find lines that has AND on it, and within the context
> distance there is a line that has OR on it.  The lines that are
> hit with such a query are still the ones that have AND on them
> (in other words, a line that has OR is used to further filter
> out the results so it will be prefixed with '-', not ':', unless
> that line happens to also have AND on it).
Nice idea even though I don't now about practical importance but it
sounds quite handy.  A few questions about this (some or all of those
features may make it quite complex):
1. Should the context of near be the same as -[ABC] or perhaps
   --near=N / --near=N:M (default could be the same as specified by
   -[ABC]).
2. Should it be possible to specify another boolean expression after
   --near? e.g. --near ( -e foo --or ( -e bar --and -e baz )) to match
   if the context contains foo or 'bar and baz'.
3. Is --near just another subexpression? e.g. search for foo with
   either A or B in the context:
   -e foo --and ( --near A --or --near B )
   This does not make sense without 1 and 2.

With some or all of those features quite mighty and complex
expressions can be build:
-e A --and --near=3:-1 ( -e B --and --near=0:0 ( -e foo --and -e bar ) )
This could mean: find lines containing A and have B in any of the 3
lines before A (without the line containing A). Additionally foo and
bar have to be found on the same line before A.

I'm really not asking for this, just telling about some ideas that
come to my mind for --near.

> With your syntax perhaps this is spelled as "--near -C -e AND -e
> OR".
Huh? What do you mean by "my syntax"? The only thing different is the
option to change the default operator to 'and'.

With the new extended expressions it would be really nice if git-grep
could also be used outside a git repository :)
