Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B6520248
	for <e@80x24.org>; Sat, 16 Mar 2019 10:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCPK07 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 06:26:59 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:8781 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPK06 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 06:26:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44LzC4033Dz5tlF;
        Sat, 16 Mar 2019 11:26:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DF1802104;
        Sat, 16 Mar 2019 11:26:54 +0100 (CET)
Subject: Re: [PATCH 1/2] fsmonitor: demonstrate that it is not refreshed after
 discard_index()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.165.git.gitgitgadget@gmail.com>
 <f451752656ea5d1e9898e5fa0b2d41de6550781b.1552729745.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <680444e1-d670-607b-e84b-c1eb4355b047@kdbg.org>
Date:   Sat, 16 Mar 2019 11:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f451752656ea5d1e9898e5fa0b2d41de6550781b.1552729745.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.03.19 um 10:49 schrieb Johannes Schindelin via GitGitGadget:
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 3e0a61db23..918bc323ab 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -346,4 +346,14 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
>  	test_cmp before after
>  '
>  
> +test_expect_failure 'discard_index() also discards fsmonitor info' '
> +	test_when_finished \
> +		"git config core.monitor .git/hooks/fsmonitor-test" &&

Did you mean
		"git config core.fsmonitor ...
?

> +	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&

And then, does this not unset core.fsmonitor after the test anyway?

> +	test_might_fail git update-index --refresh &&
> +	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
> +	printf "tracked is%s up to date\n" "" " not" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

-- Hannes
