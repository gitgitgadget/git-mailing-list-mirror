Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE2C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBAWkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBAWkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:40:01 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722825E39
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:39:59 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4P6cLP5zh2z5tlD;
        Wed,  1 Feb 2023 23:39:57 +0100 (CET)
Message-ID: <e6fa3452-6d82-bf40-ddb2-44dc686a2e29@kdbg.org>
Date:   Wed, 1 Feb 2023 23:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] compat/winansi: check for errors of CreateThread()
 correctly
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
 <pull.1445.v4.git.git.1675290034144.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1445.v4.git.git.1675290034144.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.23 um 23:20 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> The return value for failed thread creation is NULL,
> not INVALID_HANDLE_VALUE, unlike other Windows API functions.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     win32: check for NULL after creating thread
>     
>     Check for NULL handles, not "INVALID_HANDLE," as CreateThread guarantees
>     a valid handle in most cases.
>     
>     The return value for failed thread creation is NULL, not
>     INVALID_HANDLE_VALUE, unlike other Windows API functions.
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1445%2FAtariDreams%2FhThread-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1445/AtariDreams/hThread-v4
> Pull-Request: https://github.com/git/git/pull/1445
> 
> Range-diff vs v3:
> 
>  1:  1cbc43e0d82 ! 1:  6c4188977e8 win32: check for NULL after creating thread
>      @@ Metadata
>       Author: Seija Kijin <doremylover123@gmail.com>
>       
>        ## Commit message ##
>      -    win32: check for NULL after creating thread
>      -
>      -    Check for NULL handles, not "INVALID_HANDLE,"
>      -    as CreateThread guarantees a valid handle in most cases.
>      +    compat/winansi: check for errors of CreateThread() correctly
>       
>           The return value for failed thread creation is NULL,
>           not INVALID_HANDLE_VALUE, unlike other Windows API functions.
> 
> 
>  compat/winansi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3abe8dd5a27..f83610f684d 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -644,7 +644,7 @@ void winansi_init(void)
>  
>  	/* start console spool thread on the pipe's read end */
>  	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
> -	if (hthread == INVALID_HANDLE_VALUE)
> +	if (!hthread)
>  		die_lasterr("CreateThread(console_thread) failed");
>  
>  	/* schedule cleanup routine */
> 
> base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473

This iteration looks good, thank you!

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

