Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8AC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0E64DD9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhBEVQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBEVQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 16:16:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF4C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 13:15:15 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so14228324ejb.6
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=s9U5NLW3h4a/u7Rvj84nRwI8xgZCJVXacoRXufQjFIM=;
        b=LmG4KEJCCQDTEMyUivXmIxZppbq140We4yevubHaOcR9HThKN0UDZY0xsiFGPlZCEW
         QMA0SGAt0I0x1552IkxmbnwGm1L+/AoAmSgUxj34/CbEdZEwPP66m+eSTdGrMkYarNkg
         7tXJh+wEe3ylg4hcjUs2Kuw7TLV05Pu/fCaw/PFwDundyZsW4o4N3cLhgZCm38JdJcT3
         /r2AZX9EJ/oOsvm7srj0KkEYgHjJFQNZ8WYhXOtr11OtRHMpf6ANesBiyTawTtbX07FN
         TKEGW/5smyke2h/Ablcg9wODfglxroyuZaHRaC0N5QisZ2irC8LIpY+/hyuqaqnWDxzr
         +jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=s9U5NLW3h4a/u7Rvj84nRwI8xgZCJVXacoRXufQjFIM=;
        b=JCD2WFOhYYPIsVhObDtUbgt639xEuBVbfnMC72YH0dhFfJAZnwcF02y7tRlRpKZE7s
         VKeHnUhAGs5xC4iVE4tcTnXqGxl+hKobw/8u5Z97yPV+QsIONIPjiGJg9OdUJFMK5jMn
         q+sFvg5zs0BPQl3Kzgfe2BlUhPYDU5xnquuwBvVix8KX010tBMWDW17vOFJoSjt5YZJ+
         Upe2kmCHfkc0jiF8JKDhTDv4JRuF+0rVKri/mh8RhdcK42Owu5mEjM8ibbecScr9mvkX
         QLA6y9Q9fWqYUMQfwJU/YL55neCk/nkOTLFjkOIe74fJz3G33NS3ZZzEEu9rsoa5f25d
         41/Q==
X-Gm-Message-State: AOAM530amrZ7PpvuwLa9IdssqoHm2R4dhGFGa7GHM1GFkotRO+TP98lm
        8hFq8DAyp5/UHM6vxcLJPr4=
X-Google-Smtp-Source: ABdhPJxoI+uwaYPvCLtXzLtp4AUBaOx9e8jU3YzjWDA/2ieCXtcDUFu/AgWJN3YaXXWJRVzpgFcgqA==
X-Received: by 2002:a17:906:a20e:: with SMTP id r14mr5701067ejy.404.1612559714575;
        Fri, 05 Feb 2021 13:15:14 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i15sm4383821ejj.28.2021.02.05.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:15:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1612493309.git.jonathantanmy@google.com>
 <xmqq5z372ihm.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq5z372ihm.fsf@gitster.c.googlers.com>
Date:   Fri, 05 Feb 2021 22:15:12 +0100
Message-ID: <87eehucj33.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 05 2021, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> For what it's worth, here's v7 with advertise/allow/ignore and by
>> default, advertise. I think that some server operators will have use for
>> this feature, and people who want to disable it for whatever reason can
>> still do so. The main disadvantage is complexity - the server knob that
>> server administrators will need to control (but between a simpler
>> allow/ignore knob and a more complicated advertise/allow/ignore knob, I
>> think we might as well go for the slightly more complex one) and
>> complexity in the code (but now that is constrained to one function and
>> a few global variables).
>>
>> As you can see from the range-diff, not much has changed from v6.
>>
>> I've also included Junio's suggestion of tightening the promise made by
>> the server (when the client says "unborn").
>
> This looks reasonable overall, especially with the feature turned on
> by default, we'd hopefully get reasonable exposure from the get-go.
>
> Let's mark the topic to be merged to 'next' soonish, unless people
> object.

FWIW I'm still unclear on re [1] whether Jonathan thinks the semantics
of this shouldn't be documented for <reasons>, or whether he just
doesn't want to submit the patch and I should, or something else.

I still think this "remote as config source" without actually explaining
that it is is a very glaring hole in the docs[2].

And in [3] I noted that we introduced the word "branches" into
protocol-v2.txt for the first time without defining what it means
(presumably just refs/heads/*, but then let's say so...). There was a
reply promising clarification, but I note that v7 still just says
"branches".

To be clear I'm perfectly fine with a note in a CL to the effect of "had
X feedback on last version, =C3=86var said Y and Z both of which I think are
stupid ideas, so I'm not doing them" :)

The only thing I mind is being left hanging to the effect of not knowing
if a diff you proposed is considered bad by the primary author, or if I
should just submit it myself as a patch on top or whatever.

It also saves other people following along with reviews time, since they
can read later cover letters and get a brief summary of some
side-discussion in an earlier round without diving into it themselves.

Me too honestly, sometimes I come back to these threads and completely
forgot what I had to say in earlier rounds, and when I try to find out
it's hit-and-miss whether I agree with much/any of it :)





1. https://lore.kernel.org/git/87h7n3p363.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/878s8apthr.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/87k0rzp3qx.fsf@evledraar.gmail.com/
