Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B51210E2
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727269; cv=none; b=bs+NcRyOKobtA484n4oHRCQ98jvbV5d5J4JjdAUM2XQDfJ4cE41I+JyC6Uxo62y63CoZWV6uTfEQJIWcAo5EfV8pgYLMTLRd4NDueEUpneVfkx+auG2D9snd5UCD8zXvI/jfPPypEkkmO/EqQd2JhofTBF5cCwNp5HdiuBHfMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727269; c=relaxed/simple;
	bh=OdcVcSOMkB8kD42TmS6XUg+SVeKsh6Sfj4nRfuz1w4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzGAHb8CPf8acjuIJWF/3Be0jx+ekjFNwSC9Y+kJFbtXWVvPxK50tygeZN2pyRGc4mOPxUC0vOqcTTMolgn08m2AZJm/xmK+HQMhvvTM3gzb3onc+jGBA0ArZfdR9SslcxKX6DBg9o6XeBkESUyIS+HYA7/bZO916Y1aw7G7cH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D8F5sSt6; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D8F5sSt6"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5405532DED;
	Wed, 31 Jan 2024 13:54:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OdcVcSOMkB8kD42TmS6XUg+SVeKsh6Sfj4nRfu
	z1w4M=; b=D8F5sSt6nEORElwy4wEfqcbEAT0kSed90HVtcX+WUA6ZM513DOORe0
	YS3AoPXC/P2B8iERMO4AOJomPy4jyhDhAosajU0OTRhmTfDwPxZT6LN9nGOf5tFZ
	Hd9QQbPWXqhEnY/iyx9qMlg4y+uthDrcDUMBaNtim/jgBxWPWk3UM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C0A832DEC;
	Wed, 31 Jan 2024 13:54:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8254432DEB;
	Wed, 31 Jan 2024 13:54:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 02/10] trailer: move interpret_trailers() to
 interpret-trailers.c
In-Reply-To: <cafa39d10489f90897227a244e012457989a7710.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:16
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<cafa39d10489f90897227a244e012457989a7710.1706664145.git.gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 10:54:21 -0800
Message-ID: <xmqqy1c55o6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 263A8F9A-C06A-11EE-B51B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> The interpret-trailers.c builtin is the only place we need to call
> interpret_trailers(), so move its definition there.

A few helper functions that are only called by interpret_trailers()
are also moved, naturally.  I would have less surprised to see
the addtion near the beginning of builtin/interpret-trailers.c if
this part said:

    ..., so move its definition there, together with a few helper
    functions called only by it, and remove its external declaration
    from <trailer.h>.

> Delete the corresponding declaration from trailer.h, which then forces
> us to expose the working innards of that function.

This was a bit confusing, at least to me.  The reason why several
other helper functions that are called by interpret_trailers() need
to be declared in trailer.h is not because the declaration of
interpret_trailers() is deleted from trailer.h but that is how I
read the above.

    Several helper functions that are called by interpret_trailers()
    remain in trailer.c because other callers in the same file still
    call them, so add declaration for them to <trailer.h>.

> This enriches
> trailer.h with a more granular API, which can then be unit-tested in the
> future (because interpret_trailers() by itself does too many things to
> be able to be easily unit-tested).
>
> Take this opportunity to demote some file-handling functions out of the
> trailer API implementation, as these have nothing to do with trailers.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c |  94 +++++++++++++++++++++++++++
>  trailer.c                    | 120 ++++-------------------------------
>  trailer.h                    |  20 +++++-

Together with the preparatory renaming in the previous step, this
made quite a pleasant read.  Thanks.
