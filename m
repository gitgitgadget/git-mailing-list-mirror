Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F141171E
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673887; cv=none; b=PblTUeyGdmH7ATtS2kTe9e+LMCcVzwXA7U2Ou9OabL6XvCX5AzgE9N4O1YxrKZOLPKAsqUMwpSatEYPXVpU6IqeC4bh8Mz5E1VIf58ycht4/K8T5+yspFLoo6nodYoXmXHjo63LhnWQA3AzdK+yrJ2r9PNC4ZwvQx+dbO9659js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673887; c=relaxed/simple;
	bh=wGRKkFxyzm27pBpcy5B0D3EQUQj21rVxs2ieaeDEvQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t52lLy/715JGL4TaISz9H3JuxPMyY02dmx2jHADaDfl8WX1bzwR2AOTlfTCmPH0kLQfJbHMzKC6Zw31nMoo3DWkQN2tnaRg7w4uZItL9P5b8e4EYA7PuvlnDyRbUTyMBDjLxB0CIzzHdpCaeFcdfc76GS+FTclA8dBOIzYlrIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f7D/pj2O; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f7D/pj2O"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BF221F20C;
	Fri, 23 Feb 2024 02:38:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wGRKkFxyzm27pBpcy5B0D3EQUQj21rVxs2ieae
	DEvQs=; b=f7D/pj2OAdRs2w5vY2QXWRz+veVlWp2YiAxg6stA/bocsXZkZ9v7B2
	NDTo4K8Qe4nDPFViivG0t1MIE0zH4TxIJd2g4MoFjAp1rmkzBe5fCqyNS25HzFiR
	QIueAjaaDrkGvOQq7xyWLV0caa+YD6+pOmvNjQjWili6DbgygzzV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 066771F209;
	Fri, 23 Feb 2024 02:38:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CFC11F204;
	Fri, 23 Feb 2024 02:37:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v2 0/2] This PR enables a successful git build on z/OS.
In-Reply-To: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com> (Haritha
	via GitGitGadget's message of "Fri, 23 Feb 2024 03:48:29 +0000")
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
	<pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 23:37:58 -0800
Message-ID: <xmqqsf1j1vhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78171ACA-D21E-11EE-872E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since the z/OS linker does not support searching dynamic libraries, and the
> current setting of CC_LD_DYNPATH results in a directory to be supplied to
> the link step with no option as the suffix, it causes a linker error because
> the z/OS LD linker does not accept directories as input. Therefore, we
> workaround this by adding the -L option.

Hmph, do we still need that CC_LD_DYNPATH hack, with 07bbe4ca (Merge
branch 'jc/make-libpath-template', 2024-02-06) already in 'master'?

> And, Introduced z/OS (OS/390) as a
> platform in config.mak.uname

	Add support for z/OS (OS/390) in config.mak.uname.

or something (cf. Documentation/SubmittingPatches)?

> Thanks for taking the time to contribute to Git! Please be advised that the
> Git community does not use github.com for their contributions. Instead, we
> use a mailing list (git@vger.kernel.org) for code submissions, code reviews,
> and bug reports. Nevertheless, you can use GitGitGadget
> (https://gitgitgadget.github.io/) to conveniently send your Pull Requests
> commits to our mailing list.
>
> Please read the "guidelines for contributing" linked above!

For whom is the above message addressed?  Who is expected to read
that guidelines?
