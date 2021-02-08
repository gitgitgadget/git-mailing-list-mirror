Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60673C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7D64E7A
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBHWyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBHWy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:54:26 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E56C06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 14:53:46 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d85so16252470qkg.5
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjEzEfDvwVp9pjTmSLhNLEsijKE4y+VdLuVhUEBauOk=;
        b=Hjuzs4AXoxHotT7OOI7pm4Iyrs2+wUaHQk0QuV1WwxvtT4RiPQCu8NCStwd0poXhEb
         xK0xBi3k2f3BXQimjMmViYcTxcwGVQdXPwpAwQsCU+nrJugp16i47LeaJ3isqq0BGaFr
         0oAdOZy8FEKsiF70H1u6MPbKXVCFoThV81X3bUAVdT9O8ZZBdXHD5Lw8RICnwhfF+xic
         +Id3pdPQroK3QIaZF+ITzRPRsMDPNdM9kjww5evyOQiwJXq+tHsEtwwxJQgfhKDCWfQB
         deE26N3PTBeb+XInhQEfCaWJLjY3BeqdnDWdlymIEXtT0LtxRoX3tTqQzzcsDDNxLMY5
         6MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjEzEfDvwVp9pjTmSLhNLEsijKE4y+VdLuVhUEBauOk=;
        b=Z//mTNClUBu6PibypZQZAL0URUq1cTUyoaGNXaAsHqABqdhvtqQIADB4e+SxipHLwv
         7U0rOt9BMudemck41BcTm56XIU8euJVCd/4SvLeOTHgBYcTLke0e7RcHfhqnEMNnMfIf
         eNlFBMOBv/odUmN4AHm+IdOkN2bhzacQujt45l+kFD17xDqK71e0ULiiVK4wvvSiquw8
         j9HAB+1jBsDeGbEpBNdI2322TU+iJ3HgJVz7DEv1wQtj7ZpY209Fumoqf150jerbUSCG
         FoRE6jwWUsfhUz200lNART6iEjhFwoB4FnpWmfTzyTeBGOXjt7Wk+/ky4HPxGTNzNdVL
         DctA==
X-Gm-Message-State: AOAM5324FwO4C6VFuDakk8PWAWw+bzeDAYZXM2dZujHyNPdv1hpzVsee
        kTY+L+EYcTxUusjYsLFY6EoH5PNNll0EEg==
X-Google-Smtp-Source: ABdhPJw5CG6hj1JSjHZjI3fV5rrSQ8IPIsQFb1ZlbEt+Z69aFOPoaokI6SYSIpIl3M0Rz7T8YZssyQ==
X-Received: by 2002:a37:6356:: with SMTP id x83mr10755581qkb.434.1612824825592;
        Mon, 08 Feb 2021 14:53:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:65b:f1e7:ac0e:a3a2])
        by smtp.gmail.com with ESMTPSA id c7sm15189887qtc.82.2021.02.08.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:53:45 -0800 (PST)
Date:   Mon, 8 Feb 2021 17:53:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sluongng@gmail.com,
        martin.agren@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] maintenance: add pack-refs task
Message-ID: <YCHA991dv0V0hNb+@nand.local>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
 <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 08, 2021 at 02:52:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> +pack-refs::
> +	The `pack-refs` task collects the loose reference files and
> +	collects them into a single file. This speeds up operations that
> +	need to iterate across many refereences. See linkgit:git-pack-refs[1]
> +	for more information.
> +

Do you think it's worth documenting here or in git-gc(1) that running
this has the effect of disabling the same step during gc?

>  OPTIONS
>  -------
>  --auto::
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4c40594d660e..8f13c3bb8607 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -54,7 +54,6 @@ static const char *prune_worktrees_expire = "3.months.ago";
>  static unsigned long big_pack_threshold;
>  static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
>
> -static struct strvec pack_refs_cmd = STRVEC_INIT;
>  static struct strvec reflog = STRVEC_INIT;
>  static struct strvec repack = STRVEC_INIT;
>  static struct strvec prune = STRVEC_INIT;
> @@ -163,6 +162,15 @@ static void gc_config(void)
>  	git_config(git_default_config, NULL);
>  }
>
> +struct maintenance_run_opts;
> +static int maintenance_task_pack_refs(struct maintenance_run_opts *opts)

It may be worth calling this "unused", since you explicitly pass NULL
below.

> +{
> +	struct strvec pack_refs_cmd = STRVEC_INIT;
> +	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
> +
> +	return run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
> +}
> +
>  static int too_many_loose_objects(void)
>  {
>  	/*
> @@ -518,8 +526,8 @@ static void gc_before_repack(void)
>  	if (done++)
>  		return;
>
> -	if (pack_refs && run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD))
> -		die(FAILED_RUN, pack_refs_cmd.v[0]);
> +	if (pack_refs && maintenance_task_pack_refs(NULL))
> +		die(FAILED_RUN, "pack-refs");

Hmm. Am I missing where opting into the maintenance step disables this
in gc? You suggest that it does in the commit message, but I can't seem
to see it here.

> +test_expect_success 'pack-refs task' '
> +	for n in $(test_seq 1 5)
> +	do
> +		git branch -f to-pack/$n HEAD || return 1
> +	done &&
> +	git maintenance run --task=pack-refs &&
> +	ls .git/refs/heads/ >after &&
> +	test_must_be_empty after

Worth testing that $GIT_DIR/packed-refs exists, too?

Thanks,
Taylor
