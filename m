Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07936C636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00B0613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhGPQ5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhGPQ5b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:57:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2640C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:54:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id go30so16111071ejc.8
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZXP0G1W5zfqsCNv6lKzN+vvtZdf3Q9g1jMhdK8OWcQw=;
        b=RCObGyOW5B6bx6r48oyEjF7HR4wdFJFOYHj7w4U+J+UDBKl8EUuhIvOzylnYlbvRof
         eBxji5+gaaJvHeWyVg6euaT1OlST0rztIkkTZcConxW/mfWnMNxJr7nU1kefd6GClwS0
         UgVx5PhV6xrd0HREjx2ZJHwoLgOlap+JFlh7qgvAMpYmrvaT+b6MrTHiwxSQZ0ppgllL
         3e68mQ9cHY3iW8xuy484e76jx0V5XB7HGHNoQ6iofrxrHW6pM/wmkUXvAem/f2SuLUul
         dZ7IwAqrnr6BlEyF3XYCqr/w/LowPHdNddfhg+dY0vXW9NvQpAKBlF+D8aYP6eyT9ALo
         mBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZXP0G1W5zfqsCNv6lKzN+vvtZdf3Q9g1jMhdK8OWcQw=;
        b=EoPRwwYlFgh3Kt96nSfjgFDy2dWwmLtMPB9bXQmAsx/jpo1j+hn7y0H5fza3BwEwc5
         O4I/Q4+Bk+xiozlKjRMH/z31HA7dMPRSQm46KonP5AfFDWFMpRhHoEKGlQAbTvUIyR+n
         Hy8BVUgLdUzY0HeDNplMMyV+bdB90Ilf30MwshY8sf3QRn3PeGxA+tMwGMmFuTz6wp4R
         C6VEF3SRFgORDcWZf9mzGgZ1is0beMyCKcaqfCNIxQW7ZUdNPoC9Otx053RbzEm5D3wg
         9ewvxsHjubAy8ID7xxDWmITfmfi4LoqRysGcFx4BGDO2Sq76mqeH9/xO0Z8NakIUMOGu
         2jog==
X-Gm-Message-State: AOAM531sUwUv2XY31aEp31bO3ibcNRx/ngkswQE7y2dbpIDjFEO5ApFq
        Xrp2meNVFWeSeqM9oYEaink=
X-Google-Smtp-Source: ABdhPJxyyLSHQlvTtj7b+o9Lr2yD7zeIQQ37vF/OUFcEtj52hSuOkZzVmyzlvgyYKhzIfXyJ9bF4bQ==
X-Received: by 2002:a17:906:b53:: with SMTP id v19mr12641814ejg.262.1626454470234;
        Fri, 16 Jul 2021 09:54:30 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g23sm3986496edp.90.2021.07.16.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:54:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
Date:   Fri, 16 Jul 2021 18:52:07 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
 <87sg0xbq9v.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
Message-ID: <871r7yxkq8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>
>> > From: Jeff Hostetler <jeffhost@microsoft.com>
>> >
>> > Stub in empty implementation of fsmonitor--daemon
>> > backend for MacOS.
>> >
>> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> > ---
>> >  compat/fsmonitor/fsmonitor-fs-listen-macos.c | 20 ++++++++++++++++++++
>> >  config.mak.uname                             |  2 ++
>> >  contrib/buildsystems/CMakeLists.txt          |  3 +++
>> >  3 files changed, 25 insertions(+)
>> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
>> >
>> > diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsm=
onitor/fsmonitor-fs-listen-macos.c
>> > new file mode 100644
>> > index 00000000000..b91058d1c4f
>> > --- /dev/null
>> > +++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
>> > @@ -0,0 +1,20 @@
>> > +#include "cache.h"
>> > +#include "fsmonitor.h"
>> > +#include "fsmonitor-fs-listen.h"
>> > +
>> > +int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
>> > +{
>> > +	return -1;
>> > +}
>> > +
>> > +void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
>> > +{
>> > +}
>> > +
>> > +void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *s=
tate)
>> > +{
>> > +}
>> > +
>> > +void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
>> > +{
>> > +}
>> > diff --git a/config.mak.uname b/config.mak.uname
>> > index fcd88b60b14..394355463e1 100644
>> > --- a/config.mak.uname
>> > +++ b/config.mak.uname
>> > @@ -147,6 +147,8 @@ ifeq ($(uname_S),Darwin)
>> >  			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
>> >  		endif
>> >  	endif
>> > +	FSMONITOR_DAEMON_BACKEND =3D macos
>>
>> A rather trivial point, but can't we pick one of "macos" or "darwin"
>> (I'd think going with the existing uname is better) and name the file
>> after the uname (or lower-case thereof)?
>>
>> Makes these make rules more consistent too, we could just set this to
>> "YesPlease" here, and then lower case the uname for the file
>> compilation/include.
>
> So you suggest that we name the new stuff after an `uname` that reflects a
> name that is no longer relevant? I haven't seen a real Darwin system in
> quite a long time, have you?

It's not current? On an Mac Mini M1 which got released this year:

    % uname -s
    Darwin

We then have the same in config.mak.uname, it seemed the most obvious
and consistent to carry that through to file inclusion.
