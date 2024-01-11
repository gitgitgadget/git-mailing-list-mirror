Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE956771
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f83812a32so24909316d6.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009393; x=1705614193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lBqGkKi2cklJ17Dn0A1IHK5SrRqusaaYHyOi8yROdQ=;
        b=IWzlEx2qEuH/o2yyfOmnQCa7lng5lkDhfEhRAExG8vnT6BgpieImsSc8fc7uI1isAq
         NYzbC5eBSQiqOnXFxedRg4UP/TbJ+em3ikqRnsh0pNPWUNFkVdli7nwj7HRVcvReWxgu
         Bckvp3EZaFYEsLT6wURpAuwGj2z55p7fvUmeRi90WsvLz6ubtjy3BWIr+PRfXB0NyDsL
         G4B4ehBmvwgBTDkD844S+0xFDujfrwTQF+fQp+cman51pEMA34drE3CEzpy1JY/+9WR6
         biG0rjC2IVjdk0tukWXuFSXSvVvfTlct+UbCdp8iZ8HnMTFPmqXLgHw8vM0m2EILAiM9
         q5eg==
X-Gm-Message-State: AOJu0Ywnpp2NN8tZ5hhqrHpz9M6KdbTYtPKxQlIDfkP76qKJ98o6A2WM
	42tcwIq40Wc3rfbswl0h2f6Zg2GR9yyHSsALWys=
X-Google-Smtp-Source: AGHT+IHd9hw6mwnOyTUbT55mmS8mOQBubP8lT0iGtMfK2T4kSCdHh4cdF7dK8UmYgOdenPaOmHiP086REPCcx67DYmY=
X-Received: by 2002:a05:6214:2a81:b0:681:259b:b967 with SMTP id
 jr1-20020a0562142a8100b00681259bb967mr321988qvb.49.1705009392799; Thu, 11 Jan
 2024 13:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
In-Reply-To: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 11 Jan 2024 16:43:01 -0500
Message-ID: <CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
To: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Benji Kay <okaybenji@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:27=E2=80=AFPM Benji Kay via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When one issues the pull command, one may see "Already up to date."
> When issuing the push command, one may have seen "Everything up-to-date".
> To improve consistency, "Everything up to date." is printed instead.
> (The hyphens have been removed, and a period has been added.)
>
> Signed-off-by: okaybenji <okaybenji@gmail.com>

Thanks. This particular change is proposed periodically...

> diff --git a/transport.c b/transport.c
> @@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
>         else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> -               fprintf(stderr, "Everything up-to-date\n");
> +               fprintf(stderr, "Everything up to date.\n");

... but has not been considered desirable.

See, for instance, this email thread explaining the rationale for
avoiding such a change:
https://lore.kernel.org/git/pull.1298.git.1658908927714.gitgitgadget@gmail.=
com/T/
