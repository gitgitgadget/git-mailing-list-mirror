Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AE13634A
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618654; cv=none; b=tR7Frxb60/5lLQ+JxzYZuGwY0YyWoFWOkzs3lN/QfMjwVyF+RzCeEJvLTAqNJ2sdC0cKIy68CPO+L9k+TDsdCUcsg58JhwZ4+jQrpYffyJU55tc+neRDaFxMUsISNQq81oFOP9o6ffmvpy9mmQnQxnZ+b1n7r+lbGP0+JjoUF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618654; c=relaxed/simple;
	bh=pUpHvfb4AIJ/r21QtMGUwZKCA/vznKJkcfURkZvxx+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U8P6c6yCY1oCwrfGYjTS18NrTy63Sb+9kpuSzZ5b9jdla7ZfR9a7o6NfE3/aZtn2CuMk7B8Ks/Vg8y978Hts7c+cJ6GArR65m9O1s+JIvGw1TT0U0uB0DVWMhkRk+YzqspY3saXuBYLQRFE8mpzvkHKz98czP9Gj77qpGzO2CsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kKgnAD9t; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kKgnAD9t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D973027475;
	Fri,  2 Aug 2024 13:10:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pUpHvfb4AIJ/r21QtMGUwZKCA/vznKJkcfURkZ
	vxx+Q=; b=kKgnAD9tUH5ZK3BBWRXE4fB1LJ8yu/C3lxzvB5av+Nl6Bocp2RWcnr
	kbeBMATf1fG5Os1cRARYNQSFWgsRPr2n1fqMesse6BYkfdxjwPLEb8VpuiFRVsrV
	iDlK1ttqjsbFh7Uoq2xJG5vYGpZpSi3y37wjhurDBoBS5vFgvd5DE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0A1327474;
	Fri,  2 Aug 2024 13:10:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3298927473;
	Fri,  2 Aug 2024 13:10:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 2 Aug 2024 12:43:07 -0400 (EDT)")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
	<xmqq7ccygbx6.fsf@gitster.g>
	<2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
Date: Fri, 02 Aug 2024 10:10:49 -0700
Message-ID: <xmqqv80idf52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2B674B0C-50F2-11EF-9B09-BAC1940A682E-77302942!pb-smtp2.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> Hmm. I'd be inclined to take the preliminary clean-up approach, but
> some of the existing strings (there are also two "Unsupported
> ..."/"Supported ..." strings near the "Could not set..."s) are going
> through gettext, and I'm reluctant to interfere with the l10n process.

I do not see what you mean by interfering with the localization.

If we are updating text to be translated anyway, giving translators
the strings that need to be translated _earlier_ rather than later
would be more helpful to them, no?

>> If I were writing this, I would shorten to look for a bit fuzzier
>> pattern like
>>
>>    grep "^fatal: .* is required to support paths in proxy URLs" "$1"
>>
>> as that would allow us to fix the code later without needing to
>> update the pattern, if we discover reasons, other than being older
>> than libcURL 7.84, why paths in proxy URLs cannot be supported.
>
> Is this blocking feedback? This strikes me as speculative
> over-engineering

No, it is loosening a pattern that is overly tight and as a side
effect shortening the line to more readable length ;-).
