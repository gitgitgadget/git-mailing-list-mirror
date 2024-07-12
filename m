Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66313DDDB
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774603; cv=none; b=dfS67TvFK0V4YvwwMRbpHx4oR+yJ1P4jtwgnXrprAbdqsFrYQxsoRZP4cugaWpFWXcD+M2Zri3dUrEuIw240B4Wvth9zoRq3MA5EZvUPDdfyQfgTWqsuWeSlOWKGOFKqBzM1B4uEgQcjVMxKnlHtgGNvxsOO2AiFh4xZAngjmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774603; c=relaxed/simple;
	bh=AadIm7wgDwEX33lmnSvt+Rros1M1cgYIC1FLt1adn7g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dqJ4jCaDjvKopu4bl4XjbKa8C7Cl+w4G+B7yGqidg1GQk6Es6u1XtOwhr2KX6eooIOMrMX6Gup3MNjw5CUTHIOPX0gwxrxx8osM8K5rAWWfKw9zXsAszqpZ8mD0IzX860HFn67eJ+QLnP+/z5t5Pw0z0nC+CnwNFmp8E+44JlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DVQ04FN4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DVQ04FN4"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720774591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E7s2/szlN6VI4Ny+pkWtNm0XT4/ht8/3YI+llo9qFo=;
	b=DVQ04FN4JYSbG4caF/WT+Bw3QJrF3m9wKEHQ34lzGRY5RTLKWnTL+Kn4WPN66opL4kvpNt
	AX336GkoB1PJxUfM0DOuEzK5Dy2fnXQyluAa7PyVc9smWI3O/raviOsrHhlNGddx2KMCiz
	FSRNQyGKWwu16iRJPY6ibbtWa2p3gDwkJyK9k64aoC7COdCFKkkzIdS3L8Mndij7evlFFG
	r/J2BtQzqFj97AeglIQ5OxKjGwfX3W5uIzZbGyKKmLcU/24CQHOoIRCaq1Tzxz1s3iAkbv
	mdvcMwQU7yLSZ0d6mI65P3t2Ztqdi0Jt7SEBPTNXG91B7QVssQdeunMYT+PIAA==
Date: Fri, 12 Jul 2024 10:56:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/4] use the pager in 'add -p'
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Message-ID: <ac4a2d62d9169b2370f6cf40e59f007e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ruben,

On 2024-07-12 02:57, Rubén Justo wrote:
> I'm resuming work on introducing a mechanism to use the PAGER to 
> display
> hunks during interactive "git add -p" sessions, which will make it
> easier to review large hunks.
> 
> The thread where the previous discussion took place is:
> https://lore.kernel.org/git/1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com/
> 
> I'm bringing back the proposal to introduce 'P' as a mechanism to
> display the current hunks through the PAGER.
> 
> I think it's sensible to exclude from the scope of this series the
> option of a new command '|[cmd]' and other modifications to the 
> original
> proposal that have raised questions that perhaps deserve their own
> discussion, outside the scope of this series.  Questions like:
> 
>    - What to do with ANSI codes?
>    - How to allow the definition of a default command?
>    - How to facilitate the reuse of a command?
>    - How to combine a default command with command reuse?
>    - What to do if the command fails?
> 
> To mention a few...
> 
> I'm also leaving for a future series a possible configuration
> "interactive.pipeCommand", "interactive.pager" or similar.
> 
> I hope this approach makes sense and allows us to move forward, and 
> that
> it doesn't represent a step back.

I find this approach fine.  It would allow us to have this neat feature
available in its initial, simplified form, while the future improvements
would belong to follow-up discussions and patches.

> Rubén Justo (4):
>   add-patch: test for 'p' command
>   pager: do not close fd 2 unnecessarily
>   pager: introduce wait_for_pager
>   add-patch: render hunks through the pager
> 
>  add-patch.c                | 18 ++++++++++--
>  pager.c                    | 45 ++++++++++++++++++++++++----
>  pager.h                    |  1 +
>  t/t3701-add-interactive.sh | 60 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 8 deletions(-)
