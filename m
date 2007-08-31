From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 09:01:34 -0700
Message-ID: <7vmyw71yn5.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8wL-00048q-Ez
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbXHaQBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758609AbXHaQBk
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:01:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579AbXHaQBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:01:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D765212BD3F;
	Fri, 31 Aug 2007 12:01:58 -0400 (EDT)
In-Reply-To: <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 31 Aug 2007 08:44:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57177>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> ...
>> So maybe we can suppress the warning when the output is not a tty?
>
> What's your point?
>
> I did not even want to apply that "empty diff --git removal"
> patch.  I certainly do _NOT_ want to suppress that replacement
> warning anywhere.
>
> You are seriously tempting me to revert the commit
> fb13227e089f22dc31a3b1624559153821056848 (git-diff: squelch
> "empty" diffs)...

This probably needs clarification.

That warning came because I was experimenting your reproduction
recipe of touching revision.c before building.  In earlier git,
it would have shown "diff --git a/revision.c b/revision.c"
without any actual diff text to remind me of that fact, and I
would have liked it better than the current "warning at the end"
behaviour for this particular case.  It was a reminder that my
recollection of what I did (and what my understanding of what
the state of my work tree is) matches the reality, but the new
"squelched" behaviour lost that value.

With the older git, whenever I sent out such a "this is how you
would do it" patch without committing [*1*], I removed those
"expected to be empty" diffs by hand after making a mental note
that these were to be expected and my understanding of where I
am matches reality.  It was a good thing.

The new "single warning at the end" was deliberately done to
reduce the "clutter" (which, this exchange is reminding me was
not clutter at all but valuable information) as a response to
requests from some people on the list, but because it was made
much less visible, it made me to miss it.

Having said that, I am _not_ going to revert that change at this
late in the game, but I am really tempted to add an option and a
configuration variable to revive the original behaviour (and of
course I'd set that configuration variable in _my_ repository).


[Footnote]

*1* Most of the patches I send out to the list are done that
way; I do "commit then send patch" much less often than "edit,
test, send 'diff HEAD' to the list and reset, intending to later
"am" it from the list if it is accepted favourably on the list".
