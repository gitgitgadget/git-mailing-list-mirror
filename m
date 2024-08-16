Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B041C0DCA
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824706; cv=none; b=rfNQDD9Ib6nsYPtvWcSlaa+ze9BIO4IHC9WyWKcP8rrTU5U8xrFBtxLA9cRvk2Vw3iqLLasqplJcsHoqaz1XyMzY8ck0wxvGGMWT4DFm6cKaqf5AWOm7/NuVkHdIBLOykrV7FDSW9ICn1rqJqC/67Qn1h1x6Jq7l7RxVgBrvnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824706; c=relaxed/simple;
	bh=XuA3BulmpA+s4jGTPVXZaE1mgqa4uTtt6FghVUsYenw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BV2QGUbFGk0Zph/ADiuMcuNHPXMDYqhd/JvAYDzwM2t7f4TIzFUsz8jbRclpOPy4CPOj6YFZPLEDRUbSsKyCGN91yB+qtB1mY0ErvnWMwCz2uX+ZPb4VmVhy+ex0BVfJTejVlpfBZjTpmkTokOztjyUX2QmP906lGG9maIQ/2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RD/Ppzjk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RD/Ppzjk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F29629E17;
	Fri, 16 Aug 2024 12:11:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XuA3BulmpA+s4jGTPVXZaE1mgqa4uTtt6FghVU
	sYenw=; b=RD/PpzjkTY9WjpOK7WVO3N8NMsbwV/4DwLoVSM3LjyfE5Ucfd0YWq1
	SKG1JUqvos1yHCDraoRtdV8zMWWiwNcF3H5k9jTjrPaodlB+PDXpV7mBUm7bNj46
	sc923niIfWKB567fvJV6ej7K45f75+YVAh+JUC8ewRsxLizf96ofE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9688629E16;
	Fri, 16 Aug 2024 12:11:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05B1129E14;
	Fri, 16 Aug 2024 12:11:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Kyle Lippincott <spectral@google.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>,
  rsbecker@nexbridge.com,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 8/9] t/unit-tests: convert strvec tests to use clar
In-Reply-To: <1a38638e-561b-4e97-a462-f5ff034832e1@gmail.com> (Phillip Wood's
	message of "Fri, 16 Aug 2024 14:38:22 +0100")
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
	<8f56b4d6264b8e5a85ba73bc8ac541efa066c8a6.1723791831.git.ps@pks.im>
	<1a38638e-561b-4e97-a462-f5ff034832e1@gmail.com>
Date: Fri, 16 Aug 2024 09:11:36 -0700
Message-ID: <xmqq8qwwmoqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 375330FE-5BEA-11EF-A1C9-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 16/08/2024 08:04, Patrick Steinhardt wrote:
>> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
>> index 32a81299e9..82b7635e6a 100644
>> --- a/t/unit-tests/unit-test.c
>> +++ b/t/unit-tests/unit-test.c
>> @@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
>>   	int ret;
>>     	/* Append the "-t" flag such that the tests generate TAP
>> output. */
>> -	ALLOC_ARRAY(argv_copy, argc + 2);
>> +	ALLOC_ARRAY(argv_copy, argc + 1);
>>   	COPY_ARRAY(argv_copy, argv, argc);
>>   	argv_copy[argc++] = "-t";
>> -	argv_copy[argc] = NULL;
>
> I'm confused by this - it looks like it belongs in the previous patch
> but why are we deleting the line that adds the terminating NULL to
> argv in the first place?

I agree with you that it belongs to the previous step.  clar_test(),
unlike the usual convention used by main(), works solely with argc
to tell where the list of argument ends, without requiring argv[] to
be an NULL terminated array.  I do not know if clar _promises_ that
as the calling convention to its users, but if it does so, and if we
want to take advantage of that promise and leave the terminating
NULL out of argv[], we should do so from the beginning.

A NULL-terminated argv[], as long as we make sure argc only counts
the real arguments without counting that terminating NULL, would not
harm the clar_test(argc, argv) call, so I actually do not mind the
way this caller was originally written, with terminating NULL.  It
looks a lot more familiar, even though we may be wasting memory at
the end of argv[] array.
