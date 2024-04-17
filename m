Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9D17166F
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375253; cv=none; b=s+odlqsTlni8jK3npY/es2EfNgqIGrI+O21Dpd7v5Sb1oWNo7cIjUj+SU9sw/ZGf+RgcKpsrT1OX6JtT1YT3vdHXWIJlsNM2H7kNt1rC4RAnYpf6cIaBViy6UtMH3lbuiXASvpshOARK3K9/ZxzUxyWId7IxLUsvpkTCKxh+9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375253; c=relaxed/simple;
	bh=WAJjCZJnqjClM/h5mgqWDfKKfTKUNd1aahndXPgLv+4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nBLcFZCEt+flAmv9lpe7ZjJgJrnCqQ4uYoJloJYUx1U+ebMVuFvBZ2C5hhsPLG3zCKghZ47PPXWrHWOmuKry+m4x2z9mfeO9RhThtDk1UVlVmDqPfTHOjUNnBdCxYnlxqIaclSdFSyFR74933QSNFb7y9nxYfE33HsXJfi0bn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ss7eb70E; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ss7eb70E"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713375249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfPYu5V/KSZ1PwmJ/MmRS662uy6UKfQYh2xnvDKxVhQ=;
	b=ss7eb70E7L35xGUlS1F6UaA1i4J20UPL56qU7qgAjlZD6b/AaXGR66ABY5dJzs+jyLbO7r
	pj0jdK+NAVBRCZ4Kt3FYlFTmoH+nb0bXAw8k7LhTtPd95y1PrM2J8lvt1Sk2vz1J92BwAX
	JbTAVJfrD9/4FA+gPn0GI7Hp4rHApqb5bbl9V1ZuBPLEtsVzLC0xrHaPPxR+w7rJKyZN6Q
	tGOOMo20iVAmZeY1O5jmTz8bMgZGxS7ivT4q+FApnPJa5lNvCsl04vVz72iAEJmlhukpgZ
	JMeLDbouLz04ZjHWwyLf9efJKig7i+DAauCVyZkhtd0eTRZH/c2S+2mWGVjeiA==
Date: Wed, 17 Apr 2024 19:34:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <xmqq7cgwau1v.fsf@gitster.g>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <xmqq7cgwau1v.fsf@gitster.g>
Message-ID: <c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-17 17:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Playing devil's advocate for a minute, is this really common enough to
>> justify a new option when the user can use "--subject-prefix='PATCH
>> RESEND'" instead?
> 
> The same applies to "--rfc", but the justification goes like this.
> 
>  * When you are working on a single subsystem in a larger project,
>    your patches would want to carry the subsystem name.  You'd use
>    "--subject-prefix='PATCH frotz'" (and more likely it comes from
>    format.subjectPrefix in a working repository dedicated to work on
>    the frotz subsystem) for that.
> 
>  * In the context of working on that subsystem, sometimes you would
>    need to mark your patch as a RFC patch, i.e., "[RFC PATCH frotz]",
>    and that is done per-invocation basis (i.e., you are not always
>    constantly sending an RFC) with "--rfc".
> 
> Having orthogonal two mechanisms whose results are concatenated
> together is handy than having to specify the whole thing.
> 
> I somehow thought that during the review of the "--rfc" option a few
> ideas were brought up to deal with adornments other than but similar
> to RFC.  I still think the approach to make "--rfc" take an optional
> value, e.g., "--rfc=WIP" from the repository working in "frotz"
> subsystem would produce "[WIP PATCH frotz v2 2/4]" a reasonable one.

With all due respect, "--rfc=WIP" looks like a kludge, simply
because "--rfc" should, IIUC, be some kind of a fixed shorthand.
Perhaps a new option should be added for that purpose, but I'm
not really sure how it could be called.

> cf.  https://lore.kernel.org/git/xmqqbkepep9k.fsf@gitster.g/
> 
> Thanks.
