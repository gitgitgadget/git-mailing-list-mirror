Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393514EC4B
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805041; cv=none; b=HHZ6rTx4DfwFodYRBYrnZvNLJJpvzREMk+pRWnBjiQph16TqcxZyjN/yOl56bdO7R4mMCOPr/VwiIXRvaZCeO0H7MS/UhCxpXcNpXY+AcAjcnivAnm+r1c7EbtCoM0XcUNNi50l/omOoCzKHy30v3KSjNmcBWSta5nrQOx7Bugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805041; c=relaxed/simple;
	bh=zB2luocndLmJ3knovYXKqv1pKFBQurKbSDYaK7+Ylm4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gMYu67WxCEXeq9caKU21t1+5NXtWandJ/g1EwxS0AA6Y0oHoiRMiqUGI1e/grTWbXD/arHMO1st/2cC6emTeTNvm3BvA+5aGLNOXwBIPRX5ib0ETlHhKci/WC2Y9t3FjjiQRT5RfJxKL9OOcb0DLiuGe1/G1/QbfOX4CNEdLqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mfUXJBdv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mfUXJBdv"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718805036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMqSjwgKV93OUjP+3E+95tyZzPzOg0Yr4bUl7e+qA2M=;
	b=mfUXJBdvlYZzwt85UX/LxMzeQSZmW7w3xv2sX7SNouMHW8LJOwIE3h4oxvhDccVtAkGanl
	t7+TtZD1DEYGrHqRt2IiOARY0ZElOou9luWNgUNMfO8LXiohdntXIa2l4NDuxoXZyQ5/pQ
	S+2laMm1N+DcUKCimZgO6ejGisRqJSYxjIVV4/ESBQ6NEniveBbLk26kHRsY7Xcthy/SBm
	6suy9A6Z30RVTGm+dyfFNKnF9ugCUCfP8o54sY6zOsrybg8TfTjGkOfyOH0AHZhzISP2A6
	ICI2r8By1W1xo/aPB7URkCvtJmj3U8QhlzpLpdKHfXoHHLyNJDTMKUeyWGYn5A==
Date: Wed, 19 Jun 2024 15:50:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai
 <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
In-Reply-To: <20240619134533.GA943023@coredump.intra.peff.net>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
Message-ID: <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jeff,

On 2024-06-19 15:45, Jeff King wrote:
> On Wed, Jun 19, 2024 at 03:18:40PM +0200, Dragan Simic wrote:
>> On 2024-06-19 14:57, Christian Couder wrote:
>> > For debugging and statistical purposes, it can be useful for Git
>> > servers to know the OS the client are using.
>> >
>> > So let's add a new 'os-version' capability to the v2 protocol, in the
>> > same way as the existing 'agent' capability that lets clients and
>> > servers exchange the Git version they are running.
>> >
>> > This sends the same info as `git bugreport` is already sending, which
>> > uses uname(2). It should be the same as what `uname -srvm` returns,
>> > except that it is sanitized in the same way as the Git version sent by
>> > the 'agent' capability is sanitized (by replacing character having an
>> > ascii code less than 32 or more than 127 with '.').
>> 
>> This may probably be a useful debugging feature, but I strongly
>> suggest that a configuration knob exists that makes disabling it
>> possible.  For security reasons, some users may not want to
>> publicly advertise their OSes and kernel versions.  Count me in
>> as one of such users. :)
> 
> Agreed. We do send the Git version, which is already a slight privacy
> issue (though it can be overridden at both build-time and run-time). 
> But
> OS details seems like crossing a line to me.
> 
> I don't mind if this is present but disabled by default, but then I
> guess it is not really serving much of a purpose, as hardly anybody
> would enable it. Which makes collecting large-scale statistics by
> hosting providers pretty much useless (and I don't think it is all that
> useful for debugging individual cases).

I agree that it should actually be disabled by default, for privacy
and security reasons, but that would actually defeat its purpose, so
I'm not really sure should it be merged.
