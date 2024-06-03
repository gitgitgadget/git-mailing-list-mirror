Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD11877
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428524; cv=none; b=NNmFH2CVke6qY5AOPjIDHXcCd/frY8qrhP8sex61uS+mBonyaNIpHVtwmNWdCZsNcwDzvimubxfua+pTBsCC0V+CNHSHkU7RQCI4G34EQS9Wd0xwZ5MvDDMwtarNYbTcjfzRTaFyK+9Vjf15EQ/dVXifUvR2GGmTORDLIT3k9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428524; c=relaxed/simple;
	bh=cf3nDgucfSx+RuyiKA5JipvARQAqLexZEQjZOGppMlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jElDYOPxKl76ys88XN1frgvXbPuXA4oRM5KtvJS8HFNYHjXdGVVzMjziqM79oyjEHhGThHTSeHq0WpEGwe11vmzqJdVg9Giatpu7MLbj392wPwAv/14UVhfNYQtxL8R1SJfDQ1fC2ZkllWUDrmah9dYl+s/JwJyaFophX2mjOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ctt2HvbY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ctt2HvbY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A1983354A;
	Mon,  3 Jun 2024 11:28:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cf3nDgucfSx+RuyiKA5JipvARQAqLexZEQjZOG
	ppMlw=; b=ctt2HvbYqg9/eD+xoCHZK6TSNKiPgIHMO//YVrU7Sd2giBFqvTrAch
	KpDAI7IdjKa40sGeGgSxEm8AfLXcSMaHWDCzmT7gZcp2xe8u/xiQzwSAdQZK+DUH
	Cspd/P6hDISATUqwOxAL7Ix72VkhuYKuOl788bb4AjodFSztU9NGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9185833549;
	Mon,  3 Jun 2024 11:28:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0309833548;
	Mon,  3 Jun 2024 11:28:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <fb2a9e98f0b2c3a009b0ad800c05522c@manjaro.org> (Dragan Simic's
	message of "Mon, 03 Jun 2024 12:21:05 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<xmqqwmn79u98.fsf@gitster.g>
	<ec2ca25486b84615e30dbeb83ec47310@manjaro.org>
	<xmqq34pu8kkg.fsf@gitster.g>
	<fb2a9e98f0b2c3a009b0ad800c05522c@manjaro.org>
Date: Mon, 03 Jun 2024 08:28:39 -0700
Message-ID: <xmqqsexu6o60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4BD486C-21BD-11EF-B140-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> I'd probably just say $GIT_PAGER instead of its expansion if we were
>> go that route.
>
> Makes sense to me.  More precisely, the environment should be checked
> to see is it "$GIT_PAGER" or "$PAGER" that needs to be printed literally
> as part of the help message.

I was sure somebody will split a hair like that.  At that point we
are better off mentioning 'git var' X-<.  Or just 'Your Pager'.
