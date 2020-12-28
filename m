Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A97C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760B0207B0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgL1L6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:58:21 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:47856 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbgL1L6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:58:21 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4D4GJL5s7rz5tlK;
        Mon, 28 Dec 2020 12:57:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 21D6A20EE;
        Mon, 28 Dec 2020 12:57:38 +0100 (CET)
Subject: Re: [PATCH v8 4/4] mergetool: Add automerge_enabled tool-specific
 override function
To:     Seth House <seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
 <20201228045427.1166911-1-seth@eseth.com>
 <20201228045427.1166911-5-seth@eseth.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <01f6951b-69e0-01c6-6b77-950ea9d76e66@kdbg.org>
Date:   Mon, 28 Dec 2020 12:57:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228045427.1166911-5-seth@eseth.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.20 um 05:54 schrieb Seth House:
> Hat-tip to Junio C Hamano for the implementation.

We usually write this as

Helped-by: Junio C Hamano <gitster@pobox.com>

> 
> Signed-off-by: Seth House <seth@eseth.com>
> ---
>  git-mergetool--lib.sh | 4 ++++
>  git-mergetool.sh      | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e059b3559e..5084ceffeb 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -164,6 +164,10 @@ setup_tool () {
>  		return 1
>  	}
>  
> +	automerge_enabled () {
> +		true

I would have written this as `return 0` instead of `true` like some of
the functions above this hunk.

> +	}
> +
>  	translate_merge_tool_path () {
>  		echo "$1"
>  	}
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 929192d0f8..a44afd3822 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -336,7 +336,7 @@ merge_file () {
>  
>  	initialize_merge_tool "$merge_tool"
>  
> -	if test "$(
> +	if automerge_enabled && test "$(
>  		git config --get --bool "mergetool.$merge_tool.automerge" ||
>  		git config --get --bool "mergetool.automerge" ||
>  		echo true)" = true
> 

-- Hannes
