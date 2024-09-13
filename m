Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A314A85
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244271; cv=none; b=fdZ//S1kNHrwYT/2kLZdVAzhzQaoXvrQN4pfWI8bM2sPoHnFiV/ONmwcGIxJ5ndRmWJ4Dbg1Vqu/ZDpeTWpibjsmjAJv6trZbWNwwVjLbyOYoUf+oLRdDdnXLBTOR+F4WaiX+JuuTj41+YQ5T2PT5tPXxVU2Z7TSVYNrTsKxVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244271; c=relaxed/simple;
	bh=+WI9Z85HfrAfODGmIPjn/xviJxXYdH51pvmGxUdLerc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBX7lULlvDAIvLL+SIGj3raSdEFORpIW6gWbX/2TuH+fGBk3kfwzW418QFvxoy8SEChpvulGYdRg9OxhP2+HIjCdXRIpjCfJ4osl0MA41pNPIYxcIy+koEpru7AOqp9n7fk8ceVjWNhFPjWkf+gPPs0Gx1xSWMkhyOEF5ac8C4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qJ0SQGpq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qJ0SQGpq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 162A82610C;
	Fri, 13 Sep 2024 12:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+WI9Z85HfrAfODGmIPjn/xviJxXYdH51pvmGxU
	dLerc=; b=qJ0SQGpqaOWOlSdTg5xlc3IYMPWs0Ifny2exnmmYeAgctrM8myxgWw
	nSyGNQ5mD2wgMXLiYrfhkq03cKtMbyKzxDWmt/tyPnxLEv+RXgpBxpr4yeBeux60
	NThP8NMCuvKDCMtgcSLRCiXrJkY64LC1xqmlPQSWhFOp4RnC7xZyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DC0B2610B;
	Fri, 13 Sep 2024 12:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76D4A2610A;
	Fri, 13 Sep 2024 12:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
In-Reply-To: <20240913062113.GA1232933@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Sep 2024 02:21:13 -0400")
References: <20240912094238.GA589050@coredump.intra.peff.net>
	<00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
	<20240913062113.GA1232933@coredump.intra.peff.net>
Date: Fri, 13 Sep 2024 09:17:46 -0700
Message-ID: <xmqqseu31qad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B71ACEDE-71EB-11EF-B9CB-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Sep 13, 2024 at 07:52:51AM +0200, Patrick Steinhardt wrote:
>
>> In the preceding commits we had to convert the linux32 job to be based
>> on Ubuntu 20.04 instead of Ubuntu 16.04 due to a limitation in GitHub
>> Workflows. This was the only job left that still tested against this old
>> but supported Ubuntu version, and we have no other jobs that test with a
>> comparatively old Linux distribution.
>> 
>> Add a new job to GitLab CI that tests with Ubuntu 16.04 to cover the
>> resulting test gap. GitLab doesn't modify Docker images in the same way
>> GitHub does and thus doesn't fall prey to the same issue. There are two
>> compatibility issues uncovered by this:
>> 
>>   - Ubuntu 16.04 does not support HTTP/2 in Apache. We thus cannot set
>>     `GIT_TEST_HTTPD=true`, which would otherwise cause us to fail when
>>     Apache fails to start.
>> 
>>   - Ubuntu 16.04 cannot use recent JGit versions as they depend on a
>>     more recent Java runtime than we have available. We thus disable
>>     installing any kind of optional dependencies that do not come from
>>     the package manager.
>
> OK, this looks reasonable to me. I do think we could have our cake and
> eat it too on the Apache support if we added a GIT_TEST_HTTP2 knob. But
> it's probably not all that big a deal in practice, and after another 1.5
> years I think we'd drop this 16.04 job anyway (since it will be out of
> LTS then).
>
> Thanks for putting this together.

Yes, thanks, both.  Queued.
