Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11284594B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173312; cv=none; b=CDYE+LUaPDuS3fsvZFAM6yJKaf/8Qeylytj8FBFUEggM8M1I/1+Z8NymaBHlbEvTbGQnH+QXwguIzTxSSDr5XaKkGkyuWz0sUtudY+0CwxH8wOjv7D4Bv3ldfIx2lJ8nT/vNuFO7T1BzKaX/9/twH4oU2fZWf+EwNlwf1jK8UXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173312; c=relaxed/simple;
	bh=ljzM51QxGiL3N4J3i4tIWF4Kd37gO03c+JAIvYQ6pRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lm/OoFAN/IffmlXp+bpyi3ft66FFormP2EQJ7dmKyuEGsWRZ2EsfqSIk+fIprhl7sc4dMWBJIxMH0FgO1OAFqEihmaEHFgA3N71QlRDxHLFfWxhCtH8MJUBSxn6JLGEdixVL6YrO6oFqRzg/zN/VBNvU7gqEPOZWPFYnTXrdRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nAq6ai8f; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nAq6ai8f"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8394F2C8F6;
	Mon, 11 Mar 2024 12:08:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ljzM51QxGiL3N4J3i4tIWF4Kd37gO03c+JAIvY
	Q6pRc=; b=nAq6ai8ff8vtP4hUMp6sJPMunueKi/5Z5PUv11tzKoSv3J/8AfUqQt
	/4nresi5w40ZivgLuAb7rdgnq+PoIB0iaHrRRjd8Sl/VGayrzPhnKYJ+tEwowd5O
	oX+erCByYCvh4s1EwdpzOi2ukkkzKgpUr6nCh4W4Qej5Eb9hOwytI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AD852C8F5;
	Mon, 11 Mar 2024 12:08:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 232372C8F4;
	Mon, 11 Mar 2024 12:08:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Gupta <garyan447@gmail.com>,
    Vicent Marti <tanoku@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH 0/1] add zero count optimization in ewah_bitmap.c
In-Reply-To: <20240310162614.62691-1-garyan447@gmail.com> (Aryan Gupta's
	message of "Sun, 10 Mar 2024 17:26:13 +0100")
References: <20240310162614.62691-1-garyan447@gmail.com>
Date: Mon, 11 Mar 2024 09:08:19 -0700
Message-ID: <xmqqedcgvjik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94B42C9E-DFC1-11EE-8CFB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Aryan Gupta <garyan447@gmail.com> writes:

> Hey everyone
>
> I hope you are doing great. I came across a "todo" in the code base 
> which was based on zero count optimization. I tried to fix do it but
> I am not sure if this was the required this or not.

Do you mean that you are not sure if the improvement you made is
what Vicent Marti meant by "zero count optimization" when e1273106
(ewah: compressed bitmap implementation, 2013-11-14) was written?

Unfortunatelly, "what is "zero count optimization" in computer
programming?" does not produce great hits, and you are probably
better off to ask who wrote that comment (Cc'ed).

A few general pieces of advice:

 * We usually don't do a cover letter for a single patch (instead we
   write extra explanation after the three-dash line).

 * An optimization patch usually is expected to come with
   performance measurement, just like a bugfix patch is expected to
   come with tests that show existing breakages that change the
   behaviour for the better with the fix.

 * Pay attention to coding style, as deviating from existing style
   distracts reviewers and causes them to miss obvious bugs.

Thanks.
