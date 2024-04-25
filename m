Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791414D6F5
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068120; cv=none; b=EBiiZ2OXlGX4Z/PSxXkr9lCEXWtiSIFwS6/LQYXzygZOy3Gs5yQO1UibjerSDWShhWstJ0Nrn31ce887hy3MjOr2+vJwKe6NfxgUZNWqDOv7+nX7ZjDt9rQniYjAi9Q8pcDUJCL+O81tqbFMmBtA60XRz0LgbGlxJhRBlujRZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068120; c=relaxed/simple;
	bh=JS24GD77jvmYw82JETIz2YHGbfiYqJKeJjtjAJR6FR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RSc4AiDboDt3SDI3owt0lzQUiC1gnL/fTu2RuLARlPxFS0E6uu8P2YX7guubXvvB+04qdT2BhPS6Fu+Zpm6A0lvfThtB23DLfkH3LvS1fl5oEjdUp4MFxYS8LswefgfsxIYc+m5QAkvfk4onmaYjsYK0MxBqvfkI72i88RRGLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U4v5K+Mr; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U4v5K+Mr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C741B240C7;
	Thu, 25 Apr 2024 14:01:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JS24GD77jvmYw82JETIz2YHGbfiYqJKeJjtjAJ
	R6FR8=; b=U4v5K+Mr7lVxvHbBXah90JrCy7AQHGnR0YNq6PwGREM4/WlM4LxjgQ
	GpRVCFw6YwBdScRQAfCHD8v6Z7Hm7RG0Blr4/LiCnX+6ojQAu2IyDQcGt1uihHbe
	LkpadI3vEQ5lTcmKmW179nl0cIOXaOTQllUFKCLJjVsYVV2Qbz2ms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BFE86240C6;
	Thu, 25 Apr 2024 14:01:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06C82240C3;
	Thu, 25 Apr 2024 14:01:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>,  chris.torek@gmail.com,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
In-Reply-To: <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 24 Apr 2024 09:25:27 -0700")
References: <20240412095908.1134387-1-knayak@gitlab.com>
	<20240423212818.574123-1-knayak@gitlab.com>
	<20240423220308.GC1172807@coredump.intra.peff.net>
	<CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
Date: Thu, 25 Apr 2024 11:01:53 -0700
Message-ID: <xmqq4jbpgw32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6AF95E4-032D-11EF-A1E7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> 2. We change the syntax to something like
>
>     symref-update SP <ref> SP <new-ref> [SP (ref <old-target> | oid
> <old-oid>)] LF
>
> this would remove any ambiguity since the user specifies the data type
> they're providing.

Yup.  Being explicit helps, especially if you are only dealing with
programs that do not complain "that's too many keystrokes" like
pesky humans ;-).

When the topic's overall title is to add support for symbolic refs
to the update-ref command, a natural expectation is that in a far
enough future everything that can be done with "git symbolic-ref"
can be done with "git update-ref" and we can, if we wanted to,
depreate "git symbolic-ref".  Is that really what is going on here?

IOW, we should add support for operation modes other than "--stdin"
as well, shouldn't we?

Thanks.

