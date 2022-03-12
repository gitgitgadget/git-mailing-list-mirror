Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D664C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 10:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiCLKln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiCLKlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 05:41:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57892E3F
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 02:40:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t1so13569013edc.3
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AVHgLAar1nwa3yqusOhwKzUKPIUJGt+WV/Y7jOoWmcE=;
        b=WN5e2OFQ9HaJ9ryin82pcS45SAbsBzMQAJk6hv951Pwnbl7dJiNGYUMkqaXGNBATKF
         9J/RwcAQZYs+xwQiZj33Mnb5QM07548KF+IDVBxEpFbCZxCRckJOwwCUyW9BqvSXutcj
         Bwe+eAXJ7nZM3TqHFOP3avXS1yiJTmwRN4qWscCByJ/opRJgFDhMHBjCa9CFyPbij+d0
         CEXmVG4ZH/R4isj6icIBoGnlSfSKUNjdoBwI+X4rPQSyxwmsAH9ujLEpKRSxDAMtp1du
         5LrZBFAfQefNqunnNqOct/jO1RikF72CU0P5b0311B+bGB1QekUUt9mKQZQTY/k+UdOX
         MevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AVHgLAar1nwa3yqusOhwKzUKPIUJGt+WV/Y7jOoWmcE=;
        b=WTGZ714eNGNAQ865e7dLYcJ2BYhy6MT+6mXsz09yDzULYlqwWo0sCIwoynELcbDk5j
         +zOP/YQ7h0C51+hZeX6VFwe8heiO2798gB5unGuTgWYaHClh2lNCgdJTt+Ld5Z+Gwy2c
         XkpQ5D+Lp/1V9Nvrmgrq6m8OkauTv1embcoMdCer6kCkiEjccMafK7DoAnyV0tECiyku
         7+sY1jG8dlOQp5WJ2NAVXdRW/gmFsfFokzvGNdoWJAzOE8nmXA6kF1FNk9btUgzLpLJy
         ZqAlIuMn+eHqtAvF9916LSjtK+6q5lSb3EctguBNTTs4n+KlSTxR2/94VKg+U68yBjFD
         cQAg==
X-Gm-Message-State: AOAM530VrYJvWcuf2NG+HzXu/V+ijIgbuqpp+1YIQZTGFk1zrqeI8kDP
        mQ85YkAqlJn7Eyk6zisA7V4=
X-Google-Smtp-Source: ABdhPJxVifASGMB7flqehzCMGmbyFRCorVbNdTf20SXZHaO37Qv5qo4Wxvmueu1EBpIW22EIeB5UNA==
X-Received: by 2002:a05:6402:12d7:b0:415:ced2:389d with SMTP id k23-20020a05640212d700b00415ced2389dmr12782953edx.197.1647081635646;
        Sat, 12 Mar 2022 02:40:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a102-20020a509eef000000b0041614c8f79asm4626765edf.88.2022.03.12.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 02:40:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSzAo-0002Vf-Dm;
        Sat, 12 Mar 2022 11:40:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel?= =?utf-8?Q?=C3=B3n?= 
        <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
Date:   Sat, 12 Mar 2022 11:38:33 +0100
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com>
 <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
 <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
 <xmqqv8wnm30q.fsf@gitster.g> <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
 <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
Message-ID: <220312.86o82bfo7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Eric Sunshine wrote:

> On Wed, Mar 9, 2022 at 3:14 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Wed, Mar 09 2022, Junio C Hamano wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> This seems to work, though it's getting a bit verbose:
>> >>
>> >>     awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
>> >> - 2.34 < 0) exit 1 }'
>> >
>> > In general it is a good discipline to question a pipeline that
>> > preprocesses input fed to a script written in a language with full
>> > programming power like awk and perl (and to lessor extent, sed) to
>> > see if we can come up with a simpler solution without pipeline
>> > helping to solve what these languages are invented to solve, and I
>> > very much appreciate your exploration ;-)
>>
>> I agree :) But the first language we've got here is C. Rather than
>> fiddle around with getconf, awk/sed etc. why not just the rather
>> trivial:
>>
>>         +#include "test-tool.h"
>>         +#include "cache.h"
>>         +
>>         +int cmd__glibc_config(int argc, const char **argv)
>>         +{
>>         +#ifdef __GNU_LIBRARY__
>>         +       printf("%d\n%d\n", __GLIBC__, __GLIBC_MINOR__);
>>         +       return 0;
>>         +#else
>>         +       return 1;
>>         +#endif
>>         +}
>
> It feels overkill to add this just for this one case which is
> otherwise done easily enough with existing shell tools.
>
> That said, perhaps I'm missing something, but I don't see how this
> solution helps us get away from the need for `expr`, `awk`, or `perl`
> since one of those languages would be needed to perform the arithmetic
> comparison (checking if glibc is >=3D 2.34).

In this case they're \n delimited, so we can use the shell's native
whitespace splitting to $(())-compare $1 and $2.

But probably better is to just amend that to call it as "test-tool libc
is-glibc-2.34-or-newer" or whatever. Then just do:

	if (__GLIBC__ > 2 || (__GLIBC__ =3D=3D 2 && 34 >=3D __GLIBC_MINOR__))
		return 0;
	return 1;
