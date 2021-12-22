Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EFC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 23:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhLVXla (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:41:30 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:36778 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhLVXla (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 18:41:30 -0500
Received: by mail-io1-f43.google.com with SMTP id p65so4935629iof.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 15:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR0+aaujjYNUq0NwLQwbLjkx+ieeJ9YrQIsK+VrLGEw=;
        b=F0BvOgRyOqEmWbf+5UKToGq4hwGybLmaLy+vD43p3gL3w9f2umqM3VB0DvfFjWhWNq
         PT29IkS/k6aNwhoi6WB6W4Jr6USYqpLX6F6abh3cskaj2stplhEwSenyeusBLtZWdGu+
         yHEqAFmwIsW+eG5UXAMg6kPbmVySyG+LsfZ1JP1HpI//dtMUX7KrlNKkV9Bs+rrMX0Em
         o+3VRRe8H63ETatugBUDn4hj09arQYZm5/7qE+OwnITUPtyRDbRebGPvbnKZ93OYHxtc
         IBkUA8Hf0hJLk6XhbyyLKS+ou7k3a2/jZqOMkHO+MDuG8M9Nse2KKhGJ0mnIp/zXpvUX
         AbJw==
X-Gm-Message-State: AOAM530EMV7I3AvQVLuyW85Vyy6vPoRvKO8tQS3e2KUQuLZfZojMmygd
        /hSt8v9RJh7C3GS0XlPf0jMrYt1mT/w7AlubEtPvlqCAbZk=
X-Google-Smtp-Source: ABdhPJxIuMlboNpfxi42CDNrNU2+lKh+ydjoHVQ7sSibiolDVp7hYpO0aUKgxJyD1aJocBe3GR5JvHpK4DhMtkn/puY=
X-Received: by 2002:a05:6602:1588:: with SMTP id e8mr3969iow.181.1640216489380;
 Wed, 22 Dec 2021 15:41:29 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com> <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet> <xmqqczloju0q.fsf@gitster.g>
In-Reply-To: <xmqqczloju0q.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 23 Dec 2021 00:40:53 +0100
Message-ID: <CA+JQ7M-8LydHMCgMYGP9LNMJMWk_-7LLYa5WEMMb_QMpeF-+Ag@mail.gmail.com>
Subject: Re: Custom subcommand help handlers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another observation.

This also applies to external aliases
  git -c alias.fr='!git-filter-repo' fr --help
returns
  'fr' is aliased to '!git-filter-repo'
 w exit code 0

On Wed, Dec 22, 2021 at 8:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 20 Dec 2021, Junio C Hamano wrote:
> >
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>
> >> > I should point out that in most cases on Unix, it _is_ expected that you
> >> > install your manual pages into the same place as everyone else, so in
> >> > this case, installing the HTML documentation alongside Git's may be the
> >> > best solution.
> >>
> >> Yup, that sounds like the most sensible way to do things.
> >
> > So what about `~/bin/git-my-reply-to-junio`? Do we expect people to write
> > a manual page and install it into `~/man/man1` and for `man` to pick that
> > up?
>
> Yes, if they write one, and then tell man that you have extra
> manpages there via MANPATH.
>
> I expect people *not* to write a manual page in practice for such a
> thing, though ;-)
