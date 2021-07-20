Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D973A6108B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhGTUVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhGTUKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:10:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE9C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:51:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id oz7so32458254ejc.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HHx9zd2eTdLFeCZLIkv2mmpys8+VHxG6Eo7QRvJVYJQ=;
        b=iLKcLIPbdm1+nt8lYeTRJ6BA2n+SYbF3GB3yg5NBKplZBjMbGziLT7lgN48/cjK30P
         Nk8G2GuqghGNCL78eIM0X4XXdU+F9M2tgZash79kW/lpvf5qsPvfNm75NJoUwfpFaJyH
         Y+rshNkrWr4vzYL+rrXtkM4KlY5F6QSM8/giJZqXKK4UZCjuQegO6ePf5rK9jeDzfiCI
         pPNg1nIc3XNx1YPJ8q+j4Vdp1bZeoMpgbCIYWBrUfIzIPT4GYvO9TuAiMuhP0nVXrNIi
         sI6deG3bhaSaLoMRZjbnAacgQhx9Y2HkZ6ssQWqVNDfbRobWtYRv7bhh1vLPNi/QHprm
         eJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HHx9zd2eTdLFeCZLIkv2mmpys8+VHxG6Eo7QRvJVYJQ=;
        b=md26T3IeGGz0UvwbT9dmWK1rF8Lj+TDxDr1Bwkib4IiRaFp2CmTBmJJvGENZe1N2h2
         UdBpvXaDMHzrjMKbH9ber6qo5H2h+JRWBxzk6l4pmdYgzsjt3iv6CSXjvxTigem05i+7
         qUHH76QSNmYnyYBKtO6eG4fNU9yRrLq/2CtF1mMmdIre3lrUr15m57a3cyVwj5G44eCo
         syGQogrvxChvHsJDLuT0J6b1Sf7GgqNbgkRcsrAi4O90QCLOmOGZmSTj7+f2h+idZZhL
         zZxJNs+KBRUjJ6RzH6K8pCjfLaP6T+jMr6lxZr52eWwWE9u98Xtumx5jYo3SUHMwk0Qj
         7f/Q==
X-Gm-Message-State: AOAM532ruttueIWJNacl0lHQEky15I4aDwhZhdIC0VFyUjxQyF8H3sDz
        YnBzaWTXVCG1kzkLwxEEgxc=
X-Google-Smtp-Source: ABdhPJwT/IrP2sAbSFSQDiz5j7V3PIRFtlyE2iw1qyHXweq5/8vU7MVOje65iZ7WgVOw0kYO39/aHw==
X-Received: by 2002:a17:906:a391:: with SMTP id k17mr35299859ejz.516.1626814290938;
        Tue, 20 Jul 2021 13:51:30 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s11sm1003110edx.30.2021.07.20.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:51:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Date:   Tue, 20 Jul 2021 22:32:38 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
 <87v95tbqgh.fsf@evledraar.gmail.com>
 <c62cf635-1d24-3b63-9566-b98aa2ec2af5@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c62cf635-1d24-3b63-9566-b98aa2ec2af5@jeffhostetler.com>
Message-ID: <87r1fsvhcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 19 2021, Jeff Hostetler wrote:

> On 7/1/21 6:45 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Stub in empty backend for fsmonitor--daemon on Windows.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>> ---
>>>   Makefile                                     | 13 ++++++
>>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
>>>   compat/fsmonitor/fsmonitor-fs-listen.h       | 49 ++++++++++++++++++++
>>>   config.mak.uname                             |  2 +
>>>   contrib/buildsystems/CMakeLists.txt          |  5 ++
>>>   5 files changed, 90 insertions(+)
>>>   create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
>>>   create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
>>>
>>> diff --git a/Makefile b/Makefile
>>> index c45caacf2c3..a2a6e1f20f6 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -467,6 +467,11 @@ all::
>>>   # directory, and the JSON compilation database 'compile_commands.json=
' will be
>>>   # created at the root of the repository.
>>>   #
>>> +# If your platform supports a built-in fsmonitor backend, set
>>> +# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
>>> +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
>>> +# `fsmonitor_fs_listen__*()` routines.
>>> +#
>>>   # Define DEVELOPER to enable more compiler warnings. Compiler version
>>>   # and family are auto detected, but could be overridden by defining
>>>   # COMPILER_FEATURES (see config.mak.dev). You can still set
>>> @@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
>>>   	COMPAT_OBJS +=3D compat/access.o
>>>   endif
>>>   +ifdef FSMONITOR_DAEMON_BACKEND
>>> +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>>> +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DAE=
MON_BACKEND).o
>>> +endif
>>> +
>>>   ifeq ($(TCLTK_PATH),)
>>>   NO_TCLTK =3D NoThanks
>>>   endif
>>> @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
>>>   	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\'=
 >>$@+
