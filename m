From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 01:54:07 -0700
Message-ID: <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
References: <20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
	<Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728161815.GC17952@pasky.ji.cz>
	<7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
	<20050728183904.GA24948@pasky.ji.cz>
	<7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
	<20050729070628.GA24895@pasky.ji.cz>
	<7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
	<20050729081051.GH24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 10:57:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQf1-0003um-H0
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVG2IzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVG2IzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:55:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62686 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262529AbVG2IyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 04:54:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729085402.XYJY12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 04:54:02 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729081051.GH24895@pasky.ji.cz> (Petr Baudis's message of "Fri, 29 Jul 2005 10:10:51 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Exactly. I want much more freedom in pushing, the only requirement being
> that "the to-be-replaced remote head is ancestor of the to-be-pushed
> local head". I think (am I wrong?) git-send-pack localhead:remotehead
> would work just fine for me, the only thing I need is the support for
> different local and remote head names.

Now I see where you are coming from; I tend to agree why you
might want to have different names on the remote end.  I however
still suspect that you might be spreading chaos under the name
of more flexibility.  The fact that you can push into it by
definition means you have some control over the other end, and
obviously you are in total control on your end.  I do not see
why you cannot rename branches where needed so that whatever you
are pushing match.  That would also be one less thing to keep
track of for yourself [*1*].

Yes, I am aware that you brought up the example of pushing to
two separate places, but does it happen in practice that you can
push to two places, and at the same time neither of them
cooperates with you to make it easier for you to work on these
three machines by having the same head names?

Having said that, I do not particulary think allowing push to
write into different ref is an unreasonable thing.  As you
pointed out long time ago when send-pack was first done, the
protocol is not so easily extensible, so this may require either
backward incompatible protocol change, or introduction of a new
program pair send-pack-2 / receive-pack-2.  I'll take a look
sometime this weekend.  Bedtime.


[Footnote]

*1* In a hypothetical situation ``I use branch "b00" in this
repository to do XYZ work but I use branch "b24" in the other
repository for the same XYZ work'', Porcelain can keep track of
mapping between b00:b24 for you, but you still need to keep
track of b00:XYZ and b24:XYZ mapping in your head.
