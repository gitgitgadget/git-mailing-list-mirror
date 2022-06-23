Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiFWKlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFWKlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:41:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB413E07
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:41:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q6so3175945eji.13
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=y9pacfwq2bRz2M8JXEXZL/GpIzGM0URR3xF1AnayxxM=;
        b=aJ0TlOeDYIDMenqkh8p56nLs0x9W2l6RfoWfvTMuGpbLAooGfexKa7TNig88elbF2q
         Hj++sJl53o2K5W8P+Dfw4l6/tFROqQ9qf8RBQ+0w572G1yvSkHkhnOElWU9yGCaSerbz
         XwC0EIgQqelKYPDVs71s79US1MLMp5lTeG8YkmI3AdWYavoBI/LjL9jDnSaCThYThzRp
         WQP037qBpRMVtITlFxyBvugRUuaqWgg/BTM27DXeKmzEt2GRW0nfOlAG5lFDOFGph1Wl
         jfcKiZafSIGazHaS74izOJD4Rn9NcOMUgaPKad8GcrA5t67O+hCM6UmNMOM7tsqMrMGb
         k/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=y9pacfwq2bRz2M8JXEXZL/GpIzGM0URR3xF1AnayxxM=;
        b=baB9s9czENsHT0FyxV7x/ONuT37ZDDkvbE7JE7AuZiGYo98KYxjSRHxmRAvFEzjb1k
         Ni9AuzUg7flukKpzn/HUE4nSMIqE1dFmls04oDjm7xN+RDOIewQ5Npuw+wnuoga8lbPy
         ZJTjBHIxl3M4D73pZ3q6/6rQaaEUFpUdMmCQLEKgx0YA8kkWX7vz5mKEFyo2tG7n+EBD
         UvVpBNvmq9nkXdSutuM5iYLquq9Tt/nRPH0lbu8zZduWufzxXIyv+lYJx9qEAnqp2xQi
         PNmVm02JI/dmrZMtshratGWP9M3bys3TsE1SPomHFlqbRj3LpHkeImjai/M5xN23d9cU
         dLww==
X-Gm-Message-State: AJIora+VZw5904zupAsWJgejJETk9JSTz+eXmsyLWomDapaZ1+yFwZxi
        qhvPnyjgrdm67NTPtelAxN+xEGlKv0tr8A==
X-Google-Smtp-Source: AGRyM1vPrQ69dyeb1uAL7aWDAxgwm56sKGx3Sm2UBehMHWWLy+09hxxmpbUh4qUWXobmQ/QTHEOarg==
X-Received: by 2002:a17:907:a424:b0:702:f94a:a897 with SMTP id sg36-20020a170907a42400b00702f94aa897mr7300566ejc.255.1655980894442;
        Thu, 23 Jun 2022 03:41:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090631d000b006f3ef214d9fsm10529830ejf.5.2022.06.23.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:41:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4KHE-000rf3-OY;
        Thu, 23 Jun 2022 12:41:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
Date:   Thu, 23 Jun 2022 12:29:58 +0200
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
 <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
 <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
 <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
 <220622.86r13hkp2c.gmgdl@evledraar.gmail.com> <xmqq7d587lqx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d587lqx.fsf@gitster.g>
Message-ID: <220623.865ykrll0j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>   - I wondered if "make NO_PERL=3D1" would complain about "gitweb" being
>>>     in the default targets. It doesn't, but it does actually build
>>>     gitweb, which seems a little weird. I don't think we actually rely
>>>     on perl during the build (e.g., no "perl -c" checks or anything),
>>>     and the t950x tests seem to respect NO_PERL and avoid running the
>>>     generated file. So maybe it's OK?
>>
>> I think it's arguably a bug, but as you note we build/test etc. without
>> errors, and I think it's restoring the state before e25c7cc146
>> (Makefile: drop dependency between git-instaweb and gitweb, 2015-05-29).
>>
>> Arguably we should replace with a stub script like git-svn et al, and
>> arguably we should leave it, as you're more likely to e.g. run gitweb on
>> a webserver, so even if you build a "no perl" package, perhaps it's
>> convenient to have "gitweb" part of it, and then on that one box that
>> runs it you'll install perl...
>
> It is perfectly acceptable to "make DESTDIR=3D... install" and tar up
> the result on a host with NO_PERL and extract it on the target that
> is capable to run gitweb, isn't it?  As long as "make NO_PERL=3D1"
> gives exactly the gitweb as a build without NO_PERL, that should be
> OK, I would think.  I would think what you have is in a good state.

I think so, but it is inconsistent with how we treat the rest of the
*.perl scripts, which I think is what Jeff is correctly pointing
out.

I.e. if you do this your git-send-email, git-cvsserver, git-svn
etc. will be replaced by this shellscript:

	#!/bin/sh

	echo >&2 "fatal: git was built without support for $(basename $0) (NO_PERL=
=3DY)."
	exit 128

>>>   - Speaking of backwards compatibility: after this series, "cd gitweb
>>>     && make" yields an error. It's got a nice message telling you what
>>>     to do, but it's likely breaking distro scripts. Again, I'm not sure
>>>     I care, but if the point of the exercise was to avoid breaking
>>>     things, well...
>>
>> I think that's OK, having maintained those sorts of build scripts in a
>> past life.
>>
>> I.e. when you upgrade the package it's a minor hassle, and the error
>> tells you exactly what to do, and the fix is a 2-3 lines in your recipe
>> at most.
>
> We could easily add "cd .. && make gitweb" to gitweb/Makefile with
> the same "minor hassle" but that needs to be done just once, instead
> of having to be done once per packager, so I am not sure the above
> argues for a good tradeoff.

True, but I think critically in this case we've never documented that
you should be running gitweb/Makefile directly. I.e. the gitweb/INSTALL
has always documented and assumed that you run these from the top-level.

There's no "make gitweb" target in the sub-Makefile, and the
instructions make it clear that it's the top-level, as we also suggest:

    make configure &&
    [... no cd-ing to gitweb/ ...] &&
    make gitweb

(and there's no "configure" there either).

So I think this will Just Work for anyone who's packaging this already,

I was just going above & beyond in being friendly by emitting that new
message saying you should be running "make" at the top-level in case
anyone built this in a way that we never documented, but which happened
to work before.
