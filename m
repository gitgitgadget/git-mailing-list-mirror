Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9CBC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7C321532
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCgp/KKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIHG3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgIHG3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 02:29:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4EC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 23:29:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so20916778ejk.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46xMb+sfSs9PDXTV0KkAB8/nvyBEHILKiC6RjzXLUaY=;
        b=kCgp/KKfoi1Yl9D4npt6loeVAZd1lgvDkTDm/n2y9MDdz2KruF3J7DItA/DKiZ4H+G
         QhZHQ4ZDeeD6c8Dm1ad1jwBM4otP5CIYxkYBiP7vX6RDwXrfhzTybfHQqkCIpge1xNbM
         8IPXSonhwdCR4FlOI1dctciw5KG+lAH5Cmc63/EeDYRyPv+XFUJoDcg5/0lWZlWlle04
         E3w0fAWfDxFCxZQMsqW6/9929UKnKVssprlXOex3CQZposyJqGRnzAwsiMOOQmvc4iK4
         S96lhMKRHpuWmczEdx0pcOtYv6mlCzekjffOSM5RwsIOfsA74Vyj2KkqrjQ413vmwFGE
         c3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46xMb+sfSs9PDXTV0KkAB8/nvyBEHILKiC6RjzXLUaY=;
        b=iAyQfGfdsJLikyhJFaa9hYSeRAH4+uO2UO4pZf03jcvBJjAcv4keEMtJoePlBJHvfA
         AkaZr3Opp+MXE8GBf5JB5ypzHzDGy5Vamyl9TOp/nSd2OMJgNLORlGd/QUsviDPgPZnM
         vD0PSYnIaeUaf1GE0WhqrKwe2D1Yn5PZ6S5BgB55a3m2Ko1zEz7GuWsJPafgR9VEKJq8
         /8zkbplPq089eaWoM7WcgNfLGFkG/Qnhs4pEFa8VtL80pT40RFYEgrgbNB7+sbhi/EGu
         Es1o91NovRxs9KZspiWK1eYLhDi1iBZSHJoOjMXXnDrhhFk8TYIsKQzRQaSePR7cqyeN
         mgsQ==
X-Gm-Message-State: AOAM530JA23wfezdM3zBoEPjDIuzZ3O/5ts88lEb7MTSLYhaXwQSwnnx
        ceREl1ro4DwMiqvcATjNwBg=
X-Google-Smtp-Source: ABdhPJzVak9rimDRicY5ZB2rYxq462x+umyO6KG2WZYks+8AVmo+21QNL/qpKwM4vEbD591Ai+tpoA==
X-Received: by 2002:a17:906:1b15:: with SMTP id o21mr8855928ejg.377.1599546557667;
        Mon, 07 Sep 2020 23:29:17 -0700 (PDT)
Received: from szeder.dev (84-236-109-131.pool.digikabel.hu. [84.236.109.131])
        by smtp.gmail.com with ESMTPSA id a8sm17331032ejx.73.2020.09.07.23.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 23:29:16 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:29:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH 5/7] maintenance: add start/stop subcommands
