Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB9BC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiEWO4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 10:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiEWO4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 10:56:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AD5677A
        for <git@vger.kernel.org>; Mon, 23 May 2022 07:56:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rs12so17646632ejb.13
        for <git@vger.kernel.org>; Mon, 23 May 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zkaiiUITE58C9HhA49YuJtxxU88osyHlZZ0xqjYr9HI=;
        b=ZhFBEB4KJEgV1Wtooyz5hLSxizEv+GlphIdNypMUy0S+xM9XQS3mPmPEaIm0Ejx+vO
         Sj0jwO+DajlLhsfHrYmkE+leSGkyEnsp5CXGqhqdgIhuRE3A2leCoxVvjqeOZ1ew+knD
         vu8MHHhoUbAntfDxDQgFoniLsQL55FlQexgyFf61ztOdJ/Ss4GsDeNIXhKyEbypOzpRS
         AO5NFA+v31SNfSDde8dQqTbRfd6rhaSy5ozJdwPfcEBhhAGf7ON6TXeR90CUXFJi9qFf
         26nxva4znCX3prfsuctDpnCrcVOWHQ7sLBRXE92MfZCsQjE2I/GTpRjmjC1ADYSgNlUn
         VmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zkaiiUITE58C9HhA49YuJtxxU88osyHlZZ0xqjYr9HI=;
        b=sjZSAGXrW4iSqq/6M1KquEc2vmb3e8wTknRe2uYHCuUL4FOdlYOKM1QNPjk7Wfhq9V
         TDgmjAfox3GDBwRD95BMP81N8gtw9LQhuMdovR9digeHcY10Xp8oAakcPm+lHB4rpjaY
         ihUx9IiVHtQ2m/6oThYbutJFPan1xMCy5g4ILCzIW2FlBL5FM6W727RiZzyANoPpdTIF
         rOwvCEVR6FrdyKNgujNeTDzT6kkW6VqkC5prytcrjuDn/2TrBqvoDKMbpsd2bcfJAUTD
         zGIIV7az8pwoFLbp87SD9TcsqdZjDKUz/Pjxx/SAeryXx+yfVER2snhs9zFOPSHGyai0
         aIPQ==
X-Gm-Message-State: AOAM531CtcUxgFUnh+gWDK6gdNMrJQJ8zbHbhSVvqJtL24RZ/t7R2EeR
        nqzF4Hi8DCF4g0XFG2jdGZY=
X-Google-Smtp-Source: ABdhPJwuvWP8Q+WYKYy+Llwjg2rY1MOFj57k2SRCMENNV9ZAhdzY03i9OG1oa4JWnjGCqs69sKArcA==
X-Received: by 2002:a17:907:3f12:b0:6fe:f8c6:257 with SMTP id hq18-20020a1709073f1200b006fef8c60257mr1961013ejc.544.1653317806906;
        Mon, 23 May 2022 07:56:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fb19-20020a1709073a1300b006fa6a51459asm2183552ejc.96.2022.05.23.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:56:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt9UC-002z2B-KO;
        Mon, 23 May 2022 16:56:44 +0200
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
Subject: Re: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Mon, 23 May 2022 16:38:52 +0200
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com>
 <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
 <220523.86ilpwzmne.gmgdl@evledraar.gmail.com>
 <CANYiYbF8NDawCijZ1Hf=2zdi329=WSdYqL05Tz8+NOyJAFgpLA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CANYiYbF8NDawCijZ1Hf=2zdi329=WSdYqL05Tz8+NOyJAFgpLA@mail.gmail.com>
Message-ID: <220523.86sfp0xpoz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Jiang Xin wrote:

