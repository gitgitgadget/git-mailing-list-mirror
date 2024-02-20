Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B127AE45
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446050; cv=none; b=g4BCQSKK7w16McNCqNdgW9n1LKYRssbCPlg4xc8cglw9DhzCIYu8bBiDN/Qsxz0zOg5js41jL4zlLRe1FmHGYtIed/lwELYRycUnrxjWDNCXwY20kC5r3WANO3v4lZTOciwvylHI2aT7OP5cGgZaBBAO6VgvSjV7wdFTioCDU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446050; c=relaxed/simple;
	bh=5Bbox2WJ+pFROVU/km91nhHygOY7AMWbMfEIP4Pwa94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aw9a3Wvzt+AslghFXXxbYFb58s/f6q1opWfPcZAsuf1a7aRczoDVTyC/ggbtZFCcQKI1+H8JlQgLDG02N8ynCNSfP7pAL0eLK4l6mXUXBy3htoV9w5tV6tGtExniQCGjFEavHChMPS06PwWIVxIVpvWjViTBihkC4AwXAeCOsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcbA8ksT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcbA8ksT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B3612C2CD;
	Tue, 20 Feb 2024 11:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5Bbox2WJ+pFROVU/km91nhHygOY7AMWbMfEIP4
	Pwa94=; b=YcbA8ksTcd++8cGYmBhnGw8QCISIfaVVpOXUi3hqJbUrx0CK/UaDXQ
	/ZaKX2WEZsbw95siKcX2wenqMGg1BhIum2hI3U6C3u3wpYvsP6uzdgg/XLHErs5O
	K6KhUVGFFyJg8EDT05muhOf7GkbNm5vtI12XxJUrp7kbxklCD6BGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 826762C2CC;
	Tue, 20 Feb 2024 11:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 267DE2C2CB;
	Tue, 20 Feb 2024 11:20:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  Jeff King <peff@peff.net>,  Philip Peterson
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Emily Shaffer
 <nasamuffin@google.com>,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
In-Reply-To: <ZdSYxF3Hd6Zqt3Wd@tanuki> (Patrick Steinhardt's message of "Tue,
	20 Feb 2024 13:19:16 +0100")
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
	<bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
	<20240220025722.GE2713741@coredump.intra.peff.net>
	<70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com>
	<ZdSYxF3Hd6Zqt3Wd@tanuki>
Date: Tue, 20 Feb 2024 08:20:42 -0800
Message-ID: <xmqqa5nvumxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FF510E5C-D00B-11EE-BE85-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> While we're already at it throwing ideas around, I also have to wonder
> whether this would be a long-term solution towards computer-friendly
> errors. One of the problems we quite frequently hit in Gitaly is that we
> are forced to parse error messages in order to figure out why exactly
> something has failed. Needless to say, this is quite fragile and also
> feels very wrong.
>
> Now if we had a more structured way to pass errors around this might
> also enable us to convey more meaning to the caller of Git commands. In
> a hypothetical world where all errors were using an explicit error type,
> then this error type could eventually become richer and contain more
> information that is relevant to the calling script. And if such rich
> error information was available, then it would not be that far fetched
> to ask Git to emit errors in a computer-parsable format like for example
> JSON.

I do not know about the "JSON-parseable" part, but a structured
error message, or even just a set of error codes that can be
recorded in an index, might already be a great improvement.
