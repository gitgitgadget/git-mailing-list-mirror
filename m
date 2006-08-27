From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 17:24:36 -0700
Message-ID: <7vwt8vyqij.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252135.27894.jnareb@gmail.com>
	<7vpsen1eq3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 02:24:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH8SG-0006Hq-LB
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 02:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWH0AYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 20:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWH0AYO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 20:24:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41441 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750777AbWH0AYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 20:24:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827002413.YAVF4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 20:24:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EoQB1V01F4Noztg0000000
	Sat, 26 Aug 2006 20:24:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vpsen1eq3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 26 Aug 2006 12:25:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26076>

Junio C Hamano <junkio@cox.net> writes:

>    "get-following" is inherently a very expensive operation, so
>    I would suggest not doing this.  It seems that nobody uses
>    these two subs yet, so probably it is better to yank them
>    before they cause damages.

A bit of clarification.  gitk has preceding/following but unlike
gitweb it has three things that go in favor of having it.

 - gitk can afford to use as much CPU as the user throw at it,
   since it runs locally.

 - gitk finds preceding/following in the background so the user
   does not have to wait, and it is done while it gets the list
   of commits which it needs to do anyway.

 - what gitk reads from rev-list persists while the user keeps
   it around.  when the user walks around inspecting different
   commits, the cost for computing preceding/following is
   amortized.  gitweb cannot do this unless it somehow caches
   this information, but you just spent significant effort to
   make it unnecessary for gitweb to write anything on the
   filesystem, so introducing caching is somewhat going
   backwards.
