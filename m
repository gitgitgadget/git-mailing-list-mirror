Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA40DC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiAOAC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiAOACz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:02:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5EC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:02:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so39760436edc.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jJSh7PRi0Si0SU97x0IVqMoYzSkcZFHz+1Ij+4w2wEE=;
        b=mgO6pcB2zhPjOjsnhjleDssT4FBxJRToAijcGkl1/oADk7gk/cmQoLhn+mws7qqkFj
         /L7+xi88uLYAf5w9HCZoVeXF6bO76YwvtS1YPnjvzSY8suLbzatYm+vvsOkynDj/vcYq
         oDkD98JygAHA7s9dOgyZPDyVZy8l+MyWt0mgiYMzXZ2DxFT828rTM8V128JJrq48yeAN
         nIeGkLgXnXSFC57mrHIq7BwKAQIz69TfoWIO+yaysb1pcyYL6DQ7q3pokL4MSfxTSd/E
         MPJVViYYdDA5e02rDMSxwxcl9XabVfVROyPpyL4Wf1qvkZANMaJBohgwgMDhNi7lF218
         VVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jJSh7PRi0Si0SU97x0IVqMoYzSkcZFHz+1Ij+4w2wEE=;
        b=WvhcGsSiIOxSIHpSwCr6AMVreqGXlLxWyru1KGPC/zel13P2P+tnv35TBreBAQncay
         wGDtWFSIMEKoLVoaAS85aKrE672GhLB9XwF1vCwY1pfXTWmysch2eGiib3L73Ym/Q62U
         BdPG5hI1xOyf6WxIPgCRr69YNEbJhhuytfagJ675hdBQkQcR8/EkqC/CsCwvdc/2EN5B
         dSuI/CpfM13I883TeTxNeHJLGibgt9qjcrzv8A8z4LQ0DrTPVYbcU1sTqJmTOLNB6x3i
         VU0IcwACC6r3eBpd/aKPTFNjSycohI4iiEoNhIUMNX6qsV89jaaKrZ8CNxnv8rGvWIUR
         +tvg==
X-Gm-Message-State: AOAM531ulkNY8E/3ogbaHEiVtgp5iSOc8jCnb49mNgooeFpQhBwjVhB6
        /eWAe9enQosegqRG5g72M/o=
X-Google-Smtp-Source: ABdhPJwsNQWPxibo7O12EkB1cnxylPEavo0IGrlq0V1CkCu6cn9rUpTt+KZu+UnILABpB44z+9V3EQ==
X-Received: by 2002:a17:906:4f92:: with SMTP id o18mr7897048eju.681.1642204973562;
        Fri, 14 Jan 2022 16:02:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 24sm2170654ejg.47.2022.01.14.16.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:02:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8WWy-001H5F-H7;
        Sat, 15 Jan 2022 01:02:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Sat, 15 Jan 2022 00:56:34 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g> <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g> <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net> <xmqqilumayfh.fsf@gitster.g>
 <xmqqzgny7xo7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqzgny7xo7.fsf@gitster.g>
Message-ID: <220115.86tue5rhlf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I think we had this discussion about FreeBSD before and that's why I
>>> specifically dropped that option from the main makefile.  We can either
>>> drop that patch, or we can set it to -std=gnu11 and tell folks setting
>>> DEVELOPER to use a system released in the last five years.  I think we
>>> can be a little stricter with what we require in the case of DEVELOPER
>>> than we might be otherwise.
>>
>> But that is not being stricter, but looser, no?  I thought that the
>> point of -std=gnu99 was to allow us to use C99 features while catching
>> use of language features newer than that, and use of -std=gnu11 will
>> defeat half the point, wouldn't it?
>
> If FreeBSD (or any other platform) cannot do "reject features beyond
> C99", I am perfectly OK to drop -std=gnu99 on such a place.
>
> DEVELOPER=YesPlease ought to be a collection of settings that helps
> the developers the most.  So on platforms that *can* do "reject
> features beyond C99", I prefer to have it enabled when
> DEVELOPER=YesPlease is given.
>
> It seems that -std=gnu99 is only added conditionally even in today's
> config.mak.dev, so it is fine if we dropped -std=gnu99 from there.
> Which means that developers on FreeBSD cannot participate in vetting
> use of features beyond C99, but there are developers on other
> platforms who will, so it's not too bad, I would say.
>
> As config.mak.dev is included after config.mak.uname, something like
> this may be sufficient, perhaps?

Wasn't the initial goal here to check whether we'd accidentally include
C99? Just checking on GCC/Clang somewhere seems sufficient enough,
I.e. something like:
    
    diff --git a/ci/lib.sh b/ci/lib.sh
    index 9d28ab50fb4..94d0d4127b9 100755
    --- a/ci/lib.sh
    +++ b/ci/lib.sh
    @@ -209,6 +209,9 @@ linux-leaks)
            export SANITIZE=leak
            export GIT_TEST_PASSING_SANITIZE_LEAK=true
            ;;
    +linux-gcc|linux-clang)
    +       MAKEFLAGS="$MAKEFLAGS CFLAGS=-std=gnu99"
    +       ;;
     esac
     
     MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    diff --git a/config.mak.dev b/config.mak.dev
    index d4afac6b51f..216f92493fc 100644
    --- a/config.mak.dev
    +++ b/config.mak.dev
    @@ -20,10 +20,6 @@ endif
     endif
     endif
     
    -ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
    -DEVELOPER_CFLAGS += -std=gnu99
    -endif
    -
     DEVELOPER_CFLAGS += -Wdeclaration-after-statement
     DEVELOPER_CFLAGS += -Wformat-security
     DEVELOPER_CFLAGS += -Wold-style-definition
    
We're just starting to get into the whack-a-mole of hardcoding OS's and
compiler versions, it's not all versions of FreeBSD, probably not just
that OS etc.

I've also wondered why we can't just ship our own super-light version of
autoconf to run some real probes, and as a result eventually get rid of
configure.ac, ./detect-compiler, the version hardcoding in
config.mak.dev etc.

Just something as simple as extending this:
    
    diff --git a/Makefile b/Makefile
    index 5580859afdb..f197a07c100 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -2557,6 +2557,15 @@ else
     $(OBJECTS): $(LIB_H) $(GENERATED_H)
     endif
     
    +ifdef DEVELOPER
    +probe/std.mak:
    +       @mkdir -p $(@D)
    +       $(QUIET_GEN)if $(CC) -E -std=gnu99 - </dev/null >/dev/null; then \
    +               echo 'DEVELOPER_CFLAGS += -std=gnu99'; \
    +       fi >$@
    +include probe/std.mak
    +endif
    +
     ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
     all:: compile_commands.json
     compile_commands.json:
