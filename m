Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F2C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiCJWzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCJWzu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:55:50 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457A18461D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:54:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u7so9786580ljk.13
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6p2Mklpg9xuUEvuvRrVwsq3k08k2cIDm92OO0i2EBvM=;
        b=Gc3UJN2JuvxTU+joIcEVTeIyp7zw6Si+3BDObKnCQ2G3N/3rKyHRXx+FjSVZ2MnwAC
         3Js3/J8t0Ug20vRpob2VRXW3ADFSHAemHDrMLpr+ySAlUPiJRvZ5+FOiX4trhtJRfTiI
         KN0nuDIiT11ESogbjG492qgpJFT9UQtwVhbt/rptS1wJcaTo9/niiu83Uqacuea2bCo7
         DXQoC5OS4Zl/3bDozDAa6/XYJHokjOzwERWxhCfkZa66tlg89RzQqn4dBCdFYqDOovll
         BgkThaw4jMt4Sx17dJGfUfgTvW3zupIKmkR/mIrBrZ7TFNiTBoBoJZF3FTLbwBzszPQ/
         015Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p2Mklpg9xuUEvuvRrVwsq3k08k2cIDm92OO0i2EBvM=;
        b=24aGcXW2FHhfNAM4W9KsCjmSjk5KcAv1I0D5OBKVoIF9jVjoOrp9ZYAFD/+Y8FCylW
         UCgLNN7sS/tD0x8ImRxYs9jUsGtq8cFEvLp3gpLAkCcnWkrHNwHmDFgOzl7CDgwLoBkT
         zBQSfCu/Cp+s40K3diZ/Pyl0popcfZXguA8aFXNxJioA2KY7uTDla2EaKh9rrPzBqDv8
         mbMTAZjfMcFRnm5/1yKwjcS/39RAN3cO/vhtNjZvYs46SeayWYcCG7DIxxRiqRNsivN2
         vHHeJ7/8HOG7icRFcR6bzjmFsrK6EzlmMqoVDxRzywX7mMiZn2eDl/Clhlo71U/lMzSz
         oK7g==
X-Gm-Message-State: AOAM53304XjqMNw9jEtkKXkZZ2Di84Woxl76yRhBQ3/V8pJ4XDSvcjF/
        806Q4gE5HF1l6QXCsfAQs3zfYPcCusBZleK7tuo=
X-Google-Smtp-Source: ABdhPJwE+WTQ4gQojD6Arndr79ibuELY59aEWoFCPS3plQeHWp5u7mBhhGOI6TATO3h0wG42ROslQF6Nq/5PCXEg+GA=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr4352931ljq.172.1646952886814; Thu, 10
 Mar 2022 14:54:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
In-Reply-To: <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 14:54:35 -0800
Message-ID: <CANQDOddJYNiGY7raZFaMdX-ySSV7xfop9iMXoNG9jKBf5PnqTQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] core.fsync: new option to harden loose references
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 1:53 AM Patrick Steinhardt <ps@pks.im> wrote:
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 973805e8a9..b67d3c340e 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -564,8 +564,10 @@ core.fsync::
>  * `pack-metadata` hardens packfile bitmaps and indexes.
>  * `commit-graph` hardens the commit graph file.
>  * `index` hardens the index when it is modified.
> +* `loose-ref` hardens references modified in the repo in loose-ref form.
>  * `objects` is an aggregate option that is equivalent to
>    `loose-object,pack`.
> +* `refs` is an aggregate option that is equivalent to `loose-ref`.
>  * `derived-metadata` is an aggregate option that is equivalent to
>    `pack-metadata,commit-graph`.
>  * `default` is an aggregate option that is equivalent to
> diff --git a/cache.h b/cache.h
> index 63a95d1977..b56a56f539 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1005,11 +1005,14 @@ enum fsync_component {
>         FSYNC_COMPONENT_PACK_METADATA           = 1 << 2,
>         FSYNC_COMPONENT_COMMIT_GRAPH            = 1 << 3,
>         FSYNC_COMPONENT_INDEX                   = 1 << 4,
> +       FSYNC_COMPONENT_LOOSE_REF               = 1 << 5,
>  };
>
>  #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
>                                   FSYNC_COMPONENT_PACK)
>
> +#define FSYNC_COMPONENTS_REFS (FSYNC_COMPONENT_LOOSE_REF)
> +
>  #define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
>                                            FSYNC_COMPONENT_COMMIT_GRAPH)
>
> @@ -1026,7 +1029,8 @@ enum fsync_component {
>                               FSYNC_COMPONENT_PACK | \
>                               FSYNC_COMPONENT_PACK_METADATA | \
>                               FSYNC_COMPONENT_COMMIT_GRAPH | \
> -                             FSYNC_COMPONENT_INDEX)
> +                             FSYNC_COMPONENT_INDEX | \
> +                             FSYNC_COMPONENT_LOOSE_REF)
>
>  /*
>   * A bitmask indicating which components of the repo should be fsynced.
> diff --git a/config.c b/config.c
> index f03f27c3de..b5d3e6e404 100644
> --- a/config.c
> +++ b/config.c
> @@ -1332,7 +1332,9 @@ static const struct fsync_component_entry {
>         { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
>         { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>         { "index", FSYNC_COMPONENT_INDEX },
> +       { "loose-ref", FSYNC_COMPONENT_LOOSE_REF },
>         { "objects", FSYNC_COMPONENTS_OBJECTS },
> +       { "refs", FSYNC_COMPONENTS_REFS },
>         { "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
>         { "default", FSYNC_COMPONENTS_DEFAULT },
>         { "committed", FSYNC_COMPONENTS_COMMITTED },

In terms of the 'preciousness-levels', refs should be included in
FSYNC_COMPONENTS_COMMITTED,
from which it will also be included in _ADDED.
