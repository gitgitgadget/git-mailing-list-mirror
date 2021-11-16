Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA67C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5A461B39
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhKPMQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhKPMQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:16:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56DC028BBF
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:05:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so86740100edz.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B9xfjMdL519PUWhOsWO/YL05lAuBB5Ci96TLLqYILvA=;
        b=R4sO8VHah/uMQlqLjwEzuDg9J4G1Yd4AgrAgDfYBlrnUzxER1FhB6x8uATasgpDjvt
         1FAl28kKR2B4PBgLUp2iUg2gJ0YCHCZPooqnq8J38imJEJTEGouflHZ6URv14IrZdw23
         6V8FmW0hDuPoea63SnyEe1bOe2zJDm/AZUtNEh8Cky1Wc6+SGqEs/RcJIQNnkNQTg0Zi
         ge4+1yCX3ixRSy/D79y9mH9kayupiIE6LhSCihvFFibesLu8WOP9Z8wB/AhCEP77DrXD
         VsJ+NBo81C8EVc3CccJP6yDvKZ6gqf4Nkz9TGydsEHCXYVLDW3DF9oC+Nvw5l2oBPXYh
         BLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B9xfjMdL519PUWhOsWO/YL05lAuBB5Ci96TLLqYILvA=;
        b=xxScxT6FKdGoSLF1EEhPZk6VGVwfJfngLM5y8jX2kMDEd58xwx5bx54PiY2+PR4ABi
         bROFvcjIHdGa1ohD8gS0R9kzGOp7qNweeQ+mLVCaynO6xMSTKWjgoEQ8xBVRyJcaPwGs
         aB41kmySM00YMmfbwl0nfujS8vTfLGNegMboQ5Z2Qicons+TdNXMQ8/CD511Lf2Yke8N
         Dy3DxAazoWGc0R1UkpraLj48TgChXe4iOtpF+g1+cEtmf59lf+Jv7loPFSMQYppZkXYm
         nhX4lhht3S+kwIa+Y60E+hSMsfVXYxlFmVAMl0Gc/Blb1d1UtJzzYV+Eh1lt6bj41oiy
         9ZCw==
X-Gm-Message-State: AOAM530HgKcOAV+Jfwp998KMDvDrPZkPXOS1vhN9C1TIHTm7NSraOXVc
        aAlUPVweGbrzjDXmkeJHvrY=
X-Google-Smtp-Source: ABdhPJwxMFsnVPGfm77NwDIilBb/8GiaijBHBOVxyHUZLh5Hiiqi0AKffI6IXrZ/abklb6OMsNUdMw==
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr8970257ejc.134.1637064315227;
        Tue, 16 Nov 2021 04:05:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nb4sm8469525ejc.21.2021.11.16.04.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:05:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmxD8-001OMA-0V;
        Tue, 16 Nov 2021 13:05:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Tue, 16 Nov 2021 13:01:00 +0100
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <20211115220455.xse7mhbwabrheej4@glandium.org>
 <211115.86k0h9qcf5.gmgdl@evledraar.gmail.com>
 <20211115224015.vzfevpvptysxzpaa@glandium.org>
 <211115.86bl2lqbbt.gmgdl@evledraar.gmail.com>
 <20211115230032.3or3qqlsdnxjtrol@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115230032.3or3qqlsdnxjtrol@glandium.org>
Message-ID: <211116.86y25opapy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Mike Hommey wrote:

> On Mon, Nov 15, 2021 at 11:49:31PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Nov 16 2021, Mike Hommey wrote:
>>=20
>> > On Mon, Nov 15, 2021 at 11:26:36PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>=20
>> >> On Tue, Nov 16 2021, Mike Hommey wrote:
>> >>=20
>> >> > On Thu, Sep 23, 2021 at 12:30:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >> >> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-=
PREFIX
>> >> >> +hook.sp hook.s hook.o: hook-list.h
>> >> >> +
>> >> >> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook=
-list.h GIT-PREFIX
>> >> >
>> >> > hook-list.h is only included from buitin/bugreport.c, so
>> >> > builtin/bugreport.o should be the one with the hook-list.h dependen=
cy,
>> >> > shouldn't it?
>> >>=20
>> >> Well spotted, yes. This is a mistake. I think from some earlier WIP
>> >> version of the series.
>> >>=20
>> >> In practice we don't really miss dependencies due to these sorts of
>> >> mistakes since we use the .depends files, i.e. GCC & Clang figure this
>> >> out for us:
>> >>=20
>> >>     $ grep hook-list .depend/* */.depend/*
>> >>     builtin/.depend/bugreport.o.d: compat/compiler.h git-compat-util.=
h hook.h hook-list.h
>> >>     builtin/.depend/bugreport.o.d:hook-list.h:
>> >
>> > But aren't those .depends files are only created when compiling object
>> > files, such that builtin/.depend/bugreport.o.d wouldn't exist until
>> > bugreport.c is compiled, which would fail if hook-list.h wasn't created
>> > before that?
>>=20
>> Fail how?
>>=20
>> I don't think it could fail, because the purpose of these dependency
>> relationships is to avoid needless *re*builds. So if you're building for
>> the first time it doesn't matter, your compiler will find the relevant
>> things to include for you. It doesn't need what's in the Makefile to do
>> that.
>>=20
>> See [1], what I said about LIB_H there applies more generally for the
>> .depends files.
>>=20
>> It will only fail in the sense that it over-depends, i.e. if you do:
>>=20
>>     git clean -dxf; make builtin/help.o
>
> Try
>
>     git clean -dxf; make builtin/bugreport.o
>
> It fails with:
>
>       CC builtin/bugreport.o
>   builtin/bugreport.c:7:10: fatal error: hook-list.h: =E3=81=9D=E3=81=AE=
=E3=82=88=E3=81=86=E3=81=AA=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=
=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=AF=E3=81=82=E3=82=
=8A=E3=81=BE=E3=81=9B=E3=82=93
>       7 | #include "hook-list.h"
>         |          ^~~~~~~~~~~~~
>   compilation terminated.
>   make: *** [Makefile:2500: builtin/bugreport.o] =E3=82=A8=E3=83=A9=E3=83=
=BC 1
>
> The only reason I can see why it builds at all normally is that hook.o
> is built soon enough that by the time builtin/bugreport.o is built
> hook-list.h has already been generated.

Ah, you're obviously right. I don't know what I was thinking yesterday.

I submitted a re-roll of the greater dependency fix-up & optimization
series I've got kicking around, which includes a fix for this
issue. Thank you for the report:
https://lore.kernel.org/git/cover-v3-00.23-00000000000-20211116T114334Z-ava=
rab@gmail.com

