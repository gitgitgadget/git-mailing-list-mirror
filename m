Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A7C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBCA60EE5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhI0Kx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhI0Kxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 06:53:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D3C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:52:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v10so62985699edj.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NQtNumFHxCkcP1/XVE2flqf6oJUiclfsAf7Sv42VdT4=;
        b=VvgPgt2HyBzeCUfotXzs+q1t5NPQ/jZAD0ntKGTFC/VW5f+Ak2td10X91lvPMaqNrw
         IbicZ6pkkn8NrQXSM/cUFdyCO2aujvgmp6Z5hNAvO/BFx8kji5WUPIkOjY12jcdsdIEU
         do+mnspF3cBuARuEVuA0Ol8Hfdm81YXahU+OKNp7XOea4PqMsE3OI0PxW17xSNhrWrWM
         7lHAmsgmO2Vb7INZSJANfwuJB/2LbtsYmAZRgkUSnGH/JoHUsSKjhWhvv4FU0ZlJsiGL
         CKrFKN9BEogHowdcMc480FZ+c4IC9Lnx3+W0cgF8WyfifrE8/Bz8kOvmFFyAiFBpqxYM
         WVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NQtNumFHxCkcP1/XVE2flqf6oJUiclfsAf7Sv42VdT4=;
        b=PlZyDxT7u6ISrUb5l3ov9AbE+/ifgs/neg7DcfOQCneqaL4QfHM73AY9ngWcdXX+/S
         W9JRVCtNckgYac1BpQG7/upenVtjwXQWLMj77t+cXAjnGsVZgTDXAJqFyONSKBL6EC0Q
         jRDItKL6JP0PdH9mPGkvf8gcSYARVWKiQ3eZlpFVVo1lniSpEqhfPnDtF6MFgLTefY0g
         uYaxGF+hjrQeMpjcB2rBEBhmnf8sUvjv0VJgsEQhURPLnnsAdW31IbAKsredk2Yalu49
         eS3614ZDpe1mI26tHVQ5y3nqKVpp4V8xNTLuC76YBNGkcepmTQwoAGGvtX/5kvcDGFeg
         liIw==
X-Gm-Message-State: AOAM533sQzjj3PObD1L8Rg+98yFXY8VEuQvjYg2aNW/kW45wVI5tA0TF
        Ws6Sepk5WocBjkoKtIeUgsQdJ57fsG8KtA==
X-Google-Smtp-Source: ABdhPJxlTPiwoqFcrurTCnP0dRyb/W8BWHkOZC6PnykOcTyRDEB4d6JxNY4uH/qMl1+Gvix5nZtcng==
X-Received: by 2002:a17:906:fc7:: with SMTP id c7mr26946106ejk.333.1632739936583;
        Mon, 27 Sep 2021 03:52:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k20sm8488582ejd.33.2021.09.27.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:52:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/8] Makefile: generate a hook-list.h, prep for
 config-based-hooks
Date:   Mon, 27 Sep 2021 12:38:22 +0200
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
 <8d2ccf02-09ad-3876-9c9f-2dd79f9221bc@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8d2ccf02-09ad-3876-9c9f-2dd79f9221bc@gmail.com>
Message-ID: <87pmsu1eao.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Phillip Wood wrote:

> On 26/09/2021 20:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This series is an incremental restart of the now-ejected
>> es/config-based-hooks and ab/config-based-hooks-base topics. See [1]
>> for a summary of the plan and progression.
>> In v2 the "sed" invocation that generates the new hook-list.h has
>> been
>> changed to be portable under POSIX. See the thread starting at
>> https://lore.kernel.org/git/92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.c=
om/;
>> The portability issue is AFAICT theoretical in that any "sed"
>> command
>> I've tried accepts the old version (I tried the large list of OS's
>> listed in [2]), but better safe than sorry.
>> Other changes:
>>   * I noticed that the run-command.h inclusion in transport.c become
>>     redundant, I removed that and validated the other ones that have
>>     the new hook.h, they all still need run-command.h.
>>   * A whitespace change in v1 in a change to the Makefile makes the
>>     diff for 8/8 easier to read.
>> 1. http://lore.kernel.org/git/cover-0.8-00000000000-20210923T095326Z-ava=
rab@gmail.com
>> 2. https://lore.kernel.org/git/87fstt3gzd.fsf@evledraar.gmail.com/
>> [...]
>> 8:  80aae4d5c13 ! 8:  7420267ce09 hook-list.h: add a generated list of h=
ooks, like config-list.h
>>      @@ Makefile: XDIFF_LIB =3D xdiff/lib.a
>>        generated-hdrs: $(GENERATED_H)
>>              @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS)
>> $(GITLIBS)
>>      + 		$(filter %.o,$^) $(LIBS)
>>               help.sp help.s help.o: command-list.h
>>      ++hook.sp hook.s hook.o: hook-list.h
>>              -builtin/help.sp builtin/help.s builtin/help.o:
>> config-list.h GIT-PREFIX
>>      -+hook.sp hook.s hook.o: hook-list.h
>>      -+
>>       +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook=
-list.h GIT-PREFIX
>
> This is billed as a whitespace change above but this line has actually
> changed since the last version - was that intentional?

I think you're mistaken here, it is a whitespace-only change to the
end-state, but the diff and range-diff are confusing. If I diff the two
Makefiles I end up with when applying v1 and v2 I get:

@@ -2217,7 +2210,6 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 		$(filter %.o,$^) $(LIBS)
=20
 help.sp help.s help.o: command-list.h
-
 hook.sp hook.s hook.o: hook-list.h
=20
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h G=
IT-PREFIX

I.e. only the line between the old command-list.h and new hook-list.h
line is gone.

But the diff for v1 is D/A/A/A and for v2 A/D/A (D =3D Deletion, A =3D
Addition).

I.e. it's one of those times when "git diff" produces a valid diff, and
one that's actually smaller than couldu have been produced with a
v2-like diff given the change in v1.

As an aside I've sometimes wished we had a --diff-algorithm=3Dmaximal or
something, i.e. there's a lot of cases where by just adding one line to
the diff you can produce a bigger but IMO less confusing one.

In any case, the end state looks better & the diff for v2 is more
intuitive to look at.

>>        builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D=
 \
>>        	'-DGIT_HTML_PATH=3D"$(htmldir_relative_SQ)"' \
>>      @@ generate-hooklist.sh (new)
>>       +static const char *hook_name_list[] =3D {
>>       +EOF
>>       +
>>      -+sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>>      ++sed -n \
>>      ++	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
>>      ++	-e 'x' \
>>       +	<Documentation/githooks.txt |
>>       +	LC_ALL=3DC sort
>>       +
>
> The sed change looks good

Thanks for confirming.
