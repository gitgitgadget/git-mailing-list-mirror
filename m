Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38701E502
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550802; cv=none; b=YZZ99WRqA7j5dfCgyaUIvCdgdejJT10rqJDszpkGHJB6XOOehjoHxza0dldXwzKcj+5vUbOEagcwkYCXLjctOUAxz+uplonP7PUjxjZpMuT9lP1HdpRaEtibDhKa8JZl/24j+Dup0mtVVnBYcz20JDdRPVlK2tv4TeEQG9ZG/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550802; c=relaxed/simple;
	bh=4fKVIdz6xzwDbKlfLKB5Llsy8BbQ5hvA7y22Qx/yFIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bagz3RkDcY5hdqu2q9gcFymUYq9K9EbNdsSfKYpHWW2p9eFiyFzCuhnbowB43WwRGGh8PYPTQURFa5jRmvomWVulxpl/QbNkcj6vHP801aRKA42mXE9+V0CsWxDyI//TNHW8F7nCY/lT0Ete8oRBpFR8WiluqWC8tBjKmoqCrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RGzFZxrA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RGzFZxrA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F817332F3;
	Fri, 19 Apr 2024 14:20:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4fKVIdz6xzwDbKlfLKB5Llsy8BbQ5hvA7y22Qx
	/yFIA=; b=RGzFZxrAdW4gg+G5igMEOIyFcn9QTLe7ie8cwAq86/VKb280KL0QKc
	g4pRXTTTwPyIuW8GmAQslfGlw5DoVn5hncicMWrlHEjAqXU72cSUZaGOVCuYaNDA
	FNredkWe668A+JFTQtcibTiLs7cho8qQ4Z6zDILFcvnf4ceSvtCsM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7766A332F2;
	Fri, 19 Apr 2024 14:20:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1793332F1;
	Fri, 19 Apr 2024 14:19:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
In-Reply-To: <20240419180012.GA523357@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Apr 2024 14:00:12 -0400")
References: <xmqqzftqnuxq.fsf@gitster.g>
	<20240419180012.GA523357@coredump.intra.peff.net>
Date: Fri, 19 Apr 2024 11:19:55 -0700
Message-ID: <xmqq1q71jjuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D1AA998-FE79-11EE-8CB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Apr 18, 2024 at 03:54:25PM -0700, Junio C Hamano wrote:
>
>> ---rfc::
>> -	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
>> -	default). RFC means "Request For Comments"; use this when sending
>> -	an experimental patch for discussion rather than application.
>> +--rfc[=<rfc>]::
>> +	Prepends the string _<rfc>_ (defaults to "RFC") to
>> +	the subject prefix.  As the subject prefix defaults to
>> +	"PATCH", you'll get "RFC PATCH" by default.
>> ++
>> +RFC means "Request For Comments"; use this when sending
>> +an experimental patch for discussion rather than application.
>> +"--rfc=WIP" may also be a useful way to indicate that a patch
>> +is not complete yet.
>
> It's probably worth spelling out WIP here, too, like:
>
>   ...is not complete yet ("WIP" stands for "Work In Progress").
>
> These are necessarily going to be project-specific phrases, and readers
> of the manpage may not be familiar with our conventions.

Good point.  Will squash in.

