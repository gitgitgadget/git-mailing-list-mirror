Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65E13B28D
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256817; cv=none; b=K8beaRu2VA5T43go7u/2WacV2sTUin2wIrvgaWgBXgFCe9rRFTfS6mclhWlk/jrWEa+JpGXa3cPm2/F+4LU28kJY48l+DIyGr2fyUyLbkoNgnmQ0VjhmyDaUhiBcEv9xTKKxKOiHJPuWStr58B6x5hrOpL81CeXIRYFJ3ndLjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256817; c=relaxed/simple;
	bh=abfwIJa9UACz19mxseaxkX/X8bPoZ806uzmIHI+BrJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNgzAzsRyO6DVTrCv09AbaC17tqCEnwtlbea5Vq/CMNI7eEXlU1+r02wshTncwQ7wCviYLi/m9FBuBwsqxgxBvY/oBkmqt3GnTnDQXadrJjBpNRn3RX6fQNdq7IS6quYqlT1oE9GfozkzQMexO+vqqFkf0bUWGvpB9s6LczV8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VqQzAlsv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VqQzAlsv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85AF936CE6;
	Wed, 21 Aug 2024 12:13:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=abfwIJa9UACz19mxseaxkX/X8bPoZ806uzmIHI
	+BrJ8=; b=VqQzAlsvtekP5pFGqzBZXRLj5I0l+dsAmm83t+64GLYNEsrTceGYEC
	Y14inEZUHtsk5tDLTrGR919OaG9witvQEqfUXI3AxMTPRrib55UeywVWkVDSB0Bt
	tae5Zn6LX3XhZaja8w34Lx78UVzmfts+Hxnj0UcqKND9XoLmG3M48=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BB7836CE5;
	Wed, 21 Aug 2024 12:13:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9C8136CE3;
	Wed, 21 Aug 2024 12:13:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 09/11] t-reftable-block: add tests for log blocks
In-Reply-To: <ZsWXF_zJTIsp8XOE@tanuki> (Patrick Steinhardt's message of "Wed,
	21 Aug 2024 09:28:34 +0200")
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
	<20240816175414.5169-1-chandrapratap3519@gmail.com>
	<20240816175414.5169-10-chandrapratap3519@gmail.com>
	<ZsWXF_zJTIsp8XOE@tanuki>
Date: Wed, 21 Aug 2024 09:13:32 -0700
Message-ID: <xmqqle0p26s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 50554294-5FD8-11EF-83CA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
>> +	block.len = block_size;
>> +	block.source = malloc_block_source();
>> +	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
>> +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
>
> Nit: instead of a `malloc_block_source()`, you may use
> `block_source_from_strbuf()`. The former will go away with the patch
> series at [1].

I noticed that need for rewriting while merging the topic.  If the
patch uses the surviving alternative, that's one fewer thing I have
to worry about ;-).

Thanks.
