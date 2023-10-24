Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89D3B2A8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C92B3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:39:40 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-66d2f3bb312so31646786d6.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176379; x=1698781179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGr0P/l4S6AEgYyhM/UN4jP++JcJB8rR9xNa6b+A4W8=;
        b=uKWnVkIN247cGwdIsHmmsmErzFrEmvx67JTToo5paSbkmc0nObUik5yWgYwojyRjgN
         PIYQg0UkdLtmc69RxmFH8Gf/BnE0aczz7KVb22d/bQq6yh4wdvGjUTXjunjNggbFxSdv
         6XEnHVJoUybtYABYsWE40EopKFWALv9jtlQgF8TmlbWn+L66nMju9Z83QMsflGfOLvWU
         Ndoj3CK8k/RCyLGWVIgBakMkvkEZGF/kjSNcl8v56zF+NB9Houvu2ACnfV0jf218iDWk
         HYStV5vNJ2ufs+T91j354M8JHRzuQm2tAEMM1rdIJvF/f2WHTuDzAMGZDkVI3d5gg/Kq
         +WNQ==
X-Gm-Message-State: AOJu0YzzK5WgHdBnq5QkRMLLQOnB9GPSTKOIIGum5y/DYAtuM5QbgCgU
	cvbT5AXFf7x9SAeeFzIZ27DNuq9IIMWwcnOEegc=
X-Google-Smtp-Source: AGHT+IHMASjRrMK82jkp5S8mpG6OZwGEthmpb5PvNO9yWNVJAA+axlwoRTmffsReXlAIdSHqOMAZa9i/YuLlJXVSpEQ=
X-Received: by 2002:ad4:5f09:0:b0:66d:6043:fa16 with SMTP id
 fo9-20020ad45f09000000b0066d6043fa16mr17703489qvb.2.1698176379034; Tue, 24
 Oct 2023 12:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698152926.git.ps@pks.im> <adcfa7a6a9d8fb6f915faf77df52362544cd590e.1698152926.git.ps@pks.im>
In-Reply-To: <adcfa7a6a9d8fb6f915faf77df52362544cd590e.1698152926.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Oct 2023 15:39:28 -0400
Message-ID: <CAPig+cQ=VhRm40oW=TQYzy2NXKNJm4QVQhtw3FAKsFRn12qYLA@mail.gmail.com>
Subject: Re: [PATCH 10/12] builtin/show-ref: explicitly spell out different
 modes in synopsis
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The synopsis treats the `--verify` and the implicit mode the same. They
> are slightly different though:
>
>     - They accept different sets of flags.
>
>     - The implicit mode accepts patterns while the `--verify` mode
>       accepts references.
>
> Split up the synopsis for these two modes such that we can disambiguate
> those differences.

Good. When reading [2/12], my immediate thought was that such a
documentation change was needed.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.=
txt
> @@ -8,9 +8,12 @@ git-show-ref - List references in a local repository
>  SYNOPSIS
> -'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
> +'git show-ref' [-q | --quiet] [--head] [-d | --dereference]
>              [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
>              [--heads] [--] [<pattern>...]
> +'git show-ref' --verify [-q | --quiet] [-d | --dereference]
> +            [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
> +            [--] [<ref>...]
>  'git show-ref' --exclude-existing[=3D<pattern>]

What does it mean to request "quiet" for the plain `git show-ref`
mode? That seems pointless and counterintuitive. Even though this mode
may accept --quiet as a quirk of implementation, we probably shouldn't
be promoting its use in the documentation. Moreover, the blurb for
--quiet later in the document:

   Do not print any results to stdout. When combined with --verify,
   this can be used to silently check if a reference exists.

should probably be rephrased since it currently implies that it may be
used with modes other than --verify, but that's not really the case
(implementation quirks aside).

This also raises the question as to whether an interlock should be
added to disallow --quiet with plain `git show-ref`, much like the
interlock preventing --exclude-existing and --verify from being used
together. Ideally, such an interlock ought to be added, but I wouldn't
be surprised to learn that doing so would break someone's existing
tooling which insensibly uses --quiet with plain `git show-ref`.
