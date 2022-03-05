Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26086C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiCEAip (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiCEAio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:44 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEC4161A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:37:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so5412765plb.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hfWEUOsrZC28dVFIzwRg43dUXBEML7un1hROPl4N8h8=;
        b=EoKuZZD6nPhrwFY6iH87Yl1t5VudNhYjP/ZQSUW+SKyzrDYxeaK+RLE1CrBsT41Exl
         UO1E4xF55A6zLp0rTI8nFhdOgdpVak6+KHNFAa4Re0uYOvo56WA5DlUZ3MZjaDeVmN/h
         97sL+Sl7Nevk0jzF+o2c0JCG2+yKLgw/ri1GzBddxbM8HC+DDCIEp5Zlu1JcRKhXpPvN
         1BWRx1IV0/F2f/Q4DzimS0J9y+HioNOqTDo/p715ycn/ZARBMS+YZy3LjGYOLXLbE4BL
         XL2f4FLhHx97x7pTpndyMovkvatBYydLZsVY6pr0YJM6qIZeYV/GYSZGVJ72FIEiYwR6
         ObaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hfWEUOsrZC28dVFIzwRg43dUXBEML7un1hROPl4N8h8=;
        b=0LwUyy1Y5sOhDFbWAeScuKkUrt28YKaXeIcvSJEvXudWPUVriTTZSLVvGuBXlaeSHi
         2C9YZX/DUpnmje/2K2sWxhOBgNIrCtwlMOEC/2FBHeTXTklTCaVt0g0m1iiWClRWeneP
         1Fk4uI2S3Rm7xotD5X/GmvvaFSTrpnwERVOqzUSlluPOBy4VJgrQUIPdrRjS12avIakq
         GL5HBgh5VW+R7j+f2sExmiA2LovgqolaKC5OmorI1rgUf85olj/CrhP8ZgufvepxNWKa
         ztV6rDZGh5bIMECsbOwqXrQj5fHuQcyLY3MDqr3uYLfIBbGDrurBeznL1WgF3RCAF8oh
         L3jQ==
X-Gm-Message-State: AOAM5335cjMaj/uIhCdfCXhfJOH2DrFzau6iO5L0Q+D33DNoOhpQ01QK
        H6SW6dpLRKFC1cEVLXr9Kho2Cu/gFGgksg==
X-Google-Smtp-Source: ABdhPJycgzXbMMCxeMXpDD6IEty128/BYEHqcV2D/mPMVWiq9dG3VfzffScGJKEpwe5W3Dq1kDXkl84/y7G3tw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8318:0:b0:4f6:ba8c:17d6 with SMTP id
 bk24-20020aa78318000000b004f6ba8c17d6mr1376537pfb.56.1646440673263; Fri, 04
 Mar 2022 16:37:53 -0800 (PST)
Date:   Fri, 04 Mar 2022 16:37:51 -0800
In-Reply-To: <xmqqk0d9w91r.fsf@gitster.g>
Message-Id: <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
 <20220304005757.70107-10-chooglen@google.com> <xmqqsfry4f3z.fsf@gitster.g>
 <kl6l7d99494p.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqk0d9w91r.fsf@gitster.g>
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> And now that you've pointed this out, I realize that we could do away
>> with (.super_oid, .path) altogether if we had a variant of
>> repo_submodule_init() that takes the submodule name instead of (path,
>> treeish_name). (We have a similar submodule_from_name(), but that only
>> reads the submodule config, not a struct repository.) I would prefer not
>> to introduce such a function so late into the review cycle, but I could
>> clean this up later.
>
> I am puzzled.  What do you exactly mean by "late into the review
> cycle"?

I mean that reviewers have already seen several iterations of this, and
I'm afraid that a refactor might introduce unnecessary cognitive
overhead.

But of course, we might decide that the refactor is a good enough idea
that we want to do it anyway :)

>> - The changed_submodules string_list is basically a map that tells us,
>>   for a given submodule _name_, which commits we need to fetch and where
>>   repo_submodule_init() can read the submodule name from.
>> - We only use cs_data as a string_list_item.util, and the
>>   string_list_item.string is the submodule name itself.
>> - .new_commits tells us which commits to fetch.
>> - .super_oid and .path tells repo_submodule_init() how to get the name
>>   of the submodule.
>>
>> So we don't need to make this a 3-tuple.
>
> OK.  We need to learn in which local repository houses the submodule
> we discover in cs_data resides.  It may or may not have a checkout
> in the current checkout of the superorject commit.  And just one
> <.super_oid, .path> tuple should be sufficient to tell us that,
> because the mapping from submodule name to path may change as "git
> mv" moves it around, but the mapping from submodule name to where
> the submodule repository is stored in the .git/ directory of the
> superproject should not change.  Am I following you so far
> correctly?

Yes, that's correct.

> I am wondering if we need even one <.super_oid, .path> tuple.
> Looking at the implementation of repo_submodule_init(), I have a
> feeling that a version of "initialize named submodule in a given
> tree-ish in the superproject" would be rather trivial.  We already
> have submodule name, so submodule_name_to_gitdir() would be all we
> need, no?  After all, we are only interested in fetching objects to
> fill missing commits (and possibly update the remote tracking
> branches) and do not care about touching its working tree.  And once
> we learn that .git/modules/<name>/ directory, we can fetch the
> necessary commits into it, right?
>
> Or am I oversimplifying the problem?

I don't think you are oversimplifying. Now that I look at it again, it
really _does_ seem trivial. Doing this refactor saves me the headache of
explaining why we need a single <.super_oid, .path> tuple, and saves
readers the headache of figuring out if I'm right.

I'll try it and see if it really makes things simpler or not.
