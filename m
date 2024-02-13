Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543E5FF07
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845469; cv=none; b=F6ySnd9lR9dZGHUTvPzBF4apaFZhZgQmsliwg6NYHi+ohXURzNJNwz2rS4RZW3gzufnv7m/yDq8ZSRWLEpQrUPHKUq7YEe8E+/zJzaGYfK6jY4+77o1n8FBRr/SZeZaRo8jrmwEMmqHzcyXiQGaAb93ipu//lniQRY1aEafheJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845469; c=relaxed/simple;
	bh=R/BloFTvb2km9auw1KiqDZW78AItwEmHw8Sw9z9vvsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dyh3//7C+q6TuhglKSF+HpiE/Hi1YK/Lu5TyvBniKmDfWIzqpKKDbJFrBEiVlZFqVTLG8SBl04IQA+PLN1x0tDspG7zUgZnySKqcepSqrbmyVnRbKHwcgmgigJmmX5xepO5V6Ym2/O7OOBZjPNLVXh4U9bk8zasQBugKHBfZcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RWXeiM+b; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RWXeiM+b"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70CE51E79F5;
	Tue, 13 Feb 2024 12:30:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R/BloFTvb2km9auw1KiqDZW78AItwEmHw8Sw9z
	9vvsk=; b=RWXeiM+bQ0fNrSqGhBuiGi9y3/SacWcYMUVz6Yj5bvGPthiEfizjwl
	H2zxpCJwIXHIrDDe2Ia6mj9Wn6Yuqb9ikxIcLYQKLneBC5k0pMsKx6D7uHm1hTJ1
	+p3Sezk/wBNnHR/BBhoR+fyW4RVgGPN1yYV2HR4fBwYI3MG7N3yMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 665A81E79F4;
	Tue, 13 Feb 2024 12:30:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6EFC1E79E8;
	Tue, 13 Feb 2024 12:30:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
In-Reply-To: <CAP8UFD0C37qdTUvCpRFe6_zAeAcssoySY6tobw+AO8hpA8iAfg@mail.gmail.com>
	(Christian Couder's message of "Tue, 13 Feb 2024 07:55:44 +0100")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
	<xmqqjzn94404.fsf@gitster.g>
	<CAP8UFD0C37qdTUvCpRFe6_zAeAcssoySY6tobw+AO8hpA8iAfg@mail.gmail.com>
Date: Tue, 13 Feb 2024 09:30:57 -0800
Message-ID: <xmqqa5o46zla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A6847E60-CA95-11EE-BD81-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> > I took a look at all of them, and I think that this series should be
>> > split into 4 or more series.
>>
>> I presume that [01-09/28] would be the first part, nothing
>> controversial and consisting of obvious clean-ups?  I do not mind
>> merging that part down to remove the future review load if everybody
>> agrees.
>
> Yeah, patches [01-09/28] look good to me.

I was hoping that you'll give us more details of what the other 3 or
more you would envision the series to be, actually.

