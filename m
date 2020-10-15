Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA380C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0752145D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouJVL+av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgJOKa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgJOKa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 06:30:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105F7C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 03:30:26 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id s1so906617qvm.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uHJdeZGw7Fji52BhIKi0lLYrGCPAx3i9cU9yi0BSJWk=;
        b=ouJVL+av61YyEW0OJ7NDPejilyEyJjMPG3EDpDMz11k3e4/OexWM9LDWn9DanFwd2u
         rthyrJhPjY7aMbPaVzJwwV+M1KVvEzcSdV+O+jcGLNlSFcR2Aklyr5OHP1/HWGEKx96W
         +OYeurZxxJIKylJL6DI61iJBy/PYvVilwqzeNr3M0cbMTbwR8pzNJzSIrUWvmT65mMAF
         vwXgD+5xWJyZr+O6iyf3U+8HR1vl+Q/+3yGw+jJZ7xuJ2Oe0tBQeILdDIdNLG9xxmCXn
         lxeDJ8SfDS2rfDskoauLtI6aXN8HxvOnLTh8gxm38/rghflInFoXJDFkdwRD2X4XsYJ7
         vOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHJdeZGw7Fji52BhIKi0lLYrGCPAx3i9cU9yi0BSJWk=;
        b=DFf0NKhCNwf3ae4SEck73R2RDQsiQoi09iHne3WutP3yaoD+/LyAOMswzhePD9zQla
         3mQT4BQCY585wssq/S/iBuyeT3X7XNlkZqaES3DT1wta9ZWJxKi0mfoVnYP1jcCH9BC1
         DUiEz0auJlL89/LHQblsmLVSM02zBYEDATjiIfEfXskOxPn+Pyc+q16W9ijNQtICfTDk
         4wfjXU8tfiqbh3b+WV4LE/4BU9OAoyZ8Vau4lOBOMS1s2HL/qZEAisl822+LDsWzViIZ
         qS3Xsz8f5pmS+8OsxTwfRSuvy+RZ6N3N4IYsSC2kHasDADvqsSi6oDV/gXcbsjEGUFQa
         HYHw==
X-Gm-Message-State: AOAM53111/zRB04OSSUXh5iNyadtqCH4mB1GSoFT9BizWAgiZUUoVIYz
        Mmwmnx9BNvsdRsCdYqmQAZmCgTPVfPo=
X-Google-Smtp-Source: ABdhPJyCdptvKuoYYu6eStv3xazUkO5Ra16Oq+BOQhVZMSqO/VDK3mkzQ3dnyBX41admoYKorQLfog==
X-Received: by 2002:a0c:c709:: with SMTP id w9mr3863130qvi.26.1602757824461;
        Thu, 15 Oct 2020 03:30:24 -0700 (PDT)
Received: from [192.168.1.55] (c-174-56-144-2.hsd1.sc.comcast.net. [174.56.144.2])
        by smtp.gmail.com with ESMTPSA id x75sm973517qka.59.2020.10.15.03.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 03:30:23 -0700 (PDT)
Subject: Re: Branch Management questions
To:     Konstantin Tokarev <annulen@yandex.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
 <2011231602755586@mail.yandex.ru>
From:   Leam Hall <leamhall@gmail.com>
Message-ID: <d10fd33c-3d5a-c5ed-c21c-6e6eff1a6351@gmail.com>
Date:   Thu, 15 Oct 2020 06:30:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2011231602755586@mail.yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/20 5:55 AM, Konstantin Tokarev wrote:
>=20
>=20
> 15.10.2020, 12:51, "Leam Hall" <leamhall@gmail.com>:
>> 1. Two developers.
>>  =C2=A0=C2=A0=C2=A0Dev A is working on Branch A, off a release_candida=
te branch.
>>  =C2=A0=C2=A0=C2=A0Dev B is working on Branch B, off the same release_=
candidate branch.
>>  =C2=A0=C2=A0=C2=A0Branches usually run 1-4 weeks.
>>  =C2=A0=C2=A0=C2=A0Dev A does some work that would help Branch B.
>>  =C2=A0=C2=A0=C2=A0How does Dev A get the Branch B work that is needed=
, in a
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0way that does not confuse the merge pro=
cess at the end
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of the release cycle?
>=20
> Avoid long-living branches and integrate atomic parts of work into base=

> branch as soon as it's done and reviewed.

Unfortunately, for some tasks 1-4 weeks is atomic. The review process is =

being improved as well. We still need a way to integrate the=20
longer-lived branches cleanly. We've already had issues where attempts=20
meant lost code.


>> 2. One developer.
>>  =C2=A0=C2=A0=C2=A0Working on Branch P, realizes that a new functional=
ity X is
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0needed.
>>  =C2=A0=C2=A0=C2=A0X isn't specific to Branch P, but critical to it.
>>  =C2=A0=C2=A0=C2=A0What is the best way to deal with X, knowing that f=
urther work
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0on X will need to be done?
>=20
> Rebase P to the top of parent branch after X is integrated (see above).=


Ah, so "Stop work on P, Resolve X, Rebase P from updated parent"? Let me =

go read up on that, it makes sense.

Thanks!

Leam

