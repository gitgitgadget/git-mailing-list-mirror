Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DBC4360C
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4A26124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349685AbhDGIyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349706AbhDGIyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 04:54:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B121C0613D9
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 01:53:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so15848277edd.11
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bxY+FiQiHLL/iscZmAdUEbn/e04AgLWvoTg/2GtDTP8=;
        b=frObbNdnM2i8H6ssrnSRhMmuc1kINIqJ74y23/ae/I2+JU3YTsFPDebythhWKsfQbJ
         t2qqbGSS/n4M2wzFwz8QDlNaMRRnFdnQLjQXkINlS2iRwxH7doFStcj8IBICwcjtwSxN
         /mYFKZc86oxtmGQ2HnmzJK5DV6G6tUYLY2mwKjaS8I0mH6rxANyfRLZdxheF2upze0xh
         BmwbzLCNtZwI/pw5n929STsB3qdWVP9o5edUJmzNZXgGbE2JXaSqrFIUQPllJtlb2vld
         RoRfTeZsYEP1zRZf567GevtM+m6jYiii1HRG/5WJRKXMlRaBeDJQIb6Ym8jR/is8tyU9
         EMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bxY+FiQiHLL/iscZmAdUEbn/e04AgLWvoTg/2GtDTP8=;
        b=NlwJDqKRU3HlSB5HUEmnHXeb7vB6T5LlzShy1ERy5ukrbZGyQSGNmDqmXuRfehD/CW
         4+F6cWw75h3XGAWJ0hqS/DHIo0H8nitSouR0la205SRIonUDqwGW+qEkA2+4WChXkYP/
         EKNSa0wGR2GhsE8WdlkUkCKC9vpU6CtUG/ICgP5uJDwn9PdpPA4kvNiAYkHPmnJpm4m1
         4+Aa6uWrIVjJbAdtMcaNcXO6lCaYGnn7HafqWHoCx9WTxjcaOMhxO0GA02xJ0BY+X/eG
         csAP3Q+uorON8ip6xEA55MC5Y2Czvh3adixVtyqXGH5/yM7KNJSQw1QUhEGhsclg4Okw
         13OQ==
X-Gm-Message-State: AOAM531LvHfkI5gJGo3LOpjWefmuMz1aa1NJQLFLOFrJkR/9CkoAg0Hz
        9afQUFItNCG9Rayh8T+L0mU=
X-Google-Smtp-Source: ABdhPJw3IEvL7IMGVIz+gn3LFgrP9pISqMHytuL2Gt0Kn8GpfewQgSEK4Ak4Z1Xf8Ih0UQcmpjbDmA==
X-Received: by 2002:aa7:c916:: with SMTP id b22mr3110467edt.299.1617785616784;
        Wed, 07 Apr 2021 01:53:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id kx3sm7443904ejc.44.2021.04.07.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:53:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 10:53:35 +0200
Message-ID: <87o8eqjx0w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:

> [...]
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index fc2315edec11..3366ea188782 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
>  	test_commit -C clone2 two &&
>  	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>  	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> -	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
> -	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
>  	test_path_is_missing .git/refs/remotes &&
> -	git log prefetch/remote1/one &&
> -	git log prefetch/remote2/two &&
> +	git log prefetch/remotes/remote1/one &&
> +	git log prefetch/remotes/remote2/two &&
>  	git fetch --all &&
> -	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
> -	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
> +	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
> +	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
>  
>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>  	git log --oneline --decorate --all >log &&
>  	! grep "prefetch" log
>  '
>  
> +test_expect_success 'prefetch custom refspecs' '
> +	git -C clone1 branch -f special/fetched HEAD &&
> +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
> +
> +	# create multiple refspecs for remote1
> +	git config --add remote.remote1.fetch +refs/heads/special/fetched:refs/heads/fetched &&
> +	git config --add remote.remote1.fetch ^refs/heads/special/secret/not-fetched &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&

I see this is following some established convention in the file, but is
there really not a way to make this pass without directing stderr to
/dev/null? It makes ad-hoc debugging when reviewing harder.


I tried just removing it, but then (in an earlier test case) the
"test_subcommand" fails because it can't find the line we're looking
for, so us piping stderr to /dev/null impacts our trace2 output?

