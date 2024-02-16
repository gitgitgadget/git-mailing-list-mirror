Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED01426E
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064752; cv=none; b=bJrhtK7gUxLwKwYAZjrkywnOvh9yBGBqY2ubgOl6llNjGHp9I17iaalmP8Aqmpq4dw82kw7t641MJcwJZa7BzNkKDaACI5KQBuRZMslsjxCBK7t3i1RVSoxx3XSw8p9RpAInKxQXTolSqe93Bac7EfGGN+FTDYe91m4gHtTvzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064752; c=relaxed/simple;
	bh=9lucYi/w9iHM6gVCjAAuOxpu3Oz+Y1dk2uWaSyIg+6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ql6h/cnSdKoBnZq4EMUAKETcQv/I+QVyh9pW1ealRaj1Bkb5mPo6q8HQXjRWarX1QZCJUip3WKeW5MCqTKAfK2o/dE5RvdHKM/3GrUaXAy1UQJCR5uZ2Av0OIDffCibXHo4ML1JmV+qOOvP1Bglyrn5wrdJIakwnoXZtQQzU+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uurCpy7A; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uurCpy7A"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 98E2E31003;
	Fri, 16 Feb 2024 01:25:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9lucYi/w9iHM6gVCjAAuOxpu3Oz+Y1dk2uWaSy
	Ig+6k=; b=uurCpy7AwiBcHF2+tNNFaeziVedB6D7rgiP1KKO183yFnL4aGXlIfS
	qOPSzGNRMluOFPiYVFL0e/7ZuRW4vt/R9WNtxW+8UXZN6P3nvF4Vos4PXfogiN/t
	X9T+lu61xhU4vg9SPQGOyMPCYMA3S26al2fH4AQAvfbOUIaDn6ehk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 909C331001;
	Fri, 16 Feb 2024 01:25:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3323D30FF2;
	Fri, 16 Feb 2024 01:25:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Maarten Bosmans <mkbosmans@gmail.com>,  git@vger.kernel.org,  Teng Long
 <dyroneteng@gmail.com>,  Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
In-Reply-To: <20240215052640.GC2821179@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Feb 2024 00:26:40 -0500")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240205204932.16653-2-maarten.bosmans@vortech.nl>
	<xmqqil32l0i6.fsf@gitster.g>
	<CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
	<xmqqy1bxiiop.fsf@gitster.g>
	<20240213080014.GB2225494@coredump.intra.peff.net>
	<xmqq5xys6zdr.fsf@gitster.g>
	<20240215052640.GC2821179@coredump.intra.peff.net>
Date: Thu, 15 Feb 2024 22:25:45 -0800
Message-ID: <xmqqcysxkjrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 389F5E50-CC94-11EE-809B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Feb 13, 2024 at 09:35:28AM -0800, Junio C Hamano wrote:
>
>> Remind me if you can if we (1) had plans to allow non-blob objects
>> as notes, or (2) actively support to have non-text blob objects as
>> notes.  I _think_ we do assume people may try to add non-text blob
>> as notes (while they accept that they cannot merge two such notes on
>> the same object), but I do not recall if we planned to allow them to
>> store trees and commits.
>
> Short answer: no for (1) and yes for (2).
>
> In my head non-blob notes were always something we'd eventually allow.
> But I don't think the "git notes" tool really helps you at all (it
> insists on being fed message content and makes the blob itself, rather
> than letting you specify an oid).

OK, that makes my worry about dropping "git show" from the codepath
quite a lot.  At least we only have to worry about blobs.

> Non-text blob objects, on the other hand, should be easy to do with "git
> notes add -F". Interestingly, the display code (in format_note() again)
> converts embedded NULs into newlines. I think this is an accidental
> behavior due to the use of strchrnul().
>
> Of course it's reasonable to also store notes that aren't meant to be
> displayed via git-log, etc, at all. The textconv-caching machinery
> stores its results in a separate notes ref. Those should generally be
> text (since the point is to come up with something diff-able). But I
> think it would be perfectly reasonable for another mechanism to make use
> of notes in the same way and store binary goo.

Yup.  

The question is if our current use of "git show" allows creative use
of such binary data attached as notes.  The patch in question will
break such users, as it would become impossible once we start
bypassing the "git show" and emitting the binary data directly to
the standard output stream.

Because the pathname a note blob is stored at is unpredictable and
not under end-user control, it would not be practical to define
different smudge filters per note object using the attribute
mechanism, but if you limit the types of binary data you store in
your notes (e.g., refs/notes/thumbnail may be a note ref whose
contents are all jpeg thumbnail images, where your main history is
your photo archive), you might be able to convince the "git show"
invocation we use to show the note object to show that thumbnail
image by using something involving "display" (from imagemagick---of
course you could use other programs that allows you to view the
image on different platforms) in your smudge filter.  Bypassing "git
show" and sending the blob contents directly to the standard output
would be a grave regression for such a user.

