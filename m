Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A84C77B7F
	for <git@archiver.kernel.org>; Sat, 13 May 2023 05:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjEMFcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 01:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEMFck (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 01:32:40 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C930DE
        for <git@vger.kernel.org>; Fri, 12 May 2023 22:32:38 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-192b330a577so4430002fac.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 22:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683955957; x=1686547957;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3IQP6stSaS+Cj3hY2lx3wDlrdtunq2CsGn4omoEQ7A=;
        b=pQK57UM0g7Ouy86GhcQoG+lGFVNpaXfhgshvTR2rgpsS52V2HHW5VDX2j10ePes2Wj
         3o04Cckw8k5583UOx/Mz/grmdVitFQVZLB9OBxSc+ZlY9fu/lClnAiRTxblMXcscklvW
         +xTjzR3v9xB6wlTJd8FGYGEaCc9wwjtHX8OWfjk0UWaTNt22WX2R3eO2n5XZMUhGu2UM
         viW+G1e0eJ9sQNauvOhvUXfxcsXy20vP4yG3vbovvXgcgEzYg7gNNaQAm+eiXRJBXNJQ
         RKJeTbB/HdCwwgbg8XXYVGVU/6wzwb6Wuj7tSNdELGL4pMRp957o/HoZCQ6j+4xa9Dgu
         V/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683955957; x=1686547957;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G3IQP6stSaS+Cj3hY2lx3wDlrdtunq2CsGn4omoEQ7A=;
        b=Rum4csCQxsnioC0D8a30oc9qL+MQfg/FXAK4Lpyf3FwOZK+S8zNhM16+cxc/3RHEyf
         O4Zicg0ZmmUPfGa4Crddjkugrtl6+YYtG0H2R6im5cX0alF6ChvTdLQKr3l1G1q9olDS
         uGPIS4nzNG/rAgul3x2o29Hy6I7waB+hT2pf27++hJu+JkvP8dy+/bqrKkzuWAT37E40
         ffNbw5cqPWKVMuhhXybVS4GeCPb6CtAGmFTHd0b2HM8vPRk2kxRZYEXBwuRcaovbz5Ts
         HLSuB8PPLLUGVYshJF8fDDlBrEY979RVyWVqrScBxqxEJaU3F4IzLxuLNT1YtFi8QaDS
         87Rw==
X-Gm-Message-State: AC+VfDwrhxyiEftFuMBx/esbexSjuvEcgXW7jaQdqG+A/mZpGHZd2eSj
        MmC7XaojStPjCXKGMCSxSWo=
X-Google-Smtp-Source: ACHHUZ5JqG3Pwov90yL91wfljeNWHCcxzxvPuBGH/e0VrptHyprUNmFaD7ytVVxce4kyCw6FKsrJfg==
X-Received: by 2002:a05:6870:301:b0:18e:b833:4e12 with SMTP id m1-20020a056870030100b0018eb8334e12mr12777850oaf.24.1683955957354;
        Fri, 12 May 2023 22:32:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870864500b0018b03bf5f97sm9800421oal.41.2023.05.12.22.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 22:32:36 -0700 (PDT)
Date:   Fri, 12 May 2023 23:32:35 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <645f20f332476_21e719294d8@chronos.notmuch>
In-Reply-To: <xmqqpm77zlec.fsf@gitster.g>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
 <6459c31038e81_7c68294ee@chronos.notmuch>
 <xmqqjzxgzua0.fsf@gitster.g>
 <645c25dcb590b_7b63e294ea@chronos.notmuch>
 <xmqqpm77zlec.fsf@gitster.g>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> >> The "author" refers to the author of the "proposed log message" of
> >> the patch in question, i.e. me in this case.  The author of the
> >> patch under discussion thinks it is, so asking "Is it?",
> >
> > This is the full quote:
> >
> > ====
> > Let's fix the interactions of these bits to first make "-s" work as intended.
> > ====
> >
> > If instead you meant this:
> >
> > ====
> > Let's fix the interactions of these bits to first make "-s" work as I intend.
> > ====
> >
> > Then that's not a rationale, you are essentially saying "let's do X because I
> > want".
> 
> This will be the last message from me on this.  I wouldn't have even
> seen the message I am responding to, as I've already done my "once
> every few days sweep the spam folder to find things to salvage",

Comment that breaks the code of conduct:

 * Demonstrating empathy and kindness toward other people
 * Being respectful of differing opinions, viewpoints, and experiences

Is the maintainer exempt from following the code of conduct?

> I didn't say and I didn't mean "as I intend", and you know that.

No, I don't know that, because I don't make assumptions.

You said this:

====
  >> Let's fix the interactions of these bits to first make "-s" work as
  >> intended.
  >
  > Is it though?

  Yes.

  If the proposed log message says "as intended", the author thinks it
  is.
====
[1]

Since you are "the author", the above directly translates to "I think it is as
intended", but I responded directly with:

====
  The question is not if the author of the patch thinks this is the way
  `-s` is intended to work, the question is if this is the way `-s` is
  intended to work.
====
[2]

Which is a perfectly valid response, to which you replied:

====
  The "author" refers to the author of the "proposed log message" of
  the patch in question, i.e. me in this case.  The author of the
  patch under discussion thinks it is, so asking "Is it?", implying
  you do not agree, is nothing but a rhetorical question, and doing
  so, without explaining why, wastes time on both sides.
====
[3]

This is not a valid response, because the question was never "does the author
of the patch think this behavior is intended", the question was "is this
behavior intended", and I made that abundantly clear in [2].

So there's only two options:

 a. This is the behavior you intend, and you meant to say this is the
    behaviour you intend.
 b. This is the behavior you think is intended, in which case if you think so
    or not is irrelevant, instead you need to provide a rationale for why
    you think that is the case, which you never did.

If it is `a`: that's not a rationale. If it is `b`: you still need a rationale.
Either way no rationale was provided in the commit message (or anywhere else).

You chose to avoid this question and instead throw personal attacks in [3],
which is not productive.

Fortunately for the project I decided to investigate the whole history behind
the true intention behind `-s` in [4].

In that investigation it became exceedingly clear that the intention behind
`-s` is different from the intention behind `--no-patch`. And it also became
clear that after making `output_format` a bit field: the intention of `-s`
became unclear.

The culmination of that investigation is the thread in which `--no-patch` was
introduced [5]. In that thread Matthieu Moy explained the true purpose was to
make it more accessible to silence the output of `git show`.

Furthermore, Matthieu Moy happened to respond today, and make it even more
clear [6]:

====
  Looking more closely, it's rather clear to me 
  they are not, and that

     git show --raw --patch --no-patch

  should be equivalent to

     git show --raw
====

Which is *exactly* what I and Sergey argued, and to repeat and make it
unquestionably clear:

  `--raw --patch --no-patch` should be equivalent to `--raw`.

Period.

You can throw all the personal attacks you want, but what you think is the
intended behavior of `-s` is irrelevant, the fact is that the intended behavior
of `--no-patch` is independent from the intended behavior of `-s`.

History--and the explicit explanation of the original author--proves that.

So, when I asked "is it though?", that wasn't a rhetorical question intended to
waste time: the answer is clearly: NO.

This is not the way `-s` is intended to work.

> >> And it led to unproductive and irritating waste of time number of times, and
> >> eventually you were asked to leave the development community for at least a
> >> few times.
> >
> > That is blatantly false. As a member of Git's Project Leadership Committee, you
> > should know precisely how many times the committee has excercised this power,
> > and it hasn't been "a few times", it has been one time.
> 
> You were asked to leave in May 2014, and according to that message
> from May 2014 [*1*],

This is the worst kind of misrepresentation.

The fact that *one person* said something, doesn't mean *the community* said that.

Anybody who is the leader of any organization should understand that the
opinion of *one person* is not the same as the opinion of a whole community.

And this is--once again--a smoke screen.

Whatever one person said in 2014 is totally and completely irrelevant to the
topic at hand.

---

The commit message of the patch does not explain why the behavior of `-s`
should be changed in a backwards-incompatible way.

[1] https://lore.kernel.org/git/xmqqsfc62t8y.fsf@gitster.g/
[2] https://lore.kernel.org/git/6459c31038e81_7c68294ee@chronos.notmuch/
[3] https://lore.kernel.org/git/xmqqjzxgzua0.fsf@gitster.g/
[4] https://lore.kernel.org/git/645c5da0981c1_16961a29455@chronos.notmuch/
[5] https://lore.kernel.org/git/1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr/
[6] https://lore.kernel.org/git/4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr/

-- 
Felipe Contreras
