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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9532C11F67
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75C7613AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhGMSUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhGMSUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:20:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548BC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:17:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w14so22742836edc.8
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A2kl4dLKLx7kH57mD41jce/5xWhXEurNZ5R/PRRCC48=;
        b=l3vh75qOanVqE7S04vnqKKWwsSBHIqThDYU7gxEMwjiedyRSnfZfdJF1Cfyqydrs2J
         6mX9XPx75JCAxQpDj/FjGaRHH4jxPiengCDOYs3lnbJoXS4V90zBKeyfU2zAmLxKR90W
         viBeHGdvR7daMpHXdqUoLeIDcsnGJxVUBVwRlma0yKMucLms1ogvkVde6FWQgjjCAj5E
         owDP6kcvRmZxeZTHhiobxePfoqAK2lg1gzR/3W7H9zokio5GP9b2STnEYsN9vvVLRuFZ
         ONLK9MnXH8K/C3StMO5//Ak4dNN1Q5V3U8s+xYW1jeDXAi/X4a8SCnfiJzGgX9dWq2Qk
         8KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A2kl4dLKLx7kH57mD41jce/5xWhXEurNZ5R/PRRCC48=;
        b=hADeZpqPF/szgq29xcg6/4Ax81hpzWdahAgShMdlDjjq8WxMS/EGnxC4cReNWOCcB6
         THSfPNS86LtmDbKDmbQNXAYOMK8/OZFb5ljHtu8qkQpcu6xHsxUxX5/TVULX/kN/efe5
         9iOe3T9tkWOrsyp+1QuoJ4z5qKG+bWo/Y7NwQUHpqN0d4epkbOtKyz2ZPXtTGJdWmHqj
         aLluiVVrrioq1V+nkQny2yKxVRgGOaKiQwn4fyrjZSTo0e05GjTuVYkFZvrLKlK25ZNn
         SQJn5tXiagC1tGj63J7k51zf9NuIaUtkwuPNXEbLuwZ3d5ujR9J15PnstSzzNInGXXgz
         sZPA==
X-Gm-Message-State: AOAM532eScLyYIoIyLYHgkCXTcF5BE+wBuztl0E22Wa+nq8HUkJMocyO
        5751/YG1/dHKgzLKxwGux+o=
X-Google-Smtp-Source: ABdhPJymmsx3JTUxIpMAH4fJgGEG+RWm+Lx46GiC1RKqub36zT/Ye7JJJ3x3xUVIFEO7Hh2nOD4QrQ==
X-Received: by 2002:a05:6402:160d:: with SMTP id f13mr4266980edv.295.1626200277032;
        Tue, 13 Jul 2021 11:17:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id op23sm6214134ejb.7.2021.07.13.11.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:17:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
Date:   Tue, 13 Jul 2021 20:15:07 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <87k0m9bpmv.fsf@evledraar.gmail.com>
 <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
Message-ID: <87mtqq2i3r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> On 7/1/21 7:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Teach the win32 backend to register a watch on the working tree
>>> root directory (recursively).  Also watch the <gitdir> if it is
>>> not inside the working tree.  And to collect path change notifications
>>> into batches and publish.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>> ---
>>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++
>> <bikeshed mode> Spying on the early history of this (looking for the
>> Linux backend) I saw that at some point we had just
>> compat/fsmonitor/linux.c, and presumably some of
>> compat/fsmonitor/{windows,win32,macos,darwin}.c.
>> At some point those filenames became much much longer.
>>=20
>
> Once upon a time having "foo/bar/win32.c" and "abc/def/win32.c"
> would cause confusion in the debugger (I've long since forgotten
> which).  Breaking at win32.c:30 was no longer unique.
>
> Also, if the Makefile sends all .o's to the root directory or a
> unified OBJS directory rather than to the subdir containing the .c,
> then we have another issue during linking...
>
> So, having been burned too many times, I prefer to make source
> filenames unique when possible.

A much shorter name like compat/fsmonitor/fsmon-win32.c would achieve
that goal.

>> I've noticed you tend to prefer really long file and function names,
>> e.g. your borrowed daemonize() became
>> spawn_background_fsmonitor_daemon(), I think aiming for shorter
>> filenames & function names helps, e.g. these long names widen diffstats,
>> and many people who hack on the code stick religiously to 80 character
>> width terminals.
>>=20
>
> I prefer self-documenting code.

Sure, I'm not saying daemonize() is an ideal name, just suggesting that
you can both get uniqueness & self-documentation and not need to split
to multiple lines in some common cases to stay within the "We try to
keep to at most 80 characters per line" in CodingGuidelines in this
series.
