Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0897C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbeKGHLZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 02:11:25 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:14950 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeKGHLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 02:11:25 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42qNNR66mQz5tmh;
        Tue,  6 Nov 2018 22:44:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9C4091B09;
        Tue,  6 Nov 2018 22:44:07 +0100 (CET)
Subject: Re: [PATCH 1/1] Windows: force-recompile git.res for differing
 architectures
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.67.git.gitgitgadget@gmail.com>
 <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org>
Date:   Tue, 6 Nov 2018 22:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.18 um 15:55 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When git.rc is compiled into git.res, the result is actually dependent
> on the architecture. That is, you cannot simply link a 32-bit git.res
> into a 64-bit git.exe.
> 
> Therefore, to allow 32-bit and 64-bit builds in the same directory, we
> let git.res depend on GIT-PREFIX so that it gets recompiled when
> compiling for a different architecture (this works because the exec path
> changes based on the architecture: /mingw32/libexec/git-core for 32-bit
> and /mingw64/libexec/git-core for 64-bit).

On Linux, when I recompile for a different architecture, CFLAGS would 
change, so I would have thought that GIT-CFLAGS were the natural choice 
for a dependency. Don't they change in this case on Windows, too?

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index bbfbb4292d..8375736c32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2110,7 +2110,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>   	$(QUIET_GEN)$(cmd_munge_script) && \
>   	mv $@+ $@
>   
> -git.res: git.rc GIT-VERSION-FILE
> +git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
>   	$(QUIET_RC)$(RC) \
>   	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
>   	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
> 

