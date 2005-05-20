From: Junio C Hamano <junkio@cox.net>
Subject: Re: [cogito] paged output for cg-diff
Date: Fri, 20 May 2005 06:50:57 -0700
Message-ID: <7vu0kyuhtq.fsf@assigned-by-dhcp.cox.net>
References: <200505201517.05995.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ7tM-0003YU-DA
	for gcvg-git@gmane.org; Fri, 20 May 2005 15:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVETNvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 09:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVETNvK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 09:51:10 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1203 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261430AbVETNu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 09:50:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520135058.RLOI7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 09:50:58 -0400
To: Michal Rokos <michal@rokos.info>
In-Reply-To: <200505201517.05995.michal@rokos.info> (Michal Rokos's message
 of "Fri, 20 May 2005 15:17:05 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MR" == Michal Rokos <michal@rokos.info> writes:

MR> Junio is right, following is sufficent. Tested with 'more' too.
MR> Idea-from: Junio C Hamano <junkio@cox.net>

I appreciate the credit, but that is probably not needed in this
case, since this is quite commonly used pattern.  I've seen many
people do just this:

          command | ${PAGER:-less}

And if you think about it, you would realize that the above is
good enough, and probably is a lot better than what you are
doing.

Your PAGER shell function gives "-R" indiscriminately when
$PAGER_FLAGS is not set (or set to empty, which is even worse
because you are not giving the user to override this _bad_
choice) without even checking if the $PAGER is something that
understands "-R" (namely, "less").  I do not think users with
their PAGER set to "more" or "cat" (I do the latter when I am
working in Emacs) would appreciate that behaviour.

On the other hand, if your user is a "less" user, and if the
user wants it to honor ANSI "color" escape sequences, it would
be more helpful to the user if you educate/encourage the user to
have "LESS=R" in the environment and make that in effect
everywhere less is used not just in Cogito.  Giving that support
silently just in Cogito at the first thought may seem to be more
helpful but in reality it is not.

So I would suggest to use the above form without defining your
own PAGER shell function, and add a tip for "less" users to have
"LESS=R" in their environment somewhere in the documentation.

