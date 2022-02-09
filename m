Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6458DC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiBISKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiBISKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:10:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1273C0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:10:50 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p5so8255743ybd.13
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2VBkMLgFE79lghcJ3dmh2c2e/oFi44uOszUqi0TrMJo=;
        b=IhvX5yvGdIYvAsFhJQBLCgbF9Bw/eWt4FATP85QccxPcl3NNJn1PDH9occHbkmdgvF
         o6usfwFcgNnePy4r0IucL0SnX0bOVRkjDWvJlJ0YHyJnquuseWvJk3fXkE3/7haMilNY
         vH1+5MfL/grl5IKpTAh8XMpNCxMsvqTnjn/UXtn1xjX183uk9K8lcWI+voN4PBlBSorh
         Jp8kW95V7jKR2HV+fHE+sQrHGXC0Hgjkc0mWaBsojzm7SzWImmeafLgrjibXnkQpcKDp
         8VKGctFoTrFBqkCYDoyrOyUQd2XZYazmVGtwCcCrOnOtaC6DAQdiILrAP5PCEwhILhdr
         1SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2VBkMLgFE79lghcJ3dmh2c2e/oFi44uOszUqi0TrMJo=;
        b=2ZHzPKCwXKK0ehyNMK87E+kffE+0jaRpmabsy7Z0YeqBv4FfwQUMl0ultL8fexTPJY
         CoNmunFNZcfAokzN0RoUmZqzby1teRZ9OSqiMgNRkUaQJa5yVVdkQwZi8INpqTdiamai
         R/vsX+Hq3tc0jWVXVTdB7n2VFQleOdb/1ftcn7emNT0PQ9i2vzCMjUVmTV5mb+Z7JLQX
         BgIvlgdb9e3gD1HvXM2Bqc+lVsAiS1WA1LT2IeNMS4QPbRmgfdclILGbg5z/djoIt2u0
         2MJ8vLaMCaIZkH4nfpA2cz9vkopbMyKFv9F2d128dfcxtpCybiWnwLCw4cFelj1R1M7A
         ODkA==
X-Gm-Message-State: AOAM530d49LzhAVbjgzW4OqWCzUVk02GxMzdaNvm0NfD05ztqbM0Anc3
        mFkNfGozA2/UMVu4KQNvC734PWyJddjR7DLqE42JS/pr
X-Google-Smtp-Source: ABdhPJzctDU0wXjJRr/nINWlkMzASgBHyTYUrksGQbiSdlW70vxUTNYLY/f+5Oy+2GxZ8LIfeJTyB3GU1Xhf3hnaEks=
X-Received: by 2002:a25:6642:: with SMTP id z2mr3413233ybm.404.1644430249978;
 Wed, 09 Feb 2022 10:10:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643364888.git.ps@pks.im> <cover.1643806143.git.ps@pks.im> <4b9bbcf7958da6db2be771f910974a6bffb2d94a.1643806143.git.ps@pks.im>
In-Reply-To: <4b9bbcf7958da6db2be771f910974a6bffb2d94a.1643806143.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Feb 2022 19:10:38 +0100
Message-ID: <CAP8UFD0r2ZnGCAjkQcLfEZCvxHVFGSWeAC7vSat7V7-=rhiGeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fetch: skip computing output width when not
 printing anything
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 5:13 PM Patrick Steinhardt <ps@pks.im> wrote:

> Skip computing the summary width when the user asked for us to be quiet.

There is a --quiet option for git fetch, so here we can expect that it
will be used to test this speedup...

> This gives us a small speedup of nearly 10% when doing a dry-run
> mirror-fetch in a repository with thousands of references being updated:
>
>     Benchmark 1: git fetch --prune --dry-run +refs/*:refs/* (HEAD~)
>       Time (mean =C2=B1 =CF=83):     34.048 s =C2=B1  0.233 s    [User: 3=
0.739 s, System: 4.640 s]
>       Range (min =E2=80=A6 max):   33.785 s =E2=80=A6 34.296 s    5 runs
>
>     Benchmark 2: git fetch --prune --dry-run +refs/*:refs/* (HEAD)
>       Time (mean =C2=B1 =CF=83):     30.768 s =C2=B1  0.287 s    [User: 2=
7.534 s, System: 4.565 s]
>       Range (min =E2=80=A6 max):   30.432 s =E2=80=A6 31.181 s    5 runs
>
>     Summary
>       'git fetch --prune --dry-run +refs/*:refs/* (HEAD)' ran
>         1.11 =C2=B1 0.01 times faster than 'git fetch --prune --dry-run +=
refs/*:refs/* (HEAD~)'

...but --prune and --dry-run are used for testing. It would be nice if
this discrepancy was explained a bit.

Otherwise the commit message and code look good to me.
