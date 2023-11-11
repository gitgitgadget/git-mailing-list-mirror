Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4BEA1
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWpZWgJ6"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8F3C3D
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:14:41 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 780C82D7C0;
	Fri, 10 Nov 2023 19:14:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=syRdd43/HhcTSfFVuX/2ZMzdSSOhMdzBOI/Kjf
	gxKDQ=; b=BWpZWgJ661yWnqTyY5zwodglNrSk9O0xmkWpC2tISuCV5y/lWeRRSY
	GnjKidOZ/eu0aw1B2mjE4rk8zgYibXMUqppq/VC9l8nNBoH3NaZXKv2JFwh5reh0
	UzHmX0Lz6BYsd9IF136ZCDyUzXMHDNSaEZ+y/V3Ab6W3UR241ICbw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 70D702D7BF;
	Fri, 10 Nov 2023 19:14:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C6F32D7BA;
	Fri, 10 Nov 2023 19:14:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
In-Reply-To: <20231110214423.GC2758295@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 Nov 2023 16:44:23 -0500")
References: <cover.1699526999.git.ps@pks.im> <cover.1699609940.git.ps@pks.im>
	<2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
	<20231110214423.GC2758295@coredump.intra.peff.net>
Date: Sat, 11 Nov 2023 09:14:36 +0900
Message-ID: <xmqq34xdtac3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4D19D0A4-8027-11EE-B1C0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Nov 10, 2023 at 11:01:15AM +0100, Patrick Steinhardt wrote:
>
>> diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
>> index 669ebaf68be..9fbf90cee7c 100755
>> --- a/t/valgrind/valgrind.sh
>> +++ b/t/valgrind/valgrind.sh
>> @@ -23,7 +23,7 @@ memcheck)
>>  	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
>>  	VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
>>  	test 3 -gt "$VALGRIND_MAJOR" ||
>> -	test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
>> +	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||
>>  	TOOL_OPTIONS="$TOOL_OPTIONS --track-origins=yes"
>
> I was surprised to see this one as a subshell after you adjusted the
> other.

;-)

I am not so surprised that this one was missed, though.  I didn't
point this one out during my review of the previous round, either,
and not everybody is as careful as you are.

Thanks, both.
