Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F452D05E
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OhH1K2OP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BE8C266D8;
	Fri,  5 Jan 2024 11:34:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TQIh5WqpK4nBEo7eDjfTWJTwUm4fACUFkITTwm
	DxQgw=; b=OhH1K2OPF67ituwgaKnxa3El5LZiXUH5dUGIg8RCieni9AgOTBAlzh
	rJnSyH7Z2FHQy6xvI6+LEaLxifrgnQv9wG24HZ0dRqe4Uy2z5e7XwjDGhvpoa9pv
	LddtBhhUN8XcKfCJpLgMmUFJJsXyf0d6eLdhP5daCZOQdDiY+KHW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 044DF266D7;
	Fri,  5 Jan 2024 11:34:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A1D29266D6;
	Fri,  5 Jan 2024 11:34:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
In-Reply-To: <20240105085928.GA3078702@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 5 Jan 2024 03:59:28 -0500")
References: <xmqq5y0bcjpw.fsf@gitster.g>
	<20240103090152.GB1866508@coredump.intra.peff.net>
	<xmqq8r56bcew.fsf@gitster.g>
	<20240105085928.GA3078702@coredump.intra.peff.net>
Date: Fri, 05 Jan 2024 08:34:17 -0800
Message-ID: <xmqqo7dzoi2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 45CB5768-ABE8-11EE-815F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Jan 03, 2024 at 08:37:59AM -0800, Junio C Hamano wrote:
>
>> This is totally unrelated tangent, but the way "show-index" gets
>> invoked in the above loop makes readers wonder how the caller found
>> out which $idx file to read.
>> 
>> Of course, the above loop sits downstream of a pipe
>> 
>>     find .git/objects/pack -type f -name \*.idx
>> 
>> which means that any user of "git show-index" must be intimately
>> familiar with how the object database is structured.  I wonder if we
>> want an extra layer of abstraction, similar to how the reference
>> database can have different backend implementation.
>
> I assume you mean a test helper by "extra layer of abstraction".

Well, that might be a good first step, but I was envisioning more
into far future where the object store is reimplemented on top of
high-performance database, at which point we may want subcommands
like "git odb list-packs" that lists packfile names (which may not
name any on-filesystem files) that can be given to "git show-index",
for example.  Of course, the abstraction boundary of the object
store might be placed a lot higher and the interface into it may be
limited to "here is an oid, give me its contents" without distinction
between the objects in packfiles and objects in loose object files.

> So I think we should just punt on it for now. Adding one case here is
> not making a hypothetical abstraction layer significantly harder to add
> later.

Totally agree, and that is why I labeled the whole thing as an
unrelated tangent.

Thanks.
