Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CF19CC19
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070388; cv=none; b=XtUsP5aNvzNO7hI1MiGB2MbP+LiMb32lzVhwYpZ4lBVrWL518WsotXiWm8AMwWMIDDwxVMK8Uv6q27y3V0Y95RCB7q5snoAq9FkElPDmRBiJNfHiM0kH75iLaLHN6Pc5tq3qW7QNDReUwOolTH77GbQPglTaVCYeY3pllw0ecqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070388; c=relaxed/simple;
	bh=AssQAyV5RmlO8QAkUEYrUq9GR/ty4pVZ0S7YoRWeRGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecil/0VAqGnLBipQw0qxJMzDVvKB6i4izwtr7Fa6eoyp8zJFdFXWPqeGmVvs+BJxLwtrFOuX/N0uFlfAyl6WkR5dqbGcwlQaLOUo6zsS2q+3nn62HU1Yygk67+g2KJoEwP30Hi+DYYKJZZjByG7gtK4qeI0Wag+JL8DOdAj7UkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DdemKfWG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DdemKfWG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7896120D45;
	Wed, 11 Sep 2024 11:59:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AssQAyV5RmlO8QAkUEYrUq9GR/ty4pVZ0S7YoR
	WeRGI=; b=DdemKfWGyCtyUK06x2mcZuIU1IQH1cl5V/cVslRpXYjS2wcxOtgqkr
	pX1rN89IOgUzIvGgQcgiHj1E5nPjSsF11ub3wrfIotkmk3I0pBFm3d724U/0eapB
	otWIqMfn1kJdMG3X4lrKhc+MamQgBIiGt4pP9Eo85HYGCiio+zSgc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EE6520D44;
	Wed, 11 Sep 2024 11:59:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7DC220D43;
	Wed, 11 Sep 2024 11:59:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 0/2] set remote/HEAD with fetch
In-Reply-To: <D43GB8KUM7RF.3Q4SYKM4JCQ5L@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 11 Sep 2024 14:24:42 +0200")
References: <20240910203835.2288291-1-bence@ferdinandy.com>
	<xmqqldzzcfcv.fsf@gitster.g>
	<D43GB8KUM7RF.3Q4SYKM4JCQ5L@ferdinandy.com>
Date: Wed, 11 Sep 2024 08:59:43 -0700
Message-ID: <xmqqmske9o5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCFF7974-7056-11EF-B14C-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Wed Sep 11, 2024 at 00:29, Junio C Hamano <gitster@pobox.com> wrote:
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>> > What is missing for sure is:
>> > - documentation
>> > - tests (if needed)
>>
>> What change does not need tests?
>
> Fair enough, for the next iteration I'll look into tests as well!

In this project, tests are written not because we want to
demonstrate the shiny new feature we just invented.  We write tests
so that the invention we are shipping to our end users will keep
behaveing in the way we originall intended without getting broken by
future careless developers.  The tests serve as watching eyes while
the original author of the feature is not watching ;-) 

And that is why we also write tests that a feature does not trigger
when it should not, as well as it triggers when it should.

>>  * One thing we MUST be careful about is that some remotes may not
>>    have ANY remote tracking branches (i.e. you only want to use the
>>    remote mechanism to give you a shorthand for URL, but you do not
>>    have fetch refspec at all).  Even if refs/remotes/$repo/HEAD is
>>    missing for such a remote, we should *not* attempt to create it,
>>    as we are not populating refs/remotes/$repo/master and friends at
>>    all in such a case.
>
> You mean that somebody does git init && git remote add origin $remote, but
> never does calls fetch?

No.  If the remote HEAD does not exist, we may still not want to
create it.  Imagine

	[remote "his"]
		url = https://git.kernel.org/pub/scm/git/git
		push = refs/heads/maint
		push = refs/heads/master
		push = refs/heads/next
		push = +refs/heads/seen

without any refspec for the fetching side.  "git fetch his master"
may learn where the remote HEAD is, and it may even be pointing at
their 'master' branch, but because we do not maintain any remote
tracking information for their 'master' (in other words,
refs/remotes/his/master is not updated by this 'fetch' and there is
no configuration to make future 'fetch' to do so).

Thanks.
