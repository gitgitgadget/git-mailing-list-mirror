Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0951F462
	for <e@80x24.org>; Wed, 19 Jun 2019 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfFSGTX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 02:19:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:54523 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFSGTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 02:19:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45TFCX1jQrz5tlH;
        Wed, 19 Jun 2019 08:19:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 42FDF208D;
        Wed, 19 Jun 2019 08:19:19 +0200 (CEST)
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.149.git.gitgitgadget@gmail.com>
 <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
 <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
Date:   Wed, 19 Jun 2019 08:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.19 um 01:12 schrieb Eric Sunshine:
> On Tue, Jun 18, 2019 at 8:24 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> @@ -474,7 +474,8 @@ test_expect_success MINGW 'redirect std handles' '
>>         printf ".git\nfatal: Needed a single revision\n" >expect &&
>> -       test_cmp expect output.txt
>> +       sort <output.txt >output.sorted &&
>> +       test_cmp expect output.sorted
> 
> It was quite surprising to see this sorting only 'output' but not
> 'expect'. I see now that 'output' is already "sorted" (in that sense),
> but it feels fragile. More robust would be to sort 'expect' as well:
> 
>     printf ".git\nfatal: Needed a single revision\n" | sort >expect &&

Following Dscho's recent objection elsewhere that tests tend to check
for much more than regressions, wouldn't it be logical to write these as

	grep -F .git" output.txt &&
	test_i18n_grep "Needed a single rev" output.txt

without an 'expect' file at all?

-- Hannes
