Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBA1D7E21
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260714; cv=none; b=fJu9u73Xl3w4K86RyG94rkew4zH/DOta0bUxBCYWwNTwUfZfJe+e9n9yoCz6nQYFZDHJj74v6bNufpUHM7Fea3UPlJFdxYFIMKdakKgJZ4LLKMN/xhkWBDokhm0m+3d0eNkkhjYr8dhHrLxbMLk97TaFS4lcHMS7vI5Yn3w2DZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260714; c=relaxed/simple;
	bh=4YhgeoYFN7Bgx3RTdUrFJ9u/1HgcbN5z1u5Q2dGAsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvidO7MQZTQW4ZF+YUt3rORwPYfv2gnSRgvRZA/6Q+5Um1IEPmJJAcRMpg/y7Q1auyorCcZQETgvmE9V6c292e7x9fZSS3sQRKhRN7TUvDFs5tk36IDR/LOG/VplIO0z5uBNwMXBywE9U5dP/c6SMEee6bZYyw6Jz4iTqiQTJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cEUsWaA8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cEUsWaA8"
Received: (qmail 30609 invoked by uid 109); 3 Dec 2024 21:18:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4YhgeoYFN7Bgx3RTdUrFJ9u/1HgcbN5z1u5Q2dGAsrE=; b=cEUsWaA8tfN/TUd8dcPyES6FuheOKgPuocpnGrVbnS0My9kI6FRmnuAZR4OF6aGwVQD2OUf2CiTe2Pe4ByIkGOJ6WHZO0dQMNbeS8F4haToT6H7hhqIV+vFt15AgBDFHzU+y4M7TwbNINU7JbRqi6xKfjrLWh0K6IomOn+IRKe0krU24N/TlahxSKyJeKwzI+H1jcI43ByAXjKGQVF+q1eGXPHKEWX2Rmc9Ji8o4qPwO/HvadV12isf2HqEf8JLELKkO4ZZngzbv6jcIVTcg+kim9wnqs6QgUSYiTMcSXp2vTPsBqEBv5a8mfVTTaUy/YbpjEzB2fkkm2A5wqxF/VA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Dec 2024 21:18:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10318 invoked by uid 111); 3 Dec 2024 21:18:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2024 16:18:30 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Dec 2024 16:18:30 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241203211830.GA1423791@coredump.intra.peff.net>
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net>
 <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net>
 <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net>
 <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>

On Mon, Dec 02, 2024 at 07:48:05PM -0700, Dmitriy Panteleyev wrote:

> > I wonder if building git with:
> >
> >   make SANITIZE=address,undefined
> >
> > and running the same test might yield anything useful.
> 
> Not sure if this is useful, but this is what I got:

Thanks. If you bisect with that command, does it end up on the same
commit?

> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==155141==ERROR: AddressSanitizer: BUS on unknown address (pc
> 0x78811e863aed bp 0x7ffe9d5ac800 sp 0x7ffe9d5ac770 T0)
> ==155141==The signal is caused by a READ memory access.
> ==155141==Hint: this fault was caused by a dereference of a high value
> address (see register values below).  Disassemble the provided pc to
> learn which register was used.
>     #0 0x78811e863aed in inflate
> (/lib/x86_64-linux-gnu/libz.so.1+0xfaed) (BuildId:
> bbefe2bbdc367b0c3cfbfcf80c579930496fb963)
>     #1 0x563e32ec7e5f in git_inflate /tmp/git_tests/git/zlib.c:118
>     #2 0x563e32bde431 in unpack_loose_header
> /tmp/git_tests/git/object-file.c:1271
>     #3 0x563e32be429c in loose_object_info /tmp/git_tests/git/object-file.c:1474

Hmm. So we are inflating a loose object. It's mmap()-ed, so presumably
that is why you get the bus error (the underlying nfs system for
whatever reason is not able to provide the bytes).

I'm still super puzzled about why this would start happening, or how it
could be related to that commit. The rest of the stack here:

>     #4 0x563e32be5348 in do_oid_object_info_extended
> /tmp/git_tests/git/object-file.c:1582
>     #5 0x563e32be5dac in oid_object_info_extended
> /tmp/git_tests/git/object-file.c:1640
>     #6 0x563e32be5dac in oid_object_info /tmp/git_tests/git/object-file.c:1656
>     #7 0x563e32bf8b57 in parse_object_with_flags /tmp/git_tests/git/object.c:290

shows that we are coming from parse_object_with_flags(). Is it possible
that calling stat() somehow primes the nfs system to be better able to
serve the mmap'd data? That seems kind of weird.

Maybe one other thing to try. Build with:

  make NO_MMAP=1

(optionally with SANITIZE also). That should replace the mmap calls with
a compat wrapper that just reads into an internal buffer. I suspect that
will make your problem go away, though I'm not sure it gets us any
closer to understanding what's going wrong.

What's the nfs server in your setup? Is it another Linux machine, or is
it some other implementation? Do you know which nfs version?

-Peff
