From: Junio C Hamano <junkio@cox.net>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 02:51:04 -0700
Message-ID: <7v1wwd8y9j.fsf@assigned-by-dhcp.cox.net>
References: <4430D352.4010707@vilain.net>
	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
	<4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 11:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQiBq-000646-Fe
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 11:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWDDJvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWDDJvH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 05:51:07 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17071 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964820AbWDDJvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 05:51:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404095106.HYBK20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 05:51:06 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44323C52.2030803@op5.se> (Andreas Ericsson's message of "Tue, 04
	Apr 2006 11:28:50 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18382>

Andreas Ericsson <ae@op5.se> writes:

> Sam Vilain wrote:
>> Junio C Hamano wrote:
>>> [ made change on a test branch that bundles topic branches
>>>   -- now want to commit back to the component topic branch ]
>>>Would patch commutation calculus help with his problem?
>>>
>> I'd provisionally say "yes, that's the fit". It's just like having
>> multiple topic branches all checked out at once, with commits going to
>> the appropriate branch as necessary.
>
> Wouldn't "git commit -M -b topic", for committing to a different
> branch than what is checked out (-b) and also to the checked out
> branch (-M) have the same beneficial effects, but without the
> complexity of hydras and patch dependency theory? It would only remove
> the cherry-pick stage though, but perhaps it's good enough. Although
> when I think about it, -b
> <branch> for committing to another branch and -B <branch> for doing
> the above probably makes more sense.

It feels to me that the above set of flags encourage a workflow
that:

 (1) modify the source and run tests in "test" branch;
 (2) have tool automatically adjust the change to match the other
     branch (i.e. the topic to be checked in) automatically;
 (3) make a commit, without a chance to do the final sanity
     check in the context of the branch being committed.

An individual topic branch itself might not be even testable
standalone, but at least I'd prefer to have a chance to double
check if the "patch commuting" (or "cherry-pick stage") did a
sensible thing [*1*].

As I said on the list in the past, I am from a school that
believes in not committing anything that has not been
tested/reviewed as a whole, especially when it comes to
individual developers, so I am not sure it is a good idea
in general to make it easy to do so to begin with.

But that is just my personal preference, and it does not
necessarily have to stop people wishing to have that feature to
have it, especially when there are enough of them.

> Those flags don't exist currently btw, in case someone's reading this
> on the archives.

I take it that you are volunteering to come up with an initial
round of implementation of these flags?

[Footnote]

*1* ... that's where "git checkout -m that-topic", perhaps
 followed by "git diff HEAD", comes in.
