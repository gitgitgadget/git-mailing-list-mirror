Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCFC25B06
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 08:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiHJI4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiHJI4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 04:56:43 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C86E8B0
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 01:56:39 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id v128so14434686vsb.10
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ce3rnSqTxuyE/6hp+7kzEyFK+DkXKgO+NjAZkZLG330=;
        b=L42Bu/C1KnVIeUpACckf2/B2ItkhwYlPiLpDXZcNPYg34YWtna5PrRB+znSs9wWSLL
         KIzJCnhi4SBDyOR+QbHAwdEQTKLe8ZcQiB+dW6Hls/NJ7HGMwE30mGOzXpuMepnHWK+w
         sH0Ndj2m36qEeGTwVHBE6XWx1VrbSOo5tNCDb+im/2Vxtzdr6BqbiMFQagMV1Tuo0qFy
         Z/KBxJPpOU77MOH25Cw3MKd9D/lqZVWYfglAmljP8NmieKtgrCcpM7ryXE75kk7RVuCj
         jSy1RLOInrKQvL1CYOk2IQJsE/1UnJ4ZulKBPWgT3l4K1rbje1rzwNv079siGz07LoUS
         jdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ce3rnSqTxuyE/6hp+7kzEyFK+DkXKgO+NjAZkZLG330=;
        b=Ddgeq/7B5fmmXwSVtGzqKAhBoECIlQlHjwBpD7dqyEn5pULRiKtchxANEeABvt30af
         17VVZzDmrO0VHUbZ8ejMuYoCCi1i6jU6hksJuhhbpM2wfWg+ZmliTo42zw919OPCBOSa
         1K0wR3rJfDdFMy4ipMWByWBVQjDPmlHf3dEA/rY08Rz6FcMwwS5rcvdP8Shdnu03L1t4
         9UmZV6zgQeX77RMDC7mydBPboaNbdq2VJndCzUCpS5UEk+9YXfZPTDd5J3vjKeOl5UxT
         6cphg0GMX34Xxnm6ZMsp9A7zVy0l95P4AuD7+S0TkomDP9NQRTQqpJ4QPUDkF3I6Xd+e
         LQdA==
X-Gm-Message-State: ACgBeo1abp4jpsv6KPq8DrZKK73WckQmmMeaUYQr3pvfmVB31WoDV+m9
        z1X/Qxo5Gdv0aSloI4zbk2tKK825VqlLBWpujNH8ACom97k=
X-Google-Smtp-Source: AA6agR4be5JeWqs4J4jHrt5UEXLRO3W2+0OhQD+avTN8cU5TeEqrt40CY2+JAsmFbb6u8i4MBuWzcE+yenh5e/C15Ys=
X-Received: by 2002:a67:e94c:0:b0:385:19e0:df01 with SMTP id
 p12-20020a67e94c000000b0038519e0df01mr11061761vso.2.1660121798728; Wed, 10
 Aug 2022 01:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220809182045.568598-1-calvinwan@google.com> <xmqqsfm4prqk.fsf@gitster.g>
 <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
In-Reply-To: <20220810084017.gnnodcbt5lyibbf6@tb-raspi4>
From:   Alexander Meshcheryakov <alexander.s.m@gmail.com>
Date:   Wed, 10 Aug 2022 12:56:11 +0400
Message-ID: <CA+VDVVUKf48Q9A0hWPnBE+qG_7tBDuXKkdo+wWDU7iC3Wg=oEg@mail.gmail.com>
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe I have found exact place where strlen is used incorrectly
This is at diff.c:show_stats

https://github.com/git/git/blob/c50926e1f48891e2671e1830dbcd2912a4563450/di=
ff.c#L2623

It probably should be replaced with one of utf8_width, utf8_strnwidth
or utf8_strwidth from utf8.c


On Wed, 10 Aug 2022 at 12:40, Torsten B=C3=B6gershausen <tboegi@web.de> wro=
te:
>
> On Tue, Aug 09, 2022 at 10:55:31PM -0700, Junio C Hamano wrote:
> > Calvin Wan <calvinwan@google.com> writes:
> >
> > > Hi Alexander,
> > >
> > > Thank you for the report! I attempted to reproduce with the steps you
> > > provided, but was unable to do so. What commands would I have to run
> > > on a clean git repository to reproduce this?
> >
> > Sounds like a symptom observable when the width computed by
> > utf8.c::git_gcwidth(), using the width table imported from
> > unicode.org, and the width the terminal thinks each of the displayed
> > character has, do not match (e.g. seen when ambiguous characters are
> > involved, https://unicode.org/reports/tr11/#Ambiguous).
> >
>
> I am not fully sure about that - I can reproduce it with Latin based
> file names as well:
>
>  git log --stat
> [snip]
>  Arger.txt  | 1 +
>  =C3=84rger.txt | 1 +
>    2 files changed, 2 insertions(+)
>
> From this very first experiment I would suspect that we use
> strlen() somewhere rather then utf8.c::git_gcwidth()
>
> More digging needed (but I don't promise anything today)
