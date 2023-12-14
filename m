Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23193
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:44:55 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77f35b70944so473939885a.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543494; x=1703148294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/GTZt/EG0rQMmPjbKTKJk5nVIEL6AHm1IKgdAx7yLU=;
        b=xISKVAzhL1WyfLn4FiwmTWA7xx9Crb8fH9mWrshMUfJ+ZWcCiSIIFr0IRvF7kxgS3n
         QoPMCgIkWs/1nNYoI4EH0wMlbSuZxFO7EsX7Vi9jaqb3Bu9fbqgJOEE020TYfe1lz9s/
         c2ofPmrCUC4UL4I6I8Uqhw8l/yXtj0F1uXsHPTyBIM+ZKh6PerznT70CO6M+UazyYZ0R
         8nOcB+5lRK2ooT0CKI4vRppYwTUDtrxmYO0TVHzs4oYrYUebMy6q7cOmPp+hS5Ebw+Vr
         BRPvy/H7Q0JuW9ZwnCRFiYBon09354yDWsYxgVkVz2IusNDsG7gbzwYHn13JODXD6cfX
         VUJw==
X-Gm-Message-State: AOJu0Yzz4kHPW9lBoqJPPqRYQKTHTh0Sfas4xO/CvxEJq5HEsKeyCPwV
	mvQnAxnVv7FsabjcUH9D/gvUjXJ9j11oO6Tei58=
X-Google-Smtp-Source: AGHT+IF2KaYOl9NMWFbzqhH/5J6yVM4WrQzbBJJu3nhG0yBY5eRNQnLNPPSVmjgRfKDujMxUuyaOVY5FpVPsjt6CW2Y=
X-Received: by 2002:ae9:f715:0:b0:77f:4ca9:bc2f with SMTP id
 s21-20020ae9f715000000b0077f4ca9bc2fmr10566308qkg.126.1702543494393; Thu, 14
 Dec 2023 00:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <aec86a15c69aa276eee4875fad208ee2fc57635a.1702542564.git.ps@pks.im>
In-Reply-To: <aec86a15c69aa276eee4875fad208ee2fc57635a.1702542564.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Dec 2023 03:44:43 -0500
Message-ID: <CAPig+cTZmiXdPZEVO-F2UzV9YaP6c7r2MfPTC3QWksJa+rM7VA@mail.gmail.com>
Subject: Re: [PATCH v2] tests: adjust whitespace in chainlint expectations
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> [...]
> Instead of improving the detection logic, fix our ".expect" files so
> that we do not need any post-processing anymore. This allows us to drop
> the `-w` flag when diffing so that we can always use diff(1) now.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/Makefile b/t/Makefile
> @@ -108,15 +108,7 @@ check-chainlint:
>         } >'$(CHAINLINTTMP_SQ)'/expect && \
>         $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
>                 sed -e 's/^[1-9][0-9]* //;/^[   ]*$$/d' >'$(CHAINLINTTMP_=
SQ)'/actual && \
> -       if test -f ../GIT-BUILD-OPTIONS; then \
> -               . ../GIT-BUILD-OPTIONS; \
> -       fi && \
> -       if test -x ../git$$X; then \
> -               DIFFW=3D"../git$$X --no-pager diff -w --no-index"; \
> -       else \
> -               DIFFW=3D"diff -w -u"; \
> -       fi && \
> -       $$DIFFW '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
> +       diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual

This change feels incomplete. Yes, it "corrects" the whitespace, but
check-chainlint still applies sed to remove blank lines and strip the
line numbers from the beginning of each line. Based upon the commit
message, I had expected that all post-processing of the output would
have been eliminated and that the "expect" files would exactly mirror
the output of the linter.

As mentioned elsewhere[1], I'm not particularly in favor of this
approach, though I won't stand in the way of it either.

[1]: https://lore.kernel.org/git/CAPig+cSkuRfkR2D3JqYcbaJqj485nfD9Nq6pM=3Dv=
XWB5DJenWpA@mail.gmail.com/
