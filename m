Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7536C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 10:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiEZKEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbiEZKEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 06:04:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325FAF337
        for <git@vger.kernel.org>; Thu, 26 May 2022 03:04:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q15so1175501edb.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CpxXLtgkbYgTBaT388p99rSJSDZ9cWAsVoe2imkSv58=;
        b=aHLRxsqAF6JJfUzS3FeBo5nYNozH4lmu0S5a/fXvqxmC/hUkZz4U+uF6H8b396M/IP
         01Vnvk8mAFqbqPdP1zIj5OPZFBQcZnfiX546f1IQ1HI1Yu3kCCNXoIVA9Peg9658Kj0M
         oyNZuxL6Uxs7yp+E1bpsJEDT5ddLJMtAnIFQue/bRSPp/wMpqGKVWdXQOdwYB3Q3cYE7
         k5CSZLCvANjfCQunxZfcxp/yGptn/5hVkQy1LUGGA45IJQzBNPEASxeNKh2ux9TETwGV
         qPgzPoRJmnPB3Sgchwt6zn41hYwplU8Du6z7PjdCVdfGevTPjcCD3aOetYdR5NX+wCXu
         wU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CpxXLtgkbYgTBaT388p99rSJSDZ9cWAsVoe2imkSv58=;
        b=DFtyj3RilKB3IH3yzKIV0mOXxRYd69My7DRAAKbN7g8vPYTQLNHdPyqDXPkSZZUiH7
         O79EHU+wWZwjK0q30u5qWvZUSwCb4leFcyvkatGpnM4P1PnN489t8uvrXHAsgH3HVrhj
         PzBa/cxtY4L+1Ssx5tr2OwRFL2uU8LTamcoy8ib+bOaKhCwt5vFRcQEreHrlxeeJrB4U
         16yL66BFENkQWIJacqaoprC4YVBwCkQOfUXC+i3bqd31uygMo5qpn2jd40Mhyu7c/18d
         DSxj37tc1LavCQKgZ9sgnJHslpU6XI/aBdRtnxmDq5BVK6iOGegz26kQ8MqQi3sfe5GR
         Z/TQ==
X-Gm-Message-State: AOAM530ma9ixu+s7y+t4tIaw6mIfKmmwikHl1+9nI5Uv0m80E4QKGiJy
        Q6R+tuQJuk86zu/Uy80tXxM=
X-Google-Smtp-Source: ABdhPJw36CMSFgojXNCMc25HKkdHXO3bArTohW2YSnilAIIr68H3yqUhiKGIrN1c66cuUbWEb/DevQ==
X-Received: by 2002:aa7:cfd8:0:b0:42a:c287:362a with SMTP id r24-20020aa7cfd8000000b0042ac287362amr38256535edy.357.1653559441735;
        Thu, 26 May 2022 03:04:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u26-20020a50c2da000000b0042a9fcd7c73sm589792edf.46.2022.05.26.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:04:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuALX-000Bam-Tp;
        Thu, 26 May 2022 12:03:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent
 duplicate targets
Date:   Thu, 26 May 2022 12:00:04 +0200
References: <xmqqtu9d45f7.fsf@gitster.g>
 <20220526021540.2812-1-worldhello.net@gmail.com>
 <xmqqo7zl2b66.fsf@gitster.g>
 <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
 <xmqq5yls3j8i.fsf@gitster.g>
 <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
Message-ID: <220526.86tu9c625s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Jiang Xin wrote:

> On Thu, May 26, 2022 at 2:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>> >>         )
>> >> -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
>> >> +FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
>> >>
>> >>  FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
>> >>  FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
>> >>
>> >
>> > If I disabled the git-ls-files command like below,
>> >
>> >     @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
>> >...
>> > This is because the three generated header files (defined in
>> > $(GENERATED_H)) are also included in the result of "SOURCES_CMD". We
>> > can fix this by sorting LOCALIZED_C:
>> >
>> >     -LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
>> >     -             $(GENERATED_H)
>> >     +LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES)
>> > $(SCALAR_SOURCES) \
>> >     +               $(GENERATED_H))
>>
>> If you make FOUND_SOURCE_FILES unique upfront, the at least there
>> wouldn't be any duplicates there.  Do you mean that some of what is
>> in FOUND_SOURCE_FILES appear in either SCALAR_SOURCES or GENERATED_H?
>
> Yes. If find source files using "git-ls-files", the generated headers
> are not included in FOUND_SOURCE_FILES, but this is not the case for
> the find command.
>
>> If not, I think deduplicating near the source of the issue, i.e.
>>
>>   FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
>
> If we pass the "--deduplicate" option to git-ls-files, we can make
> sure files are unique in FOUND_SOURCE_FILES. So sorting
> FOUND_SOURCE_FILES becomes unnecessary. But FOUND_SOURCE_FILES may
> contain generated files if using find instead of git-ls-files in
> SOURCES_CMD, that means sort FOUND_SOURCE_FILES is not enough. Instead
> of sorting it, we may want to filter-out the generated files from it,
> like:
>
>     FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
>
> Exclude the several generated headers by add extra fixed options to
> find command is not good, but we may need to exclude the ".build"
> directory from the find command in SOURCES_CMD, in case we may
> duplicate C files in it in future version.
>
>
>     --- a/Makefile
>     +++ b/Makefile
>     @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
>     ## Exhaustive lists of our source files, either dynamically generated,
>     ## or hardcoded.
>     SOURCES_CMD = ( \
>     -       git ls-files \
>     +       git ls-files --deduplicate \
>                    '*.[hcS]' \
>                    '*.sh' \
>                    ':!*[tp][0-9][0-9][0-9][0-9]*' \
>     @@ -857,12 +857,13 @@ SOURCES_CMD = ( \
>                    -o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
>                    -o \( -name contrib -type d -prune \) \
>                    -o \( -name build -type d -prune \) \
>     +               -o \( -name .build -type d -prune \) \

This change is good and something we should do in any case, I think (and
this is my fault) that due to this we'd have broken other things,
e.g. included these in the TAGS file if we don't have "git ls-files".

>                    -o \( -name 'trash*' -type d -prune \) \
>                    -o \( -name '*.[hcS]' -type f -print \) \
>                    -o \( -name '*.sh' -type f -print \) \
>                    | sed -e 's|^\./||' \
>            )
>     -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
>     +FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
>
>     FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
>     FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
>
>> may be sufficient.  Deduplicating near the consumer, like
>> LOCALIZED_C, may force us to dedup all the consumers of it (e.g.
>> LOCALIZED_C is not the sole consumer of FOUND_C_SOURCES; you'd need
>> to sort the input to COCCI_SOURCES, for example).
>
> If we apply the above patch, sorting LOCALIZED_C is not necessary.

Per earlier feedback in
https://lore.kernel.org/git/220519.86tu9l6fw4.gmgdl@evledraar.gmail.com/
this all seesm a bit too complex, especially now.

I pointed out then that with --sort-by-file added we:

 * Don't group the translations by C/SH/Perl anymore
 * Change the sort order within files, to be line/sorted instead of
   line/order (i.e. first occurring translations first)

I suggested then to just use $(sort) on the respective lists.

So why not just:

 1. Switch to the $(FOUND_C_SOURCES) (good)
 2. Filter that by C/Perl/SH as before (just a simple $(filter)
 3. $(sort) that (which as noted, also de-dupes it)

Then we don't have any of the behavior change of --sort-by-file, and we
don't have to carefully curate the ls-files/find commands to not include
duplicates (although as seen here that seems to have been a useful
canary in the "find" case).
