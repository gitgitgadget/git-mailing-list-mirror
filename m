Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2D73186
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434028; cv=none; b=SYyRN4R+FzSeopH0oWaZ2Ueyh9C0BmT563aGjo7KUHz4lm2wYxMK7cPltiJAmip/tqBYuebbJOodbGE0i9ky7g4oBd3YqqyRLibqzA3cSzvUwOF8B8mO5UKvd3K+GyAcmcHf8vxOiftmYXTdGG5qY6yrCUzeXyizcL1hqmlIPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434028; c=relaxed/simple;
	bh=wRbjPjCyqmPC9JyvG8jgpnHnqdTLccEeRXH54PI2ZMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tezqr0ufbe4u3Eyve4pR1NIG1vU41qvuBg7TAECT6NsotnLnBUPiNpEz1O7sf6LB9dhbz79XDBjseUbthokV2RcGwGPtxV7Aww74ssog6gIgeLHPWmwkzVNPT73wfPyMDXADNs1cuHJYVjFNIOhB3YArVEoMIptH7n0CNW7EKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZiVPy/4K; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZiVPy/4K"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EA711DF198;
	Thu, 14 Mar 2024 12:33:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wRbjPjCyqmPC9JyvG8jgpnHnqdTLccEeRXH54P
	I2ZMc=; b=ZiVPy/4KCWcz+rNs1NKTWyFK2Y/NJVMdDkJXPb0gTvxZH59RTZwHMT
	EjXkpk38JLY64PEiEb4uwDml/9TnNkqLBVpxV7pLRcseqWVV6zcSZXpwSPS2b2kn
	4i/WVdUa4vGAiYUxdtyzenjo4RRntb0zM1UKfDG+yZpZJ2XvUM8cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 035591DF197;
	Thu, 14 Mar 2024 12:33:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D9881DF192;
	Thu, 14 Mar 2024 12:33:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  barroit <barroit@linux.com>,
    Emily Shaffer  <nasamuffin@google.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/2] bugreport.c: fix a crash in git bugreport with
 --no-suffix option
In-Reply-To: <xmqqbk7gye0s.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	14 Mar 2024 09:27:47 -0700")
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
	<pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
	<xmqqbk7gye0s.fsf@gitster.g>
Date: Thu, 14 Mar 2024 09:33:40 -0700
Message-ID: <xmqq4jd8ydqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E13DAE4-E220-11EE-AD25-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "barroit via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> executing git bugreport --no-suffix led to a segmentation fault due to
>> strbuf_addftime() being called with a NULL option_suffix variable. This
>> occurs because negating the "--[no-]suffix" option causes the parser to set
>> option_suffix to NULL, which is not handled prior to calling
>> strbuf_addftime().
>>
>> Jiamu Sun (2):
>>   bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option
>>   doc: update doc file and usage for git-bugreport
>
> Squash them together into a single patch.  As you didn't have any
> meaningful log message in [2/2], unless there are other things that
> need to be updated and v3 is needed, I can squash them into one
> commit, though.
>
> Thanks for updating.

I forgot the two I CC'ed the review thread for the previous round to
ping them, so here it is.

Thanks.
