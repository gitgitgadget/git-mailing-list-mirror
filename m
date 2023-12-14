Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eKI7MZB0"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279CE8
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:16:47 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 154101D15B9;
	Thu, 14 Dec 2023 11:16:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=491u3Xx6mZLuMvyrk0gMDKP6rrpntDceCtJ48n
	chpww=; b=eKI7MZB0b3vMP5X3G7POcCDkN06eVD5/cylm8hOUvz/BXPHWudTo3o
	ythwia/+Huh2mfqChMKD+TXyoLelEK6EZu2tobC6Hr0ToLv40+Ng/+pzNyXFFxR8
	IiESTdfT5cc5TPNXbvWUKS/a2ZDGHavAbkJIkTJI0ACRyOQ+1eyUQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DBA61D15B8;
	Thu, 14 Dec 2023 11:16:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 749651D15B7;
	Thu, 14 Dec 2023 11:16:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
In-Reply-To: <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Dec 2023 03:39:17 -0500")
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
	<xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki>
	<xmqqr0jqnnmn.fsf@gitster.g>
	<CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
	<ZXq5GL723v4E3_IH@tanuki>
	<CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
Date: Thu, 14 Dec 2023 08:16:45 -0800
Message-ID: <xmqqbkaspxn6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2D8E16E8-9A9C-11EE-8F26-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>>   - Fix the ".expect" files so that we can avoid all of these games.
>>
>> I actually like the last option most. I'll have a go at it and send this
>> third version out in a bit.
>
> I sent a reply[1] in the other thread explaining why I'm still leaning
> toward `sed` to smooth over these minor differences rather than
> churning the "expect" files, especially since the minor differences
> are not significant to what is actually being tested.

If it is just one time bulk conversion under t/chainlint/ to match
what the chainlint.pl script produces, with the possibility of
similar bulk updates in the future when the script gets updated, I
tend to agree with Patrick that getting rid of the fuzzy comparison
will be the best way forward.

Especially if the fuzzy comparison is done only to hide differences
between what the old chainlint.sed used to produce and what the
current version produces, that is.  If for some reason the script
started to create subtly different output for other reasons (e.g.,
it may produce different whitespaces on a particular platform, or
with a specific version of perl interpreter), we'd better be aware
of it, instead of blindly ignoring the differences without
inspecting them and verifying that they are benign.

By going through the single conversion pain, it will force us to
think twice before breaking its output stability while updating
chainlint.pl, which would also be a good thing.

THanks.
