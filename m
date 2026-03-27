Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A982DB781
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573991; cv=none; b=qChInSs4CMh9BfydUSaU5oY5pSK9oGjP5QK5RymV48V62UEieEzC58xt4HUIvUifhrFp5UCFD92kwZoVpPcqfywfW/V2rOABgOw5T52OaghU1CxBdPXQwUIdlIMVrqpOyydoRJiIg7wwgrbMZKtKJW2dKo51Vc1454fegP5I574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573991; c=relaxed/simple;
	bh=iIiFS4qVGELkqtGlk2GcstFpRci+sk236+5icqr9BLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtYAjiOWob39OjczZodvLG/Jetn529o0/wEpsQSIvv/mZVPToZLs7i7cFd64L/B9azNLyFnOH3gOVikhtwBxJlua4wql7LTZRn29PWFbRIfqnh2bDxiOgtknWyEGuU67VfcpWU6VAuSWPzeSMi+BzjBUNXsVAigdwWuAN+xWxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=iCBN4pU7; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="iCBN4pU7"
Date: Fri, 27 Mar 2026 02:13:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774573987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu9rkn2H0+xVVAVsAKZKdRFu1AxxuWmBvVabZ/TyLuQ=;
	b=iCBN4pU7o3oqWuYAxdutJM4TbRSzsoElMxNXxD44Ec7ZOtVHrCdrnh2PfeQFqMaGFpVb0w
	tAIb5kQsW3nDVqSH2PcVXR40JUVYbJeevvofSUDa3Qw3sNcjg1mMNQk7xJB7DEAPxkDjUB
	WoOk64yqLkhCpQV030MUD7S0d4569LtrjOXlCp++OmDErsq5zTcOK8LuePcY9C46MZHj5o
	lePix9K3UL6MhGUJYdziiw0pgwAklSP7XaS6CY9/vup2nE+HtOjyfU0Y7eGP4/MYtVrWd7
	vNSyhFxmjWDPOth151GFM66QszhAW57J1hFeOYwHGBqg1H1XeJZuEkGct7Af2g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
Message-ID: <acXYSm1JoX6YRuoL@exploit>
References: <cover.1773959395.git.mroik@delayed.space>
 <cover.1774284699.git.mroik@delayed.space>
 <xmqqqzpa489h.fsf@gitster.g>
 <ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
 <xmqqpl4qr1he.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl4qr1he.fsf@gitster.g>
X-Spamd-Bar: -

On Thu, Mar 26, 2026 at 09:37:17AM -0700, Junio C Hamano wrote:
> Yup, I tried "modern" and generally liked it very much.
> 
> The appearance of the list looked a bit odd that each element in a
> list of things with heading was shown without any indentation before
> the heading, though.  I'd probably use
> 
>     --commit-list-format=" %(count): %<(72,trunc)%s"
> 
> or something like that myself.
> 
> I seem to be getting spurious blank lines between the lines with the
> above, when I lengthen and shorten 72 in the format string above,
> though.  I haven't figured out what is broken, though.

Could this be because of strbuf_add_wrapped_text()? In a previous review
someone pointed out that there was no wrapping, so now each entry goes
through a pass of strbuf_add_wrapped_text() which should wrap when the
line gets longer than MAIL_DEFAULT_WRAP (72 characters). Since you
guarantee at most 72 chars for %s, if it ever gets to that the line
would be at least 76 chars long due to " n: ".
