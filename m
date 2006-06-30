From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 11:16:46 -0700
Message-ID: <7v1wt6ik4x.fsf@assigned-by-dhcp.cox.net>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<E1FwGgm-0006Nc-9a@moooo.ath.cx>
	<7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
	<E1FwMPf-0005XA-N9@moooo.ath.cx>
	<7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org>
	<E1FwN7M-0007GI-Ng@moooo.ath.cx> <e83p0q$dla$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 20:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNXx-0002IQ-Fc
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWF3SQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWF3SQt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:16:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18625 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964825AbWF3SQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 14:16:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630181647.JDFO6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 14:16:47 -0400
To: jnareb@gmail.com
In-Reply-To: <e83p0q$dla$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	30 Jun 2006 20:03:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23009>

Jakub Narebski <jnareb@gmail.com> writes:

> Because --near needs an expression it check context for (context is for
> found match of lhs expression). So
>
>   -e foo --near \( -e A --or -e B \)
>
> means lines containing foo and either A or B in the context _for "foo"_.

The syntax and semantics of --near I suggested (and you are
following) and what Matthias discusses are different and I think
that is why you two are talking past each other.

What I originally suggested is that you can (syntactically)
replace --near with --and.  That is, the LHS is the match and
RHS is "the LHS must match, but in addition RHS must match but
unlike --and RHS does not have to be exactly on the same line
but it is OK if it is a line somewhere nearby".

The --near Matthias talk about is syntactically not like --and
but more like --not.  It takes a condition for a line after
that, and loosens it to cover nearby lines.  So "-e A"
means "the line must have A on it" but "--near -e A" means "the
line must be nearby a line that satisfies `-e A'".

Matthias's "--near EXP" is spelled as "-e '' --near EXP" (the
first one is always true) with our syntax, in other words.

I do not think either of these semantics is invalid; they are
just different.  The version by Matthias is more general and
more expressive.
