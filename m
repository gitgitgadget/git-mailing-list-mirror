Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4370EC3
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393ADD69
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 17:11:14 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d093265dfso19634606d6.3
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 17:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699143073; x=1699747873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esLi7LANcI1uI6TbcxKs9UF9QyMg0kEX60UixflTEW4=;
        b=Ac2DCqxxbBFUb3LMOTZCi2dM9KfX0zNNaZ4NuuYcXqvJ03eVHebuVdyYL1ejseGw9f
         GGWcyDimwoQA+SiB7pcwCFwLWgdxlRNfH/s9VS+0lQJ0djcV2KO3TpKpqebcNUu3tdYc
         IKDxSSC3wbWsFazthITOljJDCFOxsK4IsRqcYNbGFo/UyuIJFmWDaXxl+xFhqMhxSkjW
         NXxEr1ihE4jeYx1bVWf63w6oZgNsSMJO77xvhINPjSNFhxeFVqMKBnevM0ZR8N1jjFf8
         2tRDmFCjyONmYROXzzcdvQCeg/Q190xAsltdgBjeYyx+s8JVDCg4VtykcckEBvrwzbN0
         8Stg==
X-Gm-Message-State: AOJu0YwVfrbsdcNKWuy3tu/IKkGvK7V7OzKLQiPPVeTQMgPxZLA5lC3b
	1IpluCGZcIrO+vV2jzl9NYUIq3DciZ7dsmAEEnk=
X-Google-Smtp-Source: AGHT+IF8tiacomJ0L/P8xONcWeQNxUgFMAp6nZMwswl5FrvBjqNm/FqST4+3RI5TvC2qmDbcpYyRXShpqYmSuRy+wZk=
X-Received: by 2002:a05:6214:252d:b0:672:a9f4:2a8f with SMTP id
 gg13-20020a056214252d00b00672a9f42a8fmr24225939qvb.47.1699143073231; Sat, 04
 Nov 2023 17:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
 <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com> <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
 <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com> <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
 <20231104134915.GA1492953@coredump.intra.peff.net>
In-Reply-To: <20231104134915.GA1492953@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 4 Nov 2023 20:11:01 -0400
Message-ID: <CAPig+cTy7Mq1xhTtssoUDpwrCNB_65q4VjK902jOpJ4469_tLw@mail.gmail.com>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 9:49=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Sat, Nov 04, 2023 at 02:36:48AM -0400, Eric Sunshine wrote:
> > I don't see an urgent need for it. Unlike the actual tests themselves
> > run by `make test` which may catch platform-specific problems in Git
> > itself, the purpose of the "linting" checks is not to catch
> > platform-specific problems, but rather to help test authors by
> > identifying mistakes in the tests which might make them fragile. So,
> > disabling linting on a particular platform isn't going to cause `make
> > test` to miss some important Git problem specific to that platform.
>
> Hmm. With compilation, we split the audience of "developers" vs "people
> who just want to build the program", and we crank up the number and
> severity of warning checks for the former. We could do the same here for
> tests. I.e., turn off test linting by default and re-enable it for
> DEVELOPER=3D1.

My knee-jerk reaction is that this would move us in the wrong
direction since it is probable that most drive-by contributors won't
have DEVELOPER=3D1 set, yet they are the ones who are likely to benefit
most from test script linting (which is not to say that it doesn't
help seasoned contributors, as well).

> OTOH, this is the first time I think I've seen the linting cause a
> problem (whereas unexpected compile warnings are much more likely, as we
> are depending on the system compiler's behavior).

There have been a few other times when the linting scripts have needed
a tweak or two to work properly on some less-well-represented
platform, but they were minor issues[1,2,3,4].

> So consider it an idle thought for discussion, and not necessarily a
> proposal. ;)

As noted in my response to Junio[5], in the long run, we may want to
go with =C3=86var's idea of having `make` track changes to the test
scripts, thus only run linting on an as-needed basis.

[1]: a3c4c8841c (tests: use shorter labels in chainlint.sed for AIX
sed, 2018-08-24)
[2]: 2d9ded8acc (tests: fix comment syntax in chainlint.sed for AIX
sed, 2018-08-24)
[3]: b3b753b104 (Fit to Plan 9's ANSI/POSIX compatibility layer, 2020-09-10=
)
[4]: 1f51b77f4f (chainlint.pl: fix /proc/cpuinfo regexp, 2022-11-22)
[5]: https://lore.kernel.org/git/CAPig+cSC8m5a8PhMw_eJbswwNB-VgBt+n56HSTLLa=
bV9_+y--g@mail.gmail.com/
