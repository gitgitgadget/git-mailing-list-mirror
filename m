Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED247A79
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410071; cv=none; b=O3dPLvmdepYK7J6A1keKTHxvEQjhE27B8KD9M1E30vuhxA2QkO7Z+JDHIYWJZv17jpBv5CUfjCKaNDbkGv2lPXaN23cGrQVtp98j1RzMzd026qPSZ6HGKuNrK2ThKbKi8hd+wV6pgQ3URZLQOmVc6LLneF5NHdaeoJ4QXCH9ABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410071; c=relaxed/simple;
	bh=QxpLjBiM3fje1vwjjf9y/TaOm4HKbfgqEoCMnW7DaUA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p7kAJ4QrmopYJ0+RuaIJeH/LBikDGcJBmKC9MU+Mfr3U6GKp7jHPpP04RXHIOxaIm9jNom3U1JnNJLqDViNVYt6HaplHdxywcvxQL1O4qKaldFfhQorlo9Xn5a+b5/PXcCNE2EZ5O4N86nPL0WfOvPSiWMntm/qFG6DiHwsqxkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=La0CWsaV; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="La0CWsaV"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717410066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZoRrR5Z9C0YmW0tAvloOf+bhraXFhYJfJrrQtZqU6M=;
	b=La0CWsaVDT2T8PMjChz2mRP7r5CE0/elwNS//WAMpYNYtNdlgII2K60YF7212VkjaDhpPX
	rU88NOFeX9Ep8MDlPxsmDTury6fe1gz1PnIwjwQUPLLZv9evPWNPe/QLzt+opBj5xlMzuY
	L4kyfKDatzXRkFEW6e+s8QN43+x/mwFQB+FqLlvTkAOLSGjOfouyKEKyeYxEP0zCx5ytOR
	KiNG+sN3T6tIV9ycdRQlhjT0RP9JcxNlkTN6MjeQkZiLFp4nbKyAdwTqQF/UHi8aM9FkNb
	E4G5zS+E6sqSkDJgTe1jB7EbV+ZO0ey55LWRUidAeuYHWNwpXtyFqZDn+jZPfA==
Date: Mon, 03 Jun 2024 12:21:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqq34pu8kkg.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <xmqqwmn79u98.fsf@gitster.g> <ec2ca25486b84615e30dbeb83ec47310@manjaro.org>
 <xmqq34pu8kkg.fsf@gitster.g>
Message-ID: <fb2a9e98f0b2c3a009b0ad800c05522c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-03 11:03, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> On 2024-06-02 18:36, Junio C Hamano wrote:
>>> A possibility is to phrase it like so:
>>>     | - pipe the current hunk to the program (or "%s" by default)
>>> and fill %s with the program you'd use if not given, i.e. initially
>>> the value of the GIT_PAGER but updated to the last used program
>>> after the user uses "|<program>" form to specify one.
>> 
>> The value of GIT_PAGER (or the <program>) can be a rather long string,
>> so it would have to be stripped down to the base command, but it would
>> be rather error-prone and the printed information would become much 
>> less
>> informative that way.
> 
> I'd probably just say $GIT_PAGER instead of its expansion if we were
> go that route.

Makes sense to me.  More precisely, the environment should be checked
to see is it "$GIT_PAGER" or "$PAGER" that needs to be printed literally
as part of the help message.
