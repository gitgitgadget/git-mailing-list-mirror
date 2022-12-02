Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02692C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 17:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiLBRCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiLBRCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 12:02:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C8EA9CEC
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 09:02:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n21so12932677ejb.9
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlWAmnXy+45zJjlgO+pMgx/t7vUvHDRZ0BBCP+xw1/c=;
        b=bLd6ihjQzroKO/TyXHg/82aP2oIdqWr8sRO7Dia1bmv6YD2ae97svxEFFd+5xKHIou
         27frwSqQE2jBJA+FFjC0K2yEyi/IvXHi9ZcVzgqskonnU0lQAGUm6jAImFgyTTzbkJXr
         1dBzeMYREzKj/nDHBIFHjfX0mUY7FLDOQWLIztxKxDjZd5lDRTRdqjmngJxZh3fOe0U6
         vMt0mhRAo8cjYN4w7n5UcQj+4yyKGlJaJaDLIRkWqkaE/W2BTBlAgzoaBT5XKGsS1zNe
         LrZTGEXNS4oP8MtrF7dijLLBiefKJqK9hIjWHwWD7TBx5Fz4LuCHF0TgjZhOLtUyKAEy
         okOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlWAmnXy+45zJjlgO+pMgx/t7vUvHDRZ0BBCP+xw1/c=;
        b=rtsovKHAjO6p0XNKOT6Vy4HudqhC/HvkrSKa0eEiJTHPD27nZkwr+/qSz6XdK9PQMn
         8iq+gZ7gjiypi7k8a5pnE9p/cYz+Dk+OPVbLNbJfLcKwRT4RWXE/sPhCqYTf0a8e9y2F
         mQrlshZEfJqxSJtfyNqYx3O5fQuKWFZjXo22oWIWvUKecItt0zE13VtW/OiiOsTe9deQ
         kopoR74eqXrKjlo4+sL5B1NePBQDsWNMd5yx7u2pZbZrRySGtA8gVfQU3mFJvAi2GygN
         eAxT9KJL8IJSDkbNsRHt5J6oPoyaR/zzHlA7A806zLIG2JNvCqrjnCnwsGof6Ie454dz
         ViMA==
X-Gm-Message-State: ANoB5pl90sNCCaMtyVvLLYPMA4BX802JV1/fS26286bcOx2RMEK+x57Z
        XczOHvLvjiHR5mG1VMOGhy8=
X-Google-Smtp-Source: AA0mqf7WwH41xJDceNz2FZEwIfHIBZoH7td9Pl/ONvsS07GHy812dZkdbwAIKrvKty9kLGHhbEcsTA==
X-Received: by 2002:a17:906:7f90:b0:7c0:ba2c:a4e8 with SMTP id f16-20020a1709067f9000b007c0ba2ca4e8mr5390348ejr.642.1670000535443;
        Fri, 02 Dec 2022 09:02:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709067b4800b007aed2057eacsm3188696ejo.221.2022.12.02.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:02:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p19QR-002lgq-1h;
        Fri, 02 Dec 2022 18:02:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Fri, 02 Dec 2022 17:40:34 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
Message-ID: <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Phillip Wood wrote:

> On 01/12/2022 23:00, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>>>> Junio please drop this series when you rebuild next as it breaks
>>>> manually running individual test scripts when building with Visual
>>>> Studio.
>>>
>>> I think the issue you've spotted is easily fixed on top. See below.
>> Smells more like papering over than fixed, but let's see how folks
>> who need cmake/ctest feel about it.
>
> As MSVC uses different directories for debug and release builds there
> can be more than one build directory. I don't think selecting one of=20
> them at random using 'find' is a good idea.

I think the latest iteration submitted today should fix that issue:
https://lore.kernel.org/git/cover-v5-00.15-00000000000-20221202T110947Z-ava=
rab@gmail.com/

>> Let's mark the series never to graduate to 'master' for now,
>> optionally revert it out of 'next'.
>>      Phillip, you asked about rebuilding 'next', which would not
>>      happen until 2.39.0 final---did you mean reverting the topic out
>>      of 'next'?  Do you need 'next' without this topic, not just
>>      'master'?
>
> I don't mind waiting but I'm not a Windows user. I only tested this
> topic under Windows because I knew =C3=86var had not and a quick web sear=
ch=20
> for "MSVC CMake" made me worry it was broken.
>
> I'm afraid I wont be spending anymore time on this topic. I had hoped
> that having the CMake build work under Linux would help developers
> avoid breaking it. However I'm concerned that if developers do not
> appreciate that there are differences between the Linux and Windows
> builds it will actually create a false sense of security and be used
> as an excuse not to properly test under Windows[1]. Recent events have
> confirmed my view that changes like this need the attention of someone
> with experience of Windows development and given that yesterday was
> the first time I'd used MSVC since about 1994 I do not fit that
> description.
> [...]
> [1] While our CI helps the MSVC job runs CMake manually, performs an
> in-tree build and does not use ctest. In contrast a user running the=20
> MSVC GUI does not run CMake themselves, ends up with an out-of-tree
> build and runs the tests with ctest.

I don't run Windows by choice, and I'm not interested in running a
propriterary IDE (VS) either.

The main reason I'm working on this series is that while we as a project
are happy to support proprietary OS's, it hasn't been a requirement for
participation that you need to buy a copy of Windows, OSX, AIX, HP/UX or
whatever to submit patches.

Of course we have platform-specific code. but this CMake component is
unique in how invasive it is.

It's easy to e.g. stay away from the OSX-specific code in
compat/fsmonitor/*darwin*.[ch], or generally speaking the
Windows-specific C code.

But for CMake it's become a hard requirenment for many changes, even
though it's a contrib/ component.

Now, I'm not looking to get rid of it, it's clearly useful, particularly
with MSVC (or so I've gathered).

But I'd also like some future where any time I and others who don't use
Windows need to patch certain parts of the Makefile that we don't need
to spend a long time bouncing thigs against the Windows CI, but can run
this component other platforms..

E.g. I think for cfe853e66be (hook-list.h: add a generated list of
hooks, like config-list.h, 2021-09-26) I spent at least 3-4 hours on
what should have been a 5-10 minute task of making the relatively minor
change to generate hook-list.h. It was a push, wait 30-60 minutes, find
some minor (e.g. syntax) issue, rinse & repeat.

Now, clearly the outstanding issues with (if any) need to be fixed, and
thanks for sticking with testing it for so long. But hopefully the above
gives you some background.

> In addition to the breakage I reported yesterday 623fde1438 (cmake:
> chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4, 2022-11-03)=20
> causes CMake older that 3.19 to error out when run from MSVC because
> chmod does not exist on Windows. Also when running 'ctest' on "next" I=20
> see tests failing because they cannot find 'test-tool' (I haven't
> tried running the failing tests manually)

That's odd, do you happen to have some output from "ctest" for that?

Our "cmake" build already invokes shell scripts which rely on "grep",
"sed" etc, and the test suite itself invokes "chmod", I just understand
that it's a noop wrapper on Windows.

So I can also re-roll and just ifdef that part awa on win32, but I
wonder what's going on there. I wonder if it's because we'd need to
spawn it via "/bin/sh" (but just skippin it seems better).

One of the things I didn't change with this series is how "test-tool" is
handled. I.e. it's there before in the generated "t/helper" directory,
and in the generated "bin-wrappers/".

We also find it when running the tests with Windows in GitHub CI.

Did you try on v2.38.0 and/or "master" as well?
