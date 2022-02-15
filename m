Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCCC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 09:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiBOJMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:12:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiBOJMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 04:12:46 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E1220DB
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:12:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk11so22405164ejb.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n4Hw3cSOr/4GKw3vqjKb6MTNVo7gZVWdG9ibdNFAOBo=;
        b=fZ3cY3sYDsG7KiuRzK5QMMXDzPycwQphPw9Tpkz3jO9bbTdRuYSzofQEUhB4eCQnqm
         /ZDF+HRU+I0NtOXPhoaPpErbe8V3bO6B4zaTzWsX0o+h4XmPNCm//Jszoj5EWZ6Pkoa4
         TwpYxQguAQYK12D8IkXPLtzyfT+F/jQDfTeGPS3dfJjoVl/Km2Oz0mGAdZD+zd2/O/Pk
         TwTRyMXwdKpeXkJb44BqsG2AGRQtHZp5E7kkkK/Bv+4UaSR744kmmRDTFEzqQTe55J3R
         En2tAYb7BNN+i3m6bfieHVhQMBEIUbW4JVcnQ1GnS/tU/aobWCO5B0C62CEf2Dp3s6Mw
         oxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n4Hw3cSOr/4GKw3vqjKb6MTNVo7gZVWdG9ibdNFAOBo=;
        b=kWEZw7BvWzy8EfYNmgXP9o4jWwqVP7jdamrAgCF3LWb5134H07HDJfQc4l7j3+ZbQK
         ztnDpEI3Ul+GGJLHb/3tNJfmSqkxslz27kNwT3lmThvGHsr1Qg1aVbMXCyg2XMP4uwFp
         ZH8o9cDE0RWDYM/hcusmpJS1OCgcKvDv3ACcmbAhCA+5K54ku4gzsS8swYXG5tJdYPeM
         ynWD5TYo2uvnpLtlf3opgIaxJkjKxJIwv5GEjJShZXI+iZVXqEYDMlNzehmyGuJb0kgM
         GVecLeUOTP6tT/AeB+GK0pFWgOu8P3r5nS5hNkmxNBjbGwsgcpt7i4taD+MC5K0IPKo1
         47Gw==
X-Gm-Message-State: AOAM531nMULDM2E//MvCCoVqjfJzRlLw0ELTUpGCaSFAjlLz1ZFawmTO
        wsYTeIgC+j/lYg/PEjzgxenuC+RPZapRDZl0IHw5hLuK
X-Google-Smtp-Source: ABdhPJwRrxPwnZprP4XS2gNwaHx0Txxw79lG/bKhyIsQtdPOyR9ECb/Y1SjNVnSKiozltM/DfjTyELCNQqKmYY8+hyw=
X-Received: by 2002:a17:906:2811:: with SMTP id r17mr2150583ejc.31.1644916354901;
 Tue, 15 Feb 2022 01:12:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
In-Reply-To: <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 10:12:23 +0100
Message-ID: <CAP8UFD3Fc9315jsbTFNzGunLyrm0P=zDLda2F=7O_5+B-ZtBOA@mail.gmail.com>
Subject: Re: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 9:25 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> When fetching with the `--prune` flag we will delete any local
> references matching the fetch refspec which have disappeared on the
> remote. This step is not currently covered by the `--atomic` flag: we
> delete branches even though updating of local references has failed,
> which means that the fetch is not an all-or-nothing operation.

It could perhaps be seen as a regression by some users though, if
updating of local references doesn't work anymore when deleting a
local reference matching the fetch refspec fails.

> Fix this bug by passing in the global transaction into `prune_refs()`:
> if one is given, then we'll only queue up deletions and not commit them
> right away.
>
> This change also improves performance when pruning many branches in a
> repository with a big packed-refs file: every references is pruned in
> its own transaction, which means that we potentially have to rewrite
> the packed-refs files for every single reference we're about to prune.

Yeah, I wonder if there could be a performance improvement in the
previous patch too as it looks like tag backfilling wasn't atomic too.

> The following benchmark demonstrates this: it performs a pruning fetch
> from a repository with a single reference into a repository with 100k
> references, which causes us to prune all but one reference. This is of
> course a very artificial setup, but serves to demonstrate the impact of
> only having to write the packed-refs file once:
>
>     Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
>       Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User: 0=
.858 s, System: 1.508 s]
>       Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 runs
>
>     Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
>       Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User: 0=
.715 s, System: 0.641 s]
>       Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 runs
>
>     Summary
>       'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
>         1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic +r=
efs/*:refs/* (HEAD~)'

Nice!
