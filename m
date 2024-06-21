Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6C13D521
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994522; cv=none; b=Obi1wFHKWQBda1evF7/N1/pFsJz7we6CSaVwaYKNqqrczItyyD5ikpih00VIcTkCLP48QfDca5OMfBF92x8YNChuneFbyHlbz+6AaZGRlGkBfWyGgml0/nf6FHuQuZaVb+IBbq+A3+C+kG/o6QF/Oqu+XMn4X1ZYbozWhw/Hz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994522; c=relaxed/simple;
	bh=IhXBe8g5KmfZcEFGVZTsizLJKdsFGNwxRXrpM2vm2f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ohyfUARC0UF7EcwySdDl+T8Vj7e2KsPpPRGdEVDrpdNgiNg9lQaEjte6oDIw4GvrLtzuFmVctpM3qhlxWq0Hz1lOHah4LRfnQH6anuC3FRWxWhz3mkKSFSIVjOuJ1GbCIvPF4N1fpuxpISJ7MmciEVXnLoksD1n6Hmu4bdMUu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8GhFCTa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8GhFCTa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DB3F26218;
	Fri, 21 Jun 2024 14:28:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IhXBe8g5KmfZcEFGVZTsizLJKdsFGNwxRXrpM2
	vm2f4=; b=Y8GhFCTaasIQl6FrsiWMn7akeobKgOskyrbSOrYayEH3F/jq/417tn
	n4bXtsENm9HJJA2aPObCJhAn4wZCG+8g6uIigRgT9dFz3pv9eRcFUpuNgoe3Ki+q
	llTvUpiO0vXSHTSc7mXkPIdCpiFuIobx8CJL2dYAeAVQBi0Iq+k0E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6559726217;
	Fri, 21 Jun 2024 14:28:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF13326216;
	Fri, 21 Jun 2024 14:28:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <xmqqmsnekvir.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	21 Jun 2024 11:20:28 -0700")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
Date: Fri, 21 Jun 2024 11:28:38 -0700
Message-ID: <xmqqiky2kv55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14C725C8-2FFC-11EF-B159-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "the zlib supplied ZLIB_VERSION #define supplied text macro" is
> quite a mouthful.  Something like
>
>     version: --build-options reports zlib and libcurl version information
>
>     Use ZLIB_VERSION and LIBCURL_VERSION to show them, if defined, in
>     "git version --build-options" output.
>
> should be sufficient.

Nah, that is still more verbose than necessary.  Just saying

	Show ZLIB_VERSION and LIBCURL_VERSION, if defined, in ...

is sufficient.
