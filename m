Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9961F406
	for <e@80x24.org>; Tue,  2 Jan 2018 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeABJcU (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 04:32:20 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:28962 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753154AbeABJcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 04:32:18 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z9pk80SGqz5tlJ;
        Tue,  2 Jan 2018 10:32:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5A50D303B;
        Tue,  2 Jan 2018 10:32:15 +0100 (CET)
Subject: Re: [PATCH 4/4] branch: add '--show-description' option
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180101225448.2561-1-szeder.dev@gmail.com>
 <20180101225448.2561-5-szeder.dev@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c3937260-1ffd-797b-7f25-53a6a4bf3676@kdbg.org>
Date:   Tue, 2 Jan 2018 10:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180101225448.2561-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.2018 um 23:54 schrieb SZEDER Gábor:
> 'git branch' has an option to edit a branch's description, but lacks
> the option to show that description.
> 
> Therefore, add a new '--show-description' option to do just that, as a
> more user-friendly alternative to 'git config --get
> branch.$branchname.description':
> 
>    - it's shorter to type (both in the number of characters and the
>      number of TABs if using completion),
>    - works on the current branch without explicitly naming it,
>    - hides the implementation detail that branch descriptions are
>      stored in the config file, and
>    - errors out with a proper error message when the given branch
>      doesn't exist (but exits quietly with an error code when the
>      branch does exit but has no description, just like the 'git config'
>      query does).

> +test_expect_success '--show-description with no description errors quietly' '
> +	git config --unset branch.master.description &&
> +	test_must_fail git branch --show-description >actual 2>actual.err &&
> +	test_must_be_empty actual &&
> +	test_must_be_empty actual.err
> +'

Checking the exact contents of stderr typically fails when tests are run 
under -x. Perhaps

	test_i18ngrep ! "fatal: " actual.err &&"
	test_i18ngrep ! "error: " actual.err &&
	test_i18ngrep ! "warning: " actual.err

Which makes me wonder: Why would --show-description have to error out 
silently? This is not 'git config' after all.

-- Hannes
