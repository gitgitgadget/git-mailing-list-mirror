Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A740C5C9
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007962; cv=none; b=B1tNFyw3cZjgg5+KyAq9No0X41MfeiVTRFdsp2RVzz/DXjiHvj9zcPZTqvyoxjce8mkYWqgW0vBVQos94GFMgqL7iVvs1Zb9oWdc7r78qbdM7uh6x64jwdBtFXk6VreuGQOBv4zTM2b7MHaE7sBDqSHP1RYz2bE+rUYDaG4GKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007962; c=relaxed/simple;
	bh=doPuInCErKFQRLmVqbeNFUrvn1t51ptAymSGsqitW7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbtVQ90+bZ/m3hde0DCAomqWCy8N46WiJJ1LQkfdGQpYchornsdavFnIYmrtpYMMv9HF5pBNj9V4E7/2GtfC1IwJzlXtD5LpWp40uKlL14nxuzD8n4xBUSFe5Q/3xLoMu1+wwnHXmpJVBoSyaOHmBo7rmQTGYyHEnhWohJas/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WX33gDX7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WX33gDX7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781007954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjc8ysw7fJ36eF2ZX448oMR142O0XhGHHzuRiSd3Dio=;
	b=WX33gDX7867GMhrYAzpW0sHR9somty6oVzs+hJsLFm6R86ZAX/vWls152UOo5rkYW9sGMj
	9JeW/BX77+R2/H+Gl+Qbbq+3OyGQiSX5FVtISfr9SPK2xMHHDYvWelTdILDCxeyYkB1jY2
	O/SMXDi7OgW75rM4xuh+mu5EAlx0ssE=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Karthik Nayak
 <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
In-Reply-To: <CAP8UFD0r96KxU3kW2khJ_MySgtv0ZpU26KR1vNimp_FwigQfXA@mail.gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
 <87ik7s16sg.fsf@emacs.iotcl.com>
 <CAP8UFD0r96KxU3kW2khJ_MySgtv0ZpU26KR1vNimp_FwigQfXA@mail.gmail.com>
Date: Tue, 09 Jun 2026 14:25:48 +0200
Message-ID: <877bo7294j.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

>> But I previously mentioned I felt the naming of 'acceptFromServer' and
>> 'acceptFromServerUrl' are a bit confusing. So I'm wondering whether we
>> can consider another proposal:
>>
>> What if 'acceptFromServer' would configure if 'acceptFromServerUrl'
>> should be used? I mean, imagine we put this in the config:
>>
>>     [promisor]
>>         acceptFromServer = Match
>>         acceptFromServerUrl = https://my-org.com/*
>>
>> (we can still argue over naming, but to get the idea)
>>
>> So the value "Match" for 'acceptFromServer' would inform Git to use
>> 'acceptFromServerUrl'. This way precedence isn't a concern no more,
>> because every value for 'acceptFromServer' is mutually exclusive.
>
> In this case I would prefer to remove 'acceptFromServerUrl' entirely
> and to make acceptFromServer accept values like:
>
>     match:https://my-org.com/*
>
> By the way "match" might not be the best term. Maybe something like
> "auto-configure" would be better.

I think that's too complicated. Let's not do that.

>> This has one downside though, you can no longer combine
>> acceptFromServer=KnownUrl with a 'acceptFromServerUrl'. So URLs
>> advertised by the server can no longer fall-through to
>> 'acceptFromServer' if they don't match 'acceptFromServerUrl'. You can
>> argue whether that's a good thing or not.
>
> I think it's a good thing to have this fall-through. It allows setting
> up things like this:
>
> In the global config:
>
> [promisor]
>         acceptFromServerUrl = https://my-org.com/*
>
> In the config of only a few repo that need it:
>
> [promisor]
>         acceptFromServer = knownUrl
>
> This way remotes from my-org.com are accepted in all the repos, while
> other remotes are accepted only if their name and URLs have already
> been configured in the repos that need them.
>
> This allows relatively lenient security for internal repos and more
> strict security for external ones, and I suspect that many users will
> want something like that.
>
> What you suggest doesn't allow that. It could force users to choose
> for each repo between either URL based allowlist or local
> configuration of every remote.

Well yes, that's why I mentioned:

> You can argue whether that's a good thing or not.

If it's intentional and as you mention there's a valid use-case for
this, then I agree with your approach in this series.

> Also I think it's easier to explain that 'acceptFromServerUrl' is a
> different mechanism (that allows auto-configuration, contrary to
> 'acceptFromServer') if these two variables are independent.

True, although naming-wise it doesn't feel like that. But I no longer
gonna keep picking on that, so ignore this comment please. :-)

>> What do you think? If you disagree, I'm fine with the current approach
>> and I think this version looks good.
>
> Thanks for your review and for being fine with the current approach if
> I disagree.

Thanks for explaining, I still agree moving on like this.

-- 
Cheers,
Toon
