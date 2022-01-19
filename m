Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C0C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiASA2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASA2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:28:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642BC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:28:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so3047500edd.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d71PYJuzRNU2/6YwE/885npc9GLS7acTx2z9nZDAAWE=;
        b=YA+viPStKPKIB5rx7GrsuKn01dBkz5wWbT2F+IH2nmr8UPKWBzqTeoiryiw7kP2IES
         5m9JagRH5ZVDXBFPDAof6mCnq9Vof6w4KNOxAYaVZpw30qEdi76tP9QRFYdYqjcrsGa8
         0woYJAWolJH5vMoQlGRogM9G/vGUtQcuE1fD147pOoBpiOAldHKYg/9j8dOTJJo/GSei
         LLuD8IhRdHXM52MStmYS0WlLwX8sU9NcZaFKxCtTTnF67UlAWcK2bhE7PBQfUjxlTS/J
         7PrZnapbgvlUXMLKCUvvrBKgN3oGkG9dXpAkPjE1KsCIlwJ/jNnk5yBeIu5d2eIiAovR
         +63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d71PYJuzRNU2/6YwE/885npc9GLS7acTx2z9nZDAAWE=;
        b=7/ukkz5SYxDK/oxnEiISVaFyI7TyRWnEhGscujsQOGf69jwVY153OVjOZeM59PMaVb
         VN1dHBDmd5XeKu9co8fdvL/S4MwWxQO8w790GNt3AfqsqZ/mw/MK6PcvIHLTwHbsEDzN
         KAYG3uo8wHFS2648Wr+ZDaUpdnsxQHIL0EBMCHeBEvtB3R+jjGVpggBpNoBf/M9pbYKn
         Tpx/yHV9khM/Lmzpeo6H2+JprtOGcPpb+tP+iTL1IRWyKXypOjcJCdv7WJovUsjqCKE7
         1cIDcOuo2xvnmxIQTBslr3oBKbxINZN9rhBTDSwDoCERD4bEEDvcYZsocE/EoFF2fyEH
         uWtA==
X-Gm-Message-State: AOAM532OP3TM/FCU9e4uKwJW+YMPcfjkWFeJttVCyb97mcjg5yfjqyyE
        v554Qzk4psFjK63tZuWtDsQ=
X-Google-Smtp-Source: ABdhPJzYQ11ANuL2EGGNspC9NiF2xjWZ8E8jXRexuaCz+nsN66oHw0wqxn969a8jd58pa8EtYeouyg==
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr13196736edd.167.1642552120380;
        Tue, 18 Jan 2022 16:28:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j9sm5657073ejg.64.2022.01.18.16.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:28:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9yq5-001ghm-JD;
        Wed, 19 Jan 2022 01:28:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, fuz@fuz.su
Subject: Re: [PATCH] config.mak.dev: fix DEVELOPER=1 on FreeBSD with -std=gnu99
Date:   Wed, 19 Jan 2022 01:26:19 +0100
References: <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com>
 <xmqqbl09t10v.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqbl09t10v.fsf@gitster.g>
Message-ID: <220119.86sftko9fu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The inherent problem is that __has_extension() is a way to ask
>> Clang (and GCC) whether the compiler supports that feature, but the
>> -Wc11-extensions warning will be issued on the basis of the selected
>> __STDC_VERSION__. With -std=3Dgnu99 the __has_extension() built-in will
>> return true, but the warning will still fire.
>>
>> Let's narrowly work around this by checking whether:
>
> The end result, if and when a change along this line proves OK for
> all versions of FreeBSD we care about, may be narrow, but as a band
> aid to discuss just before the final release, I do not know if
> anybody can sensibly assess the ramifications of such a change,
> except for somebody whose primary development environment has been
> FreeBSD for the past 6 months or more.

libgen.h is a trivially sized header (~20 lines of non-comment
non-whitespace), and uses __generic for exactly one thing.

If you'd like to go with your patch instead that's fair enough, but I
don't see what using FreeBSD as a primary development environment for an
extended time would buy anyone in understanding this narrow issue
causing the C11 warning.

> This looks way more than we can take comfortably at this point in
> the release cycle, compared to "fixing" the developer build by
> kicking developers on FreeBSD out of the "we are C99 or below at
> this point" enforcement mechanism.
>
>>  A. We are under FreeBSD
>>  B. We are using a C standard older than C11
>>
>> In that case we'll include sys/cdefs.h, and undefine FreeBSD's
>> __generic() wrapper if it's been defined. We'll then load libgen.h,
>> and restore whatever __generic definition we temporarily undefined
>> earlier.
>>
>> An alternate solution would be to simply define NO_LIBGEN_H=3DY in
>> config.mak.uname for FreeBSD, but this way we'll use its OS-provided
>> basename() and dirname(), and in the general case ensure that nothing
>> changes outside of DEVELOPER=3D1 builds.
>>
>> 1. https://github.com/freebsd/freebsd-src/commit/62b7f85d4749
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  git-compat-util.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 1229c8296b9..69d9b5f202f 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -318,7 +318,25 @@ static inline int setitimer(int which, const struct=
 itimerval *value, struct iti
>>  #endif
>>=20=20
>>  #ifndef NO_LIBGEN_H
>> +/*
>> + * FreeBSD's libgen.h inadvertently requires C11 features, due to its
>> + * sys/cdefs.h using _Generic() if
>> + * __has_extension(c_generic_selections) is true, regardless of
>> + * __STDC_VERSION__....
>> + */
>> +#if defined(__FreeBSD__) && __STDC_VERSION__ - 0 < 201112L
>> +#include <sys/cdefs.h>
>> +#ifdef __generic
>> +#define __fbsd_generic __generic
>> +#endif
>> +#undef __generic
>> +#endif
>>  #include <libgen.h>
>> +/* ...continue FreeBSD-specific hack above */
>> +#ifdef __fbsd_generic
>> +#define __generic __fbsd_generic
>> +#undef __fbsd_generic
>> +#endif
>>  #else
>>  #define basename gitbasename
>>  char *gitbasename(char *);

