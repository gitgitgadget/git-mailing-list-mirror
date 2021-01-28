Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735DC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B83464DEF
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhA1WhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 17:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1WhG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 17:37:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E6C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:36:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d22so8479054edy.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8KVzDFDXkT6ntqDnQu4kIjzLsA/NekXXCS5BCLr/Mek=;
        b=BoKozuPlEapT6c7E8sl4CS+rGJwSDIqwtZoxJrmi2oIyUZBDXcNWGvUVXkztnirvJq
         wpjxLQXztxzwSYIbeKegikSkAd1bru4EjqeOblzVFot20wsYqKnZzq6mNXOV3ugLcHNf
         5Hko9aTJpNx6y8n5uYvVcG/EASDAG+Q5VlmnQ1sHm0hGTj8BIgpDG0nET0YgugSRL2Zu
         OuelE+9MZ15nNluRhGFI/+8GmvQ8Mofdqh3PQ83rT/GDG0b3KlpriRIaXF31usb06Yuc
         ukFmLIJuNkbcQ5B5zRZ7yUUKEXyvWlAzpjMruuJ8s3MPTr4pMoUK+E8/3dm3IFViS1kk
         Or6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8KVzDFDXkT6ntqDnQu4kIjzLsA/NekXXCS5BCLr/Mek=;
        b=gNpzG6PZiIoJRMe+tQasEEFabZj+vR/9zgGsBg8ENZHVR7WUO3Fw/O1teTCFSbAT27
         KKhVD18hWSbOBv5SWzGQBFaQmCmS/041aeKblTVAjgiTsBVBUM3hW1F0OFxDLAf4YR7b
         2mgu4Zez5GbIVPAWAmEHbg6gY7DW4HdAZWngB7FZ4UoPgvRHCq2x1LArFs5Ul+cBptUc
         vRHAUVLaFNqcsxKIwNrXib+rfwVAl84VINavsJ7FZTC3J7GrfGWA3LRQu3TAtCZQmWYg
         6292uMQWq1KFUsQqK6t1MfW3LWrZXVbUT7WySnSAO6K2osiqG2CiqIMdfln9dis8hKK6
         Gkuw==
X-Gm-Message-State: AOAM532EJyrKS4HlCVcCz0i8lWpT+ef9XlKZAEoBGBEhvOf+V6tHcqyS
        ZFm42nQT1oKnAAwew11dnx0=
X-Google-Smtp-Source: ABdhPJy+ZUgG/aloRzTI5tl1FMnKGEPRIx93nAzgxm6Z45EXIisk+rsQq0S8rR9MBjjo1J7Vg52j0g==
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr2055025edw.88.1611873384805;
        Thu, 28 Jan 2021 14:36:24 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q26sm2889866ejr.97.2021.01.28.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:36:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] pretty: lazy-load commit data when expanding user-format
References: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
Date:   Thu, 28 Jan 2021 23:36:23 +0100
Message-ID: <87eei4pu3c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 28 2021, Jeff King wrote:

>   # using git.git as the test repo
>   Test                          HEAD^             HEAD
>   ----------------------------------------------------------------------
>   4205.1: log with %H           0.40(0.39+0.01)   0.03(0.02+0.01) -92.5%
>   4205.2: log with %h           0.45(0.44+0.01)   0.09(0.09+0.00) -80.0%
>   4205.3: log with %T           0.40(0.39+0.00)   0.04(0.04+0.00) -90.0%
>   4205.4: log with %t           0.46(0.46+0.00)   0.09(0.08+0.01) -80.4%
>   4205.5: log with %P           0.39(0.39+0.00)   0.03(0.03+0.00) -92.3%
>   4205.6: log with %p           0.46(0.46+0.00)   0.10(0.09+0.00) -78.3%
>   4205.7: log with %h-%h-%h     0.52(0.51+0.01)   0.15(0.14+0.00) -71.2%
>   4205.8: log with %an-%ae-%s   0.42(0.41+0.00)   0.42(0.41+0.01) +0.0%

Looks nice!

> diff --git a/t/perf/p4205-log-pretty-formats.sh b/t/perf/p4205-log-pretty-formats.sh
> index 7c26f4f337..609fecd65d 100755
> --- a/t/perf/p4205-log-pretty-formats.sh
> +++ b/t/perf/p4205-log-pretty-formats.sh
> @@ -6,7 +6,7 @@ test_description='Tests the performance of various pretty format placeholders'
>  
>  test_perf_default_repo
>  
> -for format in %H %h %T %t %P %p %h-%h-%h
> +for format in %H %h %T %t %P %p %h-%h-%h %an-%ae-%s
>  do
>  	test_perf "log with $format" "
>  		git log --format=\"$format\" >/dev/null


While we're at it it would be nice to have a few more formats that have
to do with the body in some way in those tests, and stess things like
mailmap/trailers etc.

    %s
    %b
    %B
    %N
    %aN-%aE
    %cn-%ce
    %cN-%cE
    %d
    %D
    %(trailers)

Just paging over the git-log manpage, that seems to stress most of the
codepaths, i.e. subject/body, but also things like notes, .mailmap, ref
names, and body parsing (trailers).