Message-ID: <20200908062914.GC6209@szeder.dev>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <e02641881d998d1e6a31e941b61eb6f89d0519f7.1599234127.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e02641881d998d1e6a31e941b61eb6f89d0519f7.1599234127.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 04, 2020 at 03:42:04PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Add new subcommands to 'git maintenance' that start or stop background
> maintenance using 'cron', when available. This integration is as simple
> as I could make it, barring some implementation complications.
> 
> The schedule is laid out as follows:
> 
>   0 1-23 * * *   $cmd maintenance run --schedule=hourly
>   0 0    * * 1-6 $cmd maintenance run --schedule=daily
>   0 0    * * 0   $cmd maintenance run --schedule=weekly
> 
> where $cmd is a properly-qualified 'git for-each-repo' execution:
> 
> $cmd=$path/git --exec-path=$path for-each-repo --config=maintenance.repo
> 
> where $path points to the location of the Git executable running 'git
> maintenance start'. This is critical for systems with multiple versions
> of Git. Specifically, macOS has a system version at '/usr/bin/git' while
> the version that users can install resides at '/usr/local/bin/git'
> (symlinked to '/usr/local/libexec/git-core/git'). This will also use
> your locally-built version if you build and run this in your development
> environment without installing first.
> 
> This conditional schedule avoids having cron launch multiple 'git
> for-each-repo' commands in parallel. Such parallel commands would likely
> lead to the 'hourly' and 'daily' tasks competing over the object
> database lock. This could lead to to some tasks never being run! Since
> the --schedule=<frequency> argument will run all tasks with _at least_
> the given frequency, the daily runs will also run the hourly tasks.
> Similarly, the weekly runs will also run the daily and hourly tasks.
> 
> The GIT_TEST_CRONTAB environment variable is not intended for users to
> edit, but instead as a way to mock the 'crontab [-l]' command. This
> variable is set in test-lib.sh to avoid a future test from accidentally
> running anything with the cron integration from modifying the user's
> schedule. We use GIT_TEST_CRONTAB='test-tool crontab <file>' in our
> tests to check how the schedule is modified in 'git maintenance
> (start|stop)' commands.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---


> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 272d1605d2..8803fcf621 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -319,4 +319,32 @@ test_expect_success 'register and unregister' '
>  	test_cmp before actual
>  '
>  
> +test_expect_success 'start from empty cron table' '
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&

This command hangs when run on Travis CI's s390x arch.  Now, Travis
CI's multi-arch support is labelled as an alpha feature and isn't
exactly bug free, so Cc-ing Adrian and Todd, who reported and tested
big-endian issues and fixes in the past, in the hope that they can
confirm.

> +
> +	# start registers the repo
> +	git config --get --global maintenance.repo "$(pwd)" &&
> +
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
> +'
> +
> +test_expect_success 'stop from existing schedule' '
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global maintenance.repo "$(pwd)" &&
> +
> +	# Operation is idempotent
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
> +	test_must_be_empty cron.txt
> +'
> +
> +test_expect_success 'start preserves existing schedule' '
> +	echo "Important information!" >cron.txt &&
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
> +	grep "Important information!" cron.txt
> +'
> +
>  test_done


> diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
> new file mode 100644
> index 0000000000..f5db6319c6
> --- /dev/null
> +++ b/t/helper/test-crontab.c
> @@ -0,0 +1,35 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +
> +/*
> + * Usage: test-tool cron <file> [-l]
> + *
> + * If -l is specified, then write the contents of <file> to stdou.

s/stdou/stdout/

> + * Otherwise, write from stdin into <file>.
> + */
> +int cmd__crontab(int argc, const char **argv)
> +{
> +	char a;

So 'a' is a char...

> +	FILE *from, *to;
> +
> +	if (argc == 3 && !strcmp(argv[2], "-l")) {
> +		from = fopen(argv[1], "r");
> +		if (!from)
> +			return 0;
> +		to = stdout;
> +	} else if (argc == 2) {
> +		from = stdin;
> +		to = fopen(argv[1], "w");
> +	} else
> +		return error("unknown arguments");
> +
> +	while ((a = fgetc(from)) != EOF)

fgetc() returns an int, which is assigned to a char, which is then
compared to whatever EOF might be on the platform.  Apparently this
casting and comparison doesn't work as expected on s390x (I haven't
even tried to think it through...), and instead of detecting EOF and
exiting we end up in an endless loop writing 0xff bytes to 'cron.txt',
while 'git maintenance start' in vain waits for 'test-crontab' to
exit.

Changing the type of 'a' to int fixes this issue, and all these tests
pass.

> +		fputc(a, to);
> +
> +	if (argc == 3)
> +		fclose(from);
> +	else
> +		fclose(to);
> +
> +	return 0;
> +}
