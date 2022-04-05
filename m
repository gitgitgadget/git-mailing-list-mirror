Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCAFC4167D
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383740AbiDEVpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457543AbiDEQIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:08:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155C225CD
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:06:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so27747409ejb.4
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Rft2OtqvT/A/gKzmm/CnF/zc2YbPJWxar8u8sAMi8D4=;
        b=jnvkuWMMJTIglf6WNrKwzQtx8wdTCu7TQIE3QHFj3zlWxlZYwGzikO5G3YSQiHpliG
         Z8KQaEdpURn7th1IlQC0x+xTaJTZOR6nKC1jn5MQIqadHMr6s7j/oyBqZR7TcMxf2ALX
         PUcLD3VLldI/CdxcJdRynqUsrBsLfuomk3zgoix4tPgt8UWwmTUgQAW5Uf0F+eUilPiP
         +PjrtZXMaZGb4GfS9UyiG4klkQGf9dq1YtbEYKvlTYxaLxwHZS/88tMEYIcfyT8K1Ldp
         e72zSZeb0r5aYt5VkDmYfrJTS+3YsTWSb9+FsmMT2HRymHYFtBaIDku0TsiA/DDUdhIS
         s5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Rft2OtqvT/A/gKzmm/CnF/zc2YbPJWxar8u8sAMi8D4=;
        b=lwV6yHtO3JMtoAulKnQqsfyMCErBTWIXG9UaQZPgfdUTsI4hcNpa4684YnVlT2BacQ
         y2wmzQ9xtg2L56hyZSxcRLicKt++2Q8HQQWcYfZRYwSJQp8Ka/IIUA5juCz86IkLHcIj
         U8AiC15ykXguaLO3K5UVgJyyX3xEtGz1otYBg+C/miBsl4zdhsL566UCUiuYcLJ6LEFb
         fsZftJk1684hpSB1pAfUPi1Z5Mc8yoA563soAuHt8qncWfyHJZg2Y0RxwCmWybZURi1T
         PK0siD1ecUXerZqIiIctkuLsgWoZ4rfmqKLCM5wGy63Jx917If8ZQtS6ESGi0JMed23f
         QFqg==
X-Gm-Message-State: AOAM530EFQ+85Iv0nAL0sA7q0GGKexHwbXVXGQo/wQGS9ke7rF4iLcGR
        p9BQWv47z3k3k/xeJ6h2UXE=
X-Google-Smtp-Source: ABdhPJw2K9JnPVYCfJWCYZlhVG1eGgcvwQzCbx9FbewrfxvVqCQevBJJ9zTvY59FMqF+l/nS2OaMJA==
X-Received: by 2002:a17:907:3e16:b0:6df:b4f0:5cc2 with SMTP id hp22-20020a1709073e1600b006dfb4f05cc2mr4316878ejc.285.1649174798365;
        Tue, 05 Apr 2022 09:06:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm5637530ejf.127.2022.04.05.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:06:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nblhU-000CSo-Ny;
        Tue, 05 Apr 2022 18:06:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/8] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Tue, 05 Apr 2022 18:04:35 +0200
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
 <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
 <patch-v5-5.8-18e0a6985f1-20220303T160155Z-avarab@gmail.com>
 <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
Message-ID: <220405.86r16bfrar.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Adam Dinwoodie wrote:

> On Thu, Mar 03, 2022 at 05:04:16PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> This was added in 30248886ce8 (Makefile: disable default implicit
>> rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
>> apply to all our Makefiles.
>>=20
>> This doesn't benefit the main Makefile at all, since it already had
>> the rule, but since we're including shared.mak in other Makefiles
>> starts to benefit them. E.g. running the 'man" target is now faster:
>>=20
>>     $ git -c hyperfine.hook.setup=3D hyperfine -L rev HEAD~1,HEAD~0 -s '=
make -C Documentation man' 'make -C Documentation -j1 man'
>>     Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
>>       Time (mean =C2=B1 =CF=83):     121.7 ms =C2=B1   8.8 ms    [User: =
105.8 ms, System: 18.6 ms]
>>       Range (min =E2=80=A6 max):   112.8 ms =E2=80=A6 148.4 ms    26 runs
>>=20
>>     Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
>>       Time (mean =C2=B1 =CF=83):      97.5 ms =C2=B1   8.0 ms    [User: =
80.1 ms, System: 20.1 ms]
>>       Range (min =E2=80=A6 max):    89.8 ms =E2=80=A6 111.8 ms    32 runs
>>=20
>>     Summary
>>       'make -C Documentation -j1 man' in 'HEAD~0' ran
>>         1.25 =C2=B1 0.14 times faster than 'make -C Documentation -j1 ma=
n' in 'HEAD~1'
>>=20
>> The reason for that can be seen when comparing that run with
>> "--debug=3Da". Without this change making a target like "git-status.1"
>> will cause "make" to consider not only "git-status.txt", but
>> "git-status.txt.o", as well as numerous other implicit suffixes such
>> as ".c", ".cc", ".cpp" etc. See [1] for a more detailed before/after
>> example.
>>=20
>> So this is causing us to omit a bunch of work we didn't need to
>> do. For making "git-status.1" the "--debug=3Da" output is reduced from
>> ~140k lines to ~6k.
>>=20
>> 1. https://lore.kernel.org/git/220222.86bkyz875k.gmgdl@evledraar.gmail.c=
om/
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Makefile   | 2 --
>>  shared.mak | 5 +++++
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 1ac924bd844..ce362720947 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2580,8 +2580,6 @@ ASM_SRC :=3D $(wildcard $(OBJECTS:o=3DS))
>>  ASM_OBJ :=3D $(ASM_SRC:S=3Do)
>>  C_OBJ :=3D $(filter-out $(ASM_OBJ),$(OBJECTS))
>>=20=20
>> -.SUFFIXES:
>> -
>>  $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
>>  	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $=
(EXTRA_CPPFLAGS) $<
>>  $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_di=
r)
>> diff --git a/shared.mak b/shared.mak
>> index 29f0e69ecb9..1dda948df09 100644
>> --- a/shared.mak
>> +++ b/shared.mak
>> @@ -9,6 +9,11 @@
>>  %:: s.%
>>  %:: SCCS/s.%
>>=20=20
>> +## Likewise delete default $(SUFFIXES). See:
>> +##
>> +##     info make --index-search=3D.SUFFIXES
>> +.SUFFIXES:
>> +
>>  ### Flags affecting all rules
>>=20=20
>>  # A GNU make extension since gmake 3.72 (released in late 1994) to
>
> I confess I really don't understand why, but as part of testing
> v2.36.0-rc0 on Cygwin, I've started getting errors building the info
> pages, and bisect points to this commit as the culprit.
>
> Specifically, I've been running
>
>     git clean -dffx && make configure && ./configure && make -j4 info
>
> Without this commit, that gets me a successful build; there's a bunch of
> noisy warnings that have been hanging around for a long time, and I think
> are fundamentally due to the slightly mismatched documentation libraries
> that Cygwin has.  With this commit, I get the same noisy warnings, but I
> also get the error "could not open .texi: No such file or directory".
>
> I have to confess, I don't really understand this aspect of GNU Make, so
> I'm not sure if this is a problem with Cygwin having a bad toolset or
> there being something about my environment that means this doesn't work,
> but regardless, it's currently causing the Cygwin Git builds to fail.

Hi. I can reproduce this locally, will look at it and fix it, sorry.
