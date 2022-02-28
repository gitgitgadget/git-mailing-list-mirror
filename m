Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC42C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiB1LV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiB1LVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:21:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BE6FA13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:20:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f8so4934215edf.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RLTw7ocnEIBzbWZf2LYTkVv8QJ3UCPGBRpE4E1uDkfY=;
        b=or0NbeGRQUjFNhzjMmCBJrJKwOKLy4+DVVFPU3K7lvFaf8sX4TtAOr1aNAAHLf//QG
         Vf2lOKKrEBzdW7sEhVbsAjQbOl0r034qJqDLinwizo/oUrvePllLRnamnCaXgMdzvVnW
         oNNSfSuI9dT8RwmiuHGAkc4PWe5YuPcp+NCsXOFdOWkpVkyMWZH/vUS/KrxHlt5ExvFh
         j7QTDFhHvMl/NAj2dXZsCovvpJqyc9KrI1m2ZjuC8Xjpn1nUzYqrzIpcXUgaNTN07d8t
         ZZadfc9zn+O4ALLvQx9vo/rgDcZukd5f9zG6Hvn1frkzqtn48v11a8VdX0uOwbBc/BIU
         Vbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RLTw7ocnEIBzbWZf2LYTkVv8QJ3UCPGBRpE4E1uDkfY=;
        b=TiNRlmiCkY6Xmt2appkbhIVk0fV7F3eLPv7wt5VlIULK4o3rD0R7wE3uQa2XDG8Ur5
         1gGsFIzG+TyW7fPLcuezQd4KqtXhDzryEZOGVEnNocErPlmQtk1iSrDweWNUVoCkkPMB
         gVPTpFBISf6wyRo2dZkWV2tTaXojxMNutSB+Cer0eqAHmxC2HLHziPcA/iEJLBTi+d8I
         gB/NBmsGrsTcDbBOf5ib3HEnMBl9bjHc2JI4EgjtHnv8mf4yNFUYrUZUca1BpjxLleE1
         JoOUsf0pFETzaJhXfRIUOmSRYckN80u6pqEjQR2QNsW5v1YnJpAxhi+xB4olVXf1Y2HR
         7fzQ==
X-Gm-Message-State: AOAM5319wu936/Siw9yxxrLUt8N1QtH6b3e/LdBqiMLhf8N8Md5zOpT2
        WlBaP2SlgBBdj7WpjvK7IMw=
X-Google-Smtp-Source: ABdhPJwZxS3Cj1019A3HOTyCY9jCXOZTHnIdQlUrkFRkHii0mXrvvZBJT4IPvuxYqSdLwwsD5aEktQ==
X-Received: by 2002:aa7:d594:0:b0:410:ef84:f706 with SMTP id r20-20020aa7d594000000b00410ef84f706mr18933018edq.347.1646047244214;
        Mon, 28 Feb 2022 03:20:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906784f00b006ccb9e1278csm4275315ejm.6.2022.02.28.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:20:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOe54-001JVm-Rt;
        Mon, 28 Feb 2022 12:20:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
Date:   Mon, 28 Feb 2022 12:16:36 +0100
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
 <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
 <faa70086-3c15-1187-93a0-88f1e1120dbf@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <faa70086-3c15-1187-93a0-88f1e1120dbf@gmail.com>
