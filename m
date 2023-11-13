Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595E3E460
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g3MIBLxN"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8988F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:27:50 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8612B1C1AEA;
	Mon, 13 Nov 2023 18:27:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ez0g9i59EE4npIiHIH+dHUYel92WkIlYcEsXkg
	QLHlo=; b=g3MIBLxNkTd09k6fvBKZTYLci2RRMNGYXRYA2clMLrq1tHzp4O6FAa
	zHMzUmefm5H0fP8hZTDPlWlbLh2uMQX4bczIIHvY+QRYgAtetu1SPT4ADM/Ffdph
	4nwkibeHrReVYtx1Zq0Ut73elvQT3vyrbIME+RxgPzNEXFmH4YT8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CD9F1C1AE9;
	Mon, 13 Nov 2023 18:27:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E51791C1AE8;
	Mon, 13 Nov 2023 18:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v2] fuzz: add new oss-fuzz fuzzer for date.c / date.h
In-Reply-To: <20231113183509.GA3838361@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Nov 2023 13:35:09 -0500")
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
	<pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
	<20231113183509.GA3838361@coredump.intra.peff.net>
Date: Tue, 14 Nov 2023 08:27:47 +0900
Message-ID: <xmqqzfzh44jw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41FA4ECC-827C-11EE-93D9-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Nov 13, 2023 at 04:22:48PM +0000, Arthur Chan via GitGitGadget wrote:
>
>> +	str = (char *)malloc(size + 1);
>> +	if (!str)
>> +		return 0;
>> +	memcpy(str, data, size);
>> +	str[size] = '\0';
>
> Is it important that we avoid calling die() if the malloc fails here?
>
> The usual way to write this in our code base is just:
>
>   str = xmemdupz(data, size);
>
> It's not entirely a style thing; we sometimes audit the code base
> looking for computations on malloc sizes (for integer overflows) as well
> as sites that should be using xmalloc and are not. Obviously we can
> exclude oss-fuzz/ from such audits, but if there's no reason not to
> prefer our usual style, it's one less thing to worry about.

Good point.  Thanks.
