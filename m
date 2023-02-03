Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39CC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 14:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBCOOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 09:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjBCONi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 09:13:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB97A84
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 06:13:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f7so5299419edw.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVeE5XxKIr2ZgESJ7HCawBfjKoUV3q2U37azI3ZYODI=;
        b=O4PKP0oXFcSCoP2x1IkMAbrHnJRZmVk5o9KxnSuB5rJ9DTwnTcMuvlHJPgeAaJfcJN
         cZQ3u0P1RNoebuJweZLxyzX6Bwz1Tbf33cfDNnz1LttOXUN5tpurZZ2aOkAVBAeACrhg
         GZYEVktemS1XvWNgRBEqOwydjvAZJCS/MmTMzm8kGkKrJ+9//BjIO41Wd1F/nZakxpXB
         F4U6RyxiquBvZK3U2oKTE3y7NWCY9KaUPCP8r2BmbCzWz7j0aQXnPlLQYhn1Gor1TSip
         12/b4qENbPVojVN9OqDlVDnpioPPgRU1+8Hi6rV+HLfj321b80opVNNQ2otMRInEpdKe
         +icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVeE5XxKIr2ZgESJ7HCawBfjKoUV3q2U37azI3ZYODI=;
        b=PITf83u611odl3wyGOZMCiqmHNEQ4PfOxDQKmAQOu+KXi6NlHpMFNw1lRhja5rIGxr
         0kZGfElQKetQzxLycgSJ8ChiOHlLx7EsemTzvUwgXTcqNF4RC4R7xxJ0kaJKc09jvBX0
         Mz4B5h0mHu3wMct8rsow9h5vhPYyCG7MHc30dyZUlpvxo17a/dRhYPnsUlU0vHtZr5zC
         ZFJQDHMina4dfCF0vLxQwIhi6sa6Jq49l2C0Umo7Asujok/l3g17m6v3bfV2HBJSU402
         RSAnYNNKMHi4XEDgzX+KlpZJ+p88gDEsGqBcVKyoHLUVVrmkqSesSQsw+5waP3Qc+h45
         qX4w==
X-Gm-Message-State: AO0yUKXFRESnk8TyKobSh0t8U7N6TK245PQb4l7cpihYvWVksHVE/Uk6
        t3pFKpfhVYUAl0FOrGn/T2g=
X-Google-Smtp-Source: AK7set/sZGAt/cF+IXorZq0nkcS1mVcydaLCnCZUDLoKWIq+mj1fEnJ34ZpyG6hhRbSkVtujVgrweQ==
X-Received: by 2002:a50:a6d2:0:b0:4a2:5e23:3499 with SMTP id f18-20020a50a6d2000000b004a25e233499mr11416419edc.31.1675433591849;
        Fri, 03 Feb 2023 06:13:11 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402104f00b004a2569f6ba0sm1170852edu.82.2023.02.03.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:13:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNwoQ-000EOf-2M;
        Fri, 03 Feb 2023 15:13:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
Date:   Fri, 03 Feb 2023 14:49:37 +0100
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
        <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
        <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
Message-ID: <230203.86fsbmbzwp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Phillip Wood wrote:

> On 02/02/2023 09:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> As reported in
>> https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.c=
om/
>> changing the default "tgz" output method of from "gzip(1)" to our
>> internal "git archive gzip" (using zlib ) broke things for users in
>> the wild that assume that the "git archive" output is stable, most
>> notably GitHub: https://github.com/orgs/community/discussions/45830
>>
>> Leaving aside the larger question of whether we're going to promise
>> output stability for "git archive" in general, the motivation for that
>> change was to have a working compression method on systems that lacked
>> a gzip(1).
>
> As I recall the reduction in cpu time used to create a compressed
> archive was a factor in making it the default.

I read those references in 76d7602631a (archive-tar: add internal gzip
implementation, 2022-06-15) more of a "it's not [much] slower", the flip
to the default in 4f4be00d302 (archive-tar: use internal gzip by
default, 2022-06-15) didn't discuss it.

So I didn't think it was important enough to mention (even though we're
now back to the faster "gzip" method).

>> As the disruption of changing the default isn't worth it, let's use
>> gzip(1) again by default, and only fall back on the new "git archive
>> gzip" if it isn't available.
>
> Playing devil's advocate for a moment as we're not going to promise
> that the compressed output of "git archive" will be stable in the
> future perhaps we should use this breakage as an opportunity to
> highlight that to users and to advertize the config setting that
> allows them to use gzip for compressing archives.

If we were trying to intentionally break things for those users we could
do a lot better than "git archive gzip", whose output is mostly the same
as "gzip", we could tweak one of the headers to make it different all
the time.

But I think it's better to advocate for such intentional chaos-monkeying
as a follow-up to this more conservative "oops, we broke stuff, it's
easy not to break it, so let's not do it'.

> Reverting the change gives the misleading impression that we're making
> a commitment to keeping the output stable.

I don't see how you can conclude that from this series. It explicitly
states that we make no such promises, what it does is go back to
allowing the gzip(1) command to make its own promises.

> The focus of this thread seems to be the
> problems relating to github which they have already addressed.

Which they've addressed by reverting the change, but while they're a
major user of git they're not the only one. They just happened to use
"git archive".

I think it would be a mistake to conclude that everyone who's run into
this has already done so, or is aware of it.

> I think there is general agreement that it is not practical to promise
> that the compressed output of "git archive" is stable so maybe it is
> better[...]

...better than what? This seems to imply that this series is making new
promises about the output stability, which it isn't doing.

> [...]to make that clear now while users can work around it in the
> short term with a config setting rather than waiting until we're faced
> with some security or other issue that forces a change to the output
> which users cannot work around so easily.

I think it's always been clear that you can use that setting. For ages
we've been saying:

	The `tar.gz` and `tgz` formats are defined automatically and use the
	command `gzip -cn` by default.

Then v2.38.0 changed it to:

	[...]
        magic command `git archive gzip` by default

Which IMO was easily missed among other "Performance, Internal
Implementation, Development Support etc." items in the release notes,
which said:

   Teach "git archive" to (optionally and then by default) avoid
   spawning an external "gzip" process when creating ".tar.gz" (and
   ".tgz") archives.

But I agree that all of this is subjective. To me a 2% reduction in CPU
use (at the cost of ~20% increse in wallclock) & some unclear benefits
to teaching users that they can't rely on our "gzip" output seems
unclear or hypothetical.

Whereas the widespread breakage reported is very real, and we should
consider GitHub as a canary for that, not the the stand & end of its
potential impact.

As we didn't have a strong reason to change this in the first place (and
as my series shows, we can have our cake & eat it too if we don't have a
"gzip") I think the obvious choice is to go back to using "gzip".
