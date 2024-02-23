Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAD79E1
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713709; cv=none; b=EIVo3kiyoLR0VhN4ViDTueq9Jb9n9kjcVelMQ2MasYm0/nPwcIAFO+T66b5TiVxFjLZWSNvBKHfSOMOrfUGnrFZpb5bIoT+dPkpjjBquCY8mL/LpHTuJh29rJ+z750XTn5mw1P2yA7toBv4LCj6BC9OkwiZzTKuv36HUpA6NoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713709; c=relaxed/simple;
	bh=SGjw3VwBqkRvwlS5QJ5i2NVBhCWf5OCIpkMsnJ0LGUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8f/my29uq5UMhf2lHBvFLp+D0Zsv5kbpiHUHRcSw6VuTto4cqQt760FfRIhjzx19tBVYV2eGxfi/vne5iWMo5eYygapB/SRd80pb3YRaLRj4mY7ioejQf5b4UatuD/fHhlcnY83CenRS5id/EZ1VJEjHQ6Lw0me4ApZNdWut44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BBA+Eqho; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BBA+Eqho"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C482269AF;
	Fri, 23 Feb 2024 13:41:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SGjw3VwBqkRvwlS5QJ5i2NVBhCWf5OCIpkMsnJ
	0LGUE=; b=BBA+EqhoklBaPEw175KGmlf/P1930xkSHvS8iL1NkLFsgsCgtVCFiq
	k1J9DZrXCsLGRA/6Y8k90wGQiMe75TJfC8AsiQhzf32B1y4ze0NXJK0i7yS1AhFT
	WAE3w/U5TlGsNRI64CmulCF4q5ObAwBLjUimSDKrs2YPeM5DU+LqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 44073269AE;
	Fri, 23 Feb 2024 13:41:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F762269AD;
	Fri, 23 Feb 2024 13:41:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/5] for-each-ref: add '--include-root-refs' option
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 23 Feb 2024 11:01:07 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240223100112.44127-1-karthik.188@gmail.com>
Date: Fri, 23 Feb 2024 10:41:41 -0800
Message-ID: <xmqqzfvrrpju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30B00D92-D27B-11EE-AE45-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes from v4:
> 1. Fixed erratic whitespace
> 2. Remove braces from single line block
> 3. Starting the comments with a capital and also adding more context.
> 4. Removed a duplicate check.

Does #4 refer to this removal?

 	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
 		kind = FILTER_REFS_PSEUDOREFS;
 	else if (!(kind & filter->kind))
 		return NULL;
 
-	if (!(kind & filter->kind))
-		return NULL;
-
 	if (!filter_pattern_match(filter, refname))
 		return NULL;
 

If filter->kind is MASK and kind is set to filter detached HEAD, we
assign to and change the value of kind to FILTER_REFS_PSEUDOREFS,
so it is unclear if the freestanding "if kind and filter->kind does
not overlap, return NULL" was redundant or outright buggy.

The hunk just stood out to me, but I haven't read other parts of the
series yet.

Thanks.
