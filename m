From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Tue, 23 Apr 2013 07:53:39 -0700
Message-ID: <7vwqrtl2mk.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUebM-0003fA-SW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab3DWOxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:53:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab3DWOxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:53:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC0218714;
	Tue, 23 Apr 2013 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v2DKl8lL6cqJ3u4vp5iC/7nBw/k=; b=vScPce
	Ftqqx+clN3exwMjQNjJRBGGDPfXjx0d+3QAn/hwuPJSqPpYHw5kLF0adTBKeuNCP
	x+96Fp2oKl2obwZOICrofsLi1HvdeE2exRQV++7mp8WRSNRjd23ASvNZL/1t3ejg
	F31IhEpI0F3sH8Ojw446mpsuxKOiV2XmErGwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1fXpAeKrGn8OzkHiIbFZ6WusxJHg6yx
	ok+wNfrp9GenIpxfddvNGboPjMmeoTTKC7HsmL1iBFSQn4AkcFAHNeAviu1Rkl48
	LsvZk21TL72XH50n0QxCE4YSI5C48n+H9Mhil+G7scKCVnR0zJZBM+tqGn/v7+Gw
	aaaRkkeEzu0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323C818713;
	Tue, 23 Apr 2013 14:53:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 645501870F;
	Tue, 23 Apr 2013 14:53:42 +0000 (UTC)
In-Reply-To: <CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	(Johan Herland's message of "Tue, 23 Apr 2013 08:34:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9727384E-AC25-11E2-9577-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222169>

Johan Herland <johan@herland.net> writes:

> Can you solve this problem with a tree object, instead of inventing a
> specially-formatted blob?

Hmm.  What problem are you guys trying to solve?

I think Michael's use of a merge commit to record a merge result is
sufficient as a means to record how to recreate an evil merge.

  http://thread.gmane.org/gmane.comp.version-control.git/212570/focus=212578

FWIW, in the [RFD], I wasn't asking for ideas on that part.  When
rebuiling 'pu', I use an even simpler solution to have rerere
autoresolve the mechanical part of the merge, and then cherry-pick a
separate commit from refs/merge-fix/ hierarchy on the result, and it
works perfectly fine (this is done by the 'Reintegrate' script on
the 'todo' branch; see Documentation/howto/maintain-git.txt).

When topic A is closer to be done than topic B (in other words, when
I merge topic B to an integration branch, topic A is already merged
there), and these topics have semantic conflicts (e.g. A renames a
function foo() to bar(), while B adds a new callsite of foo()), a
mechanical merge of B may succeed without any textual conflict (or
if there is, rerere can resolve it), but a semantic fix-up needs to
do "s/foo/bar/g" on the result.

I would do something like this for the first time:

	... while on 'pu', A has already been merged ...
        git merge B ;# may conflict
        edit textual conflicts away
        git rerere ;# remember the textual resolution
        git commit ;# commit _without_ semantics adjustment
        edit semantic conflict away, i.e. s/foo/bar/g
        git commit
        git update-ref refs/merge-fix/B

After that, next time I rebuild 'pu', when the automated procedure
processes B, it would "git merge B", "git rerere", make sure textual
conflicts are gone, and "git cherry-pick refs/merge-fix/B".  To make
sure this would work, what I typically do immediately after doing
all of the above is:

	git reset --hard HEAD^^

to drop the fix-up commit and merge of B, and actually tell the
automated procedure to process B.  It should recreate the evil merge
using the information I just recorded.

So "how a recipe to recreate an evil merge is recorded", as far as I
am concerned, is an already solved problem.

The part of the existing solution I was not happy was deciding when
to use which "merge-fix" commit to cherry-pick.  If I start merging
topic B before topic A, the "merge-fix/B" needs to be renamed to
"merge-fix/A" in the above.  Otherwise, when B is merged to 'pu',
there is no 'A' merged to it yet, so merge-fix that munges its new
call to foo() to call bar() instead will _break_ things [*1*].

And that was why I wanted to have a data structure that is quick to
query to answer "I am about to merge B.  Does the history already
have an A for which I have recorded a merge-fix for <A,B> pair?"


[Footnote]

*1* If A has other kinds of conflicts with other topics, it is not
sufficient to just rename "merge-fix/B" to "merge-fix/A"---the
effect of cherry-picking "merge-fix/B" needs to be merged to
existing "merge-fix/A".  If a merge-fix is recorded for a pair of
commits that necessitates an evil merge, this naturally goes away.
I can keep a merge-fix for the <A,B> pair whether I merge A before
or after B, and semantic conflicts A may have with another topic C
would be stored in a separate merge-fix for <A,C> pair.
