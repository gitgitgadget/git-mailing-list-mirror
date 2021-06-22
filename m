Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319BC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BC561075
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFVQC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVQCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:02:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69EC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:00:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b14so20630027iow.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uxs0KsPfDjzGzxhiUDM+/VRt1wbhg4PXdv7C19ZNbWY=;
        b=oARQcPwGEcwPKH/j3wi9weJyo73SGUj02wsg+J3EO0cyjf3eMk24suW2EaGIO70fBU
         LYvw+DXYkocex/NXZia2E9r/ie0TP9aZAf6ffF23Qvi02bBLzwFbjmLBTxIZTSR8q3gg
         AezlW+XTxXSU7NR04QdqPywgC+nAsB1jX/sfQJcHh9F2Q0Ko81IuN+nHNYf+Rtfa3U1h
         zHbqnY9bDBJXNxtt0dvsYInGzo3qvmvYEUE7sQr0ZNjYAeyYmtl19wxqID0vOVWfW0n+
         98+hWymIofXm/cNhMAueSIUuA9uz0c3wwabXrO4CArUpxDGCX/93uNrdwOM8RdkxqoTB
         MIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uxs0KsPfDjzGzxhiUDM+/VRt1wbhg4PXdv7C19ZNbWY=;
        b=ZrW7p0r9ZEVr3r9SEsHDsa1N/9UliUF3OjxJzzU293IHF1ufK20RCe7wN3JB0UHufP
         ytt/Ao0hZi81czU2uIMur2Noy6KUG2IjQkFHlAA15bOYBbJf1p8s+vRN1GL32eWzfn0W
         dJfZt452nxlb0DSsYPLjagNZ39CBQG/j/r1hP8tgVnAQ8XUCufFjUtuk3NVhn/krgqfa
         uBbbDjlZupvzKOTseegg5x7VykGeMY8pFnoiZzj0znpoi4s04pnEh2B/JIKNyn2Ic9Xc
         no6wq4SbcKMp4HxzA2aXKzCyDQ4XU5Df9/RPvBGt7LaqpSeJAbquDMtcMcLSszjTUCHZ
         jY+w==
X-Gm-Message-State: AOAM5305QO0XeQuyxIwoyW2DmICxLwYg+UDaISyE/LwhHXIUGVmbZH3T
        XhQXVOA2/GSmSjg9Pd4/P2FYTg==
X-Google-Smtp-Source: ABdhPJytq/ocDtQdD3zlNfGO6HnMNSc/ZZAeSyt1ji/IPZD8epqtX4yIolsywVz05KeMXFYhjoAVgA==
X-Received: by 2002:a5e:8349:: with SMTP id y9mr3347929iom.105.1624377608530;
        Tue, 22 Jun 2021 09:00:08 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id n17sm3180256ilt.16.2021.06.22.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:00:08 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:00:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/7] progress: catch nested/overlapping progresses with
 GIT_TEST_CHECK_PROGRESS
Message-ID: <YNIJB8uYp7gzLC6v@nand.local>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210620200303.2328957-3-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 10:02:58PM +0200, SZEDER Gábor wrote:
> Note that this will trigger even in cases where the output is not
> visibly wrong, e.g. consider this simplified sequence of calls:
>
>   progress1 = start_delayed_progress();
>   progress2 = start_delayed_progress();
>   for (i = 0; ...)
>       display_progress(progress2, i + 1);
>   stop_progres(&progress2);
>   for (j = 0; ...)
>       display_progress(progress1, j + 1);
>   stop_progres(&progress1);

s/stop_progres/&s, but no big deal. Everything else here looks good.

> diff --git a/progress.c b/progress.c
> index 255995406f..549e8d1fe7 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -48,6 +48,8 @@ struct progress {
>  static volatile sig_atomic_t progress_update;
>
>  static int test_check_progress;
> +/* Used to catch nested/overlapping progresses with GIT_TEST_CHECK_PROGRESS. */
> +static struct progress *current_progress = NULL;
>
>  /*
>   * These are only intended for testing the progress output, i.e. exclusively
> @@ -258,8 +260,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  	struct progress *progress;
>
>  	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
> +	if (test_check_progress && current_progress)
> +		BUG("progress \"%s\" is still active when starting new progress \"%s\"",
> +		    current_progress->title, title);
>
>  	progress = xmalloc(sizeof(*progress));

Ah. This is why you moved the allocation down further, since we don't
have to free anything up when calling BUG() if it wasn't allocated in
the first place (and we had no such conditional that would cause us to
abort early before).

For what it's worth, I probably would have preferred to see that change
from the previous patch included in this one rather than in the first of
the series, since it's much clearer here than it is in the first patch.

Thanks,
Taylor
