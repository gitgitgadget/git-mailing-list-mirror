Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989761B4C30
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907163; cv=none; b=eyV5iBMkgfEp21Rq5qgPFJg0h6CI5FFtl8aZdQ47bNf5I0Xym8Ne8pv7MsMqMw1sX3nl9pSlOzVPWFZw/H1ofiSQKWt77Q83lZHHTjkqXbnS/qCUVJFbvuB24bJD2wpObbuhaJFvR/zKx4NTRezougE6DJCZwRtAMQ8+/5DAHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907163; c=relaxed/simple;
	bh=MR6nNkQXZ462NGHi60YZ4MEAQlu6b3+MnOG5DdV2GEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIlvkYtrZ9v//qe1YSA3NC+h7tDlBTw2e0o2ScGPuhdgnYW7BBhyRrAqv9RRsXBX5Mcbsh+loxRzWPGSCWEHJTcHZWtcGTcenX/iJM041owIzcZ9tU0KoAgZgypJ/Ki+j3CpR2JJX86/W3qNXP+D1xZalIEP+EB4uOIZybI+N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qa/yxU8b; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qa/yxU8b"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BEA02EE94;
	Thu, 20 Jun 2024 14:12:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MR6nNkQXZ462NGHi60YZ4MEAQlu6b3+MnOG5Dd
	V2GEU=; b=Qa/yxU8bstwl19ROISl/hrZ/bxhWockfoiqk/Ut0SiOR7LWetJmFSq
	+VqtgWqmxn8ty0/Sjv3nd7vpjbvvW6nA1DebjPEhtM8NFopUXUcMdreN5PYmEEp1
	dr9nULZzgdtnuMPCQU07SWmUKmOtkbeqMQvZDElz7kPsvOAtBNswA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 03FE12EE93;
	Thu, 20 Jun 2024 14:12:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D6E02EE92;
	Thu, 20 Jun 2024 14:12:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Kyle Lippincott <spectral@google.com>,
  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/2] commit: remove find_header_mem()
In-Reply-To: <20240619173106.GA1519400@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 19 Jun 2024 13:31:06 -0400")
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
	<8b350cae-2180-4ac7-a911-d40043576445@web.de>
	<0d85712c-5beb-4a64-a7f4-797782c26694@web.de>
	<20240619173106.GA1519400@coredump.intra.peff.net>
Date: Thu, 20 Jun 2024 11:12:37 -0700
Message-ID: <xmqqr0crv5yi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD71BC56-2F30-11EF-A14C-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>> +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
>>  {
>>  	int key_len = strlen(key);
>>  	const char *line = msg;
>
> Not new in your patch, but assigning strlen() to int tingled my
> spider-sense. It's OK, though, because "key" is always a small string
> literal.

Yup.  All callers of find_commit_header() give in-program constants
and never an externally sourced random string there.

> So the conversion looks good to me.

Thanks.  Will queue.

