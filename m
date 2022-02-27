Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A5C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiB0Rnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB0Rnq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 12:43:46 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A522BC0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:43:07 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4K69pH5V8mz5tlB;
        Sun, 27 Feb 2022 18:43:03 +0100 (CET)
Message-ID: <177b8b40-9e27-5019-c4df-772642508c37@kdbg.org>
Date:   Sun, 27 Feb 2022 18:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] t0001-t0028: avoid pipes with Git on LHS
Content-Language: en-US
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     me@ttaylorr.com, avarab@gmail.com, git@vger.kernel.org
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
 <20220227122453.25278-1-shivam828787@gmail.com>
 <20220227122453.25278-2-shivam828787@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220227122453.25278-2-shivam828787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.22 um 13:24 schrieb Shubham Mishra:
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index b007f0efef..b5fa76059b 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh

> @@ -1104,12 +1105,13 @@ test_expect_success 'very long name in the index handled sanely' '
>  	>path4 &&
>  	git update-index --add path4 &&
>  	(
> -		git ls-files -s path4 |
> -		sed -e "s/	.*/	/" |
> +		git ls-files -s path4 >tmp &&
> +		sed -e "s/	.*/	/" tmp |
>  		tr -d "\012" &&
>  		echo "$a"
>  	) | git update-index --index-info &&

We see a pipe here, and in the upstream of that pipe is a git
invocation. That should be fixed, too. After the rewrite that you
already did here, it should be sufficient to move the git invocation
before the parentheses.

> -	len=$(git ls-files "a*" | wc -c) &&
> +	git ls-files "a*" >tmp &&
> +	len=$(wc -c <tmp) &&
>  	test $len = 4098
>  '

-- Hannes
