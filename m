From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff_tree_stdin
Date: Thu, 13 Oct 2005 00:11:07 -0700
Message-ID: <7vu0fl51tg.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0510111846q42c5d7e5j162bdacd49dfebbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 09:13:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPxFH-0007gu-EI
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 09:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbVJMHLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 03:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVJMHLK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 03:11:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33170 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751490AbVJMHLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 03:11:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013071108.JRTS9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 03:11:08 -0400
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0510111846q42c5d7e5j162bdacd49dfebbc@mail.gmail.com>
	(Morten Welinder's message of "Tue, 11 Oct 2005 21:46:38 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10064>

Morten Welinder <mwelinder@gmail.com> writes:

> It looks like diff_tree_stdin can overrun the this_header buffer.  Since the
> line length is already calculated, a check would be cheap.

I presume you are talking about "line", not this_header[], since
you are talking about something whose length is already
calculated.

The output buffer this_header[] only ever gets two 40-byte SHA1
and a handful more, so probably 128 bytes would be big enough --
the current 1000 is overkill.

The input line[] is first NUL terminated before getting scanned,
and scanning with get_sha1_hex() stops immediately when we see
NUL, and premature NUL makes it fail, so the first
get_sha1_hex() would not overrun.  If the first SHA1 is followed
by garbage then the second get_sha1_hex() would not succeed
without overrunning either.  If line[40] is NUL then we do not
even do the second get_sha1_hex() --- in any case I do not see
overrun.

I am getting tired (it _was_ my GIT day, but unfortunately I had
to be worried about another day-job project during the day X-<),
and I might probably be overlooking something fairly obvious to
you.  Care to explain?
