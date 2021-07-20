Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C00C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF09610A0
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhGTRix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhGTRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:37:10 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452FC061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:17:46 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w1so84387ilg.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+IpSqXuavVNDVb0HsUQshGjBTWpZOv6MOH5Lh7WcLDs=;
        b=SQa961zmaaHDaWTN4pLZENEXmUZPyv6RBMnXk1trZtKpK3QaEXAUgdVsIfx7XHGxHw
         lssiALC0VFL2/k2iER51GIZEr/5moQuJFFo1jjxmu55hBV7BFC9iIWAwMedwKFOxtsJK
         5mZ9Ft+/W9EjYwMFTPrUf+YDWRBQhIJPPCXBb0j1kTtwMEQvsQzRxzHauss6K5Xnwwqh
         P/5TcU//YGynMWrO+Guf9IzA1UjWWyG5kcYd9qhkIzkCdALztUXV0464vRmu9YCapJdr
         uQl6opK5uSCwsU0XBiqe/T1GNiiqCzPJTva1iD6l4zjRBzPSc6ja17FVGtgGacoTRCCk
         pI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+IpSqXuavVNDVb0HsUQshGjBTWpZOv6MOH5Lh7WcLDs=;
        b=r/Ygk5hwtS8QGD2WLicuWPAbAk9HmFEPCHiUOAHZbZsBJR0XRxPZPmxATXdUWvYoyH
         4N0LQSkaQIimffNGJfk4ZdMUYv8eU4SeYIXNe2MyZJql4+eHxytmjZKIWlv1Ho0r1eiS
         w6AScETtzvtJOV2v9HPCj1dVMlrSabGZMLyx9YAp1iXkmbiXV16FBi5JvKTsyYkcj4N1
         //OrE0BECBQ9d82d6iwlxNCPv3G1c2ZCCClnNq/9KVSSVUpvvszJ3DFrqfhrJu4OJOMz
         jVHbPDcoDCV6FsPvT63jj6Zq3gEIlSgKyOQQ1Au2z2kuZOBEDKBWAZ84F3GqUv2NFAMK
         yOrw==
X-Gm-Message-State: AOAM531tirTZTFuV0lEojxsKfza6wTqK/Ysma9R7xZ9o9GxQcstEuD9J
        q7sxQj5sDh75o0lX+74o6/c5Ng==
X-Google-Smtp-Source: ABdhPJx3f0tAiOQfPBEQKlaJFy79ch/aLDow5mR5GhVwqEi+6DPAgH5DjiQClHWYR01a5DEAy9b0Rw==
X-Received: by 2002:a92:dcc5:: with SMTP id b5mr21824064ilr.234.1626805066239;
        Tue, 20 Jul 2021 11:17:46 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id l5sm12734584ion.44.2021.07.20.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 11:17:45 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:17:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 5/6] commit-graph: early exit to "usage" on !argc
Message-ID: <YPcTSSUtEuG41knv@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-5.6-7acb4bd75ce-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-7acb4bd75ce-20210720T113707Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:39:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Rather than guarding all of the !argc with an additional "if" arm
> let's do an early goto to "usage". This also makes it clear that
> "save_commit_buffer" is not needed in this case.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 6e49184439f..bf34aa43f22 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -331,16 +331,17 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			     builtin_commit_graph_options,
>  			     builtin_commit_graph_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (!argc)
> +		goto usage;
>
>  	save_commit_buffer = 0;
>
> -	if (argc > 0) {
> -		if (!strcmp(argv[0], "verify"))
> -			return graph_verify(argc, argv);
> -		if (!strcmp(argv[0], "write"))
> -			return graph_write(argc, argv);
> -	}
> +	if (!strcmp(argv[0], "verify"))
> +		return graph_verify(argc, argv);
> +	else if (argc && !strcmp(argv[0], "write"))
> +		return graph_write(argc, argv);

Nice, what you wrote here is definitely an improvement in readability.
This could potentially also have an else like I suggested in the
multi-pack-index patch earlier (later?) in the thread. Maybe something
like:

      else if (strcmp(argv[0], "..."))
        return graph_xyz(...);
      else
        error(_("unrecognized subcommand: %s"), argv[0]);
    usage:
        usage_with_options(...);

Arguably that could be done in this patch, separately, or not at all
;).

Thanks,
Taylor
