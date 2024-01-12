Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA2139A
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7831c604a84so384960185a.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 19:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705029256; x=1705634056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnn3TaSOwZI+ru41jlQrDtZ3pr9sPQCjEo5m9qBWc5g=;
        b=qfBJ2O9IkH4w+G2Sy8wbs6yMEWUPifCZVSQIsmU8jKzz42wSbqxrgztCgUOQZ5zLMv
         0zVi4+V/85rKjuVjdXS3KNBznFpZWlkQxhJ7gi3igUqFuYhoXm1CQa/x660Rbspd3z+x
         z58854wsgMDprRZ5oFPghBHOwS/mqo8+2llOaXa90X4eCgWRV+HHP6Cl3QriWaxdex4k
         65d0n9W30gXLO83bvVrF4JN1Wum0Pfhs4tQPpbZh5PpB6a0OvG5NXp8Lb1V48auJvY38
         LCGQNuHFE0LQM278cAG6V9Rx8ekp7C/TwlgDbCKs305LtmiRqu3mJEB9ujRk3Wd36608
         rMuw==
X-Gm-Message-State: AOJu0Yyhs/Ov+s7aZwTVrhmfWa15pwfyttJdHlUGb32HbVOwAgK10GvK
	51BdajmYjXmGJmXf7wyXSpctoAEh5eMLAz494J8=
X-Google-Smtp-Source: AGHT+IH42GjMpgVF+A7ZZLd+kJJx1B0nEifU4PR/uGZWxoxTuiNL+17z6EGgcdqIUEWbPlRa09w3SVnEnYSKgG/rLDc=
X-Received: by 2002:a05:6214:194f:b0:681:304e:2870 with SMTP id
 q15-20020a056214194f00b00681304e2870mr223658qvk.129.1705029255925; Thu, 11
 Jan 2024 19:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
 <CAPig+cRr0V2ecnmxk1H_yF24dwSFA6niPxYXGH0MZ+wGP9m9UA@mail.gmail.com> <xmqqjzofec0e.fsf@gitster.g>
In-Reply-To: <xmqqjzofec0e.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 11 Jan 2024 22:14:05 -0500
Message-ID: <CAPig+cSO74EbK7RS5t3TAbRLUuLyynenugg4RgsOQ_=VyA4aAw@mail.gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
To: Junio C Hamano <gitster@pobox.com>
Cc: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Benji Kay <okaybenji@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 5:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Thanks. This particular change is proposed periodically...
> > ... but has not been considered desirable.
> >
> > See, for instance, this email thread explaining the rationale for
> > avoiding such a change:
> > https://lore.kernel.org/git/pull.1298.git.1658908927714.gitgitgadget@gm=
ail.com/T/
>
> Let's do the second best thing, leave a short comment near them, to
> make it possible for those who are motivated enough to find out why
> we decided to tell them "do not modify".
> ---
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> @@ -333,6 +333,7 @@ int cmd_send_pack(int argc, const char **argv, const =
char *prefix)
>         if (!ret && !transport_refs_pushed(remote_refs))
> +               /* do not modify this string */
>                 fprintf(stderr, "Everything up-to-date\n");

Yes, that helps, though, we can probably be a bit more friendly to
future developers. Rather than insisting that they dig through
history, we could use a slightly less terse comment, such as:

    /* stable plumbing output; do not modify or localize */
