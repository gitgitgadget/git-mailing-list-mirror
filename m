Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B112F391
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763875; cv=none; b=FZU9IUKvnDlNlicdhWhJWE/lQbwOcad6VKN5wyoahKhfGE375oddlR8XO/17KDo1MdM0M+fmXVLiuVhfBVf3J5+FCos6w7kyc8hY85nwVZkLjNQqiGyprOmngVOb0VoehVhKxbB5V5OJBdti6YvpCdJZyZJBhKPuotimTDfHQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763875; c=relaxed/simple;
	bh=RmtlTmb2Ar/kO0v906AKFQ+ybNHzy0TSDgsj/Rx4oK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UpFp8ziAinXyzKjAHeBlYMeGHQ+HXQCQyYS3k5K2024Hsx2WK/Tb/6th+1xfeWk/ixP057KC/njco8D3Ul7hBlbtNgZ79ApJVa0M0iUZDgwa7SlFVLyV97jE3d0iRVAxIfY9D5wLk6F3Adln7fCf4jr6c1+PZzU/SfXGBYG1eVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q4AM4goY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q4AM4goY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF20C2B41D;
	Fri,  3 May 2024 15:17:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RmtlTmb2Ar/kO0v906AKFQ+ybNHzy0TSDgsj/R
	x4oK8=; b=q4AM4goYi7fcu8bUUjG2wB0jmKKD8CAX+xMhovz+soGDkWPK/6Kr78
	keOkhCzRGw8jsk6zFwpxobyvuzLzhRvoOaao5UFVJFPktDvHHxktHD8vme64aepu
	1SkneoUiJTHRTmFqWP6QlL+taXuRnzyIgkWpeSZy79TO4vqiD0GYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6A1D2B41A;
	Fri,  3 May 2024 15:17:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48C7A2B419;
	Fri,  3 May 2024 15:17:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
In-Reply-To: <20240503180239.GA3634479@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 May 2024 14:02:39 -0400")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1713985716.git.steadmon@google.com>
	<0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
	<xmqqo79yxxk7.fsf@gitster.g>
	<20240503180239.GA3634479@coredump.intra.peff.net>
Date: Fri, 03 May 2024 12:17:45 -0700
Message-ID: <xmqq34qy7lie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2C1F202-0981-11EF-BAC2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>> 	if test -z "${TEST_SHELL_PATH:+set}"
>> 	then
>> 		echo >&2 "ERROR: TEST_SHELL_PATH is not set or empty"
>> 
>> may be what we want here.
>
> If we are using ":+" to handle the empty string, I think just:
>
>   if test -z "$TEST_SHELL_PATH"
>
> is sufficient, no?

Yes. And the other part of this hunk still needs fixing, namely,

> +		exit 1
> +	fi
> +	exec ${TEST_SHELL_PATH} "$@"
> +	;;

the above reference needs to be quoted protect $IFS in the path.
