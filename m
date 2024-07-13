Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E63308A
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885742; cv=none; b=aNjU93DTvf82bf7kXeSGHSCM2s7nnVZVQpTo5dZ6c+BIMBKXKNgdXb2Om/MO8kHEG/+vAPDPC6XLcSRoLBtNlo+rKoVG2Ft70GedU1Bbs2RxOmntW6BUzhgQ7/T57H2Iwpjn5Qvm9IAVlWZGfcGQYTodk8l/HLhj00RvApxvfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885742; c=relaxed/simple;
	bh=SCdLKgSh217BVIRQ2UDVV6SY+XmUBe8WIZyp/IfgyqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXvjOVFYGoT+cCri+Qq/foKP1T7ra1Kh3fd/LcavC4GJFVzIKQuAVG+rMUIDzq6xzViZsOJmTzv5+2ZuM3pvL5PcLh+1Y3/wSE5TPaohnmpT/I0s7GJW4njHOII9j5+vZIi/of4RFgSs3yzuLVyluoUmd8j+27oajK9GQP9R7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FXPRKb4Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FXPRKb4Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A76E1CBEA;
	Sat, 13 Jul 2024 11:49:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SCdLKgSh217BVIRQ2UDVV6SY+XmUBe8WIZyp/I
	fgyqU=; b=FXPRKb4YBKSE2YeSAdwfCo3sVLuKZM6OtRgkatkOpcbkcldomGnBL7
	G7apmVmDVc6VFSJ6lVMt01qqEvBD+I+cAcSdebv2tS2KQWHF2tpY7CkNuRA1PJGU
	0iLVcI5Lc3xa6uwkfz9mDCT6oSiMr7V7SqpM2ZoQIBFF13Wou2ncc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00D8F1CBE9;
	Sat, 13 Jul 2024 11:49:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6791B1CBE8;
	Sat, 13 Jul 2024 11:48:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
In-Reply-To: <954d67b1-8819-4bfc-ae10-f04beca5419a@gmail.com> (Phillip Wood's
	message of "Sat, 13 Jul 2024 14:27:08 +0100")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
	<51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
	<97390954-49bc-48c4-bab1-95be10717aca@web.de>
	<8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
	<6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
	<62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
	<69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com>
	<xmqq8qyblwpn.fsf@gitster.g> <xmqqa5iot01s.fsf@gitster.g>
	<954d67b1-8819-4bfc-ae10-f04beca5419a@gmail.com>
Date: Sat, 13 Jul 2024 08:48:58 -0700
Message-ID: <xmqqsewdb8d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B7D5C18-412F-11EF-B1A3-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/07/2024 16:34, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> So, perhaps test_if_XXXXXX() but it is not quite clear to me when
>> TEST_RUN() wants to return true, so I cannot come up with an
>> appropriate value to fill the XXXXXX part.  If this is about
>> honoring GIT_SKIP_TESTS or something similar, then I may suggest
>> test_if_enabled(), but that does not seem like it.  So...
>
> TEST_RUN() returns true if the test has not been skipped i.e. the test
> should be run. At the moment the only way to skip a test is to call
> test_skip_all() in a previous test. In the future I expect we'll add
> something like the "--run" option we have for the integration tests.

Thanks, so test_if_enabled() is not all that off the mark after all.
