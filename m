Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 10:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiCVK43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiCVK41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 06:56:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2239148
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:55:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qa43so35214983ejc.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jW/KkiY1aDDItXdDeWCye3hzZazjeySd+dTz2EO2GOI=;
        b=ida3/Badjwj3WlpRa5v5x2jDQxyIHsnplY3caLg07A7Nr9imyrIyr7iRZjLcafzuJV
         eryP/nvkjvh2M0Nflm52eSWstco5J8mUJoe1HKoGhtG0PfNiqG7Xf+F9f2wqvFHpMK6p
         IQoOpD8PKrMgG3RdfRXp62xyZaRqpql+27cgtbm5T0aTOv20UG77S+NT/NSCoE2/elDg
         A++vl13+RIQPDeDOSmXKyxEobW73DbbjiTpmY0Vy8EFJLJLSRkQd4VPNeRHEYxDBFPXu
         Qmx8yvATWFYUc36psciS91MIBuYcVw+c/XzFbZnFgLKqtVmBvLZ/omXCKD0vkSHS6Jtm
         67Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jW/KkiY1aDDItXdDeWCye3hzZazjeySd+dTz2EO2GOI=;
        b=XTlidCQYU0e+5X4h+dR1rVPE0GfqPctfp8I8uFr+ncQVzAjbdMeMjFbDK+57mEi20j
         +OQuony+mv/jhysYyOYt9BEaSWeW+x8DWVeeUBTJKTt14CEnCu51DiesSzgzh4xgI+Vv
         HwYY10/1h1irRZD7W3PTSI7J0/Cp2cf57OcjNYxAiWzpv4YiqK1HKtc7iKUH6eK6N/2v
         e29vd4sMqhvnNHZu4g1ZKiKpHSHXLUwrWKd1lCSg/M+NTVoqNXom3RXz9xmZwGKLbQ2d
         gWTnsm6z4Pd4F6WICogOHu++5n4RryqTYVqm3sNYNO2c6Pu2ybb/teVdJW/qAwDN02LP
         w/ew==
X-Gm-Message-State: AOAM5324/2NKm8xElO6wxdFolTX7/fMyZyi4YT+thgKj5lf/GRfakh+y
        TXU7wuDnxiKwwO0dX1G/rW4n8mmumXsTaQ==
X-Google-Smtp-Source: ABdhPJzXWEndvkOFZiWzJIu/rpWKydTP5sGu2JxWP41k6Un1pie1E6Xa5bdrX5fhl30jdVYqwCuejg==
X-Received: by 2002:a17:906:2695:b0:6cf:e1b4:118b with SMTP id t21-20020a170906269500b006cfe1b4118bmr24535871ejc.348.1647946499196;
        Tue, 22 Mar 2022 03:54:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm8154444eje.173.2022.03.22.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:54:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWcAE-000Iwb-51;
        Tue, 22 Mar 2022 11:54:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jayati Shrivastava <gaurijove@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Having grep support the -o option
Date:   Tue, 22 Mar 2022 11:50:10 +0100
References: <87in9ucsbb.fsf@evledraar.gmail.com>
 <20220318220623.50528-1-gaurijove@gmail.com>
 <CANsrJQdNKiX93GnVXztmvYQQBxr6-HsYNx5UvYXSFg32Op3ZPQ@mail.gmail.com>
 <CANsrJQe1YuggxdBHdSdukXRj3myVCTNwLiiWNLrAzPpzA4FOOA@mail.gmail.com>
 <220319.86ee2yds2f.gmgdl@evledraar.gmail.com>
 <CANsrJQdJ1wBThUyJ=QSt6NwU8HzQY2VaWc11UfZQ+ktRQs_YTQ@mail.gmail.com>
 <220319.86a6dlewyj.gmgdl@evledraar.gmail.com>
 <CANsrJQdqoz7mZ9Fj08owgVWGKs25nPzE1g1dLASL=fz9j485hw@mail.gmail.com>
 <CAP8UFD1+3FWYWZscMgg13T7tYxgB7HKSFiierehdYhuHq54F-A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CAP8UFD1+3FWYWZscMgg13T7tYxgB7HKSFiierehdYhuHq54F-A@mail.gmail.com>
Message-ID: <220322.86a6dintod.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Christian Couder wrote:

> On Sun, Mar 20, 2022 at 8:14 PM Jayati Shrivastava <gaurijove@gmail.com> =
wrote:
>>
>> On Sat, Mar 19, 2022 at 9:49 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> >
>> > One thing I'd *really* like to see is the bits of %(if) %(then)
>> > etc. extracted from ref-filter.c into some general API other commands
>> > could use with strbuf_expand() and friends.
>> >
>> > I.e. if you could in addition to the strbuf_expand() callback define
>> > what verbs you support for "if" and the like, or have callbacks for
>> > their comparison functions.
>> >
>> > Then have that machinery drive the whole format expansion, which
>> > eventually would expand your %(some-custom-thing) via a callback.
>> >
>> > I.e. the whole "valid_atom" state machine in ref-filter.c.
>>
>> So, the end goal is to design a formatting API that can be used by any
>> command that takes --format option?
>
> It might be nice if we get closer to this after your GSoC project, but
> I don't think it should become the main goal of the GSoC.

Agreed. FWIW this is off-list discussion between Jayati and myself which
started with her asking (and this was omitted in the context that made
it on list:

    [...] Infact, I'll be excited to work on anything you suggest even
    if its not related to the project, as it will help me get familiar
    with the codebase and the contribution process at Git.

So that suggestion of mine of generalizing ref-filter.c wasn't meant to
distract from the GSoC project, I understood her to be looking for
suggestions for things to work on that were *not* part of the GSoC
project.

So I suggested that ref-filter.c task, which is orthagonal, but relates
to some of the same code.
