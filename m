From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 04 Jun 2005 08:01:25 -0700
Message-ID: <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
	<17052.21846.816147.370354@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 16:59:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dea6M-0007je-Fa
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFDPBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 11:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFDPBc
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 11:01:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4484 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261374AbVFDPB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 11:01:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604150126.NALB26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 11:01:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 08:23:47 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, what do you think rev-list should do given HEADs from two
forks, like this?

    JC          git-rev-list JC LT ????
     |
     |  LT
     |   |
      \ /
       |
       |
       |

The above is often the shape of my working repository.  I pull
from you, commit a handful on top of your then-HEAD, and when I
am about ready to submit, I pull from you again to find your
HEAD advanced somewhat.

For patch-form submission, I need a list of my commits since I
forked from you.  Also I tend to rebase to your head often,
instead of merging inside my working repository (which makes
later e-mail patch-form submission more work for me), so even
when I am not immediately submitting the changes I have in my
fork, I need that list to forward port my changes.

JIT currently uses this to get this list (as a workaround):

    git-rev-list JC $(merge-base JC LT)

I am wondering if this "since they forked" is usually what the
user wants.  If that is the case then it would be great if I did
not have to do the "merge-base" part outside.

Current "proper lazy reachability" version, btw, does something
very unexpected for my use pattern.  If you have more than one
commits between the fork point and LT HEAD in the above picture,
everything from the beginning of time to JC is given, or
something silly like that.


