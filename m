Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0728DBA
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f9f6caabcso3570626d6.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 10:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391491; x=1704996291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMH+qvViYarD1IIRYumnhGj5VFsB4afS89Zpthy6SdY=;
        b=aF3UeGS4xAEnVQ0FprBtuoBo6PyZxMdav62JQk8uJkKfEkC103y40A//Wn3L+NffDW
         vYd+5gIRohHTy4wl657+d+VDr8xTlhmmuTiy7sKAMkX/nB8e9ZBhEyzDYCeDbxCsMjcZ
         MQ5Q0LuvUbMj70+nUq42IN4PPpODMe4uKZTDtt3zWJ+hFmFuHv0+a0z9a0pJb7uaURj8
         /As27DKwYnic4cSz4aDGLXKDiSQf5aledHn3nSWstLgehP+ZKqdVsRAS2Grn8FEETMWa
         m8kcg+0kQy+CivIUsFhrBvdl1BSN8DHeVVYUdfdGYbYxiEo16sZYYQakKfInGlGZBnoR
         2vsw==
X-Gm-Message-State: AOJu0YwW+oaEMh8Sz4mib7RcHjx2t4AE5m9N/Ithpvigadk+nfN8mP5s
	NpkeBoMDm9yGQiTfxlCQgH2kBtbujwTftud0mv9W/ULwdLk=
X-Google-Smtp-Source: AGHT+IGn1IIlg7o0zbr6c25TqTET3k6indXWZRDCZvo6WvYb8ul4hhBnenK6TuK3rWIcf8QVvY9eUs7XS8x93JjXHmk=
X-Received: by 2002:a05:6214:27ef:b0:680:ce74:9513 with SMTP id
 jt15-20020a05621427ef00b00680ce749513mr803141qvb.44.1704391491105; Thu, 04
 Jan 2024 10:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu> <20240104143656.615117-1-dev@tb6.eu>
 <ZZbr4yAJe0dnHRcO@nand.local>
In-Reply-To: <ZZbr4yAJe0dnHRcO@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 4 Jan 2024 13:04:39 -0500
Message-ID: <CAPig+cQw1pyYJr2Ma40udU2wUczS67Hs4JHdMG86R7t6ZECypw@mail.gmail.com>
Subject: Re: [PATCH] fetch: add new config option fetch.all
To: Taylor Blau <me@ttaylorr.com>
Cc: Tamino Bauknecht <dev@tb6.eu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:33=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> On Thu, Jan 04, 2024 at 03:33:55PM +0100, Tamino Bauknecht wrote:
> > +cat > expect << EOF
> > +  one/main
> > +  ...
> > +EOF
>
> It looks like these tests match the existing style of the test suite,
> but they are somewhat out of date with respect to our more modern
> standards. I would probably write this like:
>
>     test_expect_success 'git fetch --all (works with fetch.all =3D true)'=
 '
>       git clone one test10 &&
>       test_config -C test10 fetch.all true &&
>       for r in one two three
>       do
>         git -C test10 remote add $r ../$r || return 1
>       done &&
>       git -C test10 fetch --all &&
>       git -C test10 branch -r >actual &&
>       test_cmp expect actual
>     '

If you (Taylor) were writing these tests, you would also create the
"expect" file inside the test body:

    test_expect_success 'git fetch --all (works with fetch.all =3D true)' '
        cat >expect <<-\EOF &&
          one/main
        ...
        EOF
        git clone one test10 &&
        ...

The <<- operator which Taylor used in his example allows you to indent
the body of the heredoc, so it can be indented the same amount as the
test body itself.
