Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EE10FF
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953391; cv=none; b=Q6iBtXcDN3uWpdQD4YV4UC/KHAv/xrsGmKi9kn6tlVuHIyrHCQXC+rnL+Ro6MpnecSHp6JpP630lDh9iV/x6VwoXpj3RmTXmtUylYDOB7WKe1Z4Zbi1Whdj8aPtl9vv8DS08VREKIbZUmW/DhVvZ7s2v+DoxrH/HgiXXC9ERz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953391; c=relaxed/simple;
	bh=FlnuJ6XT9eZhDdacNxCUUQUpr120aB7I/pf4CGaW53Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0V+QwFGNTSABSweYycm1NkoGxNdXKeqamKBIdGYfI5boRk+kjrM35R6zccL8wy5RmUJ9cggFNBZtYUPO7eRPu819PDDVyDcXim6Nx0TtGA3gL/7deLCJDwTfKSuiguhhpJ8z71nQGH4408gjiRv6pJB3Nj65ekzOASytNL8MtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uOgu1cwu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uOgu1cwu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 491B930A66;
	Wed, 20 Mar 2024 12:49:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FlnuJ6XT9eZhDdacNxCUUQUpr120aB7I/pf4CG
	aW53Q=; b=uOgu1cwumx25ckKjbYtQPwzYHXeyWG4hH7OmHzu1+OUrre+bqMX5Ab
	cB0xEnOd2W0TIDHRpt0eMiyIQ5IRVcMUsyOoMdcqLX65ukafng/VFNkSASS6moSm
	8J8fYJUfOLpNyLWs9iFByQjZe1WzB3+Nhc07xtfSEeq/wFOjFFhjk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 40BA630A65;
	Wed, 20 Mar 2024 12:49:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C733D30A64;
	Wed, 20 Mar 2024 12:49:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Ignacio Encinas <ignacio@iencinas.com>,  git@vger.kernel.org,  Taylor
 Blau <me@ttaylorr.com>,  rsbecker@nexbridge.com,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
In-Reply-To: <CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
	(Chris Torek's message of "Wed, 20 Mar 2024 07:34:48 -0700")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
	<xmqqa5mulycz.fsf@gitster.g>
	<CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
	<20240320001934.GA903718@coredump.intra.peff.net>
	<CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
	<CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com>
	<CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
Date: Wed, 20 Mar 2024 09:49:44 -0700
Message-ID: <xmqqfrwkhmqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB6750C0-E6D9-11EE-A34E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> The suggestion for having `git var` list GIT_HOSTNAME gave me
> an idea: perhaps instead of, or in addition to, a `hostname`
> condition in the `includeif` code, we could:
>
>  * have an `includeif:env:...` condition that tests an env
>    variable against a pattern; and/or
>  * use $GIT_HOSTNAME as the variable.

Nice.

> We'd then set `GIT_HOSTNAME` to the gethostname() result *unless*
> it's already set.
>
> This gives users much more flexibility, because:
>
>  * they can use the hostname and/or arbitrary-env-var condition;
>  * they can then *set* GIT_HOSTNAME to the short or full
>    hostname at their discretion if the default is not suitable
>    for some reason; and of course
>  * they can, as noted, use `git var` to find the default setting.
>
> Chris
