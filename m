Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60480C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK3T6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiK3T6S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 14:58:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B96865B9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:58:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy37so43883212ejc.11
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EvfTYIKr94O8aP2RX5VW7brhBI8v0/oUIXgpBOyKnSk=;
        b=PSOwJd7/QjG8fLht4t+zrH/uQiqdJrQYGsBMuzVEcQdLlVb9KtsT8/sWmSaz6ZgTqU
         q1aBa+YX9dFtkA8s4M3YEuNRJwRrUXJ3cD+wxz5Kbx0Yeg1dWztXPPBJ+sZV59vPaXzW
         T29N5G4ra8J8BUTnwYoN8xvv+p61oWEt3oLO9750g7Dbq2nwwOPYetPfQwns/4Gsqn45
         cELAPCeeozbIf/olCGdIlo9jZURr5/AsdU38rFiVVX1TZ4Jwk3UZ0gOV1/lJJt49K8xX
         zp10cLDhvkJimo5K7Eic3vorKnQM23plou8TnnbF6WrP0Z94jR2dYGv8QPYOrpRMdiFm
         GEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvfTYIKr94O8aP2RX5VW7brhBI8v0/oUIXgpBOyKnSk=;
        b=bDHDjDGIH4+zSYDH34ML6jRWXC+9l/Xylfjx/0vstwIcnBzvlcM2zt4COLwPUcFrlB
         DOShkDl31QPUXxDYhcutjarcBz1X+xR/NzcSS5x0z6Mv3gQObobiWE4gK6TWdCBQm1j9
         Q7FmO/wABJkxMOlhgaB1CqpCmnJJKJrWE5ibxEL6GkZNxfUqw4Sp4vs8saIIph00Ia+8
         6WZLdFbttEna9TvuoOtcSEV5vi7MlN9CjOk9vGiT0825BTfbNOP2KP9ymEU0cNOz5TF3
         qzPd4CzvyYOYYeUz6TC1DwWt8PfSRnXx4Hr8XaAp32rcCX6XAdG7Smj5bzOJ+e1cO0i/
         LYJw==
X-Gm-Message-State: ANoB5pnpOMuSaJIahrVSQjAHStfNzcNO1o0En51gOP6pXNowoNTpGuLa
        r2gZa2PVji+oGx0Lme8MO1Y=
X-Google-Smtp-Source: AA0mqf49bLPAOVe+ttVq1y/LcJMuEr4XRaVrMW51t2RV8dWOGOJjVZwQEQN0U/Ty8ywFBrTFOLW28Q==
X-Received: by 2002:a17:906:32d9:b0:7ae:31a0:5727 with SMTP id k25-20020a17090632d900b007ae31a05727mr37948084ejk.540.1669838295237;
        Wed, 30 Nov 2022 11:58:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906319900b0077e6be40e4asm987557ejy.175.2022.11.30.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:58:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0TDi-0021lq-07;
        Wed, 30 Nov 2022 20:58:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/remove--super-prefix and -rc0 (was What's cooking in git.git
 (Nov 2022, #07; Tue, 29))
Date:   Wed, 30 Nov 2022 20:43:10 +0100
References: <xmqqsfi22j67.fsf@gitster.g>
 <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqilix150o.fsf@gitster.g>
 <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lh6ygqphu.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221130.864jugi59l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Hm, it looks like ab/remove--super-prefix missed the preview release..
>>> Per the discussion ending at [1] I think my one-patch fix to "git
>>> fetch" [2] should have made it into the release (it's pretty low-risk
>>> and doesn't introduce too much churn to ab/remove--super-prefix). Is it
>>> too late for that?
>>
>> Nobody seemed to have commented on [2].  Is this fixing recent
>> regressions, or is it more like addressing an "if it hurts, do not
>> do it then" problem?
>
> =C3=86var did comment on the patch in [2], but unfortunately it happened =
on
> the thread ending at [1] (and others), so it's not easy to follow.
>
> It's solidly in the latter category. I don't think this has ever worked.
> c.f. https://lore.kernel.org/git/kl6lsfiivcau.fsf@chooglen-macbookpro.roa=
m.corp.google.com/
>
>> The fact alone that these questions need to be asked _now_ is a good
>> indication that it is way too late for this cycle, I would have to
>> say.
>
> At any rate, we shouldn't be rushing review, so this is fair (though
> unfortunate). Let's continue counting on ab/remove--super-prefix and
> ignoring my one patch, then.

For my part I was waiting to see what Junio would do with
"ab/submodule-no-abspath", which is already in "next". Depending on
whether it's ejected or not I'd need to re-roll
"ab/remove--super-prefix" on top of a new "master", as it extends the
tests it added.

You noted in [1] that you strongly preferred seeing
"ab/submodule-no-abspath" ejected. I think you're right that the output
is a bit weird, but:

A. I think it's mainly odd/unintuitive for the recursive cases, I think
  outside of our own test suite absorbing repositories recursively
  almost never happens.

B. I think it's an improvement in the output compared to the absolute
   paths we have now, especially for the common case of non-recursive.

C. Changing it made it easier to test it, which is how it ended up as a
   supposedly quick prerequisite for "ab/remove--super-prefix": It's
   otherwise changing a test blindspot.

D. As you note in [1] the data we'd need to pass around to make it
   sensible (maybe it should always be consistent with "git mv -v"?)
   would require passing more state around, some of which is tricky.

I'd prefer to just have it graduate as-is, and build
"ab/remove--super-prefix" on top. We can always further tweak the output
later.

But if you & Junio feel otherwise I think the best way forward would be
to eject both topics, and I'd submit a re-rolled
"ab/remove--super-prefix".

Either would work as a way forward. Just let me know what you both
prefer.

1. https://lore.kernel.org/git/kl6l7czmec10.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
