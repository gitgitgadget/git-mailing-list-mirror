Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F056C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC02613A7
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbhI2GlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbhI2GlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:41:21 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925FC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:39:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r9so1688413ile.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=caK55Gqw0QobPXOODnKZWm84mu3dw5ZYCVEA8Aklzog=;
        b=DuoFBEGgI00z4lWKYomxEFgUwCNycSu6yrRKf3TbxhsgPItvAm04/G7nEpHD0vEdmT
         py+xBdAJ8oIuUulYHsVbrQU4ZbLD49iWJlSaRWxVrHf/z5SSxkmBL1NI0N7Fxv56iXp1
         9ZbeVqS/ckpEXseKgi+t7TBz82aoHJLypQlcXZL8Qo+KaQdDEw+zkQqQKWqYJdUT4RDo
         wLyxz1ggc2JGqSYnE8oQABEqgkdcVBHBh3KC40Ci1+sbh7ZTwAq0j5NpPu2TkSzAkpLy
         pA3s5+/awkdSwAa06vxsQi2/wPxg/16joH7Kb7/jXIwUnzH+NauJlaLXR9cHm96XEMF+
         8r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caK55Gqw0QobPXOODnKZWm84mu3dw5ZYCVEA8Aklzog=;
        b=vPayoH66YJFQmrG9lafW02YoZ60nzw/aCrTsDIQcrJxd/1XmPEabZsu3dx90QYNWgW
         rzW8oJzeuCKGK24tzks3TYMQYe9DavyTIqVC+6S+69AXLz2qBjpDGOJ40D1uM9+Q3fqx
         yVomsBcTUc9o/51bbqTDZXJp8pzZjygZk4OQXXQacBRxZhkegobUL1VDWPESBtqKv5pQ
         B+fVWrw11sCrxCYTBc3wQmvdX/1sppljLPExUhlofJLl3dj25sxPoxOxkuOMjaFvAJut
         AvTZIBtOTyQi/iDRdrBEGg4gZz20HKDQ7o2+r2SUXEmdyM+YQgJfVyibVFZ3hFVFBjAW
         1CJA==
X-Gm-Message-State: AOAM533Ya2NpcvEuFsxYCXDKKWh7FiipBv3XO/WJkj+1rF33tpiuRw16
        7Ez82/wq0IwMuC4L33g8BkgEIxbO00puKg==
X-Google-Smtp-Source: ABdhPJwHoFsn092nC76JVPQHEx94oBwKfe+mZUqttK4fWIFSCJ+g5leEesJmCm4h+48epYGb3db7tQ==
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr6930168ilv.70.1632897580731;
        Tue, 28 Sep 2021 23:39:40 -0700 (PDT)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id l3sm839579ilq.48.2021.09.28.23.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 23:39:40 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v2 3/3] gc: perform incremental repack when implictly
 enabled
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913181221.42635-1-chooglen@google.com>
 <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-4-chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <f0eb2fd0-ce1e-5833-4d64-8569ba3bbedc@sunshineco.com>
Date:   Wed, 29 Sep 2021 02:39:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917225459.68086-4-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/21 6:54 PM, Glen Choo wrote:
> builtin/gc.c has two ways of checking if multi-pack-index is enabled:
> - git_config_get_bool() in incremental_repack_auto_condition()
> - the_repository->settings.core_multi_pack_index in
>    maintenance_task_incremental_repack()
> 
> The two implementations have existed since the incremental-repack task
> was introduced in e841a79a13 (maintenance: add incremental-repack auto
> condition, 2020-09-25). These two values can diverge because
> prepare_repo_settings() enables the feature in the_repository->settings
> by default.
> 
> In the case where core.multiPackIndex is not set in the config, the auto
> condition would fail, causing the incremental-repack task to not be
> run. Because we always want to consider the default values, we should
> just always just use the_repository->settings.
> 
> Standardize on using the_repository->settings.core_multi_pack_index to
> check if multi-pack-index is enabled.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -322,31 +322,69 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
>   test_expect_success 'maintenance.incremental-repack.auto' '
> +	(
> +		git init incremental-repack-true &&
> +		cd incremental-repack-true &&
> +		git config core.multiPackIndex true &&
> +		test_commit A &&
> +		git repack -adk &&
> +		git multi-pack-index write &&
> +		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
> +			-c maintenance.incremental-repack.auto=1 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
> +		test_commit B &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
> +		test_commit C &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand git multi-pack-index write --no-progress <trace-B
> +	)
> +'
> +
> +test_expect_success 'maintenance.incremental-repack.auto (when config is unset)' '
> +	(
> +		git init incremental-repack-unset &&
> +		cd incremental-repack-unset &&
> +		test_unconfig core.multiPackIndex &&
> +		test_commit A &&
> +		git repack -adk &&
> +		git multi-pack-index write &&
> +		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
> +			-c maintenance.incremental-repack.auto=1 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
> +		test_commit B &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
> +		test_commit C &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand git multi-pack-index write --no-progress <trace-B
> +	)
>   '

The amount of code common between the two tests is significant. In 
simple cases, such duplication may not be worth worrying about, but it 
feels like we can do better here. There are a number of ways to re-use 
the code between tests. One such way would be to do something like this:

     run_incremental_repack () {
         test_commit A &&
         ...
         test_subcommand ...
     }

     test_expect_success 'maintenance.incremental-repack.auto' '
         rm -rf incremental-repack &&
         git init incremental-repack &&
         (
             cd incremental-repack &&
             git config core.multiPackIndex true &&
             run_incremental_repack
         )
     '

     test_expect_success 'maintenance.incremental-repack.auto (config 
unset)' '
         rm -rf incremental-repack &&
         git init incremental-repack &&
         (
             cd incremental-repack &&
             test_unconfig core.multiPackIndex &&
             run_incremental_repack
         )
     '
