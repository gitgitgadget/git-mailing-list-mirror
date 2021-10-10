Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069EC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D803B60E52
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 15:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhJJPrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 11:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhJJPrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 11:47:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC4C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 08:45:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ec8so7580173edb.6
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3F1qqqs83NvRW37BulWTyYmAaQnrsZVQw/bP4pvSiCo=;
        b=Qnc7yX1HqNAzipmP9y7FJaGHQpMumkpZEODlMyBsoAXzpLwre6ZIoeQR5Fx9N3C0tr
         D+/sGMPL7KWJQfWuGilRBZ5hoWVdT3XRfI+IZaUpM3yUKjTa+VYuT/g/0XVJJG79sZj9
         f06ofEfKROY42jJfeCrXjRi4zcvbikYoRaZxxXS5Q/G1ZRB40BK8mCtZpAQSmtDURdue
         UULhegfvKWUI4qAwGtfiqPVqYayQc/fkTZ9VycDz/AeaOR5Ne0YkdBwgyaXSDpgWkRzE
         pxpmY3p8YmSkAtvrH0fmZJAZV14RSXZnGpQho5M5+X1/YZEIbtVoc8U3SwoJ+3LposwK
         hpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3F1qqqs83NvRW37BulWTyYmAaQnrsZVQw/bP4pvSiCo=;
        b=wzirtvSzXzMCksnsREW7rnl8aGmMa/RH0rFw4iZ5U3hAg8QQnw3qRp5/rqCPRpZb9S
         9qLs2dPCWFdg3FAkLD0AypFW8g2n51t7Ix3HbvvBlsIa1R07XUE/V0am7K3XO+ushK/Y
         J63lJWOUwCegcsL6/HqdH+h4fFjF81iZcc4zM12uouH4etCksVVsBuMQjogUCNtmh9oL
         7EFgkeERP0hMJoYyZNi9dsD9cvT1LpjXF+HR4PicfQVpLy9yD68H7Lswvj42MYjx8Z5E
         mZ32BFkZ+o2EURcZRgqbSmBt1dedc/+9+o6m8+tm4jUZu+mGOeKdsKh2J6hfrdqTcndP
         2FYQ==
X-Gm-Message-State: AOAM530lNP8indJl8aMso+09xaqsGXhDR5/62hJIRAiUjHP/J6GEiAHP
        mdwtLpwDRPW10IyurQBZfWU4/szdHaY=
X-Google-Smtp-Source: ABdhPJyk8I0vnaN3k186dBRDsiGqzld3u9mqYzWacByviXc3uZrNPqBOiOYcJTGr3huFEgA1VQTcbA==
X-Received: by 2002:a17:906:a2c9:: with SMTP id by9mr19333030ejb.305.1633880717231;
        Sun, 10 Oct 2021 08:45:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm2209139ejx.82.2021.10.10.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 08:45:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Date:   Sun, 10 Oct 2021 17:43:42 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <5eca71b7-e4df-92a1-35bf-5a99550e558e@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <5eca71b7-e4df-92a1-35bf-5a99550e558e@kdbg.org>
Message-ID: <87sfx8lw8j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 10 2021, Johannes Sixt wrote:

> Am 09.10.21 um 04:36 schrieb Jeff King:
>> On Sat, Oct 09, 2021 at 02:58:10AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>=20
>>> I ran into this while testing the grep coloring patch[1] (but it's
>>> unrelated). Before this commit e.g.:
>>>
>>>     LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --auth=
or=3D=C3=86var -100|wc -l
>>>     28333
>>>
>>> So ~3k lines for my last 100 commits, but then:
>>>
>>>     $ LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --au=
thor=3D=C3=86var -100 2>&1|grep -c ^warning
>>>     299
>>>
>>> At first I thought it was spewing warnings for every failed re-encoded
>>> line in some cases, because I get hundreds at a time sometimes, but it's
>>> because stderr and stdout I/O buffering is different (a common
>>> case). Adding a "fflush(stderr)" "fixes" that.
>>=20
>> I don't think the buffering is the issue. By default stderr flushes on
>> lines, and we flush commits after showing them. If you take away "-P"
>> (or look at the combined 2>&1 output in order), you'll see that they are
>> grouped.
>>=20
>> Now one thing you might notice is that there may be multiple warnings
>> between output commits. But that's because we really are re-encoding
>> each of those intermediate commits to do your --author grep. And if that
>> re-encoding fails, we may well be producing the wrong output, because
>> the matching won't be correct (in your case, presumably the correct
>> output should be _nothing_, because =C3=86 is not an ascii character).
>
> I don't understand why i18n.commitEncoding plays a role here. Isn't it
> an instruction "when you make a commit, mark the commit message having
> this encoding". But grep does not make a commit.
>
> If this were i18n.logOuputEncoding it would make much more sense.
>
> Have I misunderstood the meaning of the two options?

It doesn't, see my later <871r4umfnm.fsf@evledraar.gmail.com> for when I
got it right.

For the amount of warnings etc. it's the same, whether we call iconv
because it's e.g. ascii->utf-8 and that triggers iconv() issues, or
(with i18n.logOuputEncoding) utf-8->ascii.