>>>   	@echo DC_SHA1=3D\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$=
@+
>>>   	@echo X=3D\'$(X)\' >>$@+
>>> +ifdef FSMONITOR_DAEMON_BACKEND
>>> +	@echo FSMONITOR_DAEMON_BACKEND=3D\''$(subst ','\'',$(subst ','\'',$(F=
SMONITOR_DAEMON_BACKEND)))'\' >>$@+
>>> +endif
>> Why put this in an ifdef?
>> In 342e9ef2d9e (Introduce a performance testing framework,
>> 2012-02-17)
>> we started doing that for some perf/test options (which b.t.w., I don't
>> really see the reason for, maybe it's some subtlety in how test-lib.sh
>> picks those up).
>> But for all the other compile-time stuff we don't ifdef it, we just
>> define it, and then you get an empty value or not.
>> This would AFAICT be the first build-time-for-the-C-program option
>> we
>> ifdef for writing a line to GIT-BUILD-OPTIONS.
>>=20
>
> (I'm going to respond here on the original question rather than on any
> of the follow up responses in an attempt at diffusing things a bit.)
>
> I added the ifdef because I thought it to be the *most conservative*
> thing that I could do.  The output of the generated file on unsupported
> platforms should be *identical* to what it was before my changes.  I
> only alter the contents of the generated file on supported platforms.
>
> Later, when the generated file is consumed, we don't need to worry about
> the effect (if any) on incremental compiles -- we will know that it
> won't be set -- just like it was not set in the original compile.

Okey, so e.g. when we added e.g. USE_LIBPCRE2 we added it TO
GIT-BUILD-OPTIONS unconditionally, so if you pulled that commit you'd
trigger a rebuild on anything that cares about GIT-BUILD-OPTIONS (which
is almost everything).

But you'd like to have the line not added to avoid that one-off
recompile....

> That change appears right before a 12 other ifdef'd symbols also being
> written to that generated file.  Most are test and perf, but some are
> not.  But my point is that the pattern is present already.
>
> The original question also references a 9.5 year old commit which
> uses the same pattern as I've used here.  It also muddies the water
> on why it was/wasn't needed back then.  And hints at possible
> side-effects in some of our test scripts.  So it is clear that the
> confusion/disagreements that we are having with the current patch
> and whether or not to ifdef are not new.
>
>
> So, is there value in being explicit and having the ifdef ??
>
>
> There are well defined Make rules (and Junio gave us a very elegant
> little script to demonstrate that), but the subtleties are there.
> Especially with our use generated files like `GIT-BUILD-OPTIONS`.
> We have a mailing list full of experts and yet this question received
> a lot more discussion than I thought possible or necessary, but it
> took a test script to demonstrate that the results are the same and it
> doesn't matter.  Perhaps the clarity is worth it for the price of a
> simple ifdef.
>
>
> So, how much time have we (collectively) wasted discussing this
> subtlety ??
>
>
> To summarize, I added the ifdef to make it explicitly clear that
> I'm not altering behavior on unsupported platforms.  I can remove it
> from V4 if desired or I can keep it.  (We all now know that it doesn't
> functionally matter -- it does however, provide clarity.)
>
>
> Sorry if this sounded like a rant,

...I asked because I've looked at that ifdef soup around
GIT-BUILD-OPTIONS and wondered if I could make it go away, and before a
patch lands is a good time to ask "what's this pattern for?", as opposed
to inferring this after the fact.

For me it was just a minor curiosity, I didn't expect to start this big
discussion about it. I expected just a "oh, I just copy/pasted that from
the lines at the end" or something, which would be fair enough.

I really don't care which one we go for here. If you want to change it
fine, if not that's fine too.

I have noticed a pattern where you seem to really carefully consider why
you'd like X over Y. I.e. it wasn't just copy/pasting in this case if I
understand you correctly, but a carefully thought out decision to not do
it like the other C-level-GIT-BUILD-OPTIONS.

Okey, fair enough, but that decision then doesn't go into the commit
message, and then when I innocently ask about it...

..I guess I'll stop before this starts resembling a rant on my part :)

Anyway, I have also had really non-trivial comments on this fsmonitor
series, not just a few bikeshed comments. I.e. the un-addressed question
about the wildly different performance numbers we seem to have seen in
our respective testing:
https://lore.kernel.org/git/871r8c73ej.fsf@evledraar.gmail.com

I think that's much more interesting than this relatively light-reading
bikeshedding I had while giving this a read-through.
