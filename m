Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFCEC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 14:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjC3OTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjC3OTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 10:19:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB9126
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 07:19:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id cf7so23684745ybb.5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680185960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqnAn+MEyXOrzzsNmMaW0q4rhHKH49do6Tz6lVxVXJ4=;
        b=Bkj06khK8oQT+wEPH29aBQMIWTzA7+4IzoZNHfJxzZUsUKgRa6um71jbPn0IIlWOsK
         74RQScfOiDq2xAM1MODOkRwDxte/SFqDDfWFRqHrp0E0jEkdzGjZa3Bddw+uY2ADdkRp
         v3k62etnhbQzPUceX/7Uoxmn2eu+fnjokg3Mf441FfNjOqWrLbx1UVg/U2gTzr+gRIkb
         GJTQr44wDJXsLukMs2qEiE8L5ecipq79REM8Nu5sUzMUS7nIJ2/8x34l47+qQxJqJC8P
         VWO7NlLkQITq/lBsDrkJw2NGOy7CMe4pZiDNjCdL9caRTVH1ctwPMLjcxE1l4QKC93z+
         rZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqnAn+MEyXOrzzsNmMaW0q4rhHKH49do6Tz6lVxVXJ4=;
        b=dIKW1BH1/FH/aCPeaNFw7BATnTSw5xSTYeGfHE7i/0nImE+kCMOuKfI223WphXg+OT
         39uVyj3HuHPKzlay04XxOfcR9tn9bEf2eR/kLjgJqfvxzHHFAyTVVCT6aRKwUZu9aDL7
         zXjcMHwKC1mmy72OJKW0uVJ4FwusZBO0VI6nxXan/kJVXFu7ElyNnNeeyan4Ll9A1Ewp
         +Aw9vnvqV17IJkX7lE7EGahCiyVOkNoojMuadEOK3kqCuCc17YsDu6xtLNjEgV7sGHl+
         X4DocqMnkxqkjYe65pgQARp8gzeed1q/kJ+/HATwvg/hORjEbym2nuBalshbdKxFgvn3
         NH+Q==
X-Gm-Message-State: AAQBX9fZGUShtSy3d9601LTd6TXMjmoL1d40x4QRcnM4c2QW/LearMG2
        5qiNbNgpp1xJeF/3cprsqcEGQc1SZb6eq3eNtza/IlrsEUo=
X-Google-Smtp-Source: AKy350Z9rMqspU19wsGDinbCM7Gvv4TatGKc82X+AOj1+oB7XBEF3aZ4CgBY33UdE7LWC42aO1M0RfyaCsOaTFWds4g=
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr15712508ybt.0.1680185959750; Thu, 30
 Mar 2023 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com> <xmqqa5zu4ka3.fsf@gitster.g>
In-Reply-To: <xmqqa5zu4ka3.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 30 Mar 2023 08:19:08 -0600
Message-ID: <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 4:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> While these patches may make it "work" with zsh in its native mode,
> >> because zsh that is running in its native mode is sufficiently
> >> distant from the more POSIXy portable variants of Bourne shells like
> >> dash and bash, I find it hard to justify the cost of maintaining the
> >> resulting codebase to "work" that way.
> >
> > Why do we follow POSIX anyway?
>
> It is not what we follow that is at the primary issue.
>
> The criteria is more about what our developers are expected to be
> familiar with, and what is reasonable to force our developers to
> become sufficiently familiar with.

That is not true.

This patch 77e572653b (t0050: fix printf format strings for
portability, 2010-12-21) fixed a problem that was specific with dash.
Did our developers have to learn the details of such issue? No.

How about f5799e05c0 (git-submodule.sh: separate parens by a space to
avoid confusing some shells, 2011-05-26)? Did anybody have to learn
that `((foo` causes problems in ksh in order to apply the patch?

No, these patches fixed specific issues for specific shells, and did
not affect what our developers were expected to be familiar with.

> It is my impression, however, that zsh in its native mode is even
> further out and away, pushing it on the other side of the line of
> being reasonable to force our develoerps to adjust to.

Just because it's your impression doesn't mean it's true.

> What they will learn through such an effort would be more of "what to
> do when you are forced to use zsh" than "how to write your shell
> script portably".

No, they don't have to learn anything, just like they don't have to
learn that ksh93 returns signals that are 256+n: 0e418e568f (t0005:
work around strange $? in ksh when program terminated by a signal,
2010-07-09).

You just picked the patch that fixed a specific problem for a specific
shell, and we all forgot about it.

> > Is there some sort of predisposition against zsh?
>
> There isn't.  If somebody makes the tests to also work with csh or
> /bin/sh on SunOS, I would pretty much say the same thing.

Except you did pick the patches that fixed specific issues for these
shells when the existing code was already compliant with POSIX.

--
Felipe Contreras
