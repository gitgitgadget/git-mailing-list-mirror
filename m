Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB45C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiESOih (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiESOig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 10:38:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8649968E
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:38:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n13so8498734ejv.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=E7SWvAurxXCD3oaiPTX5SJzQhEfZJ3OWuX+F2+xRA8U=;
        b=Imgvt7GxEKIZUkhQnydqOxV92WgGUTqNrmP5iowTpnRwcPbrgKVqYQ2ILDrK9rOMUR
         LYtvVg0HQRYVpEmSvkgCTkRdwxGxYZCCxKV2HT4DWA7zPn4z0rDkS+DW7EEDmHhVRzuO
         MSW8oSnz5bWJbSN9oSMZc9He6pLSPgerv1hF1EUisJ+TyMD0I2jUJEhlotZkNLQ8vSFN
         S6A4QYS7HbRSrJKkXfk5qQRgWxDFJhjH+ikxLEbyKvSnQ9dxjD4/AeRxX0lhWn0QMATE
         u2CWAjo5IVVmamMlrEof+V7EhLkA1zbKURj0VTJDqtR5WEVKogDceBvMY/t8/ci6pHsx
         TgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=E7SWvAurxXCD3oaiPTX5SJzQhEfZJ3OWuX+F2+xRA8U=;
        b=ZU0eG5xdaR0mC7JKvhs4YSoMbZesq2Yos5MP81LKtCBBDm2k7cw1CllkTagV92oWQD
         qGhng19aL1hvivqQ8M/1P20bHXlIWOIkor1BtKYXRHJpNQHO3Qx7nLYRNFh3ajD3dxU+
         AXIbiHcRSt9gJzwWyHj/CtdYXFynhiyGtA2gqWAj8r+opWS4UE9g6JUsZDVKPxiGJrS5
         5WgK8Ef3wmPQ8om2ubvR38jT90eFXYiM1cV+tdZcmG7Jo+QK3IxOUL9aEcqdVzdPwEON
         h3zmKychOuy7mVhRR2/AQ3vT46q5fHS2eVko9WDdcM4lwZDY7lV1gT7gruyqtnd6XydK
         ezqQ==
X-Gm-Message-State: AOAM530M1l9lwYG6X1d5h1mqR2bJY5sTVLNTmdijojftj5DhjVcUoj7l
        10XIJDkm1eiO2eS4VldPdF0=
X-Google-Smtp-Source: ABdhPJw3+5nq+8z2MC8vJkZYwGYSJ0ECtp88adE7YpD9jfzeQFrfQfNf/2WzfvvdZF3MH+ktRHPjNg==
X-Received: by 2002:a17:907:6e11:b0:6fe:7e13:345c with SMTP id sd17-20020a1709076e1100b006fe7e13345cmr4577469ejc.588.1652971112955;
        Thu, 19 May 2022 07:38:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640210cf00b0042aaa3b741esm2875320edu.1.2022.05.19.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:38:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrhIM-002Bxu-Mf;
        Thu, 19 May 2022 16:38:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
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
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/9] Makefile: have "make pot" not "reset --hard"
Date:   Thu, 19 May 2022 16:06:42 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-4-worldhello.net@gmail.com>
 <220519.86leux6e82.gmgdl@evledraar.gmail.com>
 <CANYiYbGpMx8JkHj2EMxYYk6KgdpiPr5=7VWEXKevp+J+e7NKcQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CANYiYbGpMx8JkHj2EMxYYk6KgdpiPr5=7VWEXKevp+J+e7NKcQ@mail.gmail.com>
Message-ID: <220519.86a6bd4mft.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> On Thu, May 19, 2022 at 5:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> In the previous discussion of kicking things around I lost track of what
>> version of mine this is picked up from, but I range-diff'd it to my
>> 6cf9c1f7022 (Makefile: have "make pot" not "reset --hard", 2022-04-02),
>> which is the latest I had in avar/Makefile-incremental-po-git-pot-rule
>> on my branch.
>>
>> A range-diff of the two follows below (yours being the RHS). Some
>> comments:
>>
>>  * There's a bug here where you're creating .build/pot/po/pretty.c.po
>>    files, not .build/pot/po/pretty.c, i.e. you add a *.po extension.
>
> In the original version of your commit, each source file has a
> duplicate version in the ".build/" directory, and this will confuse
> IDE (E.g.: VS Code) when I jump to a function declaration.
>
> Name the "pot" snippets with the ".po" extension only have the
> following side effect, nothing else:
>
>             +#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
>              #. TRANSLATORS: do not translate [y/n]
>             [...]
>             +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#

I don't think we should sacrifice correctness for such an IDE
workaround, which surely will just bite someone else in a different
way. I.e. now if I'm auto-completing .po<TAB> in a hypothetical na=C3=AFve
IDE that's looking in .build/ I'll get these built files instead.

The right solution in both cases being that the IDE in question should
be ignoring things covered by .gitignore, or perhaps we could ship
something in contrib/ for specific IDEs?

There's also an easy workaround we can do on the GNU make side. Unless
you mark files as PRECIOUS it'll delete files that are only used for
intermediate targets.

We could thus make the chain e.g.:

    git.c -> .build/pot/po/git.c -> .build/pot/po/git.c.done=20

Instead of:

    git.c -> .build/pot/po/git.c -> .build/pot/po/git.c.done

Where the only point of the ".build/pot/po/git.c.done" is to have make
delete the intermediate file as soon as it's done with it.

Or, since the comments all start with #. or #: we could post-munge them
with "sed" I guess.

> I add some notes in commit message:
>
>     While we could rename the "pot" snippets without the ".po" extension
>     to use more intuitive filenames in the comments, but that will
>     confuse the IDE with lots of invalid C or perl source files in
>     ".build/pot/po" directory.

Ah, I see that after you pointed out. I'd skimmed entirely over the
commit message thinking it must have been something I wrote, and didn't
notice that edit. Sorry.

>>  * We went a bit back & forth on the "if grep -q PRItime" part on the GH
>>    ticket. FWIW I still think just skipping that work is a better
>>    choice. Yes we'll have ~10MB of redundant files in .build, and it's
>
> Redundant source files (*.c, *.h, *.perl) in .build will make IDE mad.

Hopefully we can have our cake & eat it too here, per the above.=20

>>    marginally slower, but "make pot" isn't a hot target, better to
>>    optimize for simplicity.
>>
>>    But if you're really set on having it I don't mind...
>>
>>  * You add a "MSGCAT_FLAGS =3D --sort-by-file" here, maybe worth having
>>    some "common" flags variable in the earlier commit we can use here?
>>    I.e. share --sort-by-file with xgettext.
>>
>>  * Your version is missing FORCE on po/git.pot, which is a bug. We can't
>>    omit it on any file that's checked in. We're about to "git rm" it
>>    anyway, so maybe we shouldn't worry about it though...
>
> I'm confused. Since the "po/git.pot" target has a full set of
> prerequisites, it is fine to remove FORCE from dependence.

At this point in the series po/git.pot is still a file tracked by git.

Thus:

    make pot
    git reset --hard HEAD^
    make pot

Or whatever will report that there's nothing to do, since the timestamp
of the "generated" file will be newer than that of what it depends on.

That's why my version pulled that dance with having the
.build/pot/git.pot be non-FORCE and the po/git.pot be FORCE until it was
git rm'd.