Message-ID: <220228.867d9f5jat.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 25/02/2022 09:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> We have various behavior that's shared across our Makefiles, or that
>> really should be (e.g. via defined templates). Let's create a
>> top-level "shared.mak" to house those sorts of things, and start by
>> adding the ".DELETE_ON_ERROR" flag to it.
>> See my own 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR"
>> flag, 2021-06-29) and db10fc6c09f (doc: simplify Makefile using
>> .DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
>> ".DELETE_ON_ERROR" flag.
>> This does have the potential downside that if
>> e.g. templates/Makefile
>> would like to include this "shared.mak" in the future the semantics of
>> such a Makefile will change, but as noted in the above commits (and
>> GNU make's own documentation) any such change would be for the better,
>> so it's safe to do this.
>
> I was confused about the mention of templates/Makefile in this
> paragraph, it seems to be saying that the behavior would change in the=20
> future if we included shared.mak in templates/Makefile but this patch
> does exactly that.

Yes, oops! It's a zombie comment that I forgot to adjust from an earlier
version of this where that wasn't the case. Will adjust & re-roll.

> Also does this patch mean we're now using .DELETE_ON_ERROR in places
> where we were not previously using it?

Yes, we'll now use it in those other Makefiles as well. The commits
referenced in the second paragrap of the commit message argue for this
being safe, and I've reviewed the logic myself & don't expect any
problems with it.

As the GNU make manual itself notes the cases where that would cause
problems are really obscure, but it's not the default out of an
abundance of backwards compatibility caution in GNU make.

>> This also doesn't introduce a bug by e.g. having this
>> ".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
>> have no such scoping semantics.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   Documentation/Makefile    |  6 +++---
>>   Makefile                  | 13 +++----------
>>   contrib/scalar/Makefile   |  3 +++
>>   contrib/scalar/t/Makefile |  3 +++
>>   shared.mak                |  9 +++++++++
>>   t/Makefile                |  3 +++
>>   t/interop/Makefile        |  3 +++
>>   t/perf/Makefile           |  3 +++
>>   templates/Makefile        |  3 +++
>>   9 files changed, 33 insertions(+), 13 deletions(-)
>>   create mode 100644 shared.mak
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index ed656db2ae9..ba27456c86a 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../shared.mak
>> +
>>   # Guard against environment variables
>>   MAN1_TXT =3D
>>   MAN5_TXT =3D
>> @@ -524,7 +527,4 @@ doc-l10n install-l10n::
>>   	$(MAKE) -C po $@
>>   endif
>>   -# Delete the target file on error
>> -.DELETE_ON_ERROR:
>> -
>>   .PHONY: FORCE
>> diff --git a/Makefile b/Makefile
>> index 6f0b4b775fe..d378ec22545 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include shared.mak
>> +
>>   # The default target of this Makefile is...
>>   all::
>>   @@ -2194,16 +2197,6 @@ shell_compatibility_test:
>> please_set_SHELL_PATH_to_a_more_modern_shell
>>   strip: $(PROGRAMS) git$X
>>   	$(STRIP) $(STRIP_OPTS) $^
>>   -### Flags affecting all rules
>> -
>> -# A GNU make extension since gmake 3.72 (released in late 1994) to
>> -# remove the target of rules if commands in those rules fail. The
>> -# default is to only do that if make itself receives a signal. Affects
>> -# all targets, see:
>> -#
>> -#    info make --index-search=3D.DELETE_ON_ERROR
>> -.DELETE_ON_ERROR:
>> -
>>   ### Target-specific flags and dependencies
>>     # The generic compilation pattern rule and automatically
>> diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
>> index 5b12a437426..6fb5cc8b701 100644
>> --- a/contrib/scalar/Makefile
>> +++ b/contrib/scalar/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../../shared.mak
>> +
>>   QUIET_SUBDIR0  =3D +$(MAKE) -C # space to separate -C and subdir
>>   QUIET_SUBDIR1  =3D
>>   diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
>> index 6170672bb37..01e82e56d15 100644
>> --- a/contrib/scalar/t/Makefile
>> +++ b/contrib/scalar/t/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../../../shared.mak
>> +
>>   # Run scalar tests
>>   #
>>   # Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
>> diff --git a/shared.mak b/shared.mak
>> new file mode 100644
>> index 00000000000..0170bb397ae
>> --- /dev/null
>> +++ b/shared.mak
>> @@ -0,0 +1,9 @@
>> +### Flags affecting all rules
>> +
>> +# A GNU make extension since gmake 3.72 (released in late 1994) to
>> +# remove the target of rules if commands in those rules fail. The
>> +# default is to only do that if make itself receives a signal. Affects
>> +# all targets, see:
>> +#
>> +#    info make --index-search=3D.DELETE_ON_ERROR
>> +.DELETE_ON_ERROR:
>> diff --git a/t/Makefile b/t/Makefile
>> index 46cd5fc5273..056ce55dcc9 100644
>> --- a/t/Makefile
>> +++ b/t/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../shared.mak
>> +
>>   # Run tests
>>   #
>>   # Copyright (c) 2005 Junio C Hamano
>> diff --git a/t/interop/Makefile b/t/interop/Makefile
>> index 31a4bbc716a..6911c2915a7 100644
>> --- a/t/interop/Makefile
>> +++ b/t/interop/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../../shared.mak
>> +
>>   -include ../../config.mak
>>   export GIT_TEST_OPTIONS
>>   diff --git a/t/perf/Makefile b/t/perf/Makefile
>> index 2465770a782..e4808aebed0 100644
>> --- a/t/perf/Makefile
>> +++ b/t/perf/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../../shared.mak
>> +
>>   -include ../../config.mak
>>   export GIT_TEST_OPTIONS
>>   diff --git a/templates/Makefile b/templates/Makefile
>> index d22a71a3999..636cee52f51 100644
>> --- a/templates/Makefile
>> +++ b/templates/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include ../shared.mak
>> +
>>   # make and install sample templates
>>     ifndef V

