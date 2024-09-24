Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F251ABEA8
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193965; cv=none; b=Gdkk0bk0RIGUPTe4tmFlDSjDspTKp48UI7b7PFTbZ/5TqBY15LLqThJ71bWy1cstGOxpAU/0d56xUaRrGNPRU4cwV6iTmkctUOVWhfyf5HXatyeTFzGl76DPVFgIfiI4dI2CidKW84+irNrs0cEnobeYD9wWWIWlQfTZimCdkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193965; c=relaxed/simple;
	bh=Vs7mSIKCma409vEgPtrXxf1/GC8xtVN13g5Uz7EhSJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZeDixIiSCJZCCOU57KoPNrVaNrack5eCCiBgT7lK9W+dHbGbOnqrhh0HwR+OizREivyfQn8Pksq2Khb7FtqhipaDOq8hI5KC98M5D9rwO3sKqDxYct92ge+Aw6mG0nArQzGSj/bfEbk1BAcNpXPe76UiPb/qHsesk1Elg51GEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j6OSX+RL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6OSX+RL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79DE7194EF;
	Tue, 24 Sep 2024 12:05:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Vs7mSIKCma409vEgPtrXxf1/GC8xtVN13g5Uz7
	EhSJw=; b=j6OSX+RLZLX5TpETtlfAsPVtsZ9kuYwbPeZHx0YJyD4mfSduh0iTuA
	L1UyyK/B8GB2D9xh8QVBeb4M33P85ML91FHvWP56tWm971MOgeDOomWgpNV6+jqD
	h0kz0QZ619YRDYLX0jxZKzfW2ifXReaoR7hmnehznkv+p+ky84xf0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6895C194EE;
	Tue, 24 Sep 2024 12:05:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6C27194ED;
	Tue, 24 Sep 2024 12:05:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ronan Pigott <ronan@rjp.ie>,  shejialuo
 <shejialuo@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] t1305: exercise edge cases of "onbranch" includes
In-Reply-To: <615df98339e9451bc237decea087716ca15d157d.1727171197.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 24 Sep 2024 12:05:42 +0200")
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
	<cover.1727171197.git.ps@pks.im>
	<615df98339e9451bc237decea087716ca15d157d.1727171197.git.ps@pks.im>
Date: Tue, 24 Sep 2024 09:05:56 -0700
Message-ID: <xmqqed59vxy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E2934716-7A8E-11EF-9E47-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'onbranch without repository' '
> +	test_when_finished "rm -f .gitconfig config.inc" &&
> +	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
> +	git config set -f config.inc foo.bar baz &&

This assumes that the $(pwd) is the $HOME; so .gitconfig is the
per-user configuration that ought to apply everywhere; since
includeIf.<condition>.path that is relative is relative to the
including file, config.inc would be in cluded when the condition
holds in $HOME/.gitconfig.  OK.

> +	git config get foo.bar &&

This assumes that the $(pwd) that is $HOME is a valid repository,
and checks if includeIf.onbranch works from within a repository.
OK.

> +	test_must_fail nongit git config get foo.bar
> +'

> +test_expect_failure 'onbranch without repository but explicit nonexistent Git directory' '
> +	test_when_finished "rm -f .gitconfig config.inc" &&
> +	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
> +	git config set -f config.inc foo.bar baz &&

The same set-up.

> +	git config get foo.bar &&
> +	test_must_fail nongit git --git-dir=nonexistent config get foo.bar

It has to work when $(pwd) is outside a repository, but is "nongit"
strictly necessary?  IOW, even when we _could_ discover the top
level of a git-controlled working tree, wouldn't presence of --git-dir
that points at elsewhere make $(pwd) and the repository there irrelevant
to the operation?

I am not suggesting to just drop "nongit" from this test.  I am
wondering if this is better split into two tests, with and without
"nongit" to test different situations.

> +'
> +
>  test_done

Other than that, looks like good additions to the test coverage.

Thanks.
