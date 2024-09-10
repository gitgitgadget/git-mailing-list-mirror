Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A51ABEA4
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989472; cv=none; b=UoGfK6LSTFt3qHO/5KWvs79A0Ku+MWfUx/Apd6XQfGj2Yw+HSRqe2ccdN5h2DUpEITtElV+/t9lo8BzaLNBAp7Dv+deTauM1FS85KDc/R3ZciQDsZHrxQYE1bk6Lhl69dDZU0Ag+6ugKQEE9RUgS2h7ECbu8ae6Ia5wTk8YeZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989472; c=relaxed/simple;
	bh=+9hKTB57kucAUGNXNfGhGwQqPtuJ+JFx46z5qrXtotc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEJgZUGoourd4OUc2FfLBGJdU98oGZV6qolChtF9RpkU0kJVfUmrAngYnKTqE1I3XuCPi9sSrEQzQFhCKp/727OW9KXjHlkq5WiL+CBS2CipandU3IyU6cvU5d3LNhLSr4OIj10zq8WLbRQl9QCj0SFZClmKib67qPTD2v6A3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7LmpXtd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7LmpXtd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B1B332B12;
	Tue, 10 Sep 2024 13:31:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+9hKTB57kucAUGNXNfGhGwQqPtuJ+JFx46z5qr
	Xtotc=; b=O7LmpXtdQc16mmuAEdxZbDqd/N44a53iO2F0UIW3/hP3fASbBNsAsD
	2DE4g/NwKv/25wKd93NMJFpUxvg7Lt1L6XKb5lqkMUcmg1SzFDJEdkiJWodlZRiA
	fSQ1HJP3wt+itEOjhW3gOUG547hTENROQTG15umVvR5CAkPxt32Ww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BE1A32B11;
	Tue, 10 Sep 2024 13:31:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F349032B10;
	Tue, 10 Sep 2024 13:31:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] make chainlint output more newcomer-friendly
In-Reply-To: <20240910041013.68948-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Tue, 10 Sep 2024 00:10:10 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240910041013.68948-1-ericsunshine@charter.net>
Date: Tue, 10 Sep 2024 10:31:06 -0700
Message-ID: <xmqqfrq7fmat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 77621E6C-6F9A-11EF-AE0C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> * new patch [1/3] -- motivated by Junio's observation[2] about
>   availability of structured problem information -- takes advantage of
>   that information directly rather than post-processing "?!...?!"
>   sequences in the output stream

;-).

> * old patch [2/2] (now [3/3]) which drops "?!" decorations when emitting
>   colored output to a terminal partially justified the change by
>   claiming that the new "ERR" (or "ERR:") prefix is a good "needle" for
>   a terminal's search feature, thus the noisy "?!" is no longer needed;
>   however, I realized that "ERR" (or "ERR:") is, in fact, an awful
>   needle since the string "err" (or "err:") is quite likely to
>   legitimately appear in source text, hence I changed the prefix to
>   "LINT:" (with the colon since Patrick found lack of colon
>   confusing[3])

Nice; I prefer LINT over ERR quite a lot.

> Unfortunately, the included range-diff is a mess and pretty much useless

That's expected and OK after a large update of any series, which
often deserves to be read from cover to cover anyway.

> -	$checked =~ s/(\s) \?!/$1?!/mg;
> -	$checked =~ s/\?! (\s)/?!$1/mg;
> -	$checked =~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;

;-)
