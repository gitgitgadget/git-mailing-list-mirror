Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49024C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 01:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0760E76
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 01:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbhJIBeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJIBeH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 21:34:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B9C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 18:32:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so42609657edk.2
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/BXKDzXDYS2W3Dos5odxkzTyykJrDlVy5isPJVbUe1A=;
        b=alQvYf3tIjTCV8r8IlMU/GzvemIWQvhVxOlR+2jJMfXQlA+EkofDbb2ieo+RP6I4As
         7uUKq8w2aW4109aW81ij9dmMivATbPT3ju3yAiFJ0eTL0DB1+ypgr9huDRv+4fbPjMJd
         mFp92d6ANv1T44Jiv1yrh6xsuzCCj3EBtq68Qs2l9IzgaI5ClEI/KjXk6/ATF4bDc7gU
         QT5hFaTPvbYHEcv367u8U8haimZARgMbFh1jIphCL0wjc19KG12st6/QJxD2WPabc20X
         rSEhzjWS7Mt83pXT6wahGWx4GcMCCSxKFkbM3uP/2IQWn/ag1lJ025M89RWyL9rTROau
         +34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/BXKDzXDYS2W3Dos5odxkzTyykJrDlVy5isPJVbUe1A=;
        b=rariJEwXv3xtak/eRhvWRLiqTMD6htvzcu1AD6VV+rV024Pf9YxH5ozRcKBo53oHki
         sb9UO2oRyWo/wU9SbBDf0Lkoj8goiFbacBMA9EET/OvAlmgTBEL/wkGpk6nUlQtmR2Yl
         o/Fn/f0oYAJ6HMCE0x9tD2bFi+S1mG7fshzXT6QkFNfHmIBGxos7PYoYdODaOmkV70yw
         pAbYFyIKfm7StC2c4LC7X41yXkHl+Zm4ihuJ39FBXCFC5C9LD8FFG85YJyNo4inOQPrl
         bIWFfUMJvVLjU7lSfkdgVDIO19/SRAUfHLx/Dmg7/iGaXk8UX4j02/32ge59/XeAe5iR
         j5uw==
X-Gm-Message-State: AOAM530CNvn8xKd9sG4wiffDEv1tvpnE0jDBS5KuvjkIS5ty/O7jcqlK
        CeUHYtG9Dx24mv0hxeWyTxA=
X-Google-Smtp-Source: ABdhPJw4GxYVHoPDAFgOwrdbAZKYr+NHKP5LO9UyHV8613d6MXo6hrjdDOARs8cIn2bzEyePg/NRQw==
X-Received: by 2002:a17:906:ce2c:: with SMTP id sd12mr8546434ejb.488.1633743129551;
        Fri, 08 Oct 2021 18:32:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7sm399787ede.19.2021.10.08.18.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 18:32:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechows?= =?utf-8?Q?ki?= 
        <giecrilj@stegny.2a.pl>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Date:   Sat, 09 Oct 2021 03:29:45 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87ily7m1mv.fsf@evledraar.gmail.com>
Message-ID: <87ee8vm19j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Aug 27 2021, Jeff King wrote:
>
> $subject because I think we should really consider backing this out
> before it gets to a real release.
>
> I ran into this while testing the grep coloring patch[1] (but it's
> unrelated). Before this commit e.g.:
>
>     LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --author=
=3D=C3=86var -100|wc -l
>     28333
>
> So ~3k lines for my last 100 commits, but then:
>
>     $ LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --auth=
or=3D=C3=86var -100 2>&1|grep -c ^warning
>     299
>
> At first I thought it was spewing warnings for every failed re-encoded
> line in some cases, because I get hundreds at a time sometimes, but it's
> because stderr and stdout I/O buffering is different (a common
> case). Adding a "fflush(stderr)" "fixes" that.

It's partially that, but also more pathologically:

    $ git -P -c i18n.commitEncoding=3Dascii log --author=3Ddoesnotexist -1 =
| wc -l
    0
    $ git -P -c i18n.commitEncoding=3Dascii log --author=3Ddoesnotexist -1 =
2>&1 |wc -l
    6688

I.e. even if we don't end up emitting anything we'll warn, of course we
might not match *because* we failed, e.g. if you had a non-ascii --grep
string, but in this case it's rather noisy.

> But anyway, I think we've got a lot of users who say *do* want to
> reencode something from say UTF-8 to latin1, but then might have the
> occasional non-latin1 representable data. The old behavior of silently
> falling back is going to be much better for those users, or maybe show
> one warning at the end or something, if you feel it really needs to be
> kept.
