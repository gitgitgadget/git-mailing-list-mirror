Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B07135418
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744968; cv=none; b=mG0OogqW3rdgttpyaMIG4aXcAzs93THqK1bQE0upPEvO3jojk8lKXYZLlNMTdw3D28esRJTiF+XU9C+fONHOPpiWtL8phezBGM9RVSIIrar06CTwSaCso02BoP3HMM3kEvPtEL1sfZX9ACdS5LqUmaiU44cooSHfZaO0+mbCB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744968; c=relaxed/simple;
	bh=hBKaJkrwCTGEkuwwTjGHrYIX0cLL24PkzngpNg9KZLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OplTBUlmbygJXSduw5eAa/unXysuLWoHduDott0/WRyO0qgyhEpsBgpChs/sajQXP24p0Tf57NN5pRV48ChmgNtqwyeHZN/Us26genMYP6RVSA5zUaGxQEIgKAWbo2CON9vdQfBbELo4wCEPkb0xbj4RxD8kDnQIUioIojLq8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WT9zxs2T; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WT9zxs2T"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A6EFD1EA9A;
	Wed,  6 Mar 2024 12:09:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hBKaJkrwCTGEkuwwTjGHrYIX0cLL24PkzngpNg
	9KZLk=; b=WT9zxs2ToLcqTG9lvPnss/SOhqwfKjOFy8IGkmFqC1G+Jya195xJ5V
	XO7/d/FmGi8uAleSES7lJyHrnbVPBT494qQIZlHcTdhHcCEjq0FRKiKWFQZB9j6i
	mjK745iiCvneNfo8fIYmY34gD6ChTRB0RUBVOKtyQzDDAD45lTV1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED991EA99;
	Wed,  6 Mar 2024 12:09:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20E5D1EA97;
	Wed,  6 Mar 2024 12:09:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff Hostetler <git@jeffhostetler.com>,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Jeff Hostetler
 <jeffhostetler@github.com>
Subject: Re: [PATCH v3 00/14] FSMonitor edge cases on case-insensitive file
 systems
In-Reply-To: <ZehofMaSZyUq8S1N@tanuki> (Patrick Steinhardt's message of "Wed,
	6 Mar 2024 13:58:36 +0100")
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
	<ZehofMaSZyUq8S1N@tanuki>
Date: Wed, 06 Mar 2024 09:09:21 -0800
Message-ID: <xmqqa5nbs2wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 475ACD06-DBDC-11EE-AC1C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 26, 2024 at 09:39:11PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> Here is version 3. I think I have addressed the remaining comments.
>> 
>> I cleaned up the test code to use the test_expect_failure at the beginning
>> and squashed in the test_expect_success version of tests into the final
>> commit in the series.
>> 
>> I moved the invalidate_ce_fsm() commit earlier in the series, so that the
>> final commit actually uses all of the up-to-this-point changes to fix the
>> problem.
>> 
>> I converted a few "should not happens" to BUG()s.
>> 
>> Thanks to everyone for their time and attention reviewing this. Jeff
>
> I gave this whole patch series a read and didn't much to complain about.
> There are a couple of nits, but none of them really require a reroll in
> my opinion.
>
> Thanks!
>
> Patrick

Thanks.
