Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA446C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A90761040
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhDZVa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:30:59 -0400
Received: from mail-gateway-shared15.cyon.net ([194.126.200.68]:56494 "EHLO
        mail-gateway-shared15.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDZVa4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Apr 2021 17:30:56 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2021 17:30:56 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1lb8ga-0001xm-9Y
        for git@vger.kernel.org; Mon, 26 Apr 2021 23:22:34 +0200
Received: from [10.20.10.230] (port=25500 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.94)
        (envelope-from <dev+git@drbeat.li>)
        id 1lb8gZ-005Uov-4m; Mon, 26 Apr 2021 23:22:31 +0200
Subject: Re: [PATCH 1/2] pretty tests: simplify %aI/%cI date format test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
 <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
 <patch-1.2-4a90e4a141a-20210425T090506Z-avarab@gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <803b9a49-6d27-2792-faa2-d37886cb2151@drbeat.li>
Date:   Mon, 26 Apr 2021 23:22:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <patch-1.2-4a90e4a141a-20210425T090506Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.04.21 11:11, Ævar Arnfjörð Bjarmason wrote:
> Change a needlessly complex test for the %aI/%cI date
> formats (iso-strict) added in 466fb6742d7 (pretty: provide a strict
> ISO 8601 date format, 2014-08-29) to instead use the same pattern used
> to test %as/%cs since 0df621172d8 (pretty: provide short date format,
> 2019-11-19).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4205-log-pretty-formats.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index cabdf7d57a0..0462115ac5c 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -527,8 +527,7 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
>  
>  # ISO strict date format
>  test_expect_success 'ISO and ISO-strict date formats display the same values' '
> -	git log --format=%ai%n%ci |
> -	sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
> +	git log --format=%ad%n%cd --date=iso-strict >expected &&
>  	git log --format=%aI%n%cI >actual &&
>  	test_cmp expected actual
>  '

LGTM.

I wonder if these format shortcut tests that now look so regular should
be put into a loop with a few suitable loop parameters?

Cheers, Beat
