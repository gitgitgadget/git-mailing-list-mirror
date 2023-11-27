Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AA12C
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 09:48:42 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d81faeefc4so970302a34.2
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 09:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107322; x=1701712122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDwukuLpkGItVg8qvyeivVg48/shUmcLGCdIKPVTGT4=;
        b=SbU8Xf2iPwPRMe5B0gWpR77QLa3TSJLpSmK7Ttyc4yH/08VEQi0I0lwsTM0NYqPoRl
         Dd0vFNFtigraI7gf9O957zWNmfAfTtRXL3x2695pY0TzwKSsc2hdc3D6U8Ut7AybgewR
         H8/fErktDUAMuQo6UpXPRugt1USpEECa1HAupglOjro0Dt8R+jGYXSF1AHun8xjQHtR2
         YvPieLT3US/hNbxBzztkjD6xNsLT64MQ9QKZ7RZiln0kDUsRJG33+vTRcV5F3tPXcZq3
         jOCi3pShyXb++CFkSwy8uznrxAVjBRwkK2N9XEQmAxUCkqPfKLOWAtfNn/7aJJm7hTGe
         876g==
X-Gm-Message-State: AOJu0YxMpRoM0gCayRdNjP78cqABeEUG7+VWoXY4gYqoY/W02bbUoIHU
	VILa1Bseha+cEwELHMGX8MHve251cydcAst8FlpSHajQbKl4QQ==
X-Google-Smtp-Source: AGHT+IHiOa4yLzGXAxS+Nqf3m+4kLtS68xnhx1vlnfzynEtx5OuTOMS7Ptn6TLkt0nBu/Jdjp22JkPgZIgpYmWOxCn4=
X-Received: by 2002:a05:6830:60c:b0:6d6:3926:9a2b with SMTP id
 w12-20020a056830060c00b006d639269a2bmr13654043oti.26.1701107321776; Mon, 27
 Nov 2023 09:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de> <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
 <d1f28272-635d-4638-b0f4-76d64013b0d5@web.de>
In-Reply-To: <d1f28272-635d-4638-b0f4-76d64013b0d5@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 27 Nov 2023 12:48:30 -0500
Message-ID: <CAPig+cR_SN5yJbNQC8F6--hhTj-5_KW97WVszFDOfub=R_OeZQ@mail.gmail.com>
Subject: Re: [PATCH] i18n: factorize even more 'incompatible options' messages
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:39=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
> Am 26.11.23 um 18:49 schrieb Eric Sunshine:
> > A couple additional instances recently slipped into `show-ref.c` which
> > were caught during review[1,2] but nevertheless made it to
> > "master"[3,4]. This patch, of course, doesn't need to address those,
> > but if rerolling for some other reason, perhaps they can be included,
> > as well(?).
> >
> > [1]: https://lore.kernel.org/git/CAPig+cSrp7vZuy7D_ENHKZKZzF4OSmCtfYNHP=
GMtS1Hj6gArDw@mail.gmail.com/
> > [2]: https://lore.kernel.org/git/CAPig+cRTOMie0rUf=3DMhbo9e2EXf-_2kQyMe=
qpB9OCRB1MZZ1rw@mail.gmail.com/
> > [3]: 199970e72f (builtin/show-ref: ensure mutual exclusiveness of
> > subcommands, 2023-10-31)
> > [4]: 9080a7f178 (builtin/show-ref: add new mode to check for reference
> > existence, 2023-10-31)
>
> [4] changes the message added by [3], so that's one instance, right?

Yes, correct. Sorry for misleadingly saying there were two new
messages; it's been a month since I looked at the patches closely, and
forgot that it was just the single message which had been modified by
the subsequent patch.

Thanks for taking care of this so quickly!

> --- >8 ---
> Subject: [PATCH] show-ref: use die_for_incompatible_opt3()
>
> Use the standard message for reporting the use of multiple mutually
> exclusive options by calling die_for_incompatible_opt3() instead of
> rolling our own.  This has the benefits of showing only the actually
> given options, reducing the number of strings to translate and making
> the UI slightly more consistent.
>
> Adjust the test to no longer insist on a specific order of the
> reported options, as this implementation detail does not affect the
> usefulness of the error message.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Apparently, I haven't been following along closely enough, thus wasn't
aware that we had the die_for_incompatible_opt*() family of functions.
Neat.
