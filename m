Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2DE11184
	for <git@vger.kernel.org>; Mon, 20 May 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225845; cv=none; b=nY5c5MP3c2SU9sakO4JmB77lXmlgSBLOAu5L5yGsyR5XnRtPb3/yOmy4e6ygljFNZkcIYxb7yAcBSjG5OwFrC3PNjWKz3w9hgsJl2kkO6NNd1U4GHAgkMBmfwNKaYjYGzaAVXb46j4LcPFcPhbJcRPY8dAkYywEysPvJTnEoUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225845; c=relaxed/simple;
	bh=bZ1mNtiBuko5QhnKYbtZJOuHvF8licj8FShEhXyOW2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPYpZYIhFO1wzCbJIK2JawxCV+796POMYGCNtUt9Y+WGZMzZFk+fKJcCjvgzBJYh3yneUbww0jVo7/AR3w0i5ssURXZKlWkbO4L3W/kdEAhdgstsCXiVr/VhKvAdP+3uM7LgSzUH0C2q8uU/ulp0AND3dEwTGzHnoGeFQyCtXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dA1TifpC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dA1TifpC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B904927C54;
	Mon, 20 May 2024 13:24:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bZ1mNtiBuko5QhnKYbtZJOuHvF8licj8FShEhX
	yOW2o=; b=dA1TifpCq+w3DgRc38UbgqapBLkBWklpPd7aKbCF5DI3J5ZA7ewFPh
	R5ny+HNujnBkUPoH1K6VVqD76Uz25fwnrazr4jmk47vNYf7R+fW2ynXVMr9lsmNg
	gGRPKRS4m72Zfhn+acCqT9HqIHIEfp9/gWZATJRP6ogfxZVKUB0eQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B298D27C53;
	Mon, 20 May 2024 13:24:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B933F27C4F;
	Mon, 20 May 2024 13:24:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
  git@vger.kernel.org,  Sam James <sam@gentoo.org>,  Andreas Larsson
 <andreas@gaisler.com>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo
 on Linux SPARC
In-Reply-To: <CAPig+cQsc4AUJ7-0v=rS8VVK9JG1+_iSwa_gWUUigs=uwYq6Lw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 20 May 2024 12:50:12 -0400")
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	<xmqqseyclaq8.fsf@gitster.g>
	<CAPig+cQsc4AUJ7-0v=rS8VVK9JG1+_iSwa_gWUUigs=uwYq6Lw@mail.gmail.com>
Date: Mon, 20 May 2024 10:23:59 -0700
Message-ID: <xmqqbk50jt1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF71563A-16CD-11EF-94F8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I was wondering if we want to first add the "reasonable fallback"
>> Eric mentioned ealier, and then build on top, whose result may look
>> like the attached.
>
> I'm fine with a well-focused patch which just fixes the reported
> problem; the "reasonable fallback" change can be layered atop at any
> time.

Yeah, I never suggested to do these in a single patch.  Since I
would think that it is easier to do and review a patch that cleans
up the code and adds a reasonable fallback before adding new support
for sparc or alpha (after all, such a clean-up is also for longer
term maintainability---by definition, it must be easier to add new
support to the result of a clean-up than the original, or it is not
a clean-up), I suggested to first add such a change.  What you saw
was how the result of "then build on top" would have looked like.

> I had a more all-inclusive change in mind. These number-of-cpu checks
> are in order from least to most costly but they are not necessarily
> mutually exclusive. As such, my thinking was that the logic would fall
> through to the next check if the preceding check produced zero or
> nonsense.

OK.  All the more reason to clean-up first, then?  If we pile more
on top of the current structure, it would make the later clean-up
more cumbersome, wouldn't it?

Thanks.

