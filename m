Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A62A1B0
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349804; cv=none; b=S/e8sdm7jXt4GMHLcRzLvzjg8AHJC4nPiwEMDgowewlBo+tTIJB2Qa3c7SQE7edZpw7egPYCSa9nwIPhyRFqx90yWknkDTQ6GtnvnDup95nrkqfa4L99zpfWqQFfdZ4EQN2Hhv2mZnhii4tGnJ1hnbyCEIIuln27jDxgIWYOmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349804; c=relaxed/simple;
	bh=DyYXzsn1I51evdhxzloN31uFLnc8Sp7TmOhcxXdbY7c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CCMWFImg/RUIEMy7wh/NsjKWc1Fe6EuJ+nXxPDw3SNIVjfy9/R+rjauskB5c7L+Zsq81lfcDyXY/MUUvFbYV/q5rQrsTg9+8LGb7w4CF7A6jXiM9jZ+4Q2b7wF8bu5AyvHKoopkTrFXHX4uwC1Vzyuu8oBt9mzUCv0ibaM7YrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AN/UqSmt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AN/UqSmt"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717349798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PCStMGrd74Tsr8P6vfaOhmR3VJ1XPHTQOCMcsCvryc=;
	b=AN/UqSmtEu/hdEZQYqhn20++et2D8uE2Hpl83uAayAp6Nu2Z2iblop6QuyNkBNFgxFGRY+
	HNCjIX5bG6m+Tzq595IE96l3zGMBNbLXp87ZKwUiLCiLln6zPgRCaSc+2fZcalnm3o4GBa
	M1S2v8emqEYNzHZ4vQj4G3yqY+hl8eHWuIowhxZuJFNy6No1iacShiSil9CFCJj6Pskpx3
	4kZAbeu1OkLOg2OdPF2w4Nh8kptscU+phMehjg3qF7yGYsoUVkfLvwFk+Wkn71d0/3SiB1
	LWiy9hGiQ0ufRvW88SBTSnLfOR4haxy8iYcyU+CIZNLXu4wHaZx+jI1uvq6W/A==
Date: Sun, 02 Jun 2024 19:36:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Message-ID: <81d52b31ce4c287765a43d87d94f526b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ruben,

On 2024-06-02 17:38, Rubén Justo wrote:
> This iteration, v3, introduces a new command: '|', suggested by Junio,
> instead of the 'P' command proposed in the previous iteration.
> 
> This allows us to use the pager:
> 
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? |
> 
> But also to use other programs, like:
> 
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | head
> 
> Or:
> 
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | grep term
> 
> Hopefully, we'll find a way to avoid sending ANSI codes, on demand,
> without disabling it entirely with color.ui=never or any other global
> option.  To make this usable:
> 
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | vim -
> 
> However, the current functionality meets my current needs, so I'm happy
> with it.

The way I see it, using "| <program>" should follow the de facto rules
already established by the "--color=auto" command-line option in 
multiple
utilities.  Thus, when piping to a custom program, the escape codes that
perform the coloring should be stripped.

> This, a new 'interactive.pipeCommand' setting, or a new switch: 'add 
> -P',
> are left for discussing in, hopefully, a future series.
> 
> One final note;  I preferred to model the help text this way:
> 
>     y - stage this hunk
>     n - do not stage this hunk
>     q - quit; do not stage this hunk or any of the remaining ones
>     a - stage this hunk and all later hunks in the file
>     d - do not stage this hunk or any of the later hunks in the file
>     j - leave this hunk undecided, see next undecided hunk
>     J - leave this hunk undecided, see next hunk
>     g - select a hunk to go to
>     / - search for a hunk matching the given regex
>     s - split the current hunk into smaller hunks
>     e - manually edit the current hunk
>     p - print the current hunk
>     | - pipe the current hunk to the pager, or |<program> to use a 
> program'
>     ? - print help

I also like this form better, but I think wording could be improved.
I'll think a bit more about it, maybe something like this:

       | - use pager to show the current hunk, or use |<program> to 
customize

Also, what's the single quote doing after "use a program"?

> Instead of:
> 
>     y - stage this hunk
>     n - do not stage this hunk
>     q - quit; do not stage this hunk or any of the remaining ones
>     a - stage this hunk and all later hunks in the file
>     d - do not stage this hunk or any of the later hunks in the file
>     j - leave this hunk undecided, see next undecided hunk
>     J - leave this hunk undecided, see next hunk
>     g - select a hunk to go to
>     / - search for a hunk matching the given regex
>     s - split the current hunk into smaller hunks
>     e - manually edit the current hunk
>     p - print the current hunk
>     |[program] - pipe the current hunk to a program, the pager if 
> none...
>     ? - print help
> 
> Because I believe it reads better by maintaining a single character
> before the dash.  But I am not opposed to the latter.
