Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2336C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJSTRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSTQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 15:16:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8991CC3DE
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:16:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w18so42254158ejq.11
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9KyYCKrg/ZNSGsJxdT1YsR9sf1eThHi7YR5aca6unn0=;
        b=lKPcwWoIAjkS8pb7J4oJOxSxkQPEsgyfU09MZmC7J0IsG28CtrCJ5JPgA/6MAJTaCW
         iPKk55wuUJuufBoqE1BVPjiNdPOtpUx3zH76F7fBiQ7GySE7RTg6rFrsX6EGFJ1trF9T
         ZvJAdVMhUdfecT3RC8Fcu5d/Sfa1eOaCdL1N/5JJGjECEnpkBESnsbls5QX3eAEtkpep
         UwdyZBbvA7xz0tHujO8CqTys6utRz1u+VQeV3EstjgPk9lYI5XCPKacA/oE9PVMcwk8I
         AYqjH58F1gwvCNSvJQ1ZruaU0VTKE7RATkpyc3ivxwHLWC//Qu49ZqQ9mLUAzm9AX5/y
         ap3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KyYCKrg/ZNSGsJxdT1YsR9sf1eThHi7YR5aca6unn0=;
        b=ETJeHkO5kE/pzbPwuOYyJBmz6IVq8y8OSq/OteW1lMxIDtNt1wZbRMWB/4dIAbNrJx
         5uptEYoDZX+05nAVj3rfNSE2HFgFXMo+/ljnl/MX5ctHB3nTSvuf27lvSvmG/8mzR/1X
         MsfNzGRyWdoa+Bb2QQJ/OSPqH4aNvsOHMwCTq4mU2TFYMIxqBXfSUsGd9DwS7qIHQZxR
         S1zF9yMqSfqUnAz+wCqDENY/3by2EEqmJWBAfK/eDBrA05hNrXHt/Se9TLGa/gx69b76
         u3yN1snSd/dqqz1C5mCbyDN2v9/2JU/s9cPiO95hqe0eGlmjkMzTSN2TNAf3i6H2V3hA
         DlZg==
X-Gm-Message-State: ACrzQf0v2Lr6IEzqlb9wimvJ0mrxVc2LELgpv5uxEgvgH78hhM5+oT2R
        SBcSgLQMIpy5DCvBlcWarb4=
X-Google-Smtp-Source: AMsMyM5gnwMlGs5OrOoRLR93Ye2fpU1uW5AY1cWBgtzhNj2mg95DDCgv+z3tNHLAL+Z//OEzx0uiOw==
X-Received: by 2002:a17:906:794b:b0:790:2dc7:3115 with SMTP id l11-20020a170906794b00b007902dc73115mr8133456ejo.3.1666207009726;
        Wed, 19 Oct 2022 12:16:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b007415f8ffcbbsm9395034ejz.98.2022.10.19.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:16:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olEYZ-0068fT-2u;
        Wed, 19 Oct 2022 21:16:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Date:   Wed, 19 Oct 2022 21:11:57 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g>
 <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221019.86bkq8hake.gmgdl@evledraar.gmail.com>
 <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
Message-ID: <221019.8635bjhbds.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Eric Sunshine wrote:

> On Tue, Oct 18, 2022 at 9:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Oct 18 2022, Glen Choo wrote:
>> > I'm not too familiar with the CI, but I took a quick peek at ci/lib.sh
>> > and noticed that none of the jobs build with sha1dc, not even the Linux
>> > or Windows ones, so..
>>
>> All of our jobs except the OSX one build with SHA1_DC, because it's the
>> default.
>>
>> Per my just-sent
>> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221019T010222Z-av=
arab@gmail.com/
>> the blind spot has been lack fo SHA1_DC on OSX, for others it's the
>> reverse, we don't test e.g. BLK_SHA1.
>>
>> In practice we've been catching SHA-implementation specific code early
>> because the OSX implementation was different, but in this case it's
>> OSX-only code, so it only supported the Apple Common Crypto backend.
>
> I don't know how germane it is to the current thread, but previous
> discussions[1,2,3,4] favored dropping use of Apple's Common Crypto
> altogether since it doesn't seem to buy us much (or anything) and is
> incomplete; it doesn't support all of the OpenSSL API Git uses.
>
> [1]: https://lore.kernel.org/git/CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=3DodUQS=
RYVpV21DnRuvA@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2d=
EREg5_Ba5Ag@mail.gmail.com/T/
> [3]: https://lore.kernel.org/git/20160102234923.GA14424@gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cQ5kKAt2_RQnqT7Rn=3DuGmHV9VvxpQ+Ug=
DPOj=3DD=3Dpq6arg@mail.gmail.com/

Yeah, maybe. I'd be 100% OK with that happening, but I don't use OSX
outside fo CI really, so I wanted to avoid scope creep to "non-SHA stuff
we use OpenSSL/AppleCommonCrypto/whatever" for, in the cases where we
can/do use OpenSSL/AppleCommonCrypto/whatever for SHA also.

I.e. that's basically a question about what https://, git-imap-send
etc. should be using if not vanilla OpenSSL & the like.

But if you/someone can come up with a patch that confidently asserts
that it's useless & drops it I'd be happy to either integrate it &
submit it as part of this series if it makes things simpler, or
alternatively re-roll on top of it.

I'm just not confident in making that case myself, since I hardly use
the platform, am not too familiar with the various concerns (aside from
skimming the links above), and don't really have interest in pursuing
that.

OTOH if you do want to make the case for dropping Apple Common Crypto
that would also presumably be much easier after this series, once we're
past justifying the hurdle of "wait, we're switching the thing we use
for SHA-1 by default, which we build practically everything in git on?"
:)

1. https://lore.kernel.org/git/CAPig+cQ5kKAt2_RQnqT7Rn=3DuGmHV9VvxpQ+UgDPOj=
=3DD=3Dpq6arg@mail.gmail.com/
