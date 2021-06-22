Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F19C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F75760241
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhFVP5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhFVP5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:57:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD6C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:55:23 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id x12so18881165ill.4
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7dYBha2S068tZB5Wq2LyLe4BBdB0UaVDydcFtk3I//g=;
        b=oYo3AmJRD0+otMbz2QFABXtb13NyQTEiICpEiXeA6JMkHm3CsdbljKHdUdDTmv74FX
         DTMddmlCs+tLbIaAXzxprFJX4F+OLPHNfKM0Gg/iBu52kfufxVO3/8Pji2v4xYPqNMBT
         u797lzwAWvbN3uY0M3v70K0jc+axsY74vy2T997r3J9jdpRPDdJ8Q0ugdGFMxf+QGkc2
         /FXYLUjmdu/cR03Kza6MdajCYYZkct5GifMwB7YyMo3e4ZfhLrm3OD+uPvHvOVHgAlZU
         dLOKgHVPVgZ8Cuxc9Fis7XeBdp91r3GYJfCyZpJVH6S13CHSyBEY+Ze7xYcnUahJZ+AH
         ILqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7dYBha2S068tZB5Wq2LyLe4BBdB0UaVDydcFtk3I//g=;
        b=oGd8ZI89cP2WLkggDMhZwzfScwZSTp3qi1/trC6aGDfz3jG/y6TpsTTmMzpj87nNeo
         T9hgueexDx49vURgfxlB+L5r7MvhyCVsNrkEqDuiZDjppAiOx5mQgcBapectgJrD61Iz
         y35qapDlwDkEiDoDaT08AA1yrxL4Ca/hIiV3LDqaH8jeIPGLO9kNpE2t/1M7w3dwnD2G
         rdgchxT14EtWsKQPFoPm97MDGZvw4joH/ddw9M7+sZshzHGOCG87IyTQoYAIz/gpZ+dd
         xcyIJLJ6Vxm3bmsa4URg3KCOepvjBmR4FUl0SQcQAGTkulOnR6pKA5YtPisgkxQIJ8jq
         ORIQ==
X-Gm-Message-State: AOAM533E4qYIbTNg9svvMZbXVHmSNCFLjpBXYXy4IV/+ho8DI2iQ9lNj
        3O6fYMGPd1+QSuBaqwhM/wvOmw==
X-Google-Smtp-Source: ABdhPJy930y4hBxk78ZRZ41nCf/yYDS3CYfXpVOY0cqgTYR6F3dLQe2gAj4FV2kEb4CKLHmbX8e2nw==
X-Received: by 2002:a05:6e02:1ca8:: with SMTP id x8mr3117183ill.163.1624377322857;
        Tue, 22 Jun 2021 08:55:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id h200sm11785137iof.6.2021.06.22.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:55:22 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:55:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/7] progress: introduce GIT_TEST_CHECK_PROGRESS to
 verify progress counters
Message-ID: <YNIH6FD9NKLc9zYl@nand.local>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210620200303.2328957-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 10:02:57PM +0200, SZEDER Gábor wrote:
> +	progress->last_value = n;
> +
>  	if (progress->delay && (!progress_update || --progress->delay))
>  		return;
>
> -	progress->last_value = n;

Makes sense, and thanks for explaining it explicitly in the patch
message.

>  	tp = (progress->throughput) ? progress->throughput->display.buf : "";
>  	if (progress->total) {
>  		unsigned percent = n * 100 / progress->total;
> @@ -252,7 +255,11 @@ void display_progress(struct progress *progress, uint64_t n)
>  static struct progress *start_progress_delay(const char *title, uint64_t total,
>  					     unsigned delay, unsigned sparse)
>  {
> -	struct progress *progress = xmalloc(sizeof(*progress));
> +	struct progress *progress;
> +
> +	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
> +
> +	progress = xmalloc(sizeof(*progress));

Ævar noted below, I think, but this cleanup to move the xmalloc() call
to after reading $GIT_TEST_CHECK_PROGRESS is unnecessary.

> +test_expect_success 'GIT_TEST_CHECK_PROGRESS catches non-matching total' '
> +	cat >in <<-\EOF &&
> +	progress 1
> +	progress 2
> +	progress 4
> +	EOF
> +
> +	test_must_fail env GIT_TEST_CHECK_PROGRESS=1 \
> +		test-tool progress --total=3 "Not enough" <in 2>stderr &&
> +	grep "BUG:.*total progress does not match" stderr &&
> +
> +	test_must_fail env GIT_TEST_CHECK_PROGRESS=1 \
> +		test-tool progress --total=5 "Too much" <in 2>stderr &&
> +	grep "BUG:.*total progress does not match" stderr
> +'

This and the below test are both good to see. I wondered briefly whether
or not it would be worth adding a test to check that the "progress does
not match" triggers even when we have a non-zero delay, like:

    test_must_fail env GIT_PROGRESS_DELAY=100 GIT_TEST_CHECK_PROGRESS=1 \
      test-tool progress --total=5 "Too much" <in 2>stderr &&
    grep "BUG:.*total progress does not match" stderr

But it's not helpful, because GIT_PROGRESS_DELAY is already 2 by
default, and we unset GIT_* environment variables (including
GIT_PROGRESS_DELAY) except a few which are left alone.

So we are already testing this case implicitly. It may be worth making
it explicit, and/or testing the case where GIT_PROGRESS_DELAY=0, but I
do not feel strongly about it. Besides, I would much rather err on the
side of testing cases we feel are legitimately interesting, rather than
filling in a grid of all possible combinations, including uninteresting
ones.

Thanks,
Taylor
