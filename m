Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLGRn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhLGRn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:43:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582CC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:39:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r25so59814907edq.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gvSQWY5SGMKsH5PIR7morQUEfwo+auCOUGqnUnLz2k0=;
        b=KSTaFH5rNFJw1j1tiNeoTayHWhJOR86oqg9ggPrHtqNH7psrc9jUred1LoEUIp1LZS
         paQavC3F72DeIhfBkUtomN+LsTYwnEjfnoywyzWJM19AO5dtgJFEIUdtAknDPaYPv3Rv
         vCwGV3Knv9i7A7vGO0FOIkhSEDQXnIBuZ5HCShXO/JpXWXPQv3rui4RDktaee03BF7pn
         p11HhU9c8cg8GuN+Xh9fl7zGwKLMCgMvpzuHRpXsTMOWtUzATrteMil1rQPW0l+dwe63
         fgJaCczh5qjriZHreVQpxLZg13vi6rwGFK91PxR2zvPY25FmQQ48VKQdT5SnWbH8ZUXe
         EKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gvSQWY5SGMKsH5PIR7morQUEfwo+auCOUGqnUnLz2k0=;
        b=uQucMx3uoxcJ9MezYcmUXiNqGCGVaqScki6T72rmTTe37HuVkud8+HKL9eXgB232Sp
         Ofb7a+cVfyDF+MDw97ocRLvW/V4aiSKE/5syOIDOjxpExEioyclqn+XD1j1LMmsumnbu
         myN6LqopfA4msp+e5hWBuO5+wzkHEvuUX7QF8XfSaAIxW1NoT5vdHZF1VWpKVZ7m7v6c
         4g5m6olFHUPxvBZXk7i8aou8j20YY5Cs2E2cNUb5CSPQgrVjbUwQnwND16vTTqZ/PO1C
         NZh3n+DjpRgcl1gTkv8wStgrYB1ZuZKTopQdIfOAmOyHbgoFF8tloTD5LdXIu4pZEPUe
         UtWA==
X-Gm-Message-State: AOAM531Zy3Mfeur3gfPCZCs6SX1EbyIIdSClR8+/cfm5TVeSRcy/qotG
        y3dFqwwBEwSVkodcHfL1X1w=
X-Google-Smtp-Source: ABdhPJxCtkTs7xb7+K3ZUaWATlUXAUkhpH+iubJKD9V3qjXpHiuRGtKDNXTTEfCkLBaCtc7bKsmqIA==
X-Received: by 2002:a17:907:7e91:: with SMTP id qb17mr897707ejc.449.1638898796488;
        Tue, 07 Dec 2021 09:39:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg32sm151348ejc.43.2021.12.07.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:39:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mueRW-001EIa-K9;
        Tue, 07 Dec 2021 18:39:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Alexander Kanavin <alex.kanavin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Build race observed with git 2.34.1 - hook-list.h wasn't
 generated yet
Date:   Tue, 07 Dec 2021 18:36:47 +0100
References: <20211207113101.69686-1-alex.kanavin@gmail.com>
 <0e3e3a4f-f6af-d8df-8973-255ed7b1b7ef@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <0e3e3a4f-f6af-d8df-8973-255ed7b1b7ef@github.com>
Message-ID: <211207.86sfv4nwk5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Victoria Dye wrote:

> Alexander Kanavin wrote:
>> Specifically:
>> 
>>  builtin/bugreport.c:7:10: fatal error: hook-list.h: No such file or directory
>> |     7 | #include "hook-list.h"
>> |       |          ^~~~~~~~~~~~~
>> | compilation terminated.
>> 
>> Please see here for the full log:
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/59/builds/4427/steps/14/logs/stdio
>> 
>> Seems like COMPUTE_HEADER_DEPENDENCIES isn't working quite right? I meanwhile have set it to
>> 'no'.
>> 
>> Thanks,
>> Alexander
>> 
>
> I've encountered this as well, and it appears to be a dependency graph
> issue. For me, compilation was fixed by a patch [1] that isn't in next or
> master yet ("Needs review" - ab/make-dependency [2]). If this an important
> fix to fast-track (I'll defer to more experienced contributors to determine
> that), it might speed up review to separate that patch from the rest of the
> series?
>
> [1] https://lore.kernel.org/git/patch-v4-19.23-2710f8af6cd-20211117T101807Z-avarab@gmail.com/
>
> [2] https://lore.kernel.org/git/xmqqbl1xqheu.fsf@gitster.g/

As the person who broke it sorry again about the bother.

If Junio would like to fast-track it that patch is cleanly
cherry-pickable on top of master.

I review by someone so that ab/make-dependency can move forward is also
most welcome.

Such a review can be done without any particular expertise of the
Makefile or the "GNU make" language. Just check out
gitster/ab/make-dependency and check if your normal build workflows work
as expected.
