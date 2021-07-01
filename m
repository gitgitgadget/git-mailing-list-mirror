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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D48C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289336140E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhGAXNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhGAXND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:13:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131BC061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:10:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nd37so13145883ejc.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dHQfyIvzhDLtjKlmNmykHXJG1+YtE3dM6qXRtcJ3TqA=;
        b=KZO7DxJEXZHljT1L2ZY2F5PvQZ7+sjrZ46WGwfLJN8osS7r00vTBbVz4hSSCOvxi0F
         OvkBk7NvD37G7FnHD1AzxOu/nyfX7r/SAKjronDowU/zsHvxD0qDJ+6Utc90u35cGGtz
         B6xuHbTLCS9uBq0yjSp3wMqS+N3thCjOJ/diTR37yc8Gzp6825BjUqoH3mZgm7X8UILV
         GJOhe59GPcQs7Y4jTCMxnDFkLkNpthKRhbNkFNt9S6pmLDcP6Qp5PmDpNVEzoPvGWlge
         H4ZZacxD/Km+lsLzz91l9wi4tR721ad7PbNFjcDLoA7FSfHXEiIVD/5SqQH7RficMDv5
         8RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dHQfyIvzhDLtjKlmNmykHXJG1+YtE3dM6qXRtcJ3TqA=;
        b=ALfm8fGD9G5qjR2DHvIYgbhvUcPPH4R3QJwZVN/h68/0pX1QwCOw5S7LUk/KW3dp1G
         1jMaGhIgmrYGr5YNnkKI36A8dM2Y8y837LOeGJU5PnhozfoZNUXgcA1CuC8DIrcfASep
         ZP+IIfXVrPDfIZBxZPLGvxgbD//L6qd3lSN017Bbup2bBvTaPDexeG27XcW5qpaDnjFX
         N92QzKKzpKzTaig23UwO8UJ0f4iitibft3erAhdiXx0uNq2u5aYx6ypvjDsTynP/ghvJ
         fZwviubngujg7uHcyJqKkFZmcFKvKboFkznXI3CeZSLUXRvZwYw4nErG4MH8qWdIheF7
         bbHw==
X-Gm-Message-State: AOAM531HdwBjP4yM9watfZUUuzhVJbKOTmX34qHS0+ZY6CfEaSMyQxoc
        8W4mqoE5tXLW3s9I5S5mwW/5f6ND4Ceoew==
X-Google-Smtp-Source: ABdhPJyuowqrcaFgImBIALBaSZCf8XMcljH+6N9lbu2+S2X/Sssf4nHMmRZlhSTF03m7rn0wyzcf6Q==
X-Received: by 2002:a17:906:5d13:: with SMTP id g19mr2431967ejt.90.1625181029487;
        Thu, 01 Jul 2021 16:10:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t27sm396656eje.86.2021.07.01.16.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:10:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
Date:   Fri, 02 Jul 2021 01:09:04 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87h7hdbpgb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Change p7519 to use a single "test-tool touch" command to update
> the mtime on a series of (thousands) files instead of invoking
> thousands of commands to update a single file.
>
> This is primarily for Windows where process creation is so
> very slow and reduces the test run time by minutes.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 5eb5044a103..f74e6014a0a 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
>  	fi &&
>  
>  	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> -	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
> -	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
> -	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
> -	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
> +	test-tool touch sequence --pattern="10_files/%d" --start=1 --count=10 &&
> +	test-tool touch sequence --pattern="100_files/%d" --start=1 --count=100 &&
> +	test-tool touch sequence --pattern="1000_files/%d" --start=1 --count=1000 &&
> +	test-tool touch sequence --pattern="10000_files/%d" --start=1 --count=10000 &&
> +
>  	git add 1_file 10_files 100_files 1000_files 10000_files &&
>  	git commit -qm "Add files" &&
>  
> @@ -200,15 +201,12 @@ test_fsmonitor_suite() {
>  	# Update the mtimes on upto 100k files to make status think
>  	# that they are dirty.  For simplicity, omit any files with
>  	# LFs (i.e. anything that ls-files thinks it needs to dquote).
> -	# Then fully backslash-quote the paths to capture any
> -	# whitespace so that they pass thru xargs properly.
>  	#
>  	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>  		git ls-files | \
>  			head -100000 | \
>  			grep -v \" | \
> -			sed '\''s/\(.\)/\\\1/g'\'' | \
> -			xargs test-tool chmtime -300 &&
> +			test-tool touch stdin &&
>  		git status
>  	'

Did you try to replace this with some variant of:

    test_seq 1 10000 | xargs touch

Which (depending on your xargs version) would invoke "touch" commands
with however many argv items it thinks you can handle.
