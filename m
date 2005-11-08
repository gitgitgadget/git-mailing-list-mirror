From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Tue, 08 Nov 2005 13:47:14 -0800
Message-ID: <7vwtjierrx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:49:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZbJK-0003KA-MK
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVKHVrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKHVrS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:47:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38891 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965146AbVKHVrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 16:47:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108214648.PQOL9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 16:46:48 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108210211.GA23265@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 8 Nov 2005 22:02:11 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11359>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> The second reason is that with the fall back list the recursive
> strategy will only be used in the strange corner cases and will thus
> not get nearly the same amount of testing it would get if it was the
> first choice (or directly after the really-trivial merge).

There are two reasons to avoid git-merge choose from more than
one strategy.

1. The whole idea that git-merge implements "goodness" metric is
   bogus.  It does not know what merge strategy is good and that
   is the reason it punts and has the user choose his preferred
   strategy.

2. When it is going to loop over more than one strategy, it
   stashes away the current working tree state, so that the
   second and subsequent strategies can begin from a clean slate
   (including local modifications since the current head).  If
   we try only one, there is no such cost involved.

I think the patch I sent out last night to change the recursive
as the default strategy and make it overridable from the
configuration mechanism would be a better way to give people
more exposure to the greatness of recursive while protecting
them from potential glitches if any.
