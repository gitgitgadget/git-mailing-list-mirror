Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE892B9B0
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379360; cv=none; b=AbFvDeU70ycoPLOeQKvJTVO3GWYVD4UllJuZr2LFzlAhMRyc/D0S1a2RbsEf31jJ/VZNJQTkwuTizPoKN6u3FIEAnGC897DZfAlmWdeZ/K39R5TWGi/5sYlg+IyLXVxEFDrZYZX/hxgG2JMshe9K+fGhUXGuhvYpsQFJ1QebIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379360; c=relaxed/simple;
	bh=vrbguxCDkvfgI4MpPjTRDfBccr4Ha1ox9mv+NFsfQII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Da9g7rN6j45JTAe860NAtmdeLzME4AE/WGn6pvMxEa5YK+1MiVmSa2Ozdybauo19Tl6QRSwFL94r5wVVVpio+u+G6+yEAEEGZzRzFWHApr/D4vzl3jjz9zo5qAxnfIf1TSCvpeeGAT5+79pB8bFbi537tzjTL7s0V7TGRmbQDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TKkfPwel; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TKkfPwel"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AA70323A5;
	Fri, 14 Jun 2024 11:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vrbguxCDkvfgI4MpPjTRDfBccr4Ha1ox9mv+NF
	sfQII=; b=TKkfPwelQa2BNIaIfaaFutgeIpHe+Er7r7G/OscfMb6Oa19CcbzvuN
	cTXV52VQWREpkfQCQHuRA4V2WrC641L7l8UzF7ZY2VgCDwvQ1D41XwBYVHxUyh6q
	na6sMKzawVTbemEnMclofE60R62J0cAZzrrbvKD1myKturaBrrmlo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3295F323A4;
	Fri, 14 Jun 2024 11:35:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83A43323A3;
	Fri, 14 Jun 2024 11:35:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Non-blob .gitmodules and .gitattributes
In-Reply-To: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com> (Alexey Pelykh's
	message of "Fri, 14 Jun 2024 14:03:05 +0200")
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
Date: Fri, 14 Jun 2024 08:35:56 -0700
Message-ID: <xmqqbk43ilk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB7889D6-2A63-11EF-874D-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Alexey Pelykh <alexey.pelykh@gmail.com> writes:

> I've stumbled upon a check that ensures that .gitmodules and
> .gitattributes must be blobs,

Alexey, thanks for a report.

For those who want to take a look, unfortunately Alexey does not
show any error message or describe the end-user visible effect that
the "check" caused, so there is a bit too little to go on.

> yet while I get why they should not
> be e.g. a symlink, what's the downside of permitting (and ignoring
> for the actual purpose) e.g. .gitattributes folder?

My knee-jerk reaction is that we probably can safely loosen by
ignoring non-blob .gitWHATEVER files, but security-minded folks may
be able to come up with some plausible attack scenarios if we did
so.

Comments from those who have worked on transfer time and runtime
checks on these are highly appreciated.

Having said that, the checks for .gitmodules and .gitattributes in
fsck.c first collect objects that tree entries with these names
point at into oidsets (this all happens in fsck.c:fsck_tree()), but
the actual check for these found objects are done only when they are
blobs.  Only when we encounter a blob object, these oidsets are
looked at in fsck.c:fsck_blob(), and if it is .gitmodules its
contents inspected (and may result in a warning or an error).  So
the "checks" Alexey reports may not be in the runtime or transfer
time checks done in fsck but something else.  I dunno.

Thanks.

