Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6777AC63697
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B85322384
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 23:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKNXqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 18:46:21 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:23130 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKNXqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 18:46:20 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4CYX6M0DV0z5tlB;
        Sun, 15 Nov 2020 00:46:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 511FE30F;
        Sun, 15 Nov 2020 00:46:18 +0100 (CET)
Subject: Re: [PATCH] userdiff: php: Improved tests catching "abstract" and
 "final" functions
To:     Javier Spagnoletti via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Javier Spagnoletti <phansys@gmail.com>
References: <pull.915.git.git.1605388687554.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ce6d8478-41f7-3664-12bb-9f91e5231f61@kdbg.org>
Date:   Sun, 15 Nov 2020 00:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <pull.915.git.git.1605388687554.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.20 um 22:18 schrieb Javier Spagnoletti via GitGitGadget:
> From: Javier Spagnoletti <phansys@gmail.com>
> 
> Since the original tests cases were using other detectable keywords (like
> "public" or "protected"), they are able to pass even if the keywords
> intended to be covered are not present.

Good find! I had to look at the patch text, though, before I could 
understand what the description wants to say. How about:

We have dedicated tests that "abstract" and "final" declarations
are picked up as hunk context. However, the tests also use the
keywords "public" and "protected" that by themselves denote hunk
context lines. For this reason, the tests would not fail if the
patterns for "abstract" and "final" were to become non-functional.
Remove the distracting keywords from the two tests.

> 
> Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
> ---
>      userdiff: php: Improved test cases used to catch "abstract" and "final"
>      functions
>      
>      Since the original tests cases were using other detectable keywords
>      (like "public" or "protected"), they are able to pass even if the
>      keywords intended to be covered are not present. In the case of the test
>      for "abstract" keyword, the method's body was removed in the fixture,
>      since PHP doesn't allow an abstract method to have a body.
>      
>      Signed-off-by: Javier Spagnoletti phansys@gmail.com [phansys@gmail.com]
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-915%2Fphansys%2Fpr_864-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-915/phansys/pr_864-v1
> Pull-Request: https://github.com/git/git/pull/915
> 
>   t/t4018/php-abstract-method | 5 ++++-
>   t/t4018/php-final-method    | 2 +-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
> index ce215df75a..14d77e6c15 100644
> --- a/t/t4018/php-abstract-method
> +++ b/t/t4018/php-abstract-method
> @@ -1,7 +1,10 @@
>   abstract class Klass
>   {
> -    abstract public function RIGHT(): ?string
> +    abstract function RIGHT(): ?string
>       {
> +        // PHP doesn't allow abstract methods to have a body,
> +        // but this is here just for diff ckeck purposes.
> +
>           return 'ChangeMe';
>       }
>   }
> diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
> index 537fb8ad9a..f7dd2dec17 100644
> --- a/t/t4018/php-final-method
> +++ b/t/t4018/php-final-method
> @@ -1,6 +1,6 @@
>   class Klass
>   {
> -    final public function RIGHT(): string
> +    final function RIGHT(): string
>       {
>           return 'ChangeMe';
>       }
> 
> base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
> 

-- Hannes

