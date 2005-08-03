From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 11:00:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031055090.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508031618500.23728@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 20:03:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NYE-0004O2-TY
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 20:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVHCSAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVHCSAt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 14:00:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262371AbVHCSAr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 14:00:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73I0ZjA009107
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 11:00:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73I0WwA031584;
	Wed, 3 Aug 2005 11:00:34 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508031618500.23728@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Johannes Schindelin wrote:
> 
> I try to write a "git annotate" based on the output of git-whatchanged. 

You can't. It's fundamentally not doable, because you lose the merge 
information.

So you need to use a combination of git-rev-list _and_ git-whatchanged.

Use the "--parents" flag to git-rev-list to get the parents output for 
doing your own graph, if you want to.

I have been thinking of adding a "follow this file" mode to git-rev-list,
which just ignores all children of merges that used the file directly from
one of the other children. Exactly because then you could have a
git-rev-list that prunes based on filename, and would potentially be a lot
more efficient (not follow the "uninteresting" side of a merge).

I haven't gotten around to it, partly because I wonder if it would be
better as a separate program - even if that would mean that you'd lose all
the cool features of git-rev-list (the ability to limit it to certain
versions, and the ability to sort the output in relevant orders).

Partly because I'm just too friggin lazy.

> P.S.: My only unsolved problem is that git-whatchanged sometimes shows
> the diffs in the wrong order (clock-skew problem?)

Nope, this is a direct result of two branches modifying the same file in 
parallel. There is no "right" or "wrong" order.

		Linus
