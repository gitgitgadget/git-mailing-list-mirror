Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE1C25B08
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHDVSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHDVSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:18:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AC6FA36
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:18:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb36so1497955ejc.10
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=10zwKuS9/toEFP8ZOI4zHYSdyJy+HuIA1tK3HSTs0t0=;
        b=mOVMFTbpgFf8TOdGZZuAwvdRONZpN8PXABFQYoOomq3xtisjngvLHCzQP5+jI/6gJc
         lzU5UboPdf3ElMwoKnKir3rCHr2KviqcDKz8J8vJTV6Ex4ZMkv4ELUD6wuCvrCii/nz7
         T9RIC1QslVN7cE+8cJdIAWqzeieZUfdMutJVPQXDtv2Pj4ZNOuBFYF7l1+C++lSqwrg+
         lRctzu+sgY09sU23mlBZ5IduDRX3oj26zlwuG9W3DvHWp2lm2ltbijaANU57bAWQLkdd
         Gd2cLCF+TotTcEXK7cN+N18DRwrQfaeDdJBfj0vMFtiStPS+k6rLJ+SrH/USoLZxPlF0
         3/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=10zwKuS9/toEFP8ZOI4zHYSdyJy+HuIA1tK3HSTs0t0=;
        b=6f5FczKx7GYGUIb9MqHzSN++iZ+o1OK5UzbDfhwXTEMvqYM+cu1kkr+Gm+Cu/QgkeR
         Fx85jrnfvrHOfjeyxCtL2STLJ0bOWund+nwuvP4CMzGSQ0mqzylKxYyZTwxvjRQzIv7m
         8OoKNBfi0MG9j5lkDQ9hbRHfARBHKhbcNaCOvpFeooul5FDWZYbc96aE4zEQcd0sbb0a
         BkW2klPGUOAAXH+VDAFFjb9xoQoOdEOYwzn3878aWd4xyRyzn6XxJ/mRtht3EAJui8yL
         mVeR5GcbkPS7ePXXzvcTmDd4rN5ztc4Jw1Hat6atmKU9CzdToqyYGDYQlhGeM+QQ/OaB
         im0g==
X-Gm-Message-State: ACgBeo0S+3qfSNA77cohfbid3Yf8pMI+c2cPcExLWwFVtqk/PW65QKBE
        /QdSmm07atM868Amk0naBlSVVtl4pooeNQ==
X-Google-Smtp-Source: AA6agR5gB5x3ymZZt4f3nZRyXC3W/D4B7Q2ZR6+RWqF6r910B04g6kXZZFcEjL4C1cxPepzZ1kpVpw==
X-Received: by 2002:a17:907:28d6:b0:730:c3a9:886c with SMTP id en22-20020a17090728d600b00730c3a9886cmr2791599ejc.254.1659647890077;
        Thu, 04 Aug 2022 14:18:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0072b85a735afsm735509ejc.113.2022.08.04.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:18:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJiEK-0006R4-32;
        Thu, 04 Aug 2022 23:18:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Emily Noneman <emily.noneman@gmail.com>, Jeff King <peff@peff.net>,
        Paul Horn <git@knutwalker.engineer>, git@vger.kernel.org
Subject: Re: Bugreport: pack-objects died of signal 11
Date:   Thu, 04 Aug 2022 23:07:16 +0200
References: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
 <YtCMklbIoTAN/WRs@coredump.intra.peff.net>
 <ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com>
 <87d46db2-8e09-e5a7-b6bb-e94bf05df305@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <87d46db2-8e09-e5a7-b6bb-e94bf05df305@github.com>
Message-ID: <220804.86tu6rso6n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Derrick Stolee wrote:

> On 8/4/2022 2:21 PM, Emily Noneman wrote:
>> The stack trace:
>> Thread 2 received signal SIGSEGV, Segmentation fault.
>> git_config_check_init (repo=3D0x0) at config.c:2538
>> 2538=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (repo->config && repo->conf=
ig->hash_initialized)
>> (gdb) bt
>> #0=C2=A0 git_config_check_init (repo=3D0x0) at config.c:2538
>> #1=C2=A0 0x00000001001197a8 in repo_config_get_string (repo=3D0x0, key=
=3D0x1002a3c49 "status.showuntrackedfiles", dest=3D0x0, dest@entry=3D0x7ff7=
bfefc1f0) at config.c:2574
>> #2=C2=A0 0x000000010014a85b in new_untracked_cache_flags (istate=3D0x0) =
at dir.c:2781
>> #3=C2=A0 new_untracked_cache (istate=3D0x0, flags=3D-1) at dir.c:2797
>> #4=C2=A0 0x00000001001d68f1 in tweak_untracked_cache (istate=3D0x7ff7bfe=
fc7e0) at read-cache.c:1996
>
> Here is where things are confusing:
>
> * tweak_untracked_cache() takes an 'istate' that is non-NULL here.
>
> * The next spot in the stack is new_untracked_cache() with a NULL 'istate=
'.
>
> The only way these are connected is by a missing stack frame (probably
> optimized out) calling add_untracked_cache(). Still, it should be
> passing 'istate' throughout this process.
>
> The repo_config_get_string() call must also be coming from
> new_untracked_cache_flags() which is again a missing stack frame,
> but is called from new_untracked_cache(). Strangely, it's using
> a NULL 'repo' here which should have come from 'istate->repo', so
> we should have had a segfault earlier.
>
> Sorry for the drive-by commentary without any solution. This is
> just genuinely puzzling to me.

I think this segfault might be fixed by this patch of mine, which I
wrote for something unrelated back in April (but it was never sent to
the list).

	https://github.com/avar/git/commit/d83bfa866ba

Emily and/or Paul: Are you able to test the patch to see if it would
work, diff here: https://github.com/avar/git/commit/d83bfa866ba.patch

It's exactly on the codepath in this stacktrace,
i.e. add_index_objects_to_pending() in revision.c will do before/after:

	- struct index_state istate =3D { NULL };
	+ struct index_state istate =3D { .repo =3D revs->repo };

Then when we're all the way down in new_untracked_cache_flags() we do:

	struct repository *repo =3D istate->repo;

Which then calls (indirectly) git_config_check_init(), and we segfault
not because istate is NULL, but because the "repo" it's carrying is
NULL.

But maybe I'm wrong, I haven't been able to reproduce this.

The reason I wrote that patch (as can be seen if you peek at the WIP
branch it's at) is because I ran into a similar dependency between
the_index and the_repo & an istate variable being passed around with
fsmonitor-settings.c.
