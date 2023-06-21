Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE72EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjFUKvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjFUKup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:50:45 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581519A6
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:49:53 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5701eaf0d04so59591717b3.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687344592; x=1689936592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHZlHs0AMcY4yla8IM8jbzVEYMD/vPWTyChGvgG/6Iw=;
        b=48JyD5G9Rhdy6oFR9trXqSJ/dNPRb2vPhFXuwwe+s+B3Ashw7YGkalsVTdAsPn6l5b
         /6MUk0mZCHvbyHWi7wxzqgEEYLeBuIsBkCp9W0wHtioGPySzeB0sASNSJaQswvsPevAi
         DVHLSjoZ8PcxJn2RsrRPygeDsdz/iKw2tmf8AscHX1zfuakMlT7BUoEU1ENFFcTr0D+/
         geIBUS376drnfYEHUUd/G0434PFDemKsUPLkGFkYH3jgBjaxZW6/sodSLorQDyTXuwYw
         ayDQ/+4rkxyJm2DDJh5Cjt9BDuAZVUXNYGHxabwa6tdyhyVWQuy4y3IsJIlfbyV2dxVN
         Mb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344592; x=1689936592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHZlHs0AMcY4yla8IM8jbzVEYMD/vPWTyChGvgG/6Iw=;
        b=S3MY6EBzNWv4NPtEuP/QabrwvkWIwBnhjPnapTUmI7+X/G9RJXOxOY2TVivmzhqUyf
         J0awB/5MXMCgVGvHOjQlXGPexwt88mryB1ekPNenHYlAQedUY7VxbUsHZsu6hLwL2DjB
         zohLA/YuHr86uQ4RSxTAhME6uMFLvQBAUYM85E3eGUDQjZIY0gZSmgzDoNc3FQGjGdLW
         ByknOl1qlK9hGqKYEUjqTYXrLyY55GCEVA4FIc+62++ygDMT77IghexD9i/l0gbot7R2
         DujvlaXOKcBPyMwA2fYH5zftJDHiouF+7pNEY0MAP8Q0dfXOYvmLVyJTsR/Udanr2OTO
         boCA==
X-Gm-Message-State: AC+VfDzGQQT6jDRy7fUY017fTZy4SWLRL8GxYLHAQ4PNBjh6ClMB97IH
        PL+3TFWEeL0guSDju2U1xEEMKA==
X-Google-Smtp-Source: ACHHUZ5yXREwxTeHklS3IquL64o71y7/I1oyDAh8bnTYNQg9/vMh2fP0BGEKyH+81ZpFV8e7xaJ0qw==
X-Received: by 2002:a25:d841:0:b0:bb1:58f9:b794 with SMTP id p62-20020a25d841000000b00bb158f9b794mr12110200ybg.12.1687344592330;
        Wed, 21 Jun 2023 03:49:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c11-20020a25a2cb000000b00bad59725e11sm835064ybn.57.2023.06.21.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:49:51 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:49:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9] pack-objects: allow `--filter` without `--stdout`
Message-ID: <ZJLVzaQKBrgCARAG@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-2-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614192541.1599256-2-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 09:25:33PM +0200, Christian Couder wrote:
> 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
> taught `git pack-objects` to use `--filter`, but required the use of
> `--stdout` since a partial clone mechanism was not yet in place to
> handle missing objects. Since then, changes like 9e27beaa23
> (promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
> and others added support to dynamically fetch objects that were missing.
>
> Even without a promisor remote, filtering out objects can also be useful
> if we can put the filtered out objects in a separate pack, and in this
> case it also makes sense for pack-objects to write the packfile directly
> to an actual file rather than on stdout.
>
> Remove the `--stdout` requirement when using `--filter`, so that in a
> follow-up commit, repack can pass `--filter` to pack-objects to omit
> certain objects from the resulting packfile.

Makes sense.

Is there any situation in which using --stdout with --filter would be a
potential foot-gun? I am not as familiar with the partial clone
mechanism as others CC'd, so I have no idea one way or the other.

If it is unsafe in certain situations (or, at the very least, could
produce surprising behavior), it may be worthwhile to only allow
`--filter=<filter> --stdout` with some kind of
`--filter-to-stdout-is-ok` flag to indicate that the caller knows what
they are doing.

Presumably 'git repack --filter' would pass such a flag later on in the
series.

> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-pack-objects.txt | 4 ++--
>  builtin/pack-objects.c             | 8 ++------
>  2 files changed, 4 insertions(+), 8 deletions(-)

Should there be a trivial test here? I'm thinking something on the order
of writing a filtered pack to stdout and redirecting it to a file,
moving it into place, and then indexing the pack to make sure that we
got the expected set of objects.

Thanks,
Taylor
