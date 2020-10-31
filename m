Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A783C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EE5206ED
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm0t+K+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgJaRWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJaRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 13:22:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3AC0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:22:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id i17so2225807qvp.11
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hWAe+e1/j45ft49DRqWmyRxYDKkng7l4eXHjiRXSdeM=;
        b=Lm0t+K+br/i77qoOy9HfI3jNtk2rDs4hw4n3uwM1hqGPyYuoQ3xwLt4E1cH28dJ5ph
         L36mS6+q80RpCdG7lvWvUdABxMuT8rvG/odmrJrnl++u6bMBKly986ioYhOhQlx325Ge
         vlSTdBej7dCCPZWR6kQirOH4Ox76G4CrS7hz9QqVOCrp0oFF/aJwl5INGOnfwUPoixRZ
         KbdrtmzNucHEY5f9NWLPo6Sr3L+2lbn8FuU+upHvBXQu0R+OO+cEBfQ2kW0/HoLP6fpH
         TsAh/s1m/WQPIOKME1bGhJA/0A2X2sEoQ9VSQqo6Snnyk9L/J8qnIWTXMufQJd8mQNLT
         exaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hWAe+e1/j45ft49DRqWmyRxYDKkng7l4eXHjiRXSdeM=;
        b=EF4tmur7QCBXmMDdIfOAJu2d7BIFpqoGoXX1ltbbsnp7dBsLDb6LAr8rrEdvgR72Uq
         1H75GMc5Ukx0uZYJcbt6lZG+VljTp+6iAFt0PNjPB7VNV4vI7FDrQuo8XFKHgMUmpAe4
         V5IjYZbuf4buLbvhq0FIfK+5t9NxkrLNxHFgfesuqQVK6z2AlIuQiCGGnYjqbZrCZWKU
         hlhAaBtjSUqg3xYJ1oTQL2bzkf9yeEe0ptfmRT9MuKk/EgFohhNakKpFeceyGLwPpRjX
         Cgl4NeJiUMezsia9OsJGidfpBZH8yBm8k18orubW7NDebdZmtCzl9YPDkAp6WNlSrYGn
         4t5Q==
X-Gm-Message-State: AOAM533xodDafx0lPjlpogAykwacta8A7P5GWeaMZGhyl9y/ha+/PxvQ
        5ysKWpVO1z4JSbNgDMEDN9Q=
X-Google-Smtp-Source: ABdhPJzvjcNBF5/uqKHa2YH+YCc7cggGjHG0H0sBFNv8Ig0b4Yfzs6uhEubxGe7rk1ujaNnoqEHpOA==
X-Received: by 2002:ad4:4d47:: with SMTP id m7mr14741720qvm.32.1604164929956;
        Sat, 31 Oct 2020 10:22:09 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id n1sm2864531qkn.13.2020.10.31.10.22.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 31 Oct 2020 10:22:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/6] blame-options.txt: also mention 'funcname' in '-L' description
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq5z6s7pa6.fsf@gitster.c.googlers.com>
Date:   Sat, 31 Oct 2020 13:22:07 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45C117E5-1855-4BE5-A021-D1438B770A21@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <f7b64bf3302f934c44cf9364e4f008bb9ce26def.1603889270.git.gitgitgadget@gmail.com> <xmqq5z6s7pa6.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 29 oct. 2020 =C3=A0 16:25, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> Make it clearer that a function can be blamed by feeding `git blame`
>> '-L :<funcname>' by mentioning it at the beginnning of the =
description
>> of the '-L' option.
>=20
> I think it makes tons of sense to mention both <start>,<end> range
> and <funcname> range in the description.
>=20
> It is not a new issue you are introducing with this change, but I
> think the latter does not deserve to be treated as if it were an
> afterthought by being a mere parenthetical mention.

I agree. I'll address that for the next version.

