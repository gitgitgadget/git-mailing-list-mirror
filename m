Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EBC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiAZRuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiAZRuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:50:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57508C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:50:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id h7so294650ejf.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9bo7OdLk30MDKIvyW4BN/mSl0IIywYt/O4ddQkeiF4A=;
        b=cuW1slmyJK1V1TifjLuWU3zm00D/3k0FcskNUUHIwy14K6FMrK32kHWrLYA0P/k9BD
         UjSth6nh9KmfH9q8h77iAzkamDhmzFdfkPMu7UbtjBNrxMVMSjVeYTEp8u68lW7JawS9
         mKr80ovcombYdCWDG1Mp/6VQOrHHp7GtRtxfY2/pfgfblbjCw9WWZcm/ONR3NnxbGy+A
         jYWiz1vSnT3dWyDYbrY0spFRDmwxx8epg0R7/KtYop8dw4CVYfd31s+8CUDSVwWpBmsw
         ILmIx6uhDn+ebG44jKNVGlLR4OE+c6NB40S+km7/jmXr7HmIiZjLwcXJdK5DViZ68sB7
         9Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9bo7OdLk30MDKIvyW4BN/mSl0IIywYt/O4ddQkeiF4A=;
        b=2IY+/7/Sao9bmTAjD7mmCMoE9u/dI3/hQ/fcw87Y+UHD9r4pOnSaGiDYSK2k7AxzQr
         qhOLWLmvDCew4LM2TplOnTV8xD2g0CEzq4aTOhHBjMeWhEMx1DvvRQUkXRlKrp8dqiFT
         l9TyMTbjH0WHYc2x4cn5kWDJq7+Sv5JgGIoJAju2U/iIyNORctwEQwrNfyNQk2D989ub
         QXrHMXmZyoSNepZlYapgqPH7pKWleT5lcm7CbFSpvMUvbLwBqWN9HkSjiml4EXiWQ3Lu
         Vv7m8nzIoakHPzrjuRDCwHTsN+kn7jTeFLuCLPKIRCzsIqwUAB8nKuL4k5MFiSKhUghp
         niOg==
X-Gm-Message-State: AOAM532Ot7PL8+fR0bkqUduTi6rQuzvzShaXrgl8GAcv7Nrs4NJk/uda
        FsFtEv2jjIaO1gR8IyZ3A5XM7LJOHuyPYQ==
X-Google-Smtp-Source: ABdhPJzCOi5VegLZ/22Zz5NE4Xw9tnDbf1iZJGBf5+fVakOpRYfP7bA9TmDVBSgSvtIANpetYHGEPw==
X-Received: by 2002:a17:907:10d5:: with SMTP id rv21mr20721684ejb.52.1643219419541;
        Wed, 26 Jan 2022 09:50:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p13sm7712052ejx.183.2022.01.26.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:50:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCmQz-003CFQ-SI;
        Wed, 26 Jan 2022 18:50:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <jcai@gitlab.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Wed, 26 Jan 2022 18:30:43 +0100
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
 <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
 <B6F534FC-FCEE-4A90-9576-233103865B3E@gitlab.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <B6F534FC-FCEE-4A90-9576-233103865B3E@gitlab.com>
Message-ID: <220126.86h79qe692.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, John Cai wrote:

> On 26 Jan 2022, at 8:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Jan 25 2022, Yuri wrote:
>>
>>> Ctrl-C was pressed in the middle. git creates the stash record and
>>> didn't update the files.
>>>
>>>
>>> Expected behavior: Ctrl-C should cleanly roll back the operation.
>>
>> Yes, you're right. It really should be fixed.
>>
>> It's a known issue with builtin/stash.c being written in C, but really
>> only still being a faithful conversion of the code we had in a
>> git-stash.sh shellscript until relatively recently.
>>
>> (No fault of those doing the conversion, that's always the logical first
>> step).
>>
>> So it modifies various refs, reflogs etc., but does so mostly via
>> shelling out to other git commands, whereas it really should be moved to
>> using the ref transaction API.
>>
>> Ig you or anyone else is interested in would be a most welcome project
>> to work on=E2=80=A6
>
> I=E2=80=99d be happy to help with this!

Thanks. I think that would be a great thing to work on.

Part of it is summarized in my 212631ed50a (refs/files: remove unused
REF_DELETING in lock_ref_oid_basic(), 2021-07-20). I think there was a
better summary somewhere (maybe an exchange with Jeff King?) but I can't
find it now.

