Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA582C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 06:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiCVGKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiCVGKE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 02:10:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BAC04
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 23:08:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so22638330ljb.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lcRYnFbCzkbGxeUkuBV2QaUhaSLkW1U8pcbvjwcVh1U=;
        b=jU3HcaFhjktVe89Hx7QX/nYhKXHi/Nkc98/0nTP6gExZghgVypYRhcgJBfbAISmfM4
         lMsZoV606Fsg2Ls1rlNmrNDoduhZvSNdIUmtIxJwNjX+rqdEp0sFyIhw3gj9zhFzMlaO
         EdUKsTWnYkvHK1gsq2Q1ZHvVtzWtuwCOJydqq19R5uox7PAxA0ULz1R+s6BLjWPqINgO
         vL7x7gO7MZWvo/pCp1rRRL0LRa9QGRQW87744ZRVTDxEC48HRaGdffYCDFOI+LF8F/Vi
         h0D+pU38WTYdvHmpcCIfnOwKGXfpEV+2LDz/mRKyvN7s9un+7d0aurGpnBo5oKi6wUCH
         N5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lcRYnFbCzkbGxeUkuBV2QaUhaSLkW1U8pcbvjwcVh1U=;
        b=dZx5j3w89zNYitVvwbFR7Z5ne7OcPH1YhN/6RL3oVcYKPZxAUUzPfhEk9O5Er3Ufok
         H6fr+qgR9XqalQ8wg2qprZO2LJ6X61AIbJYpH0zLKwJJo7x7xEAVzKNMwgA9lhwzDBZD
         fLBSPH3UFaEf69psyFCNeNwm873Fjxjy2MxGDKg2n7AnAf/3K9B7xrXWSkRAxSuh/pSW
         acV65f3EY6WAlldcKFVvm0yIa9/iWEg/j1Dr56dLdRjCpO+6mfOAKAxiuP+cc5vHgfi4
         SsZG+SVT1mMizuT/Ut90D1TkN8FMyErKhK0JRovfpesihOI4tLC64n0Jec2ayAV559Ya
         fkVg==
X-Gm-Message-State: AOAM5333G02uYRxwBc10hQTTh/cZ+2uwtEp55T2qkGoJQ7Qo+aF9RGkd
        0Ehuer+k+IuaUQGmLDnDq2AnWUzK+WbI9SuSYD5VdKbmm7Y=
X-Google-Smtp-Source: ABdhPJzMHZdhoItN8vDqmrqGPTaYIBC5kYAGC/NVETG1pdGFkpXBxGHWfnNQ23/3uRNVr1d0+/KvKzKltUuEoNRn2d4=
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr7583481ljf.315.1647929315263; Mon, 21
 Mar 2022 23:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20220318220623.50528-1-gaurijove@gmail.com>
 <CANsrJQdNKiX93GnVXztmvYQQBxr6-HsYNx5UvYXSFg32Op3ZPQ@mail.gmail.com>
 <CANsrJQe1YuggxdBHdSdukXRj3myVCTNwLiiWNLrAzPpzA4FOOA@mail.gmail.com>
 <220319.86ee2yds2f.gmgdl@evledraar.gmail.com> <CANsrJQdJ1wBThUyJ=QSt6NwU8HzQY2VaWc11UfZQ+ktRQs_YTQ@mail.gmail.com>
 <220319.86a6dlewyj.gmgdl@evledraar.gmail.com> <CANsrJQdqoz7mZ9Fj08owgVWGKs25nPzE1g1dLASL=fz9j485hw@mail.gmail.com>
In-Reply-To: <CANsrJQdqoz7mZ9Fj08owgVWGKs25nPzE1g1dLASL=fz9j485hw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Mar 2022 07:08:22 +0100
Message-ID: <CAP8UFD1+3FWYWZscMgg13T7tYxgB7HKSFiierehdYhuHq54F-A@mail.gmail.com>
Subject: Re: Having grep support the -o option
To:     Jayati Shrivastava <gaurijove@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 20, 2022 at 8:14 PM Jayati Shrivastava <gaurijove@gmail.com> wr=
ote:
>
> On Sat, Mar 19, 2022 at 9:49 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > One thing I'd *really* like to see is the bits of %(if) %(then)
> > etc. extracted from ref-filter.c into some general API other commands
> > could use with strbuf_expand() and friends.
> >
> > I.e. if you could in addition to the strbuf_expand() callback define
> > what verbs you support for "if" and the like, or have callbacks for
> > their comparison functions.
> >
> > Then have that machinery drive the whole format expansion, which
> > eventually would expand your %(some-custom-thing) via a callback.
> >
> > I.e. the whole "valid_atom" state machine in ref-filter.c.
>
> So, the end goal is to design a formatting API that can be used by any
> command that takes --format option?

It might be nice if we get closer to this after your GSoC project, but
I don't think it should become the main goal of the GSoC.

> Previous interns worked on
> unifying pretty.c and cat-file.c with ref-filter.c and so the next task c=
an
> be to extend "valid_atom" state machine to work with more commands.

Note that performance issues have been a really big issue in unifying
cat-file.c with ref-filter.c.

> Do you have any suggestions for new atoms/verbs I could add
> support for or any such similar small exercise to start with?

It would be nice if we first got an idea of the features in pretty.c
that do not yet have something similar in ref-filter.c. I think Hariom
used to show how features in pretty.c corresponded to features in
ref-filter.c, and this helped with deciding about the next steps to
take.
