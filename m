Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0C2628D
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506548; cv=none; b=kO2EwlCC/0WsH/daHsSk2uRkuw6ByXBKj3MSq45BOFOtOZmE+dHhMsqJ7Gg0YQsfpusPrLjewR0QGBNOTh91ghJIc4P5G58E4AKSG+UhuvKyL8phaKPZqTCeF0MYJGVgYgOtVODpJKhs2vGzHSDldqPgOaC++o4b003oq5vw6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506548; c=relaxed/simple;
	bh=8MtJNOucQJw3mE3BqpHqjHVQRg6l1X++LYP3d+2h2Pg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LAuznFNqvtKpShCLRA3WKoXRrKORtz9aRG4I2kLLoOVPZ1ispSD6rw5kkY4GCZpj/C+pxPDElvzgbasg1lVno+7Ds89Gy6KTTmw7mc+vDpgKzWyZwsYpMuLVMw5hX2rEuuRg4ioPz/Qp2pVnksaMdw88VVP/7h5woMe66Sa5tpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CIlg6ulJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CIlg6ulJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716506543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRr7/w2WTqbf57iBXfrWpZMNRLIJZ/dJPOGMiko2apA=;
	b=CIlg6ulJ/ZECLpvYvQwW5AMzUxSxZ+1hdVIrGIM8BwHP0PJAAQlMalq8EtouCzFfTX0glE
	YdcLG13HtTLx4SaybMA+v8I0TQ9uTH3CcwPzjGIl9zUWjGhymb6CWcp8R+5u43yi116uJj
	L59dwGnvnVqU5rlFZf3WC/mIN9vroo+j+9pGPCwDeAHg2/AwFDUK7hzwPZDUU57fqPSEZf
	ghgzkyJowU/f3ZXZIWYCYlx3WoVSD2ah6A5keZeqM6+JBAVdrqBLNxwNKFolt5uEoz1Nj4
	FtQOM5Ni5up48lnf2eMp0HrWNQz94tklKn57YzZjrPgG5kSKVyu9IsDu6UGOfA==
Date: Fri, 24 May 2024 01:22:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] give range-diff at the end of single patch output
In-Reply-To: <20240523225007.2871766-1-gitster@pobox.com>
References: <20240523225007.2871766-1-gitster@pobox.com>
Message-ID: <83436db5996b129032c2869f331980d0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 00:50, Junio C Hamano wrote:
> When running "format-patch" on a multiple patch series, the output
> coming from "--interdiff" and "--range-diff" options is inserted
> after the "shortlog" list of commits and the overall diffstat.
> 
> The idea is that shortlog/diffstat are shorter and with denser
> information content, which gives a better overview before the
> readers dive into more details of range/inter diff.
> 
> When working on a single patch, however, we stuff the inter/range
> diff output before the actual patch, next to the diffstat.  This
> pushes down the patch text way down with inter/range diff output,
> distracting readers.
> 
> Move the inter/range diff output to the very end of the output,
> after all the patch text is shown.

Hmm...  I think this should be made configurable, with the current
behavior being the default.  Without that, we could easily disrupt
many people's workflows, because the power of "muscle memory" is
often really strong.

If it were just about moving a few lines up or down, making it
configurable wouldn't make much sense, but with moving this large
chunks of text...  It's a different story.
