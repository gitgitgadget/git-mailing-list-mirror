Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC45C47078
	for <git@archiver.kernel.org>; Fri, 21 May 2021 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56204613E6
	for <git@archiver.kernel.org>; Fri, 21 May 2021 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhEUPEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhEUPEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 11:04:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F4EC06138C
        for <git@vger.kernel.org>; Fri, 21 May 2021 08:03:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so7575884wmf.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y/txWD3HOQwFvWfG1dRaO6VkHYcXLVcnvQUrictWTBk=;
        b=XXho7wx385K9Vu++PAEK2F8tlXIoXJN8bMjmvm1F69TJJNSlB1mZti9nn1HNg2Ffkz
         UByqcXIiE1Hq5LCrpgYCkt16x9MndqyRifyam5Jqh2ot5QOiMJeIMIV+WWnCb8Ba2nw8
         k6zINdKMXapNPKDO3/bwND+Z6cKdESNHo4QgfLToEnXZk9QzULAwQ/qm8cfnh3IFA8Z8
         M8wTofOrRDpCmy3EaHIK276EzdvxyH4b1GHPnZDRssk02XFyDSIsvnExpPxrJGNP4vwk
         KvpR6KImsViYcqP59kbmm1UwSazDM5wSHZlVuD7OnOLBnwCNjtCnERbPPODt+iXJ3OZW
         UkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y/txWD3HOQwFvWfG1dRaO6VkHYcXLVcnvQUrictWTBk=;
        b=eCHFn3qdED7ceRbTj/3vVdVKYBsyuolA+meiHo9eBkbXxQ3ErdeKpflxKYExUclm5G
         fAHGNfDSAGooxRbw4yOSXYnGxH1W8fvjPO5JpgWQOlLq5BEtisBP65uOFNmqoZiRYHXn
         kY/kwweWqPZN6LToMczoWLVja3nGzMbZHogWQtTEr2CwmKNGwZW7wZ/idsoGkgnvtgNa
         LPOb9cFiJFlE+HZyZA3RGbklREeAycKNBDpoYSqOe2Hf7PntrH01XQA7NhYPkVLRRiMG
         i0CtzLLWC2rRKUudPlnFA9smRDVuhkhCr8UadtGUmfZV8jRL8ifK9jQnkH1Rf9HZR4hx
         /1+A==
X-Gm-Message-State: AOAM533heLMRP0yw8b/KyvUi8L+kcjGUqmNAkfb2O3Xeb3Bn65BQZYMh
        iWfJ+RYIRBTxwXgEwLm1kDE=
X-Google-Smtp-Source: ABdhPJzsRnvAEpsmvKBygDrKT5Xy5fN+qJm2NNYyLhbugd3vjrVpNmo7MoTeyu50DqsVn96eHNaH7A==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr9368216wmb.51.1621609391801;
        Fri, 21 May 2021 08:03:11 -0700 (PDT)
Received: from szeder.dev (78-131-14-196.pool.digikabel.hu. [78.131.14.196])
        by smtp.gmail.com with ESMTPSA id i11sm2446320wrq.26.2021.05.21.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:03:11 -0700 (PDT)
Date:   Fri, 21 May 2021 17:03:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] p5400: add perf tests for git-receive-pack(1)
Message-ID: <20210521150308.GI2947267@szeder.dev>
References: <cover.1621451532.git.ps@pks.im>
 <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 09:13:27PM +0200, Patrick Steinhardt wrote:
> We'll the connectivity check logic for git-receive-pack(1) in the
> following commits to make it perform better. As a preparatory step, add
> some benchmarks such that we can measure these changes.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/perf/p5400-receive-pack.sh | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100755 t/perf/p5400-receive-pack.sh
> 
> diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
> new file mode 100755
> index 0000000000..2b0c89d977
> --- /dev/null
> +++ b/t/perf/p5400-receive-pack.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of receive-pack"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +
> +test_expect_success 'setup' '
> +	# Create a main branch such that we do not have to rely on any specific
> +	# branch to exist in the perf repository.
> +	git switch --force-create main &&
> +
> +	TARGET_REPO_CLONE=$(pwd)/target-clone.git &&
> +	git clone --bare --dissociate --branch main "$(pwd)" "$TARGET_REPO_CLONE" &&
> +	TARGET_REPO_REFS=$(pwd)/target-refs.git &&
> +	git clone --bare --dissociate --branch main "$(pwd)" "$TARGET_REPO_REFS" &&
> +	TARGET_REPO_EMPTY=$(pwd)/target-empty.git &&
> +	git init --bare "$TARGET_REPO_EMPTY" &&
> +
> +	# Set up a pre-receive hook such that no refs will ever be changed.
> +	# This easily allows multiple perf runs, but still exercises
> +	# server-side reference negotiation and checking for consistency.
> +	mkdir hooks &&
> +	write_script hooks/pre-receive <<-EOF &&
> +		#!/bin/sh

Nit: the 'write_script' helper writes a shebang line, so this is
unnecessary.

> +		echo "failed in pre-receive hook"
> +		exit 1
> +	EOF
