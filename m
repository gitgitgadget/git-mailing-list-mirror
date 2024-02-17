Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A321CA86
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708149380; cv=none; b=Yg5kgpFWQeHucPVCc0GXoA+zCHNYjDf2dzWmMb0PWwZbA0BhhtM6yIdbHEcaVjxNkU5RQEkjvqa575xYIRQTJRhnYuQZy5IgYt1VAR8T+WzTW8b8goClmd3UmtZpQEW2b7qMSZQZc8PRkMv6bOzuJUektsfMas7de1Su8de2ot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708149380; c=relaxed/simple;
	bh=1c2z5py2I12+OOYeERK7jpsVlfynnyAmq04CDPrrbXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJsj7KYeXtQ2ajFnDX5uNOs7aMb6h4vReem0JjDQZA96UB58QkP/muoT1/H8TzLdQ47WvHaa8ND6Smdp/QuRrkwW7oX7P9u1Nsu5bNlcEz1g5Qup1yjUxl06EGYD7Q11ImTXd2/lSuEmKcYZxjOmNBbaGlGMiJASQH6Mn30FdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsJC9/W8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsJC9/W8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8759D1EB018;
	Sat, 17 Feb 2024 00:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1c2z5py2I12+OOYeERK7jpsVlfynnyAmq04CDP
	rrbXw=; b=bsJC9/W8JK3B9VaUjNP2yQBw2Ob0In022YNJUvrELEccUWUs2bAArn
	QlLs3s0T/KLqoRhgh+X3RoNAC6uTHF1g7uo2I30Z8pSnEMZRncQlHsvvyg/Rzlw1
	98aiY3DtCrdRQwyBhOTATH+amWa1ZkhCaj1dB7sY2esoaibpKn75o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F1191EB017;
	Sat, 17 Feb 2024 00:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3A481EB012;
	Sat, 17 Feb 2024 00:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Maarten Bosmans <mkbosmans@gmail.com>,  git@vger.kernel.org,  Teng Long
 <dyroneteng@gmail.com>,  Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
In-Reply-To: <20240217051650.GB539459@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Feb 2024 00:16:50 -0500")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240205204932.16653-2-maarten.bosmans@vortech.nl>
	<xmqqil32l0i6.fsf@gitster.g>
	<CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
	<xmqqy1bxiiop.fsf@gitster.g>
	<20240213080014.GB2225494@coredump.intra.peff.net>
	<xmqq5xys6zdr.fsf@gitster.g>
	<20240215052640.GC2821179@coredump.intra.peff.net>
	<xmqqcysxkjrq.fsf@gitster.g>
	<20240217051650.GB539459@coredump.intra.peff.net>
Date: Fri, 16 Feb 2024 21:56:14 -0800
Message-ID: <xmqqwmr3fxc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4327A858-CD59-11EE-A089-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Digging in the history, it looks like we use "git show" at all because
> this was adapted from a shell script (though that shell script probably
> ought to have been using cat-file in the first place; maybe back then we
> thought we'd support non-blobs ;) ).

Yup, that is why I suspected that we planned to store non-blobs.

> Hmm, good question. I can't think offhand of a way that the user could
> convince "git show <oid>" to do anything different than just dumping the
> literal contents. It is not even handed a path that could trigger
> .gitattributes or similar.

show_blob_object() directly calls stream_blob_to_fd() without any
filter, as the hardcoded invocation of "git show <oid>" in the note
codepath does not allow --textconv at all, so we probably are safe
to assume that the contents will appear as-is, not even going
through EOL conversion (which is a bit puzzling, to be honest,
though).  Lack of path I am not worried about, as you can easily
declare with '*' wildcard that everything in the notes tree is of
the same type.  But if the stream_blob_to_fd() interface does not
have anywhere smudge filters or textconv filters can hook into
without some command line option, we do not have to worry about it.

> Sometimes, of course, we have to support weird stuff anyway because it
> has existed for a long time and we don't want to break users. But this
> is really pushing my gut-feeling limit of what is reasonable / plausible
> for somebody to be doing.
>
> Of course I may be missing some other case where "show" behaves in a
> useful way that is different than a straight dump of the blob. But if
> not, I'd almost say that getting rid of the extra "show" call now is a
> good thing, because it locks in the simple behavior. ;)

Yes, of course.  It would be great if we can just stream the blob
contents out in-process.

Thanks.
