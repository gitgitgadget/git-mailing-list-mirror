Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54242D615
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602374; cv=none; b=b7KvO9+gjgUpzz6+nsREK5vNYjrTyqGPuiZGo8g6KSbq+QQJA/AhTjbWr9jT1J2R1GJYv0+DgM7ZM4psjKrG+6eTRkzgA91jOx/l57PChsOe3zBo9eUBdcQz+TyGZaNdAuLPlAapwXoPWe1bG0yFV2QmqPPHEHO7RpRavby02G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602374; c=relaxed/simple;
	bh=2pZkEVlDyvUKbOUivjqta2IllkURPmW25k9vG3EKXDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dybyEnkSYHRH9GtBv/AkfegmcqXRDyrfPJHf9MYAjxvXH+hUN/wFfEpFmj/dgoAbqQ0TRfeSsyOiHJBovnU9eE0MkOmQggZjP3gW2szFH2iCJGiLTZyEqbQyVff24E5Sc00CNAA01ltP7tivPSj+pPcvQGXpvvSHi1cLHpsvBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LEimOF73; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LEimOF73"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 13182373D9;
	Thu, 18 Jan 2024 13:26:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2pZkEVlDyvUKbOUivjqta2IllkURPmW25k9vG3
	EKXDw=; b=LEimOF73epJJ2o7zKIFAldlLVEkvrxJjn4SMmD+4Lsha7zYCMmIo66
	UBHef/7F7QXNUYJsHNMHk2Bn9seo9viDMXwGZRn45KtGLu7u45dR8uPcRipyUBAs
	pcHvRYA2odCEoHtZHmBiV7U+Z0gQddaX+m+3qDKCDSUpWa4VkgAs4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B5C0373D8;
	Thu, 18 Jan 2024 13:26:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B367373D7;
	Thu, 18 Jan 2024 13:26:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org> (Dragan Simic's
	message of "Thu, 18 Jan 2024 07:15:32 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
	<20240110110226.GC16674@coredump.intra.peff.net>
	<aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
	<97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
	<a97b03a305a7b8b95341b63af1de0271@manjaro.org>
	<xmqqil41duov.fsf@gitster.g>
	<d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
	<20240111080429.GG48154@coredump.intra.peff.net>
	<5f322b3e6053c27dda58ef1c1f025d11@manjaro.org>
Date: Thu, 18 Jan 2024 10:26:08 -0800
Message-ID: <xmqqil3qsdkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D37708E-B62F-11EE-891A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Perhaps having both options available could be a good thing.  Though,
> adding quite a few knobs may end up confusing the users, so we should
> make sure to document it well.

I agree there is a need for documentation, but we are not increasing
the number of knobs, are we?
