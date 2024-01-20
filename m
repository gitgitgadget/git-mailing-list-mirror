Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6712B91
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775194; cv=none; b=GqasGIHaa3wNlSzQLjH++nbBzEVELrA+twrb8b1L4Jvz+Wxu/LwEvKIseqXjBvVJgsNoVUsBTYL3GoQNYjI4cWBHBhwIpcr3iKIvxvxM3Ey1ywgtOk2m6+sdeFJH/UKd2HtyW0CaFaaab0wvvy8NPF6mBoiRfH8+yfB0UtSJ95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775194; c=relaxed/simple;
	bh=Ix2T4m89fhRpmxxbYm9hXd5LqB+Exqrw+oXUn43fb2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDdhuDW3RR9xSAXWYjqIA/nrAxDzSGZJXAJhZbnNPjEmZYDe3tI4P7GQM3kKFeikdj82DP5/n4VKeigUfp7AEcZUXBjZyR3Mb/bFSMxxlsSHo78wK+O1kEggSoc79vtc1Pm4gf8zI+LFrUVMYJNOGsXGKRIGxVqyL7zfVQDcr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kMO9mHYj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMO9mHYj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49FA01DD236;
	Sat, 20 Jan 2024 13:26:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ix2T4m89fhRpmxxbYm9hXd5LqB+Exqrw+oXUn4
	3fb2A=; b=kMO9mHYjE4kgrtw9mxqq69ozPypLHJHVeI9WKA0yvPpXgFHO5EvlnD
	hRyJXKmn4jsqqiSFXbXM5sqZsLuByVrdjKkfnnGpt/f+BgyqBHCFLWsSQfMZS5Lk
	onJc2LmiVxhK6YfMZ64G7y/0yZt3CrxDh62EgoVCPvypHEQY4m/Zw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4241D1DD235;
	Sat, 20 Jan 2024 13:26:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A58731DD233;
	Sat, 20 Jan 2024 13:26:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Farhan Khan" <farhan@farhan.codes>
Cc: git@vger.kernel.org
Subject: Re: How OBJ_REF_DELTA pack file size calculated
In-Reply-To: <afea6dc9-e557-4730-abe6-00947f77be06@app.fastmail.com> (Farhan
	Khan's message of "Fri, 19 Jan 2024 23:28:05 -0500")
References: <afea6dc9-e557-4730-abe6-00947f77be06@app.fastmail.com>
Date: Sat, 20 Jan 2024 10:26:29 -0800
Message-ID: <xmqq1qabg8tm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E95A128-B7C1-11EE-A65C-25B3960A682E-77302942!pb-smtp2.pobox.com

"Farhan Khan" <farhan@farhan.codes> writes:

> 82daab01f43e34b9f7c8e0db81a9951933b04f1b commit 94 101 82749 1 ecd0e8c88ed8891da372f5630d542150b0a0531e
>
> The size of the object is 94 bytes
> The size of the entry is 101 bytes.

> My patching/reconstruction of the object works, the compressed
> size is 97 bytes.

What do you mean by this?

The dense object header expresses the inflated size of the object
(which should be 94 in your case).  By expressing it as a delta
against some other object in the pack and then deflating the delta,
we should get the data that is much smaller than 94+20 if we choose
to express it in the OBJ_REF_DELTA representation, as with such a
suboptimal delta base, we would be better off expressing it as a
base object that is merely deflated.  We do not need 20-byte offset
overhead, and when reconstructing the object, they do not need to
deflate the base object and apply the delta.

So I am not sure what you mean by "the compressed size is 97 bytes".

> However, I cannot figure out where the 101 comes
> from. The size of the object header is 2 bytes, the OBJ_REF_DELTA
> is 20 bytes (the SHA1), but that does not add up to 101 bytes.

$ git help format-pack

   - The header is followed by a number of object entries, each of
     which looks like this:

     (undeltified representation)
     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
     compressed data

     (deltified representation)
     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
     base object name if OBJ_REF_DELTA or a negative relative
	 offset from the delta object's position in the pack if this
	 is an OBJ_OFS_DELTA object
     compressed delta data

     Observation: the length of each object is encoded in a variable
     length format and is not constrained to 32-bit or anything.

So, if the object header for this object in this pack is 2 bytes
long as you observed above, then 101 bytes should be 2 bytes of 
header, 20 bytes of base object name, and the remainder would be a
deflated delta data that is 101 - 22 = 79 bytes.  Reading the base
object and applying that delta (which deflates to 79 bytes) would
reconstruct the original 94 bytes of the object.

