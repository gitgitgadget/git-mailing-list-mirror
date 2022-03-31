Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99D9C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 12:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiCaMsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiCaMsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 08:48:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59B211EC2
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 05:46:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c62so28028213edf.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zyWHvmcTDoKJ0Tkllamjq73wEX727Tyax5uwbgdESRk=;
        b=Majy0Sw+Uhp4oG5QbvXluE3K7A4jNRa/7lVq3ImpNG81SGWg4QGYs74pRYqpq5Mlca
         LHBDIHJJMfew0YMIG31U9Jipq8k2fizY2BaQM5V9PqE2qBBL/FFo392B/BQGeoXjf0VC
         58rYwfPba7dv3mMfAxGijNZQiZ5/I9Xc0rxZ6aXfsPEZbNi15KR8PGHGsUfugsHWXGLp
         Snv7AcSkfGAjWQzka8x4lEwcyQaU8sPI74zXZ2RHPHzi2x6Ppy9tX+gzIqs1AWJcmWjo
         cMPvhw9NNOCGZAd3D41BtY2watnMewFQXJJUU+pfX+ACTlq8FTlT6Jzie8OTqmCt8pfh
         dBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zyWHvmcTDoKJ0Tkllamjq73wEX727Tyax5uwbgdESRk=;
        b=l7HnS+CQDHZOn54JjbWQrxca9ds0MufLrGxaq6KUYIz1cyHq+ge1XQmafy6P/s7Zof
         ExMap/4PK18/yf0nHM62s2oCn0scg4rUDpr4X9/oV0yykDTC/lsbDGRMS0+FSeA52gr4
         xEoJ+WkOEnLHmOVvJCy8qxrYqjAQdKygIHtDy/UTLq075MyEKtom8nr2K3CwN0icv2fb
         ZkM7Ej85ORYM1hCUADsR6Fx+NbWgqjZ/GdXwE8FLd79c+9UhjjsrzaVQOshJ6kDasrP/
         Sd/SxgAkj+a1qd8acLzvywKClipHRj4PXLGkSiEdfbLJ/+2GSzYgEwEXRHBg70+Z/Csd
         OW6A==
X-Gm-Message-State: AOAM533MkkoNpfP4VeHQLW+QfcTMgi55NSGA+2oKE2K882M8PFg80lMz
        l6pUBUcSzlfr8vqkI0QsriQ=
X-Google-Smtp-Source: ABdhPJzF69kegGRa1e4lERm6OTZIw4LqGv8Qav6rMgGRF/lWZrt6nry48fqVzXqI0o9AY3kP+EH/9Q==
X-Received: by 2002:a05:6402:1e88:b0:419:746e:fb05 with SMTP id f8-20020a0564021e8800b00419746efb05mr16085353edf.307.1648730812574;
        Thu, 31 Mar 2022 05:46:52 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm9224565ejh.204.2022.03.31.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:46:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZuCR-000Raa-GE;
        Thu, 31 Mar 2022 14:46:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v12 7/8] unpack-objects: refactor away
 unpack_non_delta_entry()
Date:   Thu, 31 Mar 2022 14:42:34 +0200
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
 <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <patch-v12-7.8-11f7aa026b4-20220329T135446Z-avarab@gmail.com>
 <2f98c63d-f2c9-26fe-cfd3-9eed6b79047a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2f98c63d-f2c9-26fe-cfd3-9eed6b79047a@web.de>
Message-ID: <220331.86wngap9vo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Ren=C3=A9 Scharfe wrote:

> Am 29.03.22 um 15:56 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> The unpack_one() function will call either a non-trivial
>> unpack_delta_entry() or a trivial unpack_non_delta_entry(). Let's
>> inline the latter in the only caller.
>>
>> Since 21666f1aae4 (convert object type handling from a string to a
>> number, 2007-02-26) the unpack_non_delta_entry() function has been
>> rather trivial, and in a preceding commit the "dry_run" condition it
>> was handling went away.
>>
>> This is not done as an optimization, as the compiler will easily
>> discover that it can do the same, rather this makes a subsequent
>> commit easier to reason about.
>
> How exactly does inlining the function make the next patch easier to
> understand or discuss?  Plugging in the stream_blob() call to handle the
> big blobs looks the same with or without the unpack_non_delta_entry()
> call to me.

The earlier version of it without this prep cleanup can be seen at
https://lore.kernel.org/git/patch-v10-6.6-6a70e49a346-20220204T135538Z-avar=
ab@gmail.com/

So yes, this could be skipped, but I tought with this step it was easier
to understand.

We previously had to change "void *buf =3D get_data(size);" in the
function to just "void *buf", and do the assignment after the condition
that's being checked here.

I think it's also more obvious in terms of control flow if we're
checking OBJ_BLOB here to not call a function which has a special-case
just for OBJ_BLOB, we can just do that here instead.

>> As it'll be handling "OBJ_BLOB" in a
>> special manner let's re-arrange that "case" in preparation for that
>> change.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/unpack-objects.c | 18 +++++++-----------
>>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> Reducing the number of lines can be an advantage. *shrug*

There was also the (admittedly rather small) knock-on-effect on
8/8. Before this it was 8 lines added / 1 removed when it came to the
code impacted by this change, now it's a 5 added/0 removed in the below
"switch".

So I think it's worth keeping.
