From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Sun, 09 Oct 2011 22:29:56 -0700
Message-ID: <7vr52lo1m3.fsf@alter.siamese.dyndns.org>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
 <7vfwj4tplw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
 <7v8votpx4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 07:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD8RF-0001m0-7k
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 07:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab1JJFaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 01:30:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab1JJF37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 01:29:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54C9025A1;
	Mon, 10 Oct 2011 01:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wlaylm+8iS6KL/LaNlWRrx0WiGE=; b=HCWQfY
	Xsm5g4VybKjRm/nvL42N+H8NSqzEtmEgSpjh0VFeiHRm2NE5fV5GWiTS5JbaUn0c
	sECY9kAbSO9gobNuqybHPwX8paltY4lvaF0m+be3oAxHDvatYNiN4ztefcuJqw40
	RUyWre1KTqVIMb0ml7j0k0/OjBT1n++OPXKm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaAcw37YWBrEZ/eC0AFuVDllcgFC8KQ8
	13SiKaD5M19Xp/pFA9g7pvNTBY/KD7J+0VZp1FGcPH7//9oyvBd/SfSLcy2xCZbW
	jqP+esfEm+ojCfE6HHR81Nk5EbplWGOmss7Pburm95MU2WYfY+xaaMoaFkMcD/CY
	utguVbbq1TE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C10125A0;
	Mon, 10 Oct 2011 01:29:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC073259F; Mon, 10 Oct 2011
 01:29:57 -0400 (EDT)
In-Reply-To: <7v8votpx4n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Oct 2011 16:23:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E450ADD8-F300-11E0-882C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183222>

Junio C Hamano <gitster@pobox.com> writes:

> To understand why it is a wrong mental model, you need to imagine a world
> where the logic to resolve conflicts in "git merge" is improved so that it
> needs less help from the users. rerere.autoupdate is half-way there---the
> user allows the merge machinery to take advantage of conflict resolutions
> that the user has performed previously. Even though we currently do not
> let "git merge" proceed to commit the result, it is entirely plausible to
> go one step further and treat the resulting tree from applying the rerere
> information as the result of the automerge. When that happens, it is very
> natural for the user to expect that the rest of what "git merge" does for
> a clean automerge to be carried out. After all, from the end user's point
> of view, it _is_ a clean auto-merge. The only difference is how the user
> helped the automerge machinery.

Addendum.

I am not suggesting that we should change rerere.autoupdate to go all the
way and record a merge commit by default automatically when rerere applies
cleanly.

I personally think that it is a sensible default to set rerere.autoupdate
to false (or not to set the variable at all) to ensure that a merge that
conflicts is always inspected by the end user, given that rerere is merely
a heuristic (even though it is a damn good one) and produces a surprising
result.

But that is a policy preference; some people want to trust rerere more
than I do and that is a valid choice for them to make. To support such a
policy preference, I am perfectly fine with introducing a third value to
rerere.autoupdate in addition to yes/no to allow commands (e.g. "merge",
"am", etc.) to continue when rerere resolved conflicts cleanly in a
situation where they would have stopped and asked user to help resolving.

By the way, on the other side of this same coin lies another use case
(different from the one in the footnote in the previous message) for
"merge --no-commit". When you know that a particular merge _will_ need
semantic adjustments, even if it were to textually merge cleanly, you
would want the command to ask you for help to come up with the final tree,
instead of trusting the clean automerge result. This often happens when
the topic branch you are about to merge has changed the semantics of an
existing function (e.g. adding a new parameter) while the branch you are
on has added new callsite to the function (or the other way around). In
such a merge, you would need to adjust the new callsite that does not know
about the additional parameter to the new function signature.  For exactly
the same reason, it is not a kosher advice to give to users of modern Git
to "interfere with the merge with 'merge --no-commit', and then conclude
with 'commit'", as 'commit' has less information than 'merge' itself what
'merge' wants to do in addition to recording the result as a 'commit'.

Either the 'commit' command needs to detect that it is conclusing the
merge and trigger the merge hooks the same way as 'merge' itself does,
(which is a bad design, as 'commit' will need to know about the clean-up
operations of all the other commands that may ask users to help and let
'commit' conclude it), or the end user instruction needs to be updated so
that 'merge --continue' is used in such a situation to give 'merge' a
chance to finish up. Again we could have "git continue" wrapper that knows
how to tell what operation was in progress and invokes "merge --continue"
when it detects that it was a 'merge' that was in progress, but that is a
mere fluff.
