Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE59219E7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119725; cv=none; b=Mv+y38wg2NAlUjSqO4vep2h6z6ByHMC+B6x99H5ESjCZHQSBfEqPzsnT9uTbvwzDKk+vGAUKENTTmvxTghiHFVAXQI0KBD7OPi865qLBscjSD6EADAaNBJ/s0NmUK4FKNUZKBSnYFg93MEoLHXmyUAsGlsYyWkFe7CaRHcJDRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119725; c=relaxed/simple;
	bh=fI6aBayRe1mQsoK4D3ZAJwgqOGVpubjxX0NfDFoqBWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtEYq7eAS7Lns1jTk0/J7k3XPangMKOeX/SCByJuB3inLd2Jg+BhAUGzm2FzwIIFm/UEllGDQfH18sQA70vNa3HCW20dgDyfvvAd7XLRmWnFgQ8OqzhCnPkKhdDI188CtKH6JPSTmjvmlcS5wiwfSTFawPfDxVBvQm55zjsoyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kUXZa6pf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kUXZa6pf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0686D18250;
	Tue, 11 Jun 2024 11:28:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fI6aBayRe1mQsoK4D3ZAJwgqOGVpubjxX0NfDF
	oqBWU=; b=kUXZa6pf9av8BoyFFTj8EeOJ6cMIA0Tml+lUZZRq+LsUiUwOWUn1v8
	dXCxnd01Z7+tANymKLjDEnhEcMlhEpPthxqpIJHjkdji2hbqV6jfYmKvYfZGrQFI
	pyDkQV+SsTstImL1BpaWlhDh42lvemFFt08aaoIz9zHQ4i6C6tV1A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F138D1824F;
	Tue, 11 Jun 2024 11:28:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6263A1824E;
	Tue, 11 Jun 2024 11:28:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mathew George <mathewegeorge@gmail.com>,  git@vger.kernel.org
Subject: Re: Cannot override `remote.origin.url` with `-c` option
In-Reply-To: <20240611075137.GF3248245@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Jun 2024 03:51:37 -0400")
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
	<20240611075137.GF3248245@coredump.intra.peff.net>
Date: Tue, 11 Jun 2024 08:28:41 -0700
Message-ID: <xmqq34pjxzva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48DE9884-2807-11EF-A15B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Of course that leaves two questions:
>
>   1. What are multiple URLs actually good for? I have no idea. I

It came from days back when there weren't a separate push URL IIRC.
You may pull from a central place like everybody else, but you may
have other publishing points of your work.

Place to fetch must be a single known stable place for obvious
reasons.  "I have N, so I'll pull from one chosen at random among
these N" would lead to madness ;-).

>   2. Is there a way to override the list?
>
>      Sadly, no. For some config keys, we allow a value-less boolean
>      entry to reset the list.

Hmph, I somehow thought that a more widely used "clear" was an empty
string, but if we can make the convention around the "I exist and I
mean true" entries, that would be great.  It would not make much
sense to have multi-valued Boolean variable to begin with.

> Of course none of that helps your immediate case. I did think of one
> workaround, though, which is to use the "insteadOf" config to rewrite
> the URL. So:
>
>   git -c url.right-url.insteadOf=wrong-url ...
>
> will rewrite all instances of "wrong-url" to use "right-url" instead (in
> origin and elsewhere).

Yup, that is an excellent idea.

> diff --git a/remote.c b/remote.c
> index dcb5492c85..69b0f28637 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -63,6 +63,10 @@ static const char *alias_url(const char *url, struct rewrites *r)
>  
>  static void add_url(struct remote *remote, const char *url)
>  {
> +	if (!url) {
> +		remote->url_nr = 0;
> +		return;
> +	}
>  	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
>  	remote->url[remote->url_nr++] = url;
>  }
> @@ -430,10 +434,7 @@ static int handle_config(const char *key, const char *value,
>  	else if (!strcmp(subkey, "prunetags"))
>  		remote->prune_tags = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "url")) {
> -		char *v;
> -		if (git_config_string(&v, key, value))
> -			return -1;
> -		add_url(remote, v);
> +		add_url(remote, xstrdup_or_null(value));
>  	} else if (!strcmp(subkey, "pushurl")) {
>  		char *v;
>  		if (git_config_string(&v, key, value))

I was expecting (with excitement) a mess, but the above is as clean
as we can make the idea, I would say.  Lack of documentation and
tests do count as incompleteness though of course.

