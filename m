Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB803C47082
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75F66052B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhEXBTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 21:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhEXBTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 21:19:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9E7C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 18:18:06 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so23681497oth.8
        for <git@vger.kernel.org>; Sun, 23 May 2021 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CHN7LSXKDhKwxGawlupEmWIeVpeeHAMe1+4jDEIVSfE=;
        b=smZfXJlzfJMc/Jp7QxO0Jf61GwYKPNbwh4FpEKfNgduWj8zFCSTzKrF6BDqs6OwrZ2
         6Oe4gBOPtN1H33yYC5TYWUHVHJpTLou9FsAInP57oD+WgmgOc4QQTNsiH2TgUo8Qkthc
         wy0aniEMt95hfpbKTFVUNGvvwL+fB003yWtKAr4IdsSgwr5/WeneJx1aCT+3rjlGLC/K
         3cb/G8s5syMC0V01kUa47BBPXJMhaF4mkIO7ptY/pT5MDAaV+7tVdW+noNDMYolnuONu
         9+XeD9LK26IOh7A5GUASG51p15aFdRxAqDFGaeGJ1Ku256bnaj34xcGzM2nhrUdJnvTe
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CHN7LSXKDhKwxGawlupEmWIeVpeeHAMe1+4jDEIVSfE=;
        b=myuL4tj32Y7xsd1ha+exKONuv4nPi502SXtXIQ6A979l8Kwq5nSGMCcacVGxgARolO
         7GuteT9sqbQ5bIVEsNBDiptC+nfo3ZC3QPGDR/R+6Ig0oFldURc/v1hYeaLxRof4JNYf
         gTR3iDO43+MrtnaKJA+FLqYWq4/nfqoSIebD9S35BlGqkpekxMr1FwK8anOAGLsny8vp
         cfxmX4B/SosQLW17Qro3gJrPWZ6nF4Zxl/iE7KLUF6quD0stwzQzVDkVae6PtjeU70Hd
         yQ2dHkzzb9haFak6ZlzHk6DZVyMo9ly6EWFJk0wCv8Bgd00oa9zcAco3nEPCBufZX1Ui
         UPFw==
X-Gm-Message-State: AOAM530PuihyzXBx4Q65Q/w+f7hdmRUsuN3z8mpJ8DEI6ohKbBWAKa6+
        a6J5eQGEuWywkF+lUckEXK4=
X-Google-Smtp-Source: ABdhPJzwdLDh3gki52rhZT0u7DJ2Al6FmXXtm1Hk+u5CZBjC84GNvj0glbJUfAtiy6dd6bDZ4xQcfQ==
X-Received: by 2002:a9d:4b8a:: with SMTP id k10mr17076090otf.131.1621819085487;
        Sun, 23 May 2021 18:18:05 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q5sm2177205oia.31.2021.05.23.18.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 18:18:05 -0700 (PDT)
Date:   Sun, 23 May 2021 20:18:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60aafecba4279_8eb820875@natae.notmuch>
In-Reply-To: <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-23 at 18:36:10, Felipe Contreras wrote:
> > Johannes Schindelin wrote:
> > > On Fri, 21 May 2021, Derrick Stolee wrote:
> > > > On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
> > > > > On 21/05/21 05.13, L=C3=A9na=C3=AFc Huard wrote:
> > > > >> The existing mechanism for scheduling background maintenance i=
s done
> > > > >> through cron. On Linux systems managed by systemd, systemd pro=
vides an
> > > > >> alternative to schedule recurring tasks: systemd timers.
> > > > >>
> > > > >> The main motivations to implement systemd timers in addition t=
o cron
> > > > >> are:
> > > > >> * cron is optional and Linux systems running systemd might not=
 have it
> > > > >> =C2=A0=C2=A0 installed.
> > > > >> * The execution of `crontab -l` can tell us if cron is install=
ed but not
> > > > >> =C2=A0=C2=A0 if the daemon is actually running.
> > > > >> * With systemd, each service is run in its own cgroup and its =
logs are
> > > > >> =C2=A0=C2=A0 tagged by the service inside journald. With cron,=
 all scheduled tasks
> > > > >> =C2=A0=C2=A0 are running in the cron daemon cgroup and all the=
 logs of the
> > > > >> =C2=A0=C2=A0 user-scheduled tasks are pretended to belong to t=
he system cron
> > > > >> =C2=A0=C2=A0 service.
> > > > >> =C2=A0=C2=A0 Concretely, a user that doesn=E2=80=99t have acce=
ss to the system logs won=E2=80=99t
> > > > >> =C2=A0=C2=A0 have access to the log of its own tasks scheduled=
 by cron whereas he
> > > > >> =C2=A0=C2=A0 will have access to the log of its own tasks sche=
duled by systemd
> > > > >> =C2=A0=C2=A0 timer.
> > > > >
> > > > > For gender neutrality, we can use he/she instead.
> > > >
> > > > Singular "they" is better. Fully accurate and less awkward.
> > > =

> > > I agree.
> > =

> > I disagree.
> =

> I'm fully in support of singular "they".

To each her/his own.

> It provides a useful pronoun to use in this context, is widely
> understood and used, is less awkward than "he/she," and is less sexist
> than the indefinite "he."

I disagree. But I wouldn't presume to dictate how other people speak.

If you like it, use it.

> > > If the singular they was good enough for Shakespeare,
> > =

> > Shakespeare:
> > =

> >  1. Did not know gammar
> >  2. Invented words as we went along
> >  3. Was no writing prose
> =

> The point is that it has been used by native English speakers as part o=
f
> the language for over half a millennium and is widely used and
> understood.

A similar thing happens with the word "nucular" [1]; it is used by
native English speakers as part of the language for many decades and is
widely used and understood.

Does that mean it's a valid word? Maybe.

But does that make "nuclear" invalid? No.

You can use "nucular" if you want (many people do). I will use
"nuclear".

Both can be valid.

> This usage is specified in Merriam Webster[0]:

Merriam-Webster is not infallible.

But fine: let's say they are correct.

Where does it say "they" is *better*? Or worse: where does it say
"his/her" is discouraged?

> > The singular they is a controversial topic[1][2], even among linguist=
s.
> > This is a software project, we must not make decrees about proper use=
 of
> > English language, especially when linguists themselves have not yet
> > fully decided.
> =

> Linguists fit roughly into two camps: prescriptive and descriptive.

I am perfectly aware of the two camps, and I have written about it.

> While I am not a linguist, I have a B.A. in English, and my views fit
> firmly into the descriptivist camp.

If you are a descriptivist (as am I), then you must acknowledge that
people use "his/her" *today*.

As a descriptivist you shouldn't dare to _prescribe_ how people use words=
.

Therefore, if I use "his/her" (as many people do), you should not
prescribe otherwise.

> Since we are writing text for an English language audience who are
> mostly not linguists, we should probably consider using the language
> that most people will use in this context.

Consider, yes. Dictate? No.

And you don't know how *most* most people speak. Your guess is as good
as mine.

> It's completely fine for a contributor to propose that they think an
> idea is better provided that they do so in a respectful and considerate=

> way, which I think happened here.

If you say you think **in your personal opinion** that A is better than
B, that's fine.

What was stated here was "A is better". So that's not what happened.

> I think it should be fine to use singular they here.  You are, of
> course, free to feel differently.

I do feel differently, but I would not presume to dictate that B is
better; I argue both A and B are fine.

 A. he/she
 B. they


To be perfectly clear; I'm not saying you shouldn't use B; I'm saying A
is fine.

Cheers.

[1] https://en.wikipedia.org/wiki/Nucular

-- =

Felipe Contreras=
