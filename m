Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92868C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 18:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiGRSiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGRSis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 14:38:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505962A712
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:38:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz17so22894279ejc.9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5ANIMloiw+jOqUCrNXU5Ol/HFkriVdlsdYCyIZHrkyE=;
        b=SU+12CYnvY83p4gXu86gChn9uGfaDngEJJyDxi57hz2LFFeY6dY8/CYj0YuPPzA2v9
         Q8KgdK7GZGcxUZZJY/ljElP8VpeDXAWAfgD4J+5e9LaEkjPHfwWIGq8+stBSZ+NeY5gs
         dOEBT8VpjRjQ2ThwCpJfaj9nNjPgP64lsnHL76KaQvyofff/Y13+m4VCfc4TNHUXU1Zh
         nJX9hlGpxegPEr7dVR9ri9N4lSHameVmU6c1h59XVxtA5eWNm2/RTXyEtqeURXrU/C+h
         YxfahkB0LcmDh5ZEQYYCnh/73ycvUaAYLkR+UhM2w/muJmjUwX9qv+H3HWpXJITtCtaL
         wEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5ANIMloiw+jOqUCrNXU5Ol/HFkriVdlsdYCyIZHrkyE=;
        b=hnGsNHWh7Ga46tEusoF/gYwopTmHogOGC8Lyw4QQCwVocV/2u5syX+oFZBRv2FPfQ4
         WsczedQbu6L1S9f8QBdjPE2zheLtM7EJyg4j2fn4iqqwU3AsGxybK5y0pSc2mJQ1Ris6
         IjszxuyV2c6MgD2YuTIlF+h5Gk44gKTYDWdp9MFUyXkc+cST2crYIHCvhfxyGz75lhg7
         QDdYIlBmTkNKnb0MlpJPrvpxkNkeHvKDkB5mySzfxHuGSZUiNk/EfJEeP0/OOn4S+8Ry
         Y7x+qTmdrs6UTYrFppGkrC11oEs0gp87Z4r3b4/4Ehjj7MZoPhXw4IjLJWgQKaAdyX+4
         +m6Q==
X-Gm-Message-State: AJIora9HvO3sGfim3r6YpmF9wNHPiJSCkC3bguSnNn/OSY0I7FrICE1B
        bism4n1DQ5cpLGVXCIa8OkE=
X-Google-Smtp-Source: AGRyM1sJfkMMHWuC+4aa4wgXT5g1CkXXpagbJOoh8qY3fgraYteCW//iEkETXWXB7jXwxQPn7np8Jg==
X-Received: by 2002:a17:906:4fd0:b0:72e:dd6c:1b95 with SMTP id i16-20020a1709064fd000b0072edd6c1b95mr21356717ejw.323.1658169524751;
        Mon, 18 Jul 2022 11:38:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7cfce000000b0043a4de1d421sm9092425edy.84.2022.07.18.11.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:38:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDVdj-003JYe-Fr;
        Mon, 18 Jul 2022 20:38:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 0/8] git doc + "git help": move "format" docs from
 technical/*
Date:   Mon, 18 Jul 2022 19:58:00 +0200
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
 <xmqqy1wqqs3j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy1wqqs3j.fsf@gitster.g>
Message-ID: <220718.86r12iw9jg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This series improves the discoverability of the technical/*
>> documentation covering those "formats" where we interact with users
>> (e.g. "gitattributes") by moving them to its own "git help" category.
>>
>> It then moves various technical documentation from technical/* to our
>> main documentation namespace, allowing us to cross-link e.g. from
>> "git-bundle(1)" to a new "gitformat-bundle(5)".
>
> This may be a good direction to go in in the longer term, but there
> are already topics in flight that change these documents.  Luckily
> none in 'next' yet, but there are two that have been in 'seen' and
> need to coordinate with this change.

The v4 merges cleanly for me, unless there's a semantic conflict you've
spotted that I've missed.

But I assume you mean a "seen" you haven't pushed out yet, which
includes SZEDER's change here:
https://lore.kernel.org/git/220718.86cze2y22q.gmgdl@evledraar.gmail.com/

I sent out the v3 with a merge resolution for the only conflict at the
time:
https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-avara=
b@gmail.com/

But as noted in the v4 CL I thought I'd make even that trivial conflict
go away in v4, but it looks like I'll need to roll a v5.

I don't want to make it a hassle for you to carry this topic, and I have
waited a few months to submit this, as there were always various
Documentation/technical/ changes in-flight.

Would you prefer to have this entirely conflict free, or to have me
solve the (small) conflicts locally and note the resolution (per
--remerge-diff) in the CLs?