> On Mon, May 23, 2022 at 4:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>  $(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
>>         $(call mkdir_p_parent_template)
>> @@ -2786,11 +2780,24 @@ sed -e 's|charset=3DCHARSET|charset=3DUTF-8|' \
>>  echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$@
>>  endef
>>
>> -.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
>> +.build/pot/git.header:
>
> No. We should rebuild the pot header if any po file need to be update,
> because we want to refresh the timestamp in the "POT-Creation-Date:"
> filed of the pot header.

Okey, I did leave a question about this in an earlier E-Mail though,
i.e. does anything actually rely on this, or the header at all, or is
this just cargo-culting?

I haven't found anything in our toolchain that cares about the header at
all (for the *.pot, not *.po!) let alone the update timestamp.

Except insofar as e.g. Emacs will add a timestamp or update it if it
finds a header already.

>>         $(call mkdir_p_parent_template)
>>         $(QUIET_GEN)$(gen_pot_header)
>>
>> -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
>> +# We go through this dance of having a prepared
>> +# e.g. .build/pot/po/grep.c.po and copying it to
>> +# .build/pot/to-cat/grep.c only because some IDEs (e.g. VSCode) pick
>> +# up on the "real" extension for the purposes of auto-completion, even
>> +# if the .build directiory is in .gitignore.
>> +LOCALIZED_ALL_GEN_TO_CAT =3D $(LOCALIZED_ALL_GEN_PO:.build/pot/po/%.po=
=3D.build/pot/to-cat/%)
>> +ifdef AGGRESSIVE_INTERMEDIATE
>> +.INTERMEDIATE: $(LOCALIZED_ALL_GEN_TO_CAT)
>> +endif
>> +$(LOCALIZED_ALL_GEN_TO_CAT): .build/pot/to-cat/%: .build/pot/po/%.po
>> +       $(call mkdir_p_parent_template)
>> +       $(QUIET_GEN)cat $< >$@
>
> Copy each po file in ".build/pot/po/" to another location
> ".build/pot/to-cat/", but without the ".po" extension.
>
> Let's take "date.c" as an example:
>
> 1. Copy "date.c" to an intermediate C source file
> ".build/pot/po-munged/date.c" and replace PRItime with PRIuMAX in it.
>
> 2. Call xgettext to create  ".build/pot/po/date.c.po" from the
> intermediate C source file ".build/pot/po-munged/date.c".
>
> 3. Optionally remove intermediate C source files like
> ".build/pot/po-munged/date.c". To have two identical C source files in
> the same worktree is not good, some software may break. So I choose to
> remove them.
>
> 4. Copy the po file (".build/pot/po/date.c.po") created in step 2 to
> an intermediate fake C source file ".build/pot/to-cat/date.c" which is
> a file without the ".po" extension. Please note this intermediate fake
> C source file ".build/pot/to-cat/date.c" is not a valid C file, but a
> PO file.
>
> 5. Call msgcat to create "po/git.pot" from all the intermediate fake C
> source files including  ".build/pot/to-cat/date.c".
>
> 6. Optionally remove all the intermediate fake C source files in
> ".build/pot/to-cat/". I choose to remove them, because leave lots of
> invalid C source files in worktree is not good.
>
> For example, ".build/pot/po/date.c.po" was created from
>> +
>> +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_TO_CAT)
>>         $(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
>
> 7. "po/git.pot" depends on the intermediate fake C source files. If
> any single C source file has been changed, will run step 6 to copy all
> po files in ".build/pot/po" to corresponding fake C source files in
> ".build/pot/to-cat/", if we choose to remove these intermediate fake C
> source files.
>
> This implementation is too heavy to solve a trivial issue. I think we
> can push forward this patch series and leave these comments in
> "po/git.pot":

If you find it too "heavy" & are trying to optimize it for some reason
then that whole extra special-dance can be made conditional on
MAKE_AVOID_REAL_EXTENSIONS_IN_GITIGNORED_FILES.

But really, it's 15MB of .build/pot in my local HEAD with this fix-up,
it's 1.4MB without it, but this whole thing just seems like premature
optimization. Especially given:
=20=20=20=20
    $ git hyperfine -r 3 -L rev origin/master,HEAD~,HEAD,avar/Makefile-incr=
emental-po-git-pot-rule~,avar/Makefile-incremental-po-git-pot-rule -p 'git =
clean -dxf; git reset --hard' 'make pot' --warmup 1
    Benchmark 1: make pot' in 'origin/master
      Time (mean =C2=B1 =CF=83):      1.970 s =C2=B1  0.014 s    [User: 1.6=
83 s, System: 0.353 s]
      Range (min =E2=80=A6 max):    1.955 s =E2=80=A6  1.982 s    3 runs
=20=20=20=20
    Benchmark 2: make pot' in 'HEAD~
      Time (mean =C2=B1 =CF=83):     931.3 ms =C2=B1   4.7 ms    [User: 335=
8.5 ms, System: 1088.7 ms]
      Range (min =E2=80=A6 max):   927.0 ms =E2=80=A6 936.3 ms    3 runs
=20=20=20=20
    Benchmark 3: make pot' in 'HEAD
      Time (mean =C2=B1 =CF=83):      1.506 s =C2=B1  0.389 s    [User: 4.6=
55 s, System: 1.363 s]
      Range (min =E2=80=A6 max):    1.257 s =E2=80=A6  1.955 s    3 runs
=20=20=20=20
    Benchmark 4: make pot' in 'avar/Makefile-incremental-po-git-pot-rule~
      Time (mean =C2=B1 =CF=83):      1.015 s =C2=B1  0.002 s    [User: 3.6=
15 s, System: 1.224 s]
      Range (min =E2=80=A6 max):    1.013 s =E2=80=A6  1.017 s    3 runs
=20=20=20=20
    Benchmark 5: make pot' in 'avar/Makefile-incremental-po-git-pot-rule
      Time (mean =C2=B1 =CF=83):      1.014 s =C2=B1  0.008 s    [User: 3.5=
40 s, System: 1.068 s]
      Range (min =E2=80=A6 max):    1.007 s =E2=80=A6  1.023 s    3 runs
=20=20=20=20
    Summary
      'make pot' in 'HEAD~' ran
        1.09 =C2=B1 0.01 times faster than 'make pot' in 'avar/Makefile-inc=
remental-po-git-pot-rule'
        1.09 =C2=B1 0.01 times faster than 'make pot' in 'avar/Makefile-inc=
remental-po-git-pot-rule~'
        1.62 =C2=B1 0.42 times faster than 'make pot' in 'HEAD'
        2.12 =C2=B1 0.02 times faster than 'make pot' in 'origin/master'

I.e. all of this is much faster than what we have on "master" now. My
22434ef36ae (Makefile: avoid "sed" on C files that don't need it,
2022-04-08) (avar/Makefile-incremental-po-git-pot-rule) is then just 10%
slower than the "grep or xgettext", its "~" is the corresponding
unoptimized.

The HEAD here is with my fix-up, and HEAD~ is your series here.

Anyway, if you really feel strongly about it let's go with your way of
doing it.

It just sounded like you weren't actually trying top optimize anything,
but to work around your editor. So if we had a method to do that....

...except it seems you also care about making it much faster than
"master" (or care about <20MB of disk space), which to be blunt seems a
bit crazy to me :) Last I checked "make test" ended up creating ~1GB of
data (not all at once, but in parallel testing a lot more than 10MB is
often in play at once).

As this was a pretty obscure target that I only expect CI, you,
translators & me to run in practice a small difference in the initial
run didn't seem to matter, especially as it's all an improvement over
"master".

Anyway, you do whatever you think is best with that :)

>>         $ grep '#-#' po/git.pot
>>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
>>         #. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
>>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
>>         #. #-#-#-#-#  branch.c.po  #-#-#-#-#
>>         #. #-#-#-#-#  object-name.c.po  #-#-#-#-#
>>         #. #-#-#-#-#  grep.c.po  #-#-#-#-#

