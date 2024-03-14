Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C851362
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383969; cv=none; b=ohe6WECroRRddvUbDvKlGOVzXl5+B71tWIhIWDbo4XSGHlbbL87qjdCXn/K+tCYIz33yI0arykbWrOqZykKWjA8qhkdJT26Z0lzJU0t1+6aOfQ/2LXvfySyB4x9aBtFPs1bn6jhB/kWH04qnbFOuhH034JCmmfm44FhYYM2eisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383969; c=relaxed/simple;
	bh=3ptFBseHO3Gch+k9Ja7ZqBQZVTnm8bsqR81Sa949Lso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8VJyPKCYYHXM9FHyICtOsWG/ExM05w9b4r7gfjk71kvgpf1a3MWaCBchqSASP+vrNSJCrjfKXCN2wFed2GpNC9/2N6r3VSPGJI6uV1ol5u6eughm8ezu66xN8Qsd1wHDqzN1vlcOvHHFWUC5SHn+JUzeDWf41y5tuTbK2NHWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690cd7f83cdso3658996d6.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 19:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710383966; x=1710988766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0RPtY76IxB+oVqKVIjzbfCReWjNfZG7AG5od5UCpgA=;
        b=qe5cJ31Jcx47Fh8ux5G2a1uWxVDOmsr5ka6U3H2x4cy7+Tt6FvdvVWrbO/l51XizEn
         nNb6PeXX8cLIrYUYyZHEbFb2xpTO6b8xh/zlXdeyQOl6P/nM6b/nnCPR/SrGfbEzvoTH
         moWyL0zipnYTtVVpglBMH9zXSu7GdY2EeHJ20rxzRplSBJhSXyYebddBeQVMEvotFmz+
         2VuGwj+s7z2idJDIVLIBbkRjpYFadRz96h8+IEJbf2EdqvRVmGRN7XnD4v7HtUBp2slh
         WndkJqzNZqmmFqtxi5CEzZvlyhIg4A8+y8z6xMjyDcwLdi4+LN21ZiFXW9dYY8AZOgA4
         /E+w==
X-Gm-Message-State: AOJu0YyLZZa/xeAoO8ASEgZNs1cplyjx1vAn0sTCLBvhCd8C8bxMo1G4
	7WQw71FSE0k1Qo7i7xun8MjxEMQEMeGd8Xepm3DruxFTOzn88Gr0GAwqyhYk6/H7bp5xa2rB2jQ
	AgmNSYP3pJcj32saGEjwsgJAZ3/k=
X-Google-Smtp-Source: AGHT+IGjSiBGS1ZaQ88+/onkgA1PKdwTt82n5Hj/CkdsPZEnSPIBMod44KJYZh+IjZBlwtSNKI7QFv9TBKU7c6q8Iig=
X-Received: by 2002:a0c:ea31:0:b0:690:be38:d875 with SMTP id
 t17-20020a0cea31000000b00690be38d875mr546318qvp.29.1710383966661; Wed, 13 Mar
 2024 19:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
In-Reply-To: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 13 Mar 2024 22:39:14 -0400
Message-ID: <CAPig+cSYB3uNZhNGh6++5KA03ehv5pE+_KK1X=hUbb5JHwMoJQ@mail.gmail.com>
Subject: Re: [PATCH] checkout: plug some leaks in git-restore
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:33=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
> In git-restore we need to free the pathspec and pathspec_from_file
> values from the struct checkout_opts.
>
> A simple fix could be to free them in cmd_restore, after the call to
> checkout_main returns, like we are doing [1][2] in the sibling function
> cmd_checkout.
>
> However, we can do better.
>
> We have git-switch and git-restore, both of them spin-offs[3][4] of
> git-checkout.  All three are implemented as thin wrappers around
> checkout_main.  Considering this, it makes a lot of sense to do the
> cleanup closer to checkout_main.
>
> Factor out the call to checkout_main in a function that does both the
> work and the cleanup, and use it in the three wrappers.
>
> As a consequence, mark: t2070, t2071, t2072 and t6418 as leak-free.
> ---

Missing sign-off.
