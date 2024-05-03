Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC08339A1
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764941; cv=none; b=kQrKdH1PkvEiFOXpVeiexHJH2IOd4ZrxSkx6tsCFLY70gq0vMxWXMbkhr7egpiiAOJcWfnAwP4YTLLii9Ev2sIL6J//ZFVy2/y8k9QJw4pno+swkw3xsd4F9NY7dI8+wg0qbD5nMpBv0H7PwmxpNdwwOo6lGHyM2XSVXWMO2Vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764941; c=relaxed/simple;
	bh=yU3tUQOk9q91gYcKeD1FAoVyoo0TsUvMjXEUefd0NUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eit/SlCmQDnXtNDtB6dXC2ZeiDFPKfVO5isFsRX1yE7QlSi1DAHSOod+o5dIdVXJD2wpjZpo8iM0Ma8tV799/f0P3c/Ysh+ZCsFFjWElbhEsTgiYcjuNs/VvGD3O9pg/cL8LjwKD8enLgNK6O4kb9YvSmUCCwycFTLNSncDg5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pFpUSvYe; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFpUSvYe"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D1A2275E8;
	Fri,  3 May 2024 15:35:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yU3tUQOk9q91gYcKeD1FAoVyoo0TsUvMjXEUef
	d0NUQ=; b=pFpUSvYejeJbxzc61AjJdEYrkQA7w64Hc1I7k7Bu5GsIZLoky/5xc+
	9oUGyRrYnLJgAcCF4gr6d9LNQHkrlxp3MdfJok5l0mZlUP3kUzDU/GbAg6ef81mJ
	RB8d7pjkLPfXseuv9XJpDGd8c2/DW7g3g1E9KvpPcGdTE2zusCZOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 655A4275E7;
	Fri,  3 May 2024 15:35:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D47E2275E6;
	Fri,  3 May 2024 15:35:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <ZjUzyNnBW1BAtEc/@nand.local> (Taylor Blau's message of "Fri, 3
	May 2024 14:58:16 -0400")
References: <cover.1714717057.git.ps@pks.im> <xmqqikzu95cf.fsf@gitster.g>
	<20240503173553.GC3631237@coredump.intra.peff.net>
	<ZjUzyNnBW1BAtEc/@nand.local>
Date: Fri, 03 May 2024 12:35:37 -0700
Message-ID: <xmqqttje6646.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 520FF688-0984-11EF-B94B-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> But TBH I think this is probably overkill and anybody who encounters an
> issue like this likely does not need the extra hand.

As long as the replacement is clearly obvious.  Is it always the
rule that "when the function F you tried to call is missing, just
prefix F with refs_ and add the first parameter that is a ref_store,
i.e., refs_f(get_main_ref_store(the_repository), ...)"?  Even if
that were the case, some in-header comment would help the affected
topic owners than having nothing at all.

