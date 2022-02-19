Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1175FC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiBSM5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 07:57:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbiBSM5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 07:57:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B61D4588
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 04:57:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w3so20124288edu.8
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ESN8hSGcfIyT2VrGWwi0NoJurmqyLdM7qBccwKgKDsg=;
        b=MebpoGnZER3QTAytsda9dwkTQLvRC6spl6q10eHwys8Vky1lCUr8369ctwyu7ZzldT
         rU2oD8Md3qMc21aBbloGVvXt8+hE+Lu5LA0Qo7dNz8JKvDwtNzXVE7r6VnDd6rhCR51r
         KWdZvna3jOwBTTuBHoBN8NO/n+n2FfgzZBcBJJWiD/SjBuFef/YeNRsQBboKfsjRnGu+
         bQXnkwJDpw9cn7UMyWNHQGGJXecR7NSI7dAfpYeBFzcEVPQhsY+VQ2YLUflaudjCj3tB
         FUqQ/Sl3vWDvnCNNG+DwpQBPLCIpC+NjdC+FV3BCGwYzUdwBwg025zKEAszaJ0BzXjrr
         HGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ESN8hSGcfIyT2VrGWwi0NoJurmqyLdM7qBccwKgKDsg=;
        b=OCSFKLr0yYGHi6h7H9UAPz7cv1kS6ywZjALpAbtX23h6DNTKATtgOw6lwPu4AtPKDI
         ywDHZ1Z4d/RIeH7OIzDPK9BSohxdzJZDWsWmYpQeCiWOQKHq8T7iiwUCNc6UoIhXGNqi
         AoXPirGRNh8/I0co218BKyEiI5lJSCRVaOYQsTPBnRea9RyaKslGf5SaNl0jGJGsgI/Z
         cHektGuA7nnFiIgry0JYSUeY1XWabL2RHfzkXq5y2W43ylpMoJ4wBdWFhHGRcuA77yW5
         CNWdzrQNhz9mUSlSdyoDkv/ifwDMOIkuxwYsMkHzJkkgoSvayUA6k64ot4lYImOMM3fl
         kCiw==
X-Gm-Message-State: AOAM5335isdxXF8bmEUGScVE5N2FG1PmSOT1bf7WgfI0e7KHgku+/xed
        m70QMBivXGlNkJ30VrTyhu0=
X-Google-Smtp-Source: ABdhPJxADNmo+zCLYwT2uVPdwOO/TV9EQqXM5ptYf+dQ/WaCdWeFfhvRgbATYVUG8ZEbfwvw4dqBWg==
X-Received: by 2002:a50:9d89:0:b0:410:ff04:5a98 with SMTP id w9-20020a509d89000000b00410ff045a98mr12923957ede.404.1645275437641;
        Sat, 19 Feb 2022 04:57:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bv2sm3201718ejb.155.2022.02.19.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 04:57:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLPIZ-004x5o-SE;
        Sat, 19 Feb 2022 13:57:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: master doesn't compile on xlc 21.01 anymore (old AIX compiler)
 (was: [PATCH v7 14/16] reftable: make reftable_record a tagged union)
Date:   Sat, 19 Feb 2022 13:54:18 +0100
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
 <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
 <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
 <CAFQ2z_M7s9Y_FH5x+qJxyZO0iHq+b_mf8=-dKcmADzFEoGLJUg@mail.gmail.com>
 <220124.86a6fkhk8s.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <220124.86a6fkhk8s.gmgdl@evledraar.gmail.com>
Message-ID: <220219.86wnhrc8us.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jan 24 2022, Han-Wen Nienhuys wrote:
>
>> On Mon, Jan 24, 2022 at 8:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>
>>> I didn't test the v6 on xlc on AIX 7.1, but found that it refuses to
>>> compile this code (but the one on AIX 7.2 is OK with it):
>>>
>>>     "reftable/generic.c", line 135.26: 1506-196 (S) Initialization betw=
een types "char*" and "struct reftable_ref_record" is not allowed.
>>>     "reftable/generic.c", line 147.26: 1506-196 (S) Initialization betw=
een types "char*" and "struct reftable_log_record" is not allowed.
>>>     "reftable/writer.c", line 261.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_ref_record" is not allowed.
>>>     "reftable/writer.c", line 312.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_log_record" is not allowed.
>>>     "reftable/writer.c", line 406.45: 1506-196 (S) Initialization betwe=
en types "unsigned long long" and "struct reftable_index_record" is not all=
owed.
>>>
>>
>>> I.e. you're dereferencing a struct type here to get at its first member,
>>
>> No, that's not what I'm doing.
>>
>>> > +   struct reftable_record rec =3D {
>>> > +             .type =3D BLOCK_TYPE_REF,
>>> > +             .u.ref =3D *ref,
>>> > +     };
>>
>> reftable_record is tagged union, and u.ref is a reftable_ref_record. I
>> intend to shallow-copying the parameter (a reftable_record called
>> 'ref') into 'rec.u.ref' , precisely as it is written.
>>
>> Does this patch pass the unittests?
>
> No, sorry about that. It fails. I didn't have time to run them earlier
> (and it takes a while on that platform).
>
> I don't know how to work around it then...

Just a reminder that now with this landed on master we've hard broken
compilation on that version of xlc:
=20=20=20=20
    avar@gcc111:[/home/avar]xlc -qversion
    IBM XL C/C++ for AIX, V12.1 (5765-J02, 5725-C72)
    Version: 12.01.0000.0000

The error is:
=20=20=20=20
    "reftable/generic.c", line 133.26: 1506-196 (S) Initialization between =
types "char*" and "struct reftable_ref_record" is not allowed.
    "reftable/generic.c", line 145.26: 1506-196 (S) Initialization between =
types "char*" and "struct reftable_log_record" is not allowed.

Is there really no workaround we can think of for this?
