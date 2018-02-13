Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F461F576
	for <e@80x24.org>; Tue, 13 Feb 2018 07:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbeBMH1X (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 02:27:23 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:27376 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeBMH1W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 02:27:22 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zgYyZ6Q1Yz5tlK;
        Tue, 13 Feb 2018 08:27:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B812F1D18;
        Tue, 13 Feb 2018 08:27:17 +0100 (CET)
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory
 before running hook
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com>
 <20180212031526.40039-3-sunshine@sunshineco.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b24e2f26-d5e4-d17d-04d1-1bd12eaf9faa@kdbg.org>
Date:   Tue, 13 Feb 2018 08:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212031526.40039-3-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2018 um 04:15 schrieb Eric Sunshine:
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -454,20 +454,29 @@ post_checkout_hook () {
>   	test_when_finished "rm -f .git/hooks/post-checkout" &&
>   	mkdir -p .git/hooks &&
>   	write_script .git/hooks/post-checkout <<-\EOF
> -	echo $* >hook.actual
> +	{
> +		echo $*
> +		git rev-parse --show-toplevel
> +	} >../hook.actual
>   	EOF
>   }
>   
>   test_expect_success '"add" invokes post-checkout hook (branch)' '
>   	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/gumby

$(pwd) is here and in the other tests correct. $PWD would be wrong on 
Windows. Thanks for being considerate.

> +	} >hook.expect &&
>   	git worktree add gumby &&
>   	test_cmp hook.expect hook.actual

-- Hannes
