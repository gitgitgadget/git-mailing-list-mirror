Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2AAC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhLHNFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLHNFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 08:05:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D6C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 05:01:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so8030779edd.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ap+7sFrvEGMw5ZLd0ObBxY5FHcIsLNJS3N4/P6e6Gn4=;
        b=cdG9rozJUZsk07o3Nk/SAbvyKTvlREykWfZnMMeAsHOWiO9vr39n7C1V492Rlr19Qh
         VM++ZS+Wja9ny1zN7YvNyKeyivFFrGneHfJcq/ORKR59qWWxLFFUk3SeQeb7p8dqMqrb
         /FpKZ33KCcPjhu7mGNewn+om75G6Udvpe5+b1R74Sdu09Rz4AYjLvXc1u2UDrVstH+dY
         bZ08Y0xlcfnnx527n72t5agWGgqyk4wAs95aFpv09NYnrvqGfE3Jo8lZ44dihOCZt6TV
         lVaUl2jvCs0MIOrlxBxUnvF8KFz3jj2GBEok9Lc8EFzW1gfERrLbga2/ZfgqLUv+RVpF
         bS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ap+7sFrvEGMw5ZLd0ObBxY5FHcIsLNJS3N4/P6e6Gn4=;
        b=z0xpeLMGRaDEz7JSNqOK38SdzHmbYV1Q2OrMNXAoe/mXdA5fbuYaygtq9HpmQH98YX
         o69dNRZA5oTbANsctP2xvywuE/WFwbzS7wbyKzlKl7fb+XGPvbGzrnNsbJdYQH4rvIwX
         sXwl+TcdE6/OXjkgiiLi9xnz52+dnmgpSnPzwKdED1s3jCVyzFX7cGi2F2WgHlJZi6x/
         bw71O+1s8Q1enC3ZFAGBzj+ojlUY0Y+UkqioNsoQCIrIVFU/M6+QYfexok3Vxv9fb5yc
         V1qOnLPyxIJ14YhewfN6l3jVpJHKmWWe7PmlyN1aR//c9nSm5v5qJqYCnvU3UyOUuePO
         n/ew==
X-Gm-Message-State: AOAM530GKgToL0AlsGQI5mlbaqEIQ00PSP1sffWhaK8oXQJfdK+fvUlJ
        jQB0ImicxpRypBSbEVohDCiQtKTtnyWwIQ==
X-Google-Smtp-Source: ABdhPJyeQQYv6HxJPvIdsengGGwxZ9/0W4U8ly57N4vSlkTHKQRF0gqme437uVmoNtXPmg8E/aC2DQ==
X-Received: by 2002:a17:907:7669:: with SMTP id kk9mr7575866ejc.8.1638968494950;
        Wed, 08 Dec 2021 05:01:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb19sm1557197ejc.120.2021.12.08.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:01:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muwZh-001Qb7-OG;
        Wed, 08 Dec 2021 14:01:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: errno oversight
Date:   Wed, 08 Dec 2021 14:00:30 +0100
References: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
 <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <211208.86sfv3l0op.gmgdl@evledraar.gmail.com>
Message-ID: <211208.86o85rl07m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Dec 08 2021, Han-Wen Nienhuys wrote:
>
>> In refs.c in origin/next and origin/seen, we have the following fragment:
>
> It's in "master".
>
>>                    if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
>>                                       &read_flags, failure_errno)) {
>>                         *flags |=3D read_flags;
>>                         if (errno)
>>                                 *failure_errno =3D errno;
>>
>> overwriting failure_errno looks like an oversight?
>
> This is from my ef18119dec8 (refs API: add a version of
> refs_resolve_ref_unsafe() with "errno", 2021-10-16).
>
> I don't see the bug here, overwriting *failure_errno is the point of
> that variable. We're keeping the right errno value right after a
> failure, and passing it up to our caller.

Urg, sorry. Yes obviously that should use the failure_errno from
refs_read_raw_ref().

I'll submit a fix for this soon. There's some good post-cleanup to be
done here, it seems only one upstream caller of
refs_resolve_ref_unsafe() cares about the failure_errno currently (but I
didn't look into your reftable code).
