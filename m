Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A731215F72
	for <git@vger.kernel.org>; Thu, 22 May 2025 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893649; cv=none; b=YyjKaPpY1J/QLm5q9hWqnIoUZBe0XYLm7hYjZIp8QTBVJ4rS9mJGtB9UwWEgUxMPMwyV34uE0ooN7/+L18oSzZApHHqO2Z7Iys/7RConQBZLl5Eq3qMNnHGnSn3XVdF3bhYKhVkbhKeqmeccLbV8Gm3I9E7im6bpGcaA9jJ4Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893649; c=relaxed/simple;
	bh=AxzuS6Cnty37YMXzeE3J0nYIdWfKVbjpxm5rbhE926Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqQqbnWOEsg+oRJjoFezUbhmSkT4FnKN7S8CCEL35c8u/j/4TIrUtnVNVZkqL5vZoYYjpbp1NAR0h0b1jKEERdZiRUE13183/uuMGYJDqOPgJ2P6TqyIByjGq14fmPoDz6iUm6yifm5T2eP2GJdxUYsfUw3L/fj8MusJg9HuHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JcWg7pHi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JcWg7pHi"
Received: (qmail 31421 invoked by uid 109); 22 May 2025 06:00:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AxzuS6Cnty37YMXzeE3J0nYIdWfKVbjpxm5rbhE926Q=; b=JcWg7pHisBfktjauY/+20bHLQomKNp3fW6w8nOijc2j7gbFlwXFDBAcYjh0R/23PjNkwVdKfZLQNEx9iCV2Hy+OY1g6qTisJWG6cw8/yMeqlORnil7xkKvi83AAwCD9UYkCwwvf3qUpWhG6DWZrpJdVKyF3BDr3pHeV+fAN0vnmpaHkuTFT2RCoJGNSKbkcb3uCYy3CSpWWhqZQR/wV5W1oKQra88p2ntHpFGe1ekWfJL2BqNl+YqQg1McBSTdH0PIGax65nXo1Ganon3QLx/6TsnpYKxQiqx8q/S8phulaGlA9YNW8eFm/igXBrI7EXLV+KX0Qjx3/L5aNkLnQFlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 06:00:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12564 invoked by uid 111); 22 May 2025 06:00:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 02:00:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 02:00:44 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
Message-ID: <20250522060044.GB1135327@coredump.intra.peff.net>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
 <xmqqy0usmprh.fsf@gitster.g>
 <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>

On Tue, May 20, 2025 at 02:05:09AM -0700, Karthik Nayak wrote:

> > Not an issue with this series at all, but one thing I wondered is if
> > it makes sense to change the type of strmap_get/strmap_put to deal
> > with "const void *".  That way, it would not be necessary to cast
> > away the constness like so:
> >
> >>     -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
> >>     ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
> >
> > without harming the other side, namely
> >
> >>     @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
> >>      +		if (reported_error)
> >>      +			cmd->error_string = reported_error;
> >>      +		else if (strmap_contains(&failed_refs, cmd->ref_name))
> >>     -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
> >>     ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
> >
> > this piece of code.
> >
> > It may not make sense, and even if it did, of course, it is totally
> > outside of this series.
> >
> > Thanks.
> 
> It definitely does, The only other typecast I did find for `strmap_put`
> was within 'strmap.h'. Nevertheless, I think it makes sense to make that
> change. strmap shouldn't modify the data provided. Perhaps #leftoverbits.

I'm not sure that is a good idea. Even though strmap does not touch the
void data pointer itself, it is accessible to the callers, and we do not
know if they stored const data or not, or how they plan to access it.

If we store a "const void *" pointer and returned that via strmap_get(),
then there will be callers who need to cast away the constness.

If we store and return a "void *" pointer as we do now, but accept a
const pointer via strmap_put(), then we're casting away potentially
important const-ness without the caller even seeing it. I think it's
safer for the client to do the cast explicitly (since they are the ones
who know how they plan to use it).

I don't think we can really represent what we want in C's type system.
But if we wanted a safe(r) interface that didn't involve type-casting,
we might be able to do something like:

  - the strmap stores an extra flag for "the data pointer is const",
    which can be set by strmap_init(). (It is tempting to replace
    strmap_clear()'s free_entries parameter by checking this flag, but
    the two are not always going to be exactly the same).

  - introduce strmap_get_const() and strmap_put_const() which give and
    receive const pointers

  - in the const functions, BUG() if the "pointers are const" flag is
    not set

But it feels gross, and it only gives runtime checking, not
compile-time. What we really want are generics that can carry the type
annotation for a particular instantiated map. That is probably pretty
easy in most modern languages, but not really in C without horrible
macros. :)

-Peff
