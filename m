Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E020314
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989932; cv=none; b=X0m3JvLH6DfNDQP+jBjwYL/s5vLHv5rOSTJMaVrVlnOtP8ZQ7DY4YJEUQb5RYoJIvGXmVIvEc7+6LjDSpa9V5z+/4zSMKuBYJdUfwiXh3BpfD2ieq6cLDyQrTlwXBniAN92fZ5OOx6aGdR7l1XgAQGQEzg0s1SW3ZYosysRgzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989932; c=relaxed/simple;
	bh=ZrSTDY+EUCkYAw83mhljSfEP2c2kdCGNiE1t0waimeM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g5DMZhPxq6Y4X6O0VnJ8cvv+TlpyDjCzR3gDXI4N3kz6/tQFpdCAaTafGqVk2rAdmbQWM18gTuUR8UZmCUEipIiSeiWxpTUa7gZOhVL483x8pvGoXJRaCoE5klP+Ou9TcQAfQwHmvaJ/LLJcTA5FQzIGhFg/r3h+U6REchfZP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QGLyr7gb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QGLyr7gb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718989919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju2we8MIqeSDkzl5npSKp0hiC05TQpKwXEMgIYju6Pk=;
	b=QGLyr7gb9FOkTPhCV08zC98tmTHReuoVggCMg3WRbcdZr4mrILrhomNz0/2oBMgHXU2X+r
	B6dlvSk/dL1DPUwQP70GK3Hu+MmnK+hsvRpkowQICos/DCrKuX0rMIvpnznDs6qBCNG9xw
	TloVLclWnNnAfgN1aGZFxCfE20741yYOGcdAP0yV9Fnbh8D9CVs0L2+s6R8D07nCEOu+Xt
	zVh61plfMcOTX5rxKMarNWtK/4vW2Za2pw1UQC/4tgXDYR60NRqE1pqWY9kaFSDb+XcjuG
	z3Ei5EBnAlq3Te3ruTchuYAN07x9svwUhipWMZWXA8s/QMN79OBte8SlHZUSXg==
Date: Fri, 21 Jun 2024 19:11:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>, Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <xmqqplsbqm2l.fsf@gitster.g>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <xmqqsex7tp0c.fsf@gitster.g> <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
 <xmqqplsbqm2l.fsf@gitster.g>
Message-ID: <c9112fd358340cd4adce3cb65b00c444@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-21 00:35, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 20.06.24 um 21:04 schrieb Junio C Hamano:
>>> Just in case there is a reason why we should instead silently return
>>> on MinGW, I'll Cc the author of bfdd9ffd, though.
>> 
>> I don't think there is a reason. IIRC, originally on Windows, failing 
>> to
>> start a pager would still let Git operate normally, just without paged
>> output. I might have regarded this as better than to fail the 
>> operation.
> 
> The "better keep going than to fail" is what Rubén finds worse, so
> both sides are quite understandable.
> 
> It is unlikely that real-world users are taking advantage of the
> fact.  If they do not want their invocation of Git command paged,
> "GIT_PAGER=cat git foo" is just as easy as "GIT_PAGER=no git foo",
> and if it was done by mistake to configure a non-working pager
> (e.g., configure core.pager to the program xyzzy and then
> uninstalling xyzzy without realizing you still have users), fixing
> it would be a one-time operation either way (you update core.pager
> or you reinstall xyzzy), so I would say that it is better to make
> the failure more stand out.

To me, failing when the configured pager cannot be executed is the
way to go.  Basically, if an invalid pager is configured, we're
actually obliged to produce a failure, simply because we have to
follow and apply the configuration strictly.  This also applies
to (partially) invalid configurations.
