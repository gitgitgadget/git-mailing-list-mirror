X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 12:05:12 -0800
Message-ID: <7vy7q8bjwn.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
	<7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
	<20061118045323.GK7201@pasky.or.cz>
	<7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
	<20061118192830.GP7201@pasky.or.cz>
	<7vejs0cz5s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 20:05:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vejs0cz5s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 18 Nov 2006 11:50:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31801>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlWRE-0007a0-Lb for gcvg-git@gmane.org; Sat, 18 Nov
 2006 21:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755241AbWKRUFP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755244AbWKRUFO
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 15:05:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58072 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1755241AbWKRUFN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 15:05:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118200513.TEXI7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 15:05:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oL4k1V00M1kojtg0000000; Sat, 18 Nov 2006
 15:04:45 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> What about leading underscore?
>
> I would rather prefer to do refs/{heads,private}/ and allow
> checkout to treat either of them as branches.  We are talking
> about allowing checkout to go to a non-branch by storing a raw
> commit object name in HEAD instead of leaving it as a symref, so
> we know we are going to touch that area already.

Oops.  Consider this rescinded.  I myself already talked about
"not necessarily just public vs private".  Silly me.

I think this is related to the common gripe of "why can't Junio
mark pu to be rewinded in his public repository".  We should be
able to leave the branch grouping to users.

Not just public vs private, but I can see an organization that
uses something like this:

    heads/1.5/{maint,master,next,pu} are to maintain and advance 1.5 series
    heads/1.5/topics/{foo,bar} are topics applicable to 1.5
    heads/2.0/{maint,master,next,pu} are to maintain and advance 2.0 series
    heads/2.0/topics/{foo,bar} are topics applicable only to 2.0
    heads/topics/{frotz,nitfol} are topics applicable to both

and wanting to view all the topics, only things related to 1.5,
etc.  So Porcelains _can_ enforce their own policies to arrange
things differently but we should also be able to let the users
(and project branch naming policy) to do what we've been talking
about by saying:

	use heads/private/ for your own stuff.  And have
	configuration that says "heads/private/" are private
	branches that are not subject to default
	pushing/pulling.

The real instruction from the project would say what the syntax
for telling that to git but I think you got the idea...
