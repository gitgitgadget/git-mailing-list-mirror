Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C294182DB
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365369; cv=none; b=JKpgG9u+GZsAkvQgSFOPSvdA9yIV6S0m8nTopQ7J5PXNyV5CVLBjfFAeChT3u7bj6E7NLlg6ZF9NSQEKdKf0677nQ0wtRT/WRPay+vSX46ZEPp1KslGX9DmVhCU9f3D3huMPXoCPE1J8wOl62nDFtNwIEKDQ7D1OaD2QMF8JFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365369; c=relaxed/simple;
	bh=GYERPoAr2hcdnbkSb9B2sOpVEcGrp8r0VVGeU5vTAmo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M9yTJUJLzN3IObGLUdISQ+HlT6QH2eXjtDLA9r19HA8HUKBMVfrUlxIy4sGJSx/OpqGM7wpg46egwQrCs/bHNi/MlXD0mX2tVbIOQPpljucefPPiTNJ/KuSdDGX1hfFvDzG0Hm5MpnrdvpmRhm5Q5t3hCZ3tfIZ9s7ZjTSt0fRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=L22NXa3D; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="L22NXa3D"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716365365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aU89Qj3GsraHK21ic6m2rrScPdwmP+oKxyeMQq8wwpY=;
	b=L22NXa3DF/hrCNhnI5RAriU/iTB/FD64dZiU865jVMBuez6SNuFtx4lr2oFtDRel1Gdk/n
	7pibUPPbMK2MjuaVWwl0SMdaAlVJIVaCGw7xiCOT6cpngLP96koMDdiYKiLdi7C7N4kzul
	QxlWcyCMXGv0/D3TIdLJF9mzHk/kmOOA4izyZAM58P4CqOzQqP6dhyXOxnpIc1IPLVlRKB
	NaDu0uKbRpRHJKg/xu1D7BTSuRCTInasaw/TAUwtOts6lOhVinHJYV0SGRBVlojlMtWrrM
	nDewwE55nN+MxdGoZyiSZnnfaGU7q3NLtNygenziywfGa0qDmJVkW7uf20INtw==
Date: Wed, 22 May 2024 10:09:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] add-patch: render hunks through the pager
In-Reply-To: <310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
Message-ID: <1accd0163c96811b7b7f146e477acf89@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ruben,

On 2024-05-21 22:52, Rubén Justo wrote:
> Make the print command to trigger the pager when invoked using a 
> capital
> 'P', to make it easier for the user to review long hunks.
> 
> ...
> 
> @@ -1387,7 +1388,7 @@ N_("j - leave this hunk undecided, see next
> undecided hunk\n"
>     "/ - search for a hunk matching the given regex\n"
>     "s - split the current hunk into smaller hunks\n"
>     "e - manually edit the current hunk\n"
> -   "p - print the current hunk\n"
> +   "p - print the current hunk, 'P' to use the pager\n"

I think it would be better to move the description of "P" into
a separate line after the "p" line, perhaps like this:

   "P - use the pager to print the current hunk\n"

I know, we'd sacrifice one line of the valuable vertical space
this way, but I find it more consistent and much harder to miss
the new "P" option.

Overall, I find the introduction of "P" as the new single-character
menu option fine.  Maybe we can later add "-P" as the new command-
line option, if there will be some demand to do that.
