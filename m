Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C71C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C4A222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZzR5m/TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgJTCjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbgJTCjC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:39:02 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB73C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:39:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p16so426064ilq.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7NbOZA3ZtHLIqycaZcCI70EsJpoST9B7j8lU31m591Q=;
        b=ZzR5m/TNzmOF5ru6Ce8xjN2MI7NzxYNnrkGbKJKYRLeNmALtjgBgkUp4pn4vPdDAX7
         aEx8viUk5DP02oNk+L4neNw+iDc0vBm9Cu48erFpwhvRjKNCZ2TK1TLBOPjjncWSsO8d
         2xcshxDCYNIOpX+FLtXtFdYYNBj+qRL+mzC+P9ZmcvSakQQe9JLdtNMiKF2JbNM5fJOY
         00emNuH1S66KJhr2Wjlf+Ei+qvtryuAWFnaaQMDSeBlP7eABIIFL3JmmXtP5IgRnAzqG
         PDUClk04oOSsti8rXDRwO7xfucZ0+A3EjiXOBGsoV3mgJYsAuZ4g2UNYcEo2wX2ng2CU
         ySXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7NbOZA3ZtHLIqycaZcCI70EsJpoST9B7j8lU31m591Q=;
        b=dSGyTEJcx2/chimuE018bM3FecmueINuF9HxW9DRcFI+Yl9FVv3ii+HZCo/fY3WPoC
         0NgYtoKA54/ieUwpOBBNPbWVsE2Vp1QjR2uFxjv/F0JNRJ0JfXjeQOuC0c7zRVfcEN2v
         x5AlOEV3wOYZ56zXD4a7cgISYq2U32GiuVtF8Oi5SoxYWAqstQraMp8dplpiCOHnvSeE
         B8RLiaQJ+u3c4qvatMMVJoDjJtxv+X8pgQ4NX3kzow4UCus8KLgRd81P7aetGvOdMfcp
         T1PiiQE8qka08llULX1vHC33/ty4ovDaVZlHNf48lZPQVdjAbvL+iaO0Hziw3RnkiM9O
         X74A==
X-Gm-Message-State: AOAM531dBKZjUiCPYuWGDmMim+NYyFtKaoFV+a9BXdarmoQj480PnPSO
        nE4Aoa7U7iIKU6JXuzE1D38lNQ==
X-Google-Smtp-Source: ABdhPJxouJpb/HbuWPR88hLRfx5GQYW8h3+5BuhBbhMA6ZxENFRVyAOJxPQwt/aAEg106hWsGItcvw==
X-Received: by 2002:a92:9e8b:: with SMTP id s11mr337492ilk.61.1603161540180;
        Mon, 19 Oct 2020 19:39:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id d26sm509430ill.83.2020.10.19.19.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:38:59 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:38:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf
 tests
Message-ID: <20201020023857.GC54484@nand.local>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 10:47:35PM +0000, Nipunn Koorapati via GitGitGadget wrote:
>  test-lint-shell-syntax:
> -	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
> +	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)

I really appreciate your initiative to modify t/Makefile to start
linting t/perf/p????-*.sh files, too. Could I bother you to elaborate a
little bit on why you chose to modify a recipe in t/Makefile instead of
t/perf/Makefile?

I'm not necessarily opposed, but having this in t/perf/Makefile would
allow me to just run 'make' in 't/perf' and still have the scripts
linted there without having to involve a 'make' in 't'.

For what it's worth, I suspect that this is because 't/Makefile' already
has a 'test-lint-shell-syntax' target, and 't/perf/Makefile' does not. I
think it would be OK to add it there, too, and move this change into
t/perf.

> diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
> index d202aaed06..7a0bb29448 100755
> --- a/t/perf/p3400-rebase.sh
> +++ b/t/perf/p3400-rebase.sh
> @@ -9,16 +9,16 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
>  	git checkout -f -B base &&
>  	git checkout -B to-rebase &&
>  	git checkout -B upstream &&
> -	for i in $(seq 100)
> +	for i in $(test_seq 100)
>  	do
>  		# simulate huge diffs
>  		echo change$i >unrelated-file$i &&
> -		seq 1000 >>unrelated-file$i &&
> +		test_seq 1000 >>unrelated-file$i &&
>  		git add unrelated-file$i &&
>  		test_tick &&
>  		git commit -m commit$i unrelated-file$i &&
>  		echo change$i >unrelated-file$i &&
> -		seq 1000 | tac >>unrelated-file$i &&
> +		test_seq 1000 | tac >>unrelated-file$i &&

Makes sense. I wouldn't be opposed to breaking this out into an earlier
change (e.g., "it's about to become not OK to use seq in t/perf, so
prepare for that by replacing any invocations with test_seq()"), but I
think it's probably not worth it, since this patch is small as it is.

Thanks,
Taylor
