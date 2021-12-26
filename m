Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E77C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 21:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhLZVKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 16:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhLZVKU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 16:10:20 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12398C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 13:10:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so54672314eds.10
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bmnPOAYB+i66mhjD361G4YkrJ+JMFog1kqRNiuF8gxg=;
        b=E67a5EaweEv8ePsAH4eMJIndu8OCsOPTXb/i669vPqoSy1uncKeFhjxg8MzKQY+a1R
         5Tc/nIfyFLCXWvDekbX65zXErC1Lj4KwRicYNqIe1TsUKzJCc79RqgtC2zq1HWxct45v
         nvsRsmEI/6AAkub0+WxfWrT/BiVI9IbV9umfwhWVBMDdn+SZu+X3pDthtd5SkksW3ZUe
         wpeWYaMHSbEvTzOFMa/SNZ9hIvttr6oVho0XHydJyHVb5GfQ5NPhhOO0RrhdbcHC4BBZ
         89AVXsGnx7ezptTN5yR7vB/afUIOdKWSgtrm6grnIrE9C1rC2bOe+ctUeB8/NSNBP5Ih
         eCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bmnPOAYB+i66mhjD361G4YkrJ+JMFog1kqRNiuF8gxg=;
        b=HmcgWtjUdn7bk6QcI6mmFVnma9Y/8G5tiZwV6qEgL7ax3bqNz8a3/KCc5ooQ2ytKY7
         euH3HvbasaQo7y3kYv3MJ2sAWoqTlGkKrQV47mHh0yQv46iIgozQ4+Pe/1hBkhSFv57x
         /DYekge0uuAJyeZ2W8F+7BLhmJACIyLGwIrueTDOUCp4UWvNcm2jwgF8FUWjZSPLc0GT
         l9NMhKqqSEFqK8aCVtQp6IMqzXFdporYnZwWUPkXua3SizCGM57yi5rdmaLLOLaTOr52
         KL6ADgXshmkbGfNY4Fqy5fDevk3ts3ngbxVxIq4myw4pdDwPuGQjv/Wl1raNKPAmejIM
         Usog==
X-Gm-Message-State: AOAM532058BaONLy2BtXml4nM6fGUpY0ADqaXarXcpXkZzlwtddMXocc
        jZR2tPjJQFx8j4XCeGvg0ac=
X-Google-Smtp-Source: ABdhPJwAsKJqHvf/wCaBAPVhtPMTZJZXiAEPpc1Yrr+UpDYAuxCgDmNEuViWBuMK+04ZYERaO/DRWA==
X-Received: by 2002:a17:906:82c7:: with SMTP id a7mr12397495ejy.91.1640553018512;
        Sun, 26 Dec 2021 13:10:18 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id qf1sm4469846ejc.156.2021.12.26.13.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 13:10:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1amW-000EFK-QA;
        Sun, 26 Dec 2021 22:10:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length
 memcpy calls
Date:   Sun, 26 Dec 2021 22:07:38 +0100
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g> <af378ac5-a24c-5110-04a7-3257a909815b@web.de>
 <xmqqo857b11h.fsf@gitster.g> <e288fad3-8a83-448c-d701-47c56bc258e3@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e288fad3-8a83-448c-d701-47c56bc258e3@web.de>
Message-ID: <211226.86pmpjf4xz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 26 2021, Ren=C3=A9 Scharfe wrote:

> Am 23.12.21 um 19:59 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>>> @@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, =
struct strbuf key,
>>>>>  	uint64_t last;
>>>>>  	int j;
>>>>>  	r->hash_prefix =3D reftable_malloc(key.len);
>>>>> -	memcpy(r->hash_prefix, key.buf, key.len);
>>>>> +	if (key.len)
>>>>> +		memcpy(r->hash_prefix, key.buf, key.len);
>>>>>  	r->hash_prefix_len =3D key.len;
>>>>>
>>>>>  	if (val_type =3D=3D 0) {
>>>>
>>>> I am not sure why any of these are needed.
>>>> ...
>>> I don't know about the first two, but in the third case dst (i.e.
>>> r->hash_prefix) might be NULL if key.len =3D=3D 0, reftable_malloc is m=
alloc
>>> (which it is, because reftable_set_alloc is never called) and malloc(0)
>>> returns NULL (which it might do according to
>>> https://www.man7.org/linux/man-pages/man3/malloc.3.html).
>>>
>>> malloc can return NULL on failure, too, of course, and none of the
>>> reftable_malloc callers check for that.  That seems a bit too
>>> optimistic.
>>
>> Yeah, I agree that the real bug in this code is that the returned
>> value of malloc() is not checked.  But checking if key.len is zero
>> before using memcpy() would not help fix it, or hide it.  So I am
>> not sure if that is a counter-argument against "this check is
>> pointless".
>
> It's not -- I was just trying to find a scenario which would cause a
> Coverity warning that could be silenced by such a zero check.
>
> We can use xmalloc and xrealloc to handle allocation failures and to get
> valid pointers for zero-sized allocations, like in the patch below.
>
> I don't understand why reftable_set_alloc exists, though -- is there
> really a use case that requires changing the allocator at runtime?

I don't know why it's there, but I suppose it's for the same reason as
PCREv2's integration, whose rabbit hole starts at 513f2b0bbd4 (grep:
make PCRE2 aware of custom allocator, 2019-10-16).

I.e. for building it as part of git.git we can just replace
malloc()/free(), but for other uses as a general linkable library you'd
want to replace it at runtime.

