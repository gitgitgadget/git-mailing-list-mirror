From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD state while preserving its staged state
Date: Sat, 04 May 2013 12:56:42 -0700
Message-ID: <7va9oawmbp.fsf@alter.siamese.dyndns.org>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Dimitar Bonev <dsbonev@gmail.com>, Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 04 21:57:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYiZr-0002l7-90
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 21:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab3EDT4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 15:56:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab3EDT4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 15:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27A3B1B874;
	Sat,  4 May 2013 19:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ynak4QYjGBoaSfe7Aa86sogVAhE=; b=S36Ynh
	RD4i5F5LLLWXLFReA+XVV2AIPNDv1Q2EM5YRUP7x4AnqyXD+ezKVDdtCj+KiSoch
	vFtxAonrB6bgNTs4P81Z1IJllhgep2lJ/pFYqJX5u525SVv+07pzBJ5iU86b4bSB
	c38Vib7GEsr5woqvE9ZLxL1RLpCIU74Rdf23w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhrTnvsZBOq7qBeh7LLYnhbcObUtxlno
	cxOGUvipcKmzEfB4sItYjuswhVDwnjpxGJlT9OL4H/NHB2qUTtc1oyN85hXr9K/Y
	QeBFMYC2DK0t3JPVCkd/LmNR0OaERMEwPHKa7MqvPzh+QQ6Yfqn2sJ43aWb+UDRh
	FH6zwxRdze8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA4C1B873;
	Sat,  4 May 2013 19:56:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E7101B872;
	Sat,  4 May 2013 19:56:44 +0000 (UTC)
In-Reply-To: <87obcryvcw.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Sat, 4 May 2013 10:58:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEFF83EE-B4F4-11E2-8CD9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223374>

Thomas Rast <trast@inf.ethz.ch> writes:

>> I have been looking for such a command/option and no one gave me
>> sufficient answer. So this message should be considered as a feature
>> request. I had a situation where I had staged a file with a problem
>> solution in it, then I wanted to experiment with a different solution
>> so I had to revert the file to its HEAD state and I couldn't find a
>> way that preserves the staged state of that file.
> ...

"I have something worth saving, better than HEAD in some way
(e.g. contains fixes), in my index. I want to keep it while I
experiment an approach that is unrelated to it, so I want a clean
slate in the working tree from HEAD without disturbing the index".

At the first glance, that looks like a reasonable thing to ask, but
after thinking about it a bit more, I am not sure if it really is,
primarily because it is unclear what you can productively do to the
end result next.

Suppose you matched the working tree to HEAD while keeping a
valuable change in the index, and after working for a while, now
have finished the experiment and have something in your working
tree.

What is your next move?

If the end result in the working tree were "Nah, this other approach
does not work, trash it", you can checkout the working tree from the
index, so nothing is lost.

But if your result is _also_ something worth saving, what would you
do?  "git add" to update the index will trash the work that was in
the index, and that is by definition unrelated to what you worked on
in the working tree (you wanted to start from the version in the
HEAD, not from the version in the index, so the end result is likely
to lack the work you saved in the index).

That makes me think that "match working tree from HEAD bypassing
index" is not a very useful strategy, unless you are expecting a
failed experiment from the start.

As Thomas said, I think a more reasonable workflow would begin by
saving the "somewhat worth saving" state you have in your index as a
WIP commit, i.e.

	git commit -m wip

When I experiment starting from a clean slate (after saving away
such a WIP commit), I would then do this:

        git checkout HEAD^

to start at the state before the WIP commit and hack away.  As I do
not know how the experiment would go when I do this, I often do not
bother giving the experiment its own branch.

If the experiment does not seem to go in a productive direction, I
can simply "git reset --hard && git checkout -" to get rid of it.

On the other hand, if its direction shows promise but turns out to
be more involved than a quick hack, I can at that point decide to
give it its own branch with "git checkout -b newbranch".  Then I can
choose to keep working on it, or switch to other tasks after making
a wip commit on that new branch.

Or if the experiment results in a series of good and straightforward
changes that should come _before_ that original wip (which happens
very often), then I could do:

	git commit ;# maybe more commits.
        git cherry-pick @{-1} ;# the one stashed away
        git co -B @{-1}

to update the original branch and come back to it.  The state in the
original index may be a WIP, so I may then reset with

	git reset HEAD^

after the above.

> Is that a common enough issue to warrant a better solution than
>
>   git show HEAD:targetfile > targetfile
>
> which is how we would do it?

Or "git diff HEAD <paths> | git apply -R", which is a good trick to
learn.  You can inspect "git diff HEAD <paths>" to check what you
will lose and then add "| git apply -R" to actually revert it.
