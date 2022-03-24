Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BBC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiCXTXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbiCXTXq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:23:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28C6662F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:22:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p10so3904914lfa.12
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJSiEkj9IUorq50YrCSnEnxvfbJb7x3R7afiRTVVJ9Y=;
        b=K036VEupZkGoQyYYiprn+zXaWnrPxJRlQcvx6nenjScQcVm7DDyLbSDikaynrMqhr5
         jXcULQayXe306MZept+KykGrIS1p0DvAkFugW9yuRX6q4GlRqKGBYrpywW+pVsrzcsZP
         vOSa2IjYVbe9f3VTBm4qWiyd1kgb5UYKGt5xPvx5RckGmvxtJ3qZJtd4WkrFoDsF7Dyl
         04F4f4V/6WT0PMfd20fvIBnSc46Ud2hmuzC2j7Pyr2v5TC8tCGFnPL69N2fc89xvhx0h
         UfzkkbXFj+Pxs5H6gTzrajMqXpNoehOwU3kXI8b8drn3s1jWHHwOl8FTREEOtcS6s+ZG
         6dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJSiEkj9IUorq50YrCSnEnxvfbJb7x3R7afiRTVVJ9Y=;
        b=rb3V+zV1di14Uzc3iMGG4fnoEslAXD3jAHDXX4cjUYJ/iIKK7eCF0HIBYw/WjaP3/n
         IXEb6wzVxStg7pnGnjzNECHIrvuC58P1+RmV1wkNTwjyW0W2dqQp7JI9bK4gQ4fPd3pf
         3THJxYw2wlJgBetRQoggQVOT3wbzrS+6d2O7zVIPbfv0sj52LshhBrtpeaEE2u4p7Ale
         i44faBV0bCVyooC+GBWaAP1IkuBbjXmmHRfW4w7n//bBwffAWv2RzTZGDIajxzWd9Ipp
         QDx8zUiuVrN7a4s3MCq5++SZjmam8igM4ioj+WHqKV09EAod+TbfU9sa8mEYeTSRo31X
         x2fw==
X-Gm-Message-State: AOAM533ZVuCmZpLBHjCO6d7OoSzVaLHlMD6nlUChKqQUtQVchFKPGuU+
        l9KaLokS2RvOWn0HeNSnAIn7l1+s4YSxbUHNl1CIhbFCr6mJWg==
X-Google-Smtp-Source: ABdhPJwwnHhjFaw9qi1yUd4agHuAqo6Ovd/RCjop3sScBUTr2Yr8UYPFO4uqEV+Ju2g5K6lvSXjulO43K/n2xM/wHSQ=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr4846064lfe.74.1648149730567; Thu, 24
 Mar 2022 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> <xmqqo81vi6u7.fsf@gitster.g>
In-Reply-To: <xmqqo81vi6u7.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 24 Mar 2022 12:21:59 -0700
Message-ID: <CANQDOdfcgaRUkygG9or7VS02uzo9vz1Ve=nkFUs_aYu3vVaCnA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 10:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > V3 changes:
> >
> >  * Rebrand plug/unplug-bulk-checkin to "begin_odb_transaction" and
> >    "end_odb_transaction"
>
> OK.  Makes me wonder (not "object", more appropriate verb than
> "object" being "be curious") how well "odb-transaction" meshes with
> mechanisms to ensure that the bits hit the disk platter to protect
> things outside the odb that you may or may not be covering in this
> series (e.g. the index file, the refs, the working tree files).
>

As of this series, the odb-transaction will ensure that loose-objects
(and trivially packs as well, since they're currently eagerly-synced)
are efficiently made durable by the time the transaction ends.  Other
parts of the repo (index, refs, etc) need to be updated and synced
after the odb transaction ends.  Patrick's original ref syncing work
at [1] also contained a batch mode delimited by the existing ref
transactions.

I think larger transactions would be interesting to have, but I'd
argue that the current patch series is a worthwhile building block for
that world.  It solves the real-world multiplicative pain of adding N
objects to the ODB, where each one needs to be fsynced.  Patrick's
batch mode solves the real-world multiplicative pain of updating R
refs during a big mirror push.  Even talking just about the ODB, we
still have O(TreeSize) fsyncs for the updated trees and a few extra
fsyncs for commits.  We can add odb transactions around those things
too, which should be easy enough going forward.

[1] https://lore.kernel.org/git/d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im/

> > This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.
>
> "at ."???
>

Sorry, to make GGG/Github happy, I had to rebase onto b9f5d0358d2,
which was the last non-merge commit that's present in next. Then I
could target next with the PR and get the right set of patches.
Basing on fd008b1442 didn't work because GGG doesn't want to see a
merge commit in the set of changes not in the target branch.
