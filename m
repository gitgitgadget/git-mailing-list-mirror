From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bisect and the merge from hell
Date: Fri, 03 Feb 2006 12:34:58 -0800
Message-ID: <7virrwdvv1.fsf@assigned-by-dhcp.cox.net>
References: <200602031947.k13JlaDr003720@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 21:35:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57e6-0008QJ-Th
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWBCUfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWBCUfB
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:35:01 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55442 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751472AbWBCUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:35:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203203343.JBBV20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 15:33:43 -0500
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200602031947.k13JlaDr003720@agluck-lia64.sc.intel.com> (Tony
	Luck's message of "Fri, 3 Feb 2006 11:47:36 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15551>

"Luck, Tony" <tony.luck@intel.com> writes:

> Sometime between -rc1 and -rc2 the ia64 kernel picked up a bug
> that prevents booting a UP kernel on my workstation (I recycled
> the serial cable to hook up a new machine, so I don't have the
> OOPS).
>
> So I thought I'd use git bisect to narrow it down.  A few iterations
> in it picked the merge from hell, and two iterations after that it
> appears to have wandered into the weeds and picked something from
> before -rc1.
>
>  $ git describe 3c5c363826e435cf4d54d917202567e5b57cae5f
>  v2.6.15-g3c5c3638
>
> Is this normal?

I haven't looked at your ancestry graph yet (I am at work
writing this message during my lunch break), but if one of the
branches merged between rc1 and rc2 were forked from the
mainline at a commit before rc1, that is an expected behaviour.
Suppose:

       .o---o---o--- ... ---o---o.
      /                           \
     /                             \
 ---o---o---*---o--- ... ---o---o---*---o---o---*
            rc1                     octopus     rc2

And you said "rc1 was OK but rc2 is BAD".  Now, the bug may well
be somewhere between rc1 and Len's octopus on the lower
development track.  But the problem may have been introduced by
some of the commits on the upper development track that bypassed
rc1.  They are not descendant of rc1, and describe would say
they come after v2.6.15.

The side branch merged during that timeperiod that forked before
rc1 may not be the one merged by Len's octopus but may be merged
by some other merge, but the story is the same.
