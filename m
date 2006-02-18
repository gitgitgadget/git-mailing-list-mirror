From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why can't git-rebase back up?
Date: Sat, 18 Feb 2006 01:15:09 -0800
Message-ID: <7vpsllowo2.fsf@assigned-by-dhcp.cox.net>
References: <7vmzgpru8m.fsf@assigned-by-dhcp.cox.net>
	<20060218085608.30325.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 10:15:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAOBa-0002Zx-09
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 10:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWBRJPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 04:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWBRJPM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 04:15:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54201 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWBRJPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 04:15:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218091238.SBBI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 04:12:38 -0500
To: linux@horizon.com
In-Reply-To: <20060218085608.30325.qmail@science.horizon.com>
	(linux@horizon.com's message of "18 Feb 2006 03:56:08 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16404>

linux@horizon.com writes:

> That also lets you do something about the rebasing-a-merged-branch
> problem.  If you have:
>
>       g-->h-->i-->j topic
>      /       /
> a-->b-->c-->d-->e-->f master

Ideally, you should be able to come up with:

                        g'->h'->j' topic
                       /
  a-->b-->c-->d-->e-->f master

But it should not matter.  You should not be merging master (or
any other branches that might have interaction with the topic)
into your topic branches to begin with.

Instead, use a separate test branch and merge both topic and
master into it:

             g-->h-->j topic
            /         \       
           /---o---o---o test
          /       / 
     a-->b-->c-->d-->e-->f master

Once your topic is fully cooked, you would merge it into
master.  If the area topic and master touch overlaps, you might
have to resolve the same conflict you would have already
resolved when you merged (j) commit into test in the above
picture, but that is why we have "git rerere" ;-).

BTW, why are we suddenly having many nameless people on this
list, I wonder...
