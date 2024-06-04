Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B584A5F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526218; cv=none; b=ssUuQdSETcKAU+VHOgn4Ft7yUmgWRWMrX6/+qrPIv2hbpM/J5OWzzY1f/3cD65cixRjwbwiKoECTzZnIl7zsPPyQTnyMxh+piRqJE0k+hnoi4f/ykUrX0lwLz+tPIvCzYT7JQE/qT2Y6pMmc7dsz0J+FZhRAAu7RpC5mOBzHf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526218; c=relaxed/simple;
	bh=GEmNa/Q4T5ItIdruaxmQmDGckyBo95r1WVVZGiRmGSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CwQeEF6DXgqgTMCLXhwXR736rgDLO/L6L1KVRnF8m8egyhsXqhMz86VO6ZcU9iWFmZ+cDw+Gb/2cHqqN2AT1gUiW9S7Qhf2g1C4WpLasUAgfceT7Xc7CAvedulBtMLRfKMkwhnfUsh4sr2N6xMR4d/P8AU2J1sWZYVIMRjipkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X3R8NLFt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3R8NLFt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 991DF32B47;
	Tue,  4 Jun 2024 14:36:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GEmNa/Q4T5ItIdruaxmQmDGckyBo95r1WVVZGi
	RmGSw=; b=X3R8NLFt+F5urphjZHnLnbHeZ+cH73EgfnSbiFW61e+NpCNxgBvX7A
	6r62T1lW78rVhOyAXf6Kg+CZTqIHhwpoFnIoskRI+lfMwgMPabvxCXhfRHNlpBu6
	n6y0651L8DjINs0PYpQRyL/XE7QCXcRgX1TnAhsE6e4ePR5PQlfek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9050D32B46;
	Tue,  4 Jun 2024 14:36:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1A7432B45;
	Tue,  4 Jun 2024 14:36:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
In-Reply-To: <20240604085200.GA1147131@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2024 04:52:00 -0400")
References: <xmqqo78h1bdg.fsf@gitster.g>
	<20240604085200.GA1147131@coredump.intra.peff.net>
Date: Tue, 04 Jun 2024 11:36:52 -0700
Message-ID: <xmqqzfs0tv0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A215D3A-22A1-11EF-B0EE-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Weirdly, with ps/no-writable-strings merged (but without the fix
> above applied yet), SANITIZE=leak does not seem to find the leak
> anymore! Even though I can confirm in a debugger or by printing the
> strbuf's fields that it is still there. So that's...odd.

Yeah, that is what had me puzzled ;-)

> 	 	if (all_msgs.len == 0) {
> 	 		fprintf(stderr, "nothing to send\n");
> 	+		strbuf_release(&all_msgs);
> 	 		return 1;
> 	 	}
> 	 
> 	 	total = count_messages(&all_msgs);
> 	 	if (!total) {
> 	 		fprintf(stderr, "no messages to send\n");
> 	 		return 1;
> 	 	}
>
> But I wonder if strbuf_read() should handle the allocation itself when
> it does a 0-byte read. We already do so for an error return (so the
> "could not read from stdin" path above is actually OK).

Thanks.
