Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A7C54FCE
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1C220663
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 10:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj9gqHTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCVKsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:48:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40665 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgCVKsb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 06:48:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so12877567wrw.7
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/EEJ0UltNW+UgJ/MnBJRUiLpz7qctnxrPuduZ8zezIE=;
        b=jj9gqHTpKEH/1F2ga/CG02hoKzGdgWtMLgEgEfF1FqpKQt6HSAasQRrNtaNpPeye+9
         VzW9qYnt20XqaoCqh5ZVa2zDmGPSWmtZ7xUQkrdyTuV5uvonB3/G9MUDQKYycvrwcaBU
         0vLmkyc8zhLhQpFs+vnQwuJ287Yn8Fdk36zLPvLVV3bZikTyaTBEWV/bf3WDxpN7Qclu
         hn6U2AVmikpVpRwVavzI9p/+nn677mn7TrvLv4TFFXJGGxpd5FEa33fcGlcTAKCwHyDv
         NR6BHiMvqxg94wwROo5kWQrhjo19uqDBxDJpk79kRzdZBLxeSHE7bkAOQEDo/b6mg5ak
         CmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/EEJ0UltNW+UgJ/MnBJRUiLpz7qctnxrPuduZ8zezIE=;
        b=HGXZyt3BU17MDtVsc/pL+xi8uIkQ4Toe619bZYvPxHz8Nz7KYTA2QErMyun4yWRFNV
         vXDW2ODUNx/9sUVroCzda22yGL6zMV8dK6+xH8JCq6bTZN86mmSfgSmsvM9ywn9aRxS4
         ocJchuBOXeJTjPFwtjbuVFG3Mvlk8qNA7fP9Y1nvAQ0y9GmTsvupWFnjIaHDHABOZnd/
         ruWis5lhxl19zotfVwuV8wkyyCx/oCSMO3iE5tS8J3HXNgr9ied/bPb/h3zdX5WBjJg6
         tL2oQgFu3DNjqPDtaitwjC6X2Nrn7r3CEASrOhFWvgvPQe4zC7AmOcP66MC7r1196G30
         jdgw==
X-Gm-Message-State: ANhLgQ1Yv6SbEa7iGM1A8+iP387fFD5Qbi2zJNu0h25hQegLzAKyK1ZI
        rbZV+f/gwUli24EzDQ0ZfkA=
X-Google-Smtp-Source: ADFU+vsZAddde5hV2q4PM818NiLiBB+wUn5LAB/JRCE3WGi13vi9lqig3t1w3yRRRjvFMP0p+oAleA==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr1329766wru.383.1584874109580;
        Sun, 22 Mar 2020 03:48:29 -0700 (PDT)
Received: from szeder.dev (62-165-238-214.pool.digikabel.hu. [62.165.238.214])
        by smtp.gmail.com with ESMTPSA id s8sm13477031wrv.97.2020.03.22.03.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 03:48:28 -0700 (PDT)
Date:   Sun, 22 Mar 2020 11:48:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sheikh hamza via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sheikh hamza <sheikhhamza012@gmail.com>
Subject: Re: [PATCH] bisect: remove root directory restriction for git bisect
Message-ID: <20200322104826.GB2224@szeder.dev>
References: <pull.736.git.git.1584868547682.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.736.git.git.1584868547682.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 09:15:47AM +0000, Sheikh hamza via GitGitGadget wrote:
> From: sheikh hamza <sheikhhamza012@gmail.com>
> 
>     according to the open issue #486

What issue #486?  Where?  The Git project doesn't use issues.

> the git bisect
>     command should be able to run from inside any
>     subdirectory

Why should 'git bisect' be able to run from inside any subdirectory
(of the working tree, I presume)?

In particular, what happens, if someone starts 'git bisect' from
within 'subdir/', and 'git bisect' then checks out an old commit,
where said 'subdir/' didn't exist?  What happens, if the user runs
'git bisect run ./script' from within 'subdir/', and that 'subdir/'
doesn't exist in that old commit?  What happens, if 'subdir' does
exists in that old commit, but it's a file, not a directory?  What
happens, if all this is on Windows?


> and in the same disscusion "dscho"
>     gave the directions and those directions lead me
>     the fix of adding SUBDIRECTORY_OK=Yes on L#34
>     before sourcing git-sh-setup that made it work as
>     in git-sh-setup there was a check on SUBDIRECTORY_OK
>     that prevents it to run in sub directories if it is not
>     set to "ok" as this file was also sourced in other commands
>     that are required to only run from root one of such scripts
>     is git-filter-branch

Please don't indent the commit message and use punctuation to make it
more readable.

> 
> Signed-off-by: sheikh hamza <sheikhhamza012@gmail.com>
> ---
>     bisect: remove root directory restriction for git bisect
>     
>     according to the open issue #486 the git bisect
>     command should be able to run from inside any
>     subdirectory and in the same disscusion "dscho"
>     gave the directions and those directions lead me
>     the fix of adding SUBDIRECTORY_OK=Yes on L#34
>     before sourcing git-sh-setup that made it work as
>     in git-sh-setup there was a check on SUBDIRECTORY_OK
>     that prevents it to run in sub directories if it is not
>     set to "ok" as this file was also sourced in other commands
>     that are required to only run from root one of such scripts
>     is git-filter-branch
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-736%2Fsheikhhamza012%2Fbisect_subdirectory_fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-736/sheikhhamza012/bisect_subdirectory_fix-v1
> Pull-Request: https://github.com/git/git/pull/736
> 
>  git-bisect.sh            | 1 +
>  t/perf/bisect_regression | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1e..8c1da200e41 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -31,6 +31,7 @@ git bisect run <cmd>...
>  
>  Please use "git help bisect" to get the full man page.'
>  
> +SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
>  . git-sh-setup
>  
> diff --git a/t/perf/bisect_regression b/t/perf/bisect_regression
> index ce47e1662a9..d6b96f49e46 100755
> --- a/t/perf/bisect_regression
> +++ b/t/perf/bisect_regression
> @@ -57,11 +57,9 @@ tmpdir=$(mktemp -d -t bisect_regression_XXXXXX) || die "Failed to create temp di
>  echo "$oldtime" >"$tmpdir/oldtime" || die "Failed to write to '$tmpdir/oldtime'"
>  echo "$newtime" >"$tmpdir/newtime" || die "Failed to write to '$tmpdir/newtime'"
>  
> -# Bisecting must be performed from the top level directory (even with --no-checkout)
> -(
> -	toplevel_dir=$(git rev-parse --show-toplevel) || die "Failed to find top level directory"
> -	cd "$toplevel_dir" || die "Failed to cd into top level directory '$toplevel_dir'"
>  
> +(
> +	 
>  	git bisect start --no-checkout "$newrev" "$oldrev" || die "Failed to start bisecting"
>  
>  	git bisect run t/perf/bisect_run_script "$test_script" "$test_number" "$tmpdir"
> 
> base-commit: 98cedd0233ee88e69711f79d1126b6bd772ff5bd
> -- 
> gitgitgadget
