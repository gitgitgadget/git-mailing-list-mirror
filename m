From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 12:57:12 -0700
Message-ID: <7vis2d2rmv.fsf@assigned-by-dhcp.cox.net>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	<42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
	<426A4669.7080500@ppp0.net>
	<1114266083.3419.40.camel@localhost.localdomain>
	<426A5BFC.1020507@ppp0.net>
	<1114266907.3419.43.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
	<20050423175422.GA7100@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
	<2911.10.10.10.24.1114279589.squirrel@linux1>
	<Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:53:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQge-0002Lp-GN
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVDWT5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDWT5t
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:57:49 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17315 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261738AbVDWT5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 15:57:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050423195713.OZGJ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Apr 2005 15:57:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 23 Apr 2005 12:38:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Guys, I will say this once more: git will not look at the signature.

LT> And that is why I from the very beginning tried to make ti very clear that
LT> the signature goes at the end. Not at the beginning, not in the middle,
LT> and not in a different file. IT GOES AT THE END.

If that is the case, can't you do it without introducing this
new tag object, like this?

  1. Find existing commit-id that you want to tag.
  2. Sign that commit object:

     cat-file commit $commit |
     gpg --detach-sign --armor -u 'Linus Torvalds' >commit.sig

  3. Make another commit, making the original commit as its parent:

     {
         echo tag This is my tag.
         cat commit.sig 
     } | commit-tree $(cat-file commit $commit |
                       sed -e 's/tree //;d') -p $commit

Then you can publish the ID of this commit object, which attests
that the original commit is what you vouch for.  Am I missing
something?

