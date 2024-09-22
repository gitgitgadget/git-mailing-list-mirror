Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12326E56E
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024154; cv=none; b=EusQk3WJzqVuTMjN4OP3pII4aShDK+mhqBakZ4H0fXTSuX/tC5nFb3Zv6d2XL18qXMJaTsHR3Xub0sj7PUx6ISUSUvB8plNfeadKpyTTQA/xH+DoQu5eTlYRN8rLM7yIDFZl5sRboESXO4FNV7eTQLIL5Q2cv3nlz7dRPaweAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024154; c=relaxed/simple;
	bh=3HxXmObJXK7pHrwv1esbIJlwAZjoRtv8GgKEnKYousY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UfEjUIBIJt2mLZeXq8WfgtfmmT3Rkrp7F74xrjlvq/mHjOQQ6vlATBpsEpNEqgeQQEUYXbFkLZqv02DNoPDIY1o86Y9F3U1P8QLN6bOeNleOB3HwBLo5OCG/lnN6mVHanmInWWrcks/f1jN8GhKL4VrM8tkC12c405773xPNXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZv1/4X0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZv1/4X0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F903D3BD;
	Sun, 22 Sep 2024 12:55:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3HxXmObJXK7pHrwv1esbIJlwAZjoRtv8GgKEnK
	YousY=; b=TZv1/4X0wUIgAuc4gCbB5KOKrXl+8S6r0x5lI9PF3Yxc+QEiMPhzhF
	ipKFrytj6+balRxSpOhNnF712jYBHz4XcGZcF8yg9Lw8P62ZZTtfa55acRSRHMQl
	BpyihHYzodundgXwRai/gTQeor7FvF6OQIH9ZrPOTabH2YCSfkIE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C22113D3BC;
	Sun, 22 Sep 2024 12:55:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B1233D3BB;
	Sun, 22 Sep 2024 12:55:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/5] ref: add symref content check for files backend
In-Reply-To: <ZvA9agbGaGnF6nxW@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 22 Sep 2024 23:53:14 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRzzwZds8ys-JEN@ArchLinux>
	<xmqqldzobtq6.fsf@gitster.g> <ZvA9agbGaGnF6nxW@ArchLinux>
Date: Sun, 22 Sep 2024 09:55:40 -0700
Message-ID: <xmqq5xqn8w6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80AEB0E4-7903-11EF-A231-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

>> > +`escapeReferent`::
>> > +	(ERROR) The referent of a symref is outside the "ref" directory.
>> 
>> I am not sure starting this as ERROR is wise.  Users and third-party
>> tools make creative uses of the system and I cannot offhand think of
>> an argument why it should be forbidden to create a symbolic link to
>> our own HEAD or to some worktree-specific ref in another worktree.
>> 
> Do we allow this cross-access (hack)? It might cause some trouble from
> my perspective.

If the current implementation allows users to set up and take
advantage of, then it is not a hack.  It would cause breakage
if we make it an error.  Does such a symref successfully refer
to the referent right now?  I think it does.

Thanks.
