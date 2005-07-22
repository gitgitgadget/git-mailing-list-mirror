From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 14:18:00 -0400
Message-ID: <20050722181800.GU20369@mythryan2.michonline.com>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 20:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw26w-0000hD-Fg
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 20:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVGVSST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVGVSST
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 14:18:19 -0400
Received: from mail.autoweb.net ([198.172.237.26]:53915 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261349AbVGVSSE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 14:18:04 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dw25w-000061-VO; Fri, 22 Jul 2005 14:18:01 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dw2EE-0008MR-00; Fri, 22 Jul 2005 14:26:34 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dw25w-0003zb-7T; Fri, 22 Jul 2005 14:18:00 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2005 at 09:56:19AM -0700, Junio C Hamano wrote:
> Now if we had a mechanism to graft a later history which starts
> at 2.6.12-rc2 on top of this earlier history leading up to
> it,...  ;-)

We do - it's not even very hard, we just end up with 2 commits for every
change/merge that's unique to git, until we get to the current head:

Take the last imported commit - we'll call this branch A.
Take the 2.6.12-rc2 initial commit, we'll call this branch B.

This algorithm should stitch things together:

For each commit on branch B
	Copy all commit metadata (author,etc)
	Add a new parent Ai.
	Take the trees from commit B.
	Write a new commit, Ai+1

When we get to HEAD, we replace HEAD with this last commit we have
created, and we now have a nice, parallel commit tree that stitches
everything back together.

Working from the initial import up, you'll need to work in parallel and
handle create some mappings of "old commit" to "new commit" to create
all the merges with the new commit ids, but I think  this should be
pretty straightforward to do.

If this is all integrated, I'd suggest unpacking everything but the
packs that are currently in the main tree, and repacking one very big
pack to get the maximum posible benefit from the deltas.

-- 

Ryan Anderson
  sometimes Pug Majere
