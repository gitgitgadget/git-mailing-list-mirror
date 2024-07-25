Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1519922A
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924397; cv=none; b=j89guxCA3TE/RNPU2m9iNDH1QEGJgJUUPBhp+AudST3MAqSHzc/Z1cWGqJBa8Yc8hGu8xqUH1pvNUYQY5jPsk/lqMXUaZaUWSm557OTXESO6mXwe4KKX7Mc1HoV50OuQvvmDRgp0Jp0OV767EJtguLNMKL7ZW4iTKAdc1kvPck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924397; c=relaxed/simple;
	bh=fUUYUKWlSe7H/CM8RuPuIGf04+R3vF+sHrIsrUP33wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKg9UchEu+bsroQVJeVfCdLL5mBS+/nRAKeUkZgq38k8V8pdzgEXZSri/7xSHJpLZg4D6se3sUBYZSibpnKJxhok/RGsWQhnztnxGNHLKfiOQUMIVhBahTDpllNLJUg9PjWQ38q9foRY1iigDXNhZXX55ZaM8LMjwh+6MZ4Pb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j/DC2tTg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j/DC2tTg"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D5D3291EE;
	Thu, 25 Jul 2024 12:19:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fUUYUKWlSe7H/CM8RuPuIGf04+R3vF+sHrIsrU
	P33wg=; b=j/DC2tTgGcXampEFpsGplCLdHzlgVjckUoWaxpowXqc7OAwhZ9/ee+
	aoawcnBVt+N89XyqoiHc5BvYuQL+5mHLXKVVsZsWczkBCgxr859j/6QQhSjkY+oP
	pR62Oux5KUOkCGI+i3BVr9tzlKwAIpoqQC2O2sZk7eUhmYzTZNUsQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 55C5D291ED;
	Thu, 25 Jul 2024 12:19:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA508291EC;
	Thu, 25 Jul 2024 12:19:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
In-Reply-To: <1106076396.2672924.1721906849141@mail.yahoo.com> (avih's message
	of "Thu, 25 Jul 2024 11:27:29 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com>
	<xmqqy15rzwi5.fsf@gitster.g>
	<1542063589.2363688.1721786934049@mail.yahoo.com>
	<1106076396.2672924.1721906849141@mail.yahoo.com>
Date: Thu, 25 Jul 2024 09:19:50 -0700
Message-ID: <xmqqwml9igux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B899F71A-4AA1-11EF-BBE3-9625FCCAB05B-77302942!pb-smtp21.pobox.com

avih <avihpit@yahoo.com> writes:

> Generalized solution (without namespace-ification):

I think you are over-engineering this.  We do not have immediate
need for such facility to be used by other scripts.  On the other
hand, we know exactly what git-prompt wants to see available, and
you already implemented them.

So just losing "make assignment asuming $'blah' works, and then
reassign based on what printf gave us" and always using the printf
thing is what we want to see here.

>     assign_as_fmt \
>         __git_SOH='\1' __git_STX='\2' __git_ESC='\33' \
>         __git_LF='\n' __git_CRLF='\r\n'

Are you sure that everybody's implementation of printf(1) is happy
with \d and \dd?  I am an old timer who learnt in a distant past to
always spell octals as \ddd without omitting any leading 0-digit,
because some was unhappy.

Thanks.
