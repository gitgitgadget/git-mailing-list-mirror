Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A55FF19
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845735; cv=none; b=SGtiKs9+hZlQrIQPViN18cwCX3srp7m8om/NdvMewoTMWKi1sxqxtNQU6oxyo08JR8rWcEzJ0+JNpubPA/G0CmaqWD9vO0yvmpf5D2nlULAdkQcmsLPuYMffxKiD+ycKeXVME3//oBidrs7D5OIeJmuKdWrpZ4lS37aTxAlFBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845735; c=relaxed/simple;
	bh=KZz+/gC1Pf9lL5mLPW85cslP3qOSha0bSDMw+dAouoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFTLRXKrWHY1NCX8u6nI6+Kg/kYNHt+XVGjErbnAfl5tLLlq83SHgGaWxafpc9oP5ZZ3DNMmYjP3he+0WzbgKBoQXiI5oMiroSTuQhDBRGL3RK84IyYLtX0V5v8z9Cj/zhchNP0zrP2AhgnxzrX3pHDt9bqdI/ZWiIX6MWMf3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H29Vlm2X; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H29Vlm2X"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A46D234ECB;
	Tue, 13 Feb 2024 12:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KZz+/gC1Pf9lL5mLPW85cslP3qOSha0bSDMw+d
	AouoA=; b=H29Vlm2XjvO2SmCXijzti2qlUh9MNR8jTZCFWoFltbpN6FJ8FoXn+l
	jbBmHQGZ0V47rZZl52AOigriO1J6wdg+DaBXsjZQFFZYhuavD2mHxAHLgnQddIBK
	ABo+beZXpHIJxyUNVtvDcpn7St/hCAhQo+ssB6qch6O4EftmuUTjM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C96334ECA;
	Tue, 13 Feb 2024 12:35:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3683734EC8;
	Tue, 13 Feb 2024 12:35:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Maarten Bosmans <mkbosmans@gmail.com>,  git@vger.kernel.org,  Teng Long
 <dyroneteng@gmail.com>,  Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
In-Reply-To: <20240213080014.GB2225494@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Feb 2024 03:00:14 -0500")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240205204932.16653-2-maarten.bosmans@vortech.nl>
	<xmqqil32l0i6.fsf@gitster.g>
	<CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
	<xmqqy1bxiiop.fsf@gitster.g>
	<20240213080014.GB2225494@coredump.intra.peff.net>
Date: Tue, 13 Feb 2024 09:35:28 -0800
Message-ID: <xmqq5xys6zdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48532278-CA96-11EE-8FAC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Feb 06, 2024 at 09:52:38AM -0800, Junio C Hamano wrote:
>
>> > That is also a cool idea. That would probably use the functionality of
>> > the cat-file batch mode, right?
>> 
>> Not really.  I was hoping that "git show" that can take multiple
>> objects from its command line would directly be used, or with a new
>> option that gives a separator between these objects.
>
> How about:
>
>   cat some_commit_ids |
>   git show --stdin -s -z --format='%H%n%N'

Yeah, that is more in line with what I was hoping to see, instead of
invoking "git show %s" for a note object one by one.

Thanks.

Remind me if you can if we (1) had plans to allow non-blob objects
as notes, or (2) actively support to have non-text blob objects as
notes.  I _think_ we do assume people may try to add non-text blob
as notes (while they accept that they cannot merge two such notes on
the same object), but I do not recall if we planned to allow them to
store trees and commits.
