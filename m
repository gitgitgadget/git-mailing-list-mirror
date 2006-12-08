X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 07 Dec 2006 22:31:52 -0800
Message-ID: <7vac1yoq3r.fsf@assigned-by-dhcp.cox.net>
References: <20061207100152.GA12966@spearce.org>
	<7vlkljsd1k.fsf@assigned-by-dhcp.cox.net>
	<20061207195715.GG12143@spearce.org>
	<7v64cns8nf.fsf@assigned-by-dhcp.cox.net>
	<20061207214053.GC31035@fieldses.org>
	<20061207215914.GC12502@spearce.org>
	<20061208044516.GC5939@fieldses.org>
	<20061208055938.GB13999@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:32:00 +0000 (UTC)
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061208055938.GB13999@spearce.org> (Shawn Pearce's message of
	"Fri, 8 Dec 2006 00:59:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33663>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsZH4-0002ds-0M for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424803AbWLHGby (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424804AbWLHGby
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:31:54 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52663 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424803AbWLHGbx (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:31:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208063153.FGZS20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 01:31:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w6Y31V00j1kojtg0000000; Fri, 08 Dec 2006
 01:32:04 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

>> But my main complaint is just that I wouldn't want to see the behavior
>> of defaulting to HEAD--behavior which is simple, easy to explain, and
>> shared by most other git commands--by something significantly more
>> complicated.  That's more a complaint about Junio's suggestion than
>> yours, though.
>
> True, defaulting to HEAD is something that is done almost everywhere.
> Changing it for `git checkout -b` may surprise a lot of people,
> almost as much as --index vs. --cached.

I did not mean to change the default to something other than
HEAD depending on the configuration.

> (0) proceed if there is an explicit branch point specified on
>     the command like, just like now;

... which is the same as before.

> (1) allow omission of branch-point if the current branch has
>     allowbranchbydefault configuration set as in above.  A new
>     branch is created forking off of the current HEAD;

... which allows people to do the same as before, but only on
selected "primary" branches;

> (2) allow omission of branch-point if no branch has such
>     configuration; in other words, existing repositories that
>     do not have the allowbranchbydefault configuration anywhere
>     are not affected.  A new branch is created forking off of
>     the current HEAD;

... which allows people to keep using the current behaviour in
existing repositories;

> (3) otherwise, it barfs if you do not give an explicit
>     branch-point.

... but a newly created repositories would have an
allowbranchbydefault entry on "master" (and only on "master"),
which means new people would be prevented from making mistakes
when on a non-master branch 'foo':

	$ git branch bar

and end up a foobar branch that is not based on 'master'.  They
will instead get an error message that says "Hey, are you sure
you want to fork off of this branch 'foo'?"

But I do not deeply care about this.  An option to disable
"default to HEAD" altogether is fine.
