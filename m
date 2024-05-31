Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853211C687
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169238; cv=none; b=XP81R68XY+0LJtq7OjPOH7lkD2SrPdrITHYNbrznHN9odNpLNBVzjt9sPAQCG0L+t+3fvWgsaie0EPm1vuiKNB/dNYIF5oeSortmw/NwPKzpgqqJiAy0kamauuPMnXv67aauyzB6wg/3EMNqzDVU5gIQ4P2/r0c4h5G1qberDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169238; c=relaxed/simple;
	bh=fkLwNEHv6PWqFZ951Ov7auSb8szTOdE6GsNAXic36Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZlN6btS9aqnvrSzGpPkjTgI4Ix5+U8vcuI5ZmjjQecT6Dtip9xZpExB9BLdabzZjUiA9AhUPIzOQlN0gPmEG7Agn47ci2OrvHXS4s4F9Een+9rw2xV0HRxTAq9ef+WnTCKpnWtGVmAYYsglsY8P8k8J+1ZjOJGqKawYdBNm8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FDwdGKOa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FDwdGKOa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6922F341DD;
	Fri, 31 May 2024 11:27:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fkLwNEHv6PWqFZ951Ov7auSb8szTOdE6GsNAXi
	c36Gs=; b=FDwdGKOaCm0VeP7mEXLwBtA0ZUY2eW0tjZoebIDa+hHASSQ1gylHiX
	ZhDKgLhuNjWjvDgSTdNwOH1ognKqp/1arxfxmC1PPfasW89CekWZvl74+ozgPMcg
	HvCtd1+YZKB1YMto4cq/yto8gjeqIj6d8cOvTMq0VR/c0nK1K/RWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61556341DC;
	Fri, 31 May 2024 11:27:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5D32341DB;
	Fri, 31 May 2024 11:27:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
In-Reply-To: <ZlnJ83qSnGlQ0FWR@tanuki> (Patrick Steinhardt's message of "Fri,
	31 May 2024 15:00:35 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
	<xmqqplt4y1gk.fsf@gitster.g> <ZlhjN7K8JKYz6Opd@tanuki>
	<xmqq34pzozsq.fsf@gitster.g> <ZlnJ83qSnGlQ0FWR@tanuki>
Date: Fri, 31 May 2024 08:27:13 -0700
Message-ID: <xmqq4jaehui6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 421DE264-1F62-11EF-9D77-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 30, 2024 at 12:38:45PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Well, we do. Not in `get_fetch_map()`, but in `query_refspecs()`. It
>> > does weird stuff where it writes the result into either `src` or `dst`
>> > depending on which of these fields is provided by the caller. Which
>> > means that one of the fields would typically be a constant, whereas the
>> > other one will be allocated.
> ...
> Well, yes, the pointers can be updated. But that doesn't solve the
> underlying problem that the interface is not well-prepared to track
> ownership of its inputs and outputs.

Oh, absolutely.  That is exactly why I wondered why .src and .dst
need to be "char *" and not "const char *".  If the piece of memory
these members point at are never modified via these pointers, marking
them as "const char *" would help the compilers help us by catching
when we try to break the promise.

Sometimes, the "constness of a pointer should help compilers help us
avoid modifying a piece of memory we promised not to modify through
the pointer" contradicts with the idea of (ab)using the constness to
signal ownership, i.e., "const pointers point at something owned by
somebody else, but via non-const pointers you always own the memory".

I wonder if we can do something to separate these two concerns
apart, using a trick similar to what we often use with an extra
variable "to_free".  Doing so would bloat the refspec_item, but
unlike the references themselves, there won't be thousands of them,
so it may not be an issue, perhaps?

>> And again you are conflating "allocated" with "read-write" here.  It
>> is often convenient if a variable that points at an allocated string
>> is of type "char *" and not "const char *", because you do not cast
>> it when calling free().  But if you want to make a structure member
>> or a variable that holds an allocated string responsible for
>> _owning_ the piece of memory, then you need to consistently have the
>> member point at an allocated piece of memory (or NULL), no?  What
>> this patch does, i.e. prepare an on-stack refspec_str[] array that
>> is initialized from a constant string, and have .src member point at
>> it, would not make .src freeable.  In other words, .src pointing at
>> an allocated piece of string "some of the time" alone is not a good
>> justification to make it a non-const pointer, I would think.
>
> That's fair enough. I'm trying to work around a broken interface, but do
> not solve the underlying issue.


