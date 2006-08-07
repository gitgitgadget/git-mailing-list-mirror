From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff: support custom callbacks for output
Date: Mon, 07 Aug 2006 03:16:20 -0700
Message-ID: <7vhd0o4zrf.fsf@assigned-by-dhcp.cox.net>
References: <20060807075002.GA29693@coredump.intra.peff.net>
	<7vr6zt3oz5.fsf@assigned-by-dhcp.cox.net>
	<20060807091953.GA31137@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 12:16:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA2AM-0001mq-KE
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 12:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWHGKQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 06:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWHGKQW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 06:16:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21948 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751050AbWHGKQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 06:16:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807101621.UGLS6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 06:16:21 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060807091953.GA31137@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 7 Aug 2006 05:19:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25005>

Jeff King <peff@peff.net> writes:

> I'm starting by writing run_status in C. Once that is working (which
> should be soon), I believe it should suffice as a vanilla git-status
> (do people actually do things like git-status with flags? It's not
> documented, but it does work).

Well, "git-status" is by definition (see list discussion when it
was made into its current shape) a preview of "git-commit", so
all the options are supported and needs to work with options.  I
just noticed that its documentation has not been updated, though.

So I'd suggest, mildly, against naming your "run_status()
equivalent" git-status.  And if you follow through your plan,
you would most likely have git-status _and_ git-commit both in C
at about the same time when you finish.

> I'm definitely in favor.
>
>>         Will commit
>>                 modified: Makefile (warning: further changed)
>
> I like it (the double-mention of files which were changed, updated, then
> changed has always bothered me). However, I'm not sure how we can get
> the diff machinery to figure this out easily. Getting the knowledge for
> the line above requires diffing tree to cache and cache to working
> directory. Is there a better way than saving the queue from one diff and
> cross-referencing it with the other?

I do not think so.  I was initially planning to write a new
traversal function that walks working tree, index _and_ a tree
in parallel, but that would not work well with -M and -C, so I
dropped it.
