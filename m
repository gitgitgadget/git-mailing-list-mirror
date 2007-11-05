From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 14:21:49 -0800
Message-ID: <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAKl-0004gP-2m
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbXKEWV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbXKEWV6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:21:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50742 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbXKEWV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:21:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 62F1D2F2;
	Mon,  5 Nov 2007 17:22:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B132F9295E;
	Mon,  5 Nov 2007 17:22:14 -0500 (EST)
In-Reply-To: <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> (Steven
	Grimm's message of "Mon, 5 Nov 2007 11:28:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63571>

Steven Grimm <koreth@midwinter.com> writes:

> But that suggested command is not going to convince anyone they were
> wrong about git being hard to learn. I wonder if instead of saying, "I
> know what you meant, but I'm going to make you type a different
> command," we should make git revert just do what the user meant.
>
> There is already precedent for that kind of mixed-mode UI:
>
> git checkout my-branch
> vs.
> git checkout my/source/file.c

That's an example of mixed-mode UI, but what you are suggesting
is quite different, isn't it?

There is no other officially supported single-command-way to
checkout paths out of the index.  "git checkout paths..." does
not introduce a confusion because of that.  The user learns the
way git supports that concept and that's the end of the story.
The same thing can be said about "git checkout <commit>
paths...".  That's _the_ way to checkout paths out of an
arbitrary commit.

In the case being discussed, we already have the concept of
checking out paths from the index, which has an officially
supported way to express.

You are proposing to give it a synonym "git revert paths...",
which superfitially sounds friendlier.  But I actually think
allowing a mistaken

	git revert path...

to be burned to users' fingers and brains is doing the user a
great disservice.

The next person would say "Why doesn't 'git revert HEAD path...'
work?", and you would add the synonym to do 'git checkout HEAD
path...'.  Up to that point it is sort-of Ok (but not quite).
You already have "git checkout" that let's you do so, but you
introduced new concepts that are "revert paths to the index" and
"revert paths to the last commit".

Which may make you feel good, but you just introduced a narrower
synonym the user needs to learn, than a more established and
wider concept that we already have: "checkout paths out of X",
where X are either the index or an arbitrary commit.

The reason I think the narrower synonym is bad and will lead to
more user confusion is because after that point you will have
a few issues.

Another newcomer would say "I like the fact that 'git revert
HEAD path...' works but why doesn't 'git revert HEAD~12 path...'
work?".

 - You may further allow "git revert <arbitrary-commit>
   path...".  But what does that _mean_?  "revert the path to
   the twelfth commit"?  You may implement that _anyway_.

   Then, the user would say "eh, why do you have both 'git
   checkout path...' and 'git revert path...' that seem to do
   the same thing?  There's no difference?  Why Why Why, git is
   so hard to learn".

 - You may instead not to do so, and explain that the "arbitrary
   commit" form is not supported and tell the user to use "git
   checkout <commit> paths...".

   The user will say: "but you earlier told me to use revert --
   you could have taught me to use checkout from the beginning
   and saved me from great confusion instead".

Giving the same concept two different names is bad unless there
is a compelling reason to do so.  Labelling an initially
narrower subset of an existing concept with a different name,
and having to extended that 'new concept' ending up with the
same as the existing concept is even worse.
