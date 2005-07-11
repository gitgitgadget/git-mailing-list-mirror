From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Sun, 10 Jul 2005 20:18:56 -0700
Message-ID: <7v4qb2ni73.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
	<42D17D89.9080808@innehallsbolaget.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DropF-0005mS-6y
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVGKDTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVGKDTH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:19:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19887 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262198AbVGKDTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:19:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711031856.ECOT1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 10 Jul 2005 23:18:56 -0400
To: Dan Holmsand <dan@innehallsbolaget.se>,
	Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <42D17D89.9080808@innehallsbolaget.se> (Dan Holmsand's message of "Sun, 10 Jul 2005 21:56:57 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One very minor problem I have with Holmsand approach [*1*] is
that the original Barkalow puller allowed a really dumb http
server by not requiring directory index at all.  For somebody
like me with a cheap ISP account [*2*], it was great that I did
not have to update 256 index.html files for objects/??/
directories.  Admittedly, it would be just one directory
object/pack/, but still...

On the other hand, picking an optimum set of packs from
overlapping set of packs is indeed a very interesting (and hard
combinatorial) problem to solve.  I am hoping that in practice
people would not force clients to do it with "interesting" set
of packs.  I would hope them to have just a full pack and
incrementals, never having ovelaps, like Linus plans to do on
his kernel repo.

On the other hand, for somebody like Jeff Garzik with 50 heads,
it might make some sense to have a handful different overlapping
packs, optimized for different sets of people wanting to pull
some but not all of his heads.

Having said that, even if we want to support such a repository,
we should remember that the server side optimization needs to be
done only once per push to support many pulls by different
downstream clients.  Maybe preparing more than "list of pack
file names" to help clients decide which packs to pull is
desirable anyway.  Say, "here are the list of packs.  If you want
to sync with this and that head, I would suggest starting by
getting this pack."


[Footnotes]

*1* I was about to type Dan's, but both of you are ;-).

*2* Not having a public, rsync-reachable repository gave me a
lot of incentive to think about issues to support small/cheap
projects well ;-).
