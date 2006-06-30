From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 09:46:53 +0200
Message-ID: <E1FwDiI-0007Xp-2s@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDiY-00077F-I9
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWF3HrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWF3HrA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:47:00 -0400
Received: from moooo.ath.cx ([85.116.203.178]:45512 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751398AbWF3Hq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 03:46:58 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22968>

(Junio: please reply to this one, forgot the Cc in the first one :/)

Junio C Hamano wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > OR and AND have precedence, so there are two possibilities, I'd take
> > the first one.
> > 1. OR, AND:
> >     This will make it easier to read because OR can be skipped:
> >       pat1 pat2 AND pat3 pat4
> >     = pat1 OR pat2 AND pat3 OR pat4
> >     = (pat1 OR pat2) AND (pat3 OR pat4)
> > 2. AND, OR:
> >     This is a bit more logic if you think of AND as * and OR as +.
> 
> > ... FOO should not be named --and imo but I don't have any idea
> > for a good name atm.
> 
> I personally feel FOO should not even exist.  An option that
> covers the entire expression to make operator precedence in it
> sounds quite evil.  
> 
> I would say make --and bind tighter than --or and use parentheses as
> needed.
Ok, perhaps changing operator precedence is a bit much. What do you
think of that then:
Operator precedence AND, OR. The FOO options changes the default
operator to AND. This also seems quite natural if you think of
AND as * and OR as +:
A B + C D = A * B + C * D = (A * B) + (C * D)

A few examples to get an impression how the command line could look
like:
A OR B OR (C AND D)    => A B C AND D
(A OR B OR C) AND D    => (A B C) AND D
A AND B AND (C OR D)   => -FOO A B (C OR D)
(A AND B AND C) OR D   => -FOO A B C OR D

Perhaps we even could use options which are similar to * and +, for
example:
 - -* and -+ (-* should not be expanded often but is annoying anyway)
 - -. and -+
 - -t and -p (A -t B is A times B, A -p B is A plus B)

> Making --or optional sounds fine as that
> would make the default "multiple -e" case similar to what GNU
> grep does without any --and nor --or.
That's exactly what I was thinking about: make extended expressions
compatible to current grep options. This will confuse less people and
there is no need for an extra option to activate this.
