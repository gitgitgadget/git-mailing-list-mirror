Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA1EA7A
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520990; cv=none; b=cvZtGE5nTgv0svCQFxjlyonN8gXRs2DY4m6HdaerBqtrIrFAe4KLg5hB6UfbKYY23yitrS0i5GR99IXIJ7UQAgyK6p92uj5yOBstkiF/216/wuMX/DDA4iPo9XC8q/EMWFM7fmmrRf8efWAdozOBERRFwbf17vogEFgOQ2B9KG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520990; c=relaxed/simple;
	bh=/oOqWNavSRLEYpBb1tepwZWQA6EJNEySJHUkpeMYado=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWUG3TZRSDgAWj+8bITB9HHPdW2AFUS5OuYfh0ejtYnOBVBlu7EqCqhOMwQ5WTL6H1hBEAg1RMSMMF67IaiF9o4d4TkEZ2Bb3rbLyiMfET5pBcDcVfZ3tMNUDFyeSK4cnfyO8aPQ4c4zDHV5DyHiiYKUA6GG0WSzN5tbOIoMcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t3bXu2N+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3bXu2N+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 523191E2495;
	Fri, 15 Mar 2024 12:43:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/oOqWNavSRLEYpBb1tepwZWQA6EJNEySJHUkpe
	MYado=; b=t3bXu2N+oEbjyriSBTnhc8zsc8zQN8jgm0oC/a2LGDy0wmSf690vMs
	pULYp/w2IjWXBbGUCpuDAPdy5xwnaJLjPDQf7aeAY5ckyFcfG6ZLQIK9Y/cxnhW4
	zB3zJCPahl7Kcr3kfMMyrgtSompuyIfR92dSjEOEmOeSbKGiaC24E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED9BE1E2493;
	Fri, 15 Mar 2024 12:43:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177EF1E2492;
	Fri, 15 Mar 2024 12:43:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
In-Reply-To: <SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Fri, 15 Mar 2024 06:09:02 +0000")
References: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<xmqqttl94qxg.fsf@gitster.g>
	<SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Fri, 15 Mar 2024 09:42:58 -0700
Message-ID: <xmqqil1nsay5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 15820D4C-E2EB-11EE-9EDA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> The shoehorned `if` was to avoid duplicating the `strbuf_addstr` and
> `type` statements.  It sounds like code duplication is not a concern,
> so I can make that change.  However, with this new logic flow, maybe
> it would be better to have wholly unique values for the display,...

I wasn't avoiding duplication at all.

20% of the reason why I pointed it out was because the third member
"forced no-op update" that is added to the existing two, "forced
update" and "non-forced fast-forwarding update", looked as if it
were made a part of the "non-forced update", where the three at
least to me looked more like equals.  And the rest 80% is exactly
because the "three equals" arrangement gives us a more freedom to
express how we show the update.

>    deadbeef==deadbeef   main -> main
>    deadbeef..deadbeef   main == main
>
> There's a fair amount of room for creativity here.  Of course, using
> revisions is useful, but the existing output contains `+` for forced
> updates, which is not valid in a revision, so there is clearly space
> for novelty.

Sorry, but I do not understand the remark about '+' at all.  In the
existing output, the flag char like '+' comes at the beginning and
followed by a whitespace before <from> and <to> ref correspondence
is reported, no?

I can buy the idea of using "summary" that is different from the
existing A..B or A...B form to make it stand out, but the "->"
between the two "main" in your example must stay as is.  That part
of the output shows the correspondence between our ref and their
ref, and has nothing to do with what object their ref originally was
pointing at and what object their ref points at now.  There is no
choice of the sign there, but even if there were a choice [*], it
should not be influenced by how the pair of <old,new> objects
involved in the update are related.

	Side note: we could imagine using a different sign other
	than "->" if you update a branch from a non-ref
	(e.g. pushing the freshly made commit on detached HEAD state
	to update a branch over there), or perhaps updating a ref
	with a ref from different hierarchies (e.g. push the tip of
	the current branch to update their refs/tags/v1.2.3).

Perhaps use "%" as the type and show just a single object name in
summary?  I.e. something like the first one in this example:

 % 4f9b731bde		   master -> main
   1203cff8ae..6e790dbe36  next -> next
 + b7485789d7...3e580ca942 seen -> seen

> We may also want to consider what happens when both --force and this
> new option are used at the same time.  When testing, the message was
> always "up-to-date", but I realize now that a server might report it
> as a forced update - it would be odd, but would it be impossible?

If I recall correctly what happens at the protocol level (without
looking at the code---look for comment "Finally.*tell the other end"
to find it out where it is), I do not think the receiving end can
even tell, because the only thing they see for each ref is the old
and the new object name and the refname.  There are intricate
mechanism among the sender (push/send-pack), the receiver
(receive-pack), and the transport helpers, to carry necessary info
around to produce a report that says "this ref update went OK" and
"this ref update was NG, due to such and such reason", but I do not
think the receiving end does not compute the forcedness for
reporting.  It only runs in_merge_bases() between old and new
objects to decide if it is a non-fast-forward, when configured to
reject such updates, and it may report the failure was due to
non-fast-forward condition, but I do not think there is more than
one kind of successful updates reported (they just say "ok").

Speaking of what happens on the receiving end, we may have to
consider what, if anything, we need to do to the hooks that run
there, which gets "the ref X was updated from object A to object B".
They never saw "object A to object A" update and may get confused.
