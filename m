Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6152C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiLLSOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiLLSNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:13:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029F186FC
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:11:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fc4so30130591ejc.12
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLKXIDz6XTWa53vSYDeyhrrP2+qOUZ87sQ+Ydf12TTY=;
        b=JbCSGg9Ez7OfavehUcDowqDL4vC1ezvBVm09gsJL9aI437UqwIJpexZ7/Laqbn+WOH
         GdnTC4r2uMM5atM+fXKAr150K8Q3g7CYzGjaaZT0xLkBPmDrR7x2iKDmwFH/3+Plezkv
         rEY4Hfa7JDfx2obmt8wPHGUSQKygBLpPmEDZnbh0ZyNG5WykQ9qdewnuPmHZkd48+gLR
         jhFmp8UCXAy9YtVUNCwfEIDXyjZZST/0DVWBM+6ZQ0KLbjj+vEDdWjWjV0rIV+mkNByX
         KH60hTK+XC4U/0U6sxYTWLKK506E+m1JNtNuFX4hbqvT0wZPKYWsOKjVTGh8uiMW/jPU
         pq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLKXIDz6XTWa53vSYDeyhrrP2+qOUZ87sQ+Ydf12TTY=;
        b=Vg4XiJg6yNkKpHYIe9Nin57bx7hFtWcKfkjD2RyA872CyZz8MJ+tz3pcfLtMaDfq4g
         TUFmqy6Tylcj6qGy30WJlfUkUi3/JiWe+Q9G3S0cXGeiSwYoDAF4oHtpfk7AutBENgLe
         nfngo+pyzs8UjQ4IFr0OXSMy2sBdSadzqKjefUd+H0xKo4HWCuUslCcL5s1iVts58wC3
         zDyk+bJOA5pW+ldGzBeAQ+jvlYmQTG9q/i3N6WE1YKs8bR8T853hzc9Cvpe9FwaHYrs3
         NRgd123qaTUgSrep9vbM2D2qvoSLtjFPg33lxZI+2GELQtGd0kLEASzONqeu5F1NTsHa
         Usug==
X-Gm-Message-State: ANoB5pknNrNh/5RHBiuXDxyLZHehG4cxImEkEJnPmTpztm2S6PwERmxf
        cTShSzNAePeCxKZzjM6o+1F5eFLaTYI=
X-Google-Smtp-Source: AA0mqf5JWD9LCJPtcM11llL2l2fBSyFN3KIxBFeq5jewpQnyVhuI63Eo+uZBcWNQ0STjeJX8drBDIQ==
X-Received: by 2002:a17:906:76d2:b0:7c1:20ff:c044 with SMTP id q18-20020a17090676d200b007c120ffc044mr15079013ejn.27.1670868611250;
        Mon, 12 Dec 2022 10:10:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090630c200b007b839689adesm3555886ejb.166.2022.12.12.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:10:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4nFi-005RTP-0s;
        Mon, 12 Dec 2022 19:10:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
Date:   Mon, 12 Dec 2022 19:01:51 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
 <221208.86mt7y946t.gmgdl@evledraar.gmail.com>
 <5301dfa1-71c9-1ff4-6ba0-e37f25e8ef62@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5301dfa1-71c9-1ff4-6ba0-e37f25e8ef62@github.com>
Message-ID: <221212.868rjc5w8t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Derrick Stolee wrote:

> On 12/7/2022 6:06 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> [...]
>>> While older Git versions will not recognize the null hash as a special
>>> case, the file format itself is still being met in terms of its
>>> structure. Using this null hash will still allow Git operations to
>>> function across older versions.
>>=20
>> That's good news, but...
>>=20
>>> The one exception is 'git fsck' which checks the hash of the index file.
>>> This used to be a check on every index read, but was split out to just
>>> the index in a33fc72fe91 (read-cache: force_verify_index_checksum,
>>> 2017-04-14).
>>=20
>> ...uh, what?
>>=20
>> Is there an implied claim here that versions before v2.13.0 don't count
>> as "older versions"?
>>=20
>> I.e. doesn't v2.12.0 hard fail the verification for all index writing?
>> It's only after v2.13.0 that we do it only for the fsck.
>>=20
>> That seems like a rather significant caveat that we should be noting
>> prominently in the docs added in 4/4.
>
> I can add those details.
>=20=20
>>> As a quick comparison, I tested 'git update-index --force-write' with
>>> and without index.computeHash=3Dfalse on a copy of the Linux kernel
>>> repository.
>>=20
>> It took me a bit to see why I was failing to reproduce this, before
>> finding that it's because you mention index.computeHash here, but it's
>> index.skipHash now.
>>>
>>> Benchmark 1: with hash
>>>   Time (mean =C2=B1 =CF=83):      46.3 ms =C2=B1  13.8 ms    [User: 34.=
3 ms, System: 11.9 ms]
>>>   Range (min =E2=80=A6 max):    34.3 ms =E2=80=A6  79.1 ms    82 runs
>>>
>>> Benchmark 2: without hash
>>>   Time (mean =C2=B1 =CF=83):      26.0 ms =C2=B1   7.9 ms    [User: 11.=
8 ms, System: 14.2 ms]
>>>   Range (min =E2=80=A6 max):    16.3 ms =E2=80=A6  42.0 ms    69 runs
>>>
>>> Summary
>>>   'without hash' ran
>>>     1.78 =C2=B1 0.76 times faster than 'with hash'
>>=20
>> I suggested in
>> https://lore.kernel.org/git/221207.868rjiam86.gmgdl@evledraar.gmail.com/
>> earlier to benchmark this against not-sha1collisiondetection.
>
> Generally, I'm avoiding that benchmark because sha1dc is here to stay.
>
> If users want to go through the trouble of compiling to use the non-dc
> version, then I would expect the difference to be less noticeable, but
> still significant. However, I would strongly avoid considering compiling
> both into the client by default, letting certain paths use sha1dc and
> others using non-dc. Certain secure environments currently only use Git
> under exceptions that allow SHA1 for "non-cryptographic" reasons, but
> also with the understanding that sha1dc is used as a safety measure.
> Adding the non-dc version back in would put that understanding at risk.

Doesn't using a checksum for our own index count as a "non-cryptographic
reason"? I.e. we control the .git/index file, and the context is that
we're checking if bytes we wrote to disk are corrupt since we last saw
them.

Even if hypothetically an attacker could craft files to go into the
index (knowing our envelope) in such a way as to craft a collision
between that index file and some other index file I don't see how that
would give the attacker anything. We'd still have a valid index, and
we'd probably be replacing that crafted index with a new one anyway.

I understand that some organizations have SHA-1 on some naughty list,
and using it again in non-SHA1DC contexts might trigger some audit.

So it wouldn't be something for everyone, and it's orthagonal to the
benefits of a new ref format or index format.

But if we're considering new formats, I think it's worth considering a
non-format change which doesn't get us all of the way of no
checksumming, but more than halfway there.

Maybe we'll still want the "don't do any checksumming", but maybe some
would find that enough (particularly if SHA-1 HW acceleration is
available).



