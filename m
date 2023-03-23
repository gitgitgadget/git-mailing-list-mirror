Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7809CC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCWXW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCWXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:22:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6C1EFED
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:22:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p204so240805ybc.12
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679613734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvw3D6foVOOgbBmzJnIilJn0IlDnQgpTXYnTUok1NIg=;
        b=GEAVSSJkVbGehBDgWQ20HL64vRIuDcFzuSxIs357aZPkm4TOzFgQCNf0c+WtbgB636
         lxKOaOVt+sBOKvRQ1/kpnEBXJDOrhbOAbgAdBKKZBYqD2Rrhjr5SlgIOvAmZMK9lpjR5
         qmyGK9Zr3F2TjRvCWZWyKR1RkjgOOSUpm0sBGHQX2xL2hDd09qiLAk0C1jZkCxV4b0sV
         3YrI90R++UzCrzo4Uj07UPY4NvOhkOFb0/9Rw3mEeGpLybowocC+/YFP/tTbNze9qMEF
         aA/xu/CqI5XHu1my1caWgxeTylw11TV4SRNVq1Z7cbZfQj4H78TF1RRflaISh9FIZfAb
         I5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679613734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvw3D6foVOOgbBmzJnIilJn0IlDnQgpTXYnTUok1NIg=;
        b=ZGwkAoi72G3LP+6k3OnUr3T9sBXEsBFDqQV8IBroez6qyX8RRi4bAPGm8YBZG7hCvI
         UC3C7RjpCyUBA2idNsn+e+7k8qKSRJHktsFKvPuyjBNsX7Jhds36GpnTXqChfTx9CPcM
         nvYwY14keOokz/w5lGwjXdrH+lW5nBOci8OecRkmBBKNJ1WdsROtXZigXm/hMeSY8H/K
         Rx6GXmteajjdAUYrPh7XeXLIJVqkWD29SYSN7uuJFj2g7heVwi0IEozwbJIo8PxE7yG7
         4Nm5Y1Du3JcGcsZ7p5MoP8JIkj/4UsSVdry/xhBatG3vHddO9b03Ali6Lvxwp0mUXYul
         9GJw==
X-Gm-Message-State: AAQBX9dUe9YL95SeFpJMRHGARjoPFPNZPA3/pIZ7bwONE1BO7ZfDUk03
        xOkgYQ2aG6ER3/nnNFa5gH2GmdEqt1yPGMTA+jE=
X-Google-Smtp-Source: AKy350YUM31MacULQNpqBjU06WsCSQa/JIdm2IcAyyJcaui+PzyFtR2gEA0f59s6qFoRwnofoSIc3Zhj/R1tVce2nJ0=
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr225942ybt.0.1679613733834; Thu, 23 Mar
 2023 16:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
 <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk>
In-Reply-To: <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 23 Mar 2023 17:22:02 -0600
Message-ID: <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     phillip.wood@dunelm.org.uk
Cc:     demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2023 at 5:12=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 18/02/2023 01:59, demerphq wrote:
> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Emily Shaffer <nasamuffin@google.com> writes:
> >>
> >>> Basically, if this effort turns out not to be fruitful as a whole, I'=
d
> >>> like for us to still have left a positive impact on the codebase.
> >>> ...
> >>> So what's next? Naturally, I'm looking forward to a spirited
> >>> discussion about this topic - I'd like to know which concerns haven't
> >>> been addressed and figure out whether we can find a way around them,
> >>> and generally build awareness of this effort with the community.
> >>
> >> On of the gravest concerns is that the devil is in the details.
> >>
> >> For example, "die() is inconvenient to callers, let's propagate
> >> errors up the callchain" is an easy thing to say, but it would take
> >> much more than "let's propagate errors up" to libify something like
> >> check_connected() to do the same thing without spawning a separate
> >> process that is expected to exit with failure.
> >
> >
> > What does "propagate errors up the callchain" mean?  One
> > interpretation I can think of seems quite horrible, but another seems
> > quite doable and reasonable and likely not even very invasive of the
> > existing code:
> >
> > You can use setjmp/longjmp to implement a form of "try", so that
> > errors dont have to be *explicitly* returned *in* the call chain. And
> > you could probably do so without changing very much of the existing
> > code at all, and maintain a high level of conceptual alignment with
> > the current code strategy.
>
> Using setjmp/longjmp is an interesting suggestion, I think lua does
> something similar to what you describe for perl. However I think both of
> those use a allocator with garbage collection. I worry that using
> longjmp in git would be more invasive (or result in more memory leaks)
> as we'd need to to guard each allocation with some code to clean it up
> and then propagate the error. That means we're back to manually
> propagating errors up the call chain in many cases.

We could just use talloc [1].

All the downstream code can create objects that are descendents of the
master object, when the "exception" occurs the code is sent back to
where the master object was created, it's destroyed, and all the
children are destroyed as well.

I've played around with both talloc and stack contexts and I don't see
how this isn't doable.

Cheers.

[1] https://talloc.samba.org/talloc/doc/html/index.html

--=20
Felipe Contreras
