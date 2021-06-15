Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7997C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15456109D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFOT1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOT1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:27:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A030C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:25:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w21so52546838edv.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/h5m4bMbAUr4VuIf7zO23Xgi+w2VxBiH9EaZAlu5eAM=;
        b=W92Pv5EsUcXQj5TD2AN6ibmYxA0d8/f2aJRQFzyTm2Wq4fe2JKlFwzHLPHt82eLzO8
         mhMQfi2i9hEJDk6WJQn6z8VMHSOQuuPEoLcQ9bBIQPAzUmtefEC97t8Uoj24Vzo2krtg
         QhYyZYv+ksWMeo01RWt+3IfSVvLBp3wSI1RPO9wz59A9GsSiAMOnqilwdVWTpPBT9N4+
         RBfk5vzwtmTLt3TLZ4WLLA2iBs83UaSBsblsHwC8V+9XDkPcYNFZiXvryD98Uw16r5K1
         SksnyU5LKEXSbe8lp2nQbbcSxFuTwUrPEE5cKHx08K8CeMOJWUyKrDQjlM7tYmB6bCyL
         wYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/h5m4bMbAUr4VuIf7zO23Xgi+w2VxBiH9EaZAlu5eAM=;
        b=QfUV/zJq7XodTQ80P14Or63iLmSaXBf5gTUpQvRLYxjFQghT5OW2dv0ABpnBGiNFfl
         5wW8ncGTQ5fXaOd5iR8s/eaxAZ+6FZOAalnnrZWFYEDgCg53HquiunSK9VdX0dN1IH4a
         QZxXdj1IubQV6X1i5cHTyDAj8yt123HB/6Abghm6ILty36ozDAwmXziBjC+G2/nSgsYy
         gpklvjs9KuLxzaqalfudZp1E4194YCK7LXU7kb8Gz+DxXmj5b19ObGg4nvXLmZZ9hXMm
         HPTp1ny29GQ1i+zjCUdI4aX2WnHOwTQGI3IT3OAsL5X/My79ErzOo99P9doBJ5ro4EM8
         rv+w==
X-Gm-Message-State: AOAM530hRMMt4HEboeP8RyFOx271caatkwQV2yBUDCZQDgUlFGMLYakU
        qyry5oCQth0wwimgoBRsnDgo+Wazmji6nQ==
X-Google-Smtp-Source: ABdhPJzAY0DV9HefM13ddH/IpB1GHwPlyGyp1DllXiHMC74YDwu95ZIc/zyRGjQ6Xs14jWumVW8lcw==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr1497633edy.32.1623785128970;
        Tue, 15 Jun 2021 12:25:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t17sm7653256edv.75.2021.06.15.12.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:25:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] doc: builtin add -i is enabled by feature.experimental
Date:   Tue, 15 Jun 2021 21:24:16 +0200
References: <20210615164522.1079951-1-tmz@pobox.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210615164522.1079951-1-tmz@pobox.com>
Message-ID: <87v96fx74n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Todd Zullinger wrote:

> Note that add.interactive.useBuiltin is enabled by feature.experimental.
> It was added in 2df2d81ddd (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08).
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I was checking my configuration to see if I still needed to have
> add.interactive.useBuiltin set and noticed that it wasn't listed in the
> settings enabled by feature.experimental.
>
> Unless it's time to take this out of the experimental phase, it seems worth
> documenting -- if for no other reason than to keep fetch.negotiationAlgorithm
> from being lonely in the feature.experimental section. ;)
>
> FWIW, I've had this enabled for perhaps a year or so and I don't recall any
> instances where it hasn't worked well.  It has come in handy on some systems
> where I can't easily install Perl but don't want to give up `add -[ip]`.
> Thanks Dscho!
>
>  Documentation/config/add.txt     | 3 ++-
>  Documentation/config/feature.txt | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index c9f748f81c..7d6d325571 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -9,4 +9,5 @@ add.ignore-errors (deprecated)::
>  add.interactive.useBuiltin::
>  	[EXPERIMENTAL] Set to `true` to use the experimental built-in
>  	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	instead of the Perl script version.  If `feature.experimental` is
> +	enabled, this setting is `true`.  By default, it is `false`.
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index cdecd04e5b..caaa97dc61 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -12,6 +12,10 @@ feature.experimental::
>  	setting if you are interested in providing feedback on experimental
>  	features. The new default values are:
>  +
> +* `add.interactive.useBuiltin=true` which enables the built-in implementation
> +of the interactive version of linkgit:git-add[1] instead of the Perl script
> +version.
> ++
>  * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
>  skipping more commits at a time, reducing the number of round trips.
>  
>  feature.manyFiles::
>  	Enable config options that optimize for repos with many files in the

Unless there's specific bugs in it that I'm unaware of, I would think
that we'd be better of just removing the setting and switching 100% to
the built-in. See the history of the other *.useBuiltin settings, where
we migrated on a fairly fast schedule.

I also see that use of stash.useBuiltin is still warning for a few
releases now, that could be removed entirely while we're at it. See
9bcde4d5314 (rebase: remove transitory rebase.useBuiltin setting & env,
2021-03-23).
