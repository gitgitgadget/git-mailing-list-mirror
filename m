Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF47C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 15:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354791AbiALPtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354783AbiALPtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 10:49:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0EC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 07:49:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h10so5068112wrb.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6vrzr1I9CwlwiSyWkYALO4ehDFl/2cNT4EE7no6GtJk=;
        b=En4/nyOWo9J96hMX1HqHws8IKYx1oo4Li9cYcrIU7sucKKaeHQZuTcOclRUn3UBo2D
         VwOQEwCemEm9hKqz1duFFmN8GFz+DUzeBQlzh5pU1JJmU6HPj4cu/xflm7xmqtpJ8T5G
         5lgBfThKl41NQccoRupSF7HvWcN6PT7L5K3oXmlXigCh59ZhtyZ6j7wGCEya2VMRc8Ov
         g+DnF3sZ2hiwOhEvTzFMSI47nma3HvSKVfN9zhxaatJKs9W1P5h52SnNBFbMXRmxH8aB
         yEIRC7nAgYzzxIcp38ITGn7zJkhbzmWFRHHZUS14fy/lxDlAaTDtSai2gce/PfW1QHuS
         JzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6vrzr1I9CwlwiSyWkYALO4ehDFl/2cNT4EE7no6GtJk=;
        b=B6GD6RRr7OWSWJGFnqM1h4QLKFNIFhcBBue53I2RHdVJT3wFsNacGtju/ZltTTtwFc
         8/CCLO+n86/J85LMJ0tRqBUWS1FyOu8Wiezl2DNAFEK5UfphBGCTCWukbIVhmo1pSGJ7
         3GZQqLWW+BmdKgFDoRTMP1H84uflfVKxxGStFa24W0nAJfF0LTvO983WxIvYlEs+EnVT
         AEda+tKBXHONl6Ib5s/RDywpSLtiZf6QLG56INmbB5XOutejDcAJn1o6t0N7sZPFDiET
         5+ktag0MyHFo/PRH+b2ZEclziFPCutNuzi5HbUiskD6k64bOpsInVvws5hE5t+9UbbOW
         mhSw==
X-Gm-Message-State: AOAM533ADEOojq2V2JM1/OnRe2YYuZXcJKzkWsn3enQxSvkpY4x4Fco8
        gYps8hrFQbT1aQyE0UhQjPwT4tKHQ9Q12m+g
X-Google-Smtp-Source: ABdhPJwPONgGLHr61aDzcSeJF9a27UCT9/g6zGlk4Vm01IZV3Hydc+XHl6Sg6RwK/rwqqdTTPi2Oqg==
X-Received: by 2002:a5d:4009:: with SMTP id n9mr288917wrp.555.1642002550322;
        Wed, 12 Jan 2022 07:49:10 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id j13sm5772914wmq.11.2022.01.12.07.49.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 07:49:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <c4de043e-45e1-6066-37d5-6b06b7a820f7@web.de>
Date:   Wed, 12 Jan 2022 15:49:09 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <366952CA-95D1-4912-9E93-1178247AF173@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <641A33F3-E98A-40B1-BB11-ADC8C1FECA75@jrtc27.com>
 <c4de043e-45e1-6066-37d5-6b06b7a820f7@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 Jan 2022, at 15:47, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> Am 12.01.22 um 14:58 schrieb Jessica Clarke:
>>=20
>> I can see the alternative fixes for qsort are now in next, as is the
>> cleanup of register_symlink_changes to use string sets, which just
>> leaves the mem-pool.c change to not assume that uintmax_t is
>> sufficiently aligned for every type that git will use. If I move
>> GIT_MAX_ALIGNMENT and its helper aggregates to mem-pool.c would that =
be
>> acceptable?
>=20
> Defining it at its single site of use sounds like a good idea to me.
> We can export it to git-compat-util.h later, iff necessary.
>=20
>>> diff --git a/git-compat-util.h b/git-compat-util.h
>>> index 5fa54a7afe..28581a45c5 100644
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>>> #define _ALL_SOURCE 1
>>> #endif
>>>=20
>>> +typedef union {
>>> +	uintmax_t max_align_uintmax;
>>> +	void *max_align_pointer;
>>> +} git_max_align;
>>> +
>>> +typedef struct {
>>> +	char unalign;
>>> +	git_max_align aligned;
>>> +} git_max_alignment;
>>> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
>=20
> Style nit: We tend to use typedef sparingly.  And the union type =
doesn't
> even need a name.  E.g. this would work as well, while reducing the =
name
> space footprint:
>=20
>   struct git_max_alignment {
>      char unalign;
>      union {
>         uintmax_t max_align_uintmax;
>         void *max_align_pointer;
>      } aligned;
>   };
>   #define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, =
aligned)
>=20
> When someone uses a mempool for objects that requires 128-bit =
alignment
> (e.g. because it includes a long double or uint128_t member) then we'd
> need add long double to the union as well, like e.g. compat/obstack.c
> does.  That would be the safe route, but currently only add 8 bytes of
> unnecessary overhead to each allocation.
>=20
> Perhaps mempool alignment should be configurable.  For now a comment
> might suffice which indicates that GIT_MAX_ALIGNMENT is only the
> maximum alignment requirement of current mempool users, not the
> highest possible requirement for the machine.  Renaming it to =
something
> with MEMPOOL in the name would help in this regard as well.

Sure, that all makes sense.

Jess

>>> +
>>> /* used on Mac OS X */
>>> #ifdef PRECOMPOSE_UNICODE
>>> #include "compat/precompose_utf8.h"
>>> diff --git a/mem-pool.c b/mem-pool.c
>>> index ccdcad2e3d..748eff925a 100644
>>> --- a/mem-pool.c
>>> +++ b/mem-pool.c
>>> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t =
len)
>>> 	struct mp_block *p =3D NULL;
>>> 	void *r;
>>>=20
>>> -	/* round up to a 'uintmax_t' alignment */
>>> -	if (len & (sizeof(uintmax_t) - 1))
>>> -		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - =
1));
>>> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
>>> +	if (len & (GIT_MAX_ALIGNMENT - 1))
>>> +		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - =
1));
>>>=20
>>> 	if (pool->mp_block &&
>>> 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)
>>> --
>>> 2.33.1
>>>=20
>>=20
>=20

