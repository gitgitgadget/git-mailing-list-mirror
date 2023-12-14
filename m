Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18520E3
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:39:29 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67ad531686eso3196466d6.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543168; x=1703147968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0U4T48WSEdpm2d+a0f8yS0jcE4003FE5iR39vUt3h8=;
        b=AvpkBprhpds7TS3yAJQGLzTUBOZ+tAC0ETzdZwTuXZb0YttRxCBo5m3DPMLAuM7mUe
         rUETnjrlfAFookmkDH/IhLMkjTAH2q1Y+D0V9tVPuwttS7FG/qwPmpuTJXj/apmbFV+Z
         GEhIqVkRFBQaWKqO6+jHi56hm/icqz5bq1hWGxkIwcWNYLT9oTYpslymtg1VM+qwJvC/
         iYt94tZ05jmxDV3Pcw4/WygX0DoQ1CNrj81SgRkdOa5nwPPh4KeuM/rK+vG06RwjoHiP
         EI55uyNPv5+qK2ilQaH7vmRjWwCDs59u4ucmbnGGjWvM4t6e9HbTaSsUbwYDpT12tcaZ
         7UJQ==
X-Gm-Message-State: AOJu0YyxddqCML6IEq+rCbjElFWCs5XHJbmYz58qpVfnKJwEU1Ey2l2b
	ZvFYQxRcTeMK4LQlOB3BmA2Awd0S/LPJVuQokDU=
X-Google-Smtp-Source: AGHT+IHZTuH5OQW2UbYVWvPKvP97LgktY5S2qeGmAv6IVAkLqQ57rTX+aiGNoofytWQ4LyjcXFZ7DnYmC8X5DFPrSLE=
X-Received: by 2002:a05:6214:29ea:b0:67a:a72d:fbb5 with SMTP id
 jv10-20020a05621429ea00b0067aa72dfbb5mr15913369qvb.51.1702543168172; Thu, 14
 Dec 2023 00:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki> <xmqqr0jqnnmn.fsf@gitster.g>
 <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com> <ZXq5GL723v4E3_IH@tanuki>
In-Reply-To: <ZXq5GL723v4E3_IH@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Dec 2023 03:39:17 -0500
Message-ID: <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Wed, Dec 13, 2023 at 10:33:00PM -0500, Eric Sunshine wrote:
> > On Wed, Dec 13, 2023 at 10:11=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> > > Mostly because your "differences in features supported by just-built
> > > one and what happens to be on $PATH can cause problems" cuts both
> > > ways [...]
> >
> > I sent an alternative solution[1] which should sidestep this objection.
>
> Thanks, I've replied to the thread. I think by now there are three
> different ideas:
>
>   - Improve the logic to pick some kind of diff implementation, which is
>     my patch series. It would need to be improved so that we also probe
>     whether the respective Git executables actually understand the repo
>     format so that we can fall back from the just-built Git to system's
>     Git.
>
>   - Munge the whitespace of the expected results with some regexes.
>     I like that idea better because we can avoid the git-diff(1)
>     problem, but find that the result is somewhat hard to read.
>
>   - Fix the ".expect" files so that we can avoid all of these games.
>
> I actually like the last option most. I'll have a go at it and send this
> third version out in a bit.

I sent a reply[1] in the other thread explaining why I'm still leaning
toward `sed` to smooth over these minor differences rather than
churning the "expect" files, especially since the minor differences
are not significant to what is actually being tested. That said, I
won't stand in the way of such a patch to "fix" the "expect" files,
but it feels unnecessary.

[1]: https://lore.kernel.org/git/CAPig+cSkuRfkR2D3JqYcbaJqj485nfD9Nq6pM=3Dv=
XWB5DJenWpA@mail.gmail.com/
