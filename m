Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E37C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiCWRrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiCWRrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 13:47:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F871EF7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 10:46:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so4017311lfb.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ozdxb2nA9BFXJSJlmQhH1M31U3M5rfreijpKmv782CY=;
        b=GZBWbzTLqc2iCcLftTSmMR9WY0C8jx8lFkznPCw6lNDWmeWSXE1p61AaMuS2XW7azQ
         0nLtMBa0XrOc0Za4hhdGR7jU+NwkTSTcasRZhcEz3Xw1CXv8rTzg8QikgqRfnu3gY7Ou
         x3QWtAKKvnZiUcueR65zuzfBVyZatKuG5bGu2VXKXGzNXtkoixk1F5tmQzWxN9tmIslE
         B+jBnMJzasSHhfb20lZfGjTFzub1j+P0W2OiNddlh1tREvv9ngIrV/Ms3rSxJj388lWE
         2KEpdG/woeMHk5ks5u38ifR5Gt2XmKrBhl+Zu3tlY4kouWnlgRRFNSoSGs+IWokbi0YD
         TJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ozdxb2nA9BFXJSJlmQhH1M31U3M5rfreijpKmv782CY=;
        b=heDV19FFIVxtsmJc3/XDLF1UGSRGntSFmJMACxKc+sSSAg0kiLwECmwQE9cyEGTSJD
         WxiwL13x/FhuqocRCEwHfkiP2+knJ8nYlXZCqwbn5pov/j20QwhO7qmmXKnQGowkW+L/
         9gzV6usXDJBZ2b65OgkbuKNfzfF85bk3P7E7wQgvQf5rqVd9zB9gSLQiHjpSEuPtz1Tn
         1srqO9+LVBNhBNb3ayC8RybldXILRqRkFUsYPYG3e81la0ARLH9aYdOLeCFr6R7lzg9x
         U0/0EL07Vd3CY+fXvsD17bpQqPElTdtamjw2ngIzxjTAWilLMsHWf40l0XcZJuq4AHdp
         sHkA==
X-Gm-Message-State: AOAM530Lrrs0q7RKQON94g/iCvneL0MVhpWzDYK29F2KCT3JQCFCjaDD
        Rz8prsdXHS8fgsL30fV5iQClfwgYPqm9towZL0uATYD5apooOw==
X-Google-Smtp-Source: ABdhPJyUAk3M9gN/rxj7aRBemMBfosijOrpZHztqIgFI64At4t9ggM6xWnD0dZ2lHXvN+vK4O3hCpz/zeUTnui46eiA=
X-Received: by 2002:a05:6512:3402:b0:448:970:c3a5 with SMTP id
 i2-20020a056512340200b004480970c3a5mr747692lfr.576.1648057568496; Wed, 23 Mar
 2022 10:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20220318220623.50528-1-gaurijove@gmail.com>
 <CANsrJQdNKiX93GnVXztmvYQQBxr6-HsYNx5UvYXSFg32Op3ZPQ@mail.gmail.com>
 <CANsrJQe1YuggxdBHdSdukXRj3myVCTNwLiiWNLrAzPpzA4FOOA@mail.gmail.com>
 <220319.86ee2yds2f.gmgdl@evledraar.gmail.com> <CANsrJQdJ1wBThUyJ=QSt6NwU8HzQY2VaWc11UfZQ+ktRQs_YTQ@mail.gmail.com>
 <220319.86a6dlewyj.gmgdl@evledraar.gmail.com> <CANsrJQdqoz7mZ9Fj08owgVWGKs25nPzE1g1dLASL=fz9j485hw@mail.gmail.com>
 <CAP8UFD1+3FWYWZscMgg13T7tYxgB7HKSFiierehdYhuHq54F-A@mail.gmail.com> <220322.86a6dintod.gmgdl@evledraar.gmail.com>
In-Reply-To: <220322.86a6dintod.gmgdl@evledraar.gmail.com>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Wed, 23 Mar 2022 23:15:56 +0530
Message-ID: <CANsrJQc0c5w5iA99L_L8QpZTh_vSkDwXoq7zm2mKkZQtxzUH3Q@mail.gmail.com>
Subject: Re: Having grep support the -o option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 4:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Mar 22 2022, Christian Couder wrote:
>
> > On Sun, Mar 20, 2022 at 8:14 PM Jayati Shrivastava <gaurijove@gmail.com=
> wrote:
> >>
> >> On Sat, Mar 19, 2022 at 9:49 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> >> <avarab@gmail.com> wrote:
> >> >
> >> >
> >> > One thing I'd *really* like to see is the bits of %(if) %(then)
> >> > etc. extracted from ref-filter.c into some general API other command=
s
> >> > could use with strbuf_expand() and friends.
> >> >
> >> > I.e. if you could in addition to the strbuf_expand() callback define
> >> > what verbs you support for "if" and the like, or have callbacks for
> >> > their comparison functions.
> >> >
> >> > Then have that machinery drive the whole format expansion, which
> >> > eventually would expand your %(some-custom-thing) via a callback.
> >> >
> >> > I.e. the whole "valid_atom" state machine in ref-filter.c.
> >>
> >> So, the end goal is to design a formatting API that can be used by any
> >> command that takes --format option?
> >
> > It might be nice if we get closer to this after your GSoC project, but
> > I don't think it should become the main goal of the GSoC.
>
> Agreed. FWIW this is off-list discussion between Jayati and myself which
> started with her asking (and this was omitted in the context that made
> it on list:
>
>     [...] Infact, I'll be excited to work on anything you suggest even
>     if its not related to the project, as it will help me get familiar
>     with the codebase and the contribution process at Git.
>
> So that suggestion of mine of generalizing ref-filter.c wasn't meant to
> distract from the GSoC project, I understood her to be looking for
> suggestions for things to work on that were *not* part of the GSoC
> project.
>
> So I suggested that ref-filter.c task, which is orthagonal, but relates
> to some of the same code.

I understand this might be out of scope for the gsoc project but I=E2=80=99=
ll
try to work in the
general direction of it.
I have been going through Hariom=E2=80=99s work from last year. He has
mentioned some failing
log tests for the new pretty library he implemented. I am currently
attempting to understand
these failures.