There's a further summary of the remaining callers in 52106430dc8
(refs/files: remove "name exist?" check in lock_ref_oid_basic(),
2021-10-16), which as we'll see is closely coupled with these remaining
transaction-less refs API callers.

Beginning to fix that is as basic as starting with some light move of
existing code into library form, e.g. when you "git stash drop" it will
invoke:

    18:29:02.800983 git.c:459               trace: built-in: git reflog del=
ete --updateref --rewrite 'refs/stash@{0}'

Which will lock a ref with:
=20=20=20=20
    (gdb) bt
    #0  BUG_fl (file=3D0x7965ef "refs/files-backend.c", line=3D1011, fmt=3D=
0x796f30 "hi") at usage.c:324
    #1  0x0000000000675488 in lock_ref_oid_basic (refs=3D0x855470, refname=
=3D0x855140 "refs/stash", err=3D0x7fffffffd9b0) at refs/files-backend.c:1011
    #2  0x00000000006722bb in files_reflog_expire (ref_store=3D0x855470, re=
fname=3D0x855140 "refs/stash", expire_flags=3D6, prepare_fn=3D0x4c9390 <ref=
log_expiry_prepare>,
        should_prune_fn=3D0x4c8c40 <should_expire_reflog_ent>, cleanup_fn=
=3D0x4c9510 <reflog_expiry_cleanup>, policy_cb_data=3D0x7fffffffdb30) at re=
fs/files-backend.c:3159
    #3  0x000000000066d832 in refs_reflog_expire (refs=3D0x855470, refname=
=3D0x855140 "refs/stash", flags=3D6, prepare_fn=3D0x4c9390 <reflog_expiry_p=
repare>,
        should_prune_fn=3D0x4c8c40 <should_expire_reflog_ent>, cleanup_fn=
=3D0x4c9510 <reflog_expiry_cleanup>, policy_cb_data=3D0x7fffffffdb30) at re=
fs.c:2411
    #4  0x000000000066d88f in reflog_expire (refname=3D0x855140 "refs/stash=
", flags=3D6, prepare_fn=3D0x4c9390 <reflog_expiry_prepare>, should_prune_f=
n=3D0x4c8c40 <should_expire_reflog_ent>,
        cleanup_fn=3D0x4c9510 <reflog_expiry_cleanup>, policy_cb_data=3D0x7=
fffffffdb30) at refs.c:2423
    #5  0x00000000004c8ad7 in cmd_reflog_delete (argc=3D1, argv=3D0x7ffffff=
fe118, prefix=3D0x0) at builtin/reflog.c:780
    #6  0x00000000004c7abb in cmd_reflog (argc=3D5, argv=3D0x7fffffffe110, =
prefix=3D0x0) at builtin/reflog.c:839
    #7  0x0000000000407c8b in run_builtin (p=3D0x81e0e0 <commands+2304>, ar=
gc=3D5, argv=3D0x7fffffffe110) at git.c:465
    #8  0x0000000000406742 in handle_builtin (argc=3D5, argv=3D0x7fffffffe1=
10) at git.c:719
    #9  0x0000000000407676 in run_argv (argcp=3D0x7fffffffdfcc, argv=3D0x7f=
ffffffdfc0) at git.c:786
    #10 0x0000000000406501 in cmd_main (argc=3D5, argv=3D0x7fffffffe110) at=
 git.c:917
    #11 0x0000000000510fba in main (argc=3D6, argv=3D0x7fffffffe108) at com=
mon-main.c:56

Which, if you chase that down to builtin/reflog.c you can see is just a
case where we could avoid the sub-process invocation by calling
reflog_expire() ourselves in builtin/stash.c, perhps after lib-ifying
some of what it's doing into a new top-level reflog.c, and having the
command-line specific stuff in builtin/reflog.c call that.

You've hacked on that code recently, so that should be easy to start
with :)

Then once we do all the ref updates in-process it should be easy (or
easy enough...) to move it over to the ref transaction API. So if we
fail we'll roll everything back properly.

The eventual approximate goal should be to get rid of
lock_ref_oid_basic() entirely, it's legacy API in the refs files backend
that makes a lot of things over there more complex. Some other users of
it can be found with:

    git grep -w -e copy_ref -e rename_ref

Or, by just removing the function recursively during testing, and
following the compilation errors.
