Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA841FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdFPSnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 14:43:31 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:8943 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdFPSna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 14:43:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3wq8QS4Y72z5tl9;
        Fri, 16 Jun 2017 20:43:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 149CF21A;
        Fri, 16 Jun 2017 20:43:27 +0200 (CEST)
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170614102427.5220-1-phillip.wood@talktalk.net>
 <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
 <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
 <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3c975634-8651-af74-66bf-ee793bc073fc@kdbg.org>
Date:   Fri, 16 Jun 2017 20:43:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.06.2017 um 15:49 schrieb Johannes Schindelin:
> On Thu, 15 Jun 2017, Junio C Hamano wrote:
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 325ec75353..801bce25da 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -45,7 +45,7 @@ create_expected_success_am() {
>>   }
>>   
>>   create_expected_success_interactive() {
>> -	cr=$'\r' &&
>> +	cr=$(echo . | tr '.' '\015') &&
>>   	cat >expected <<-EOF
>>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>   	HEAD is now at $(git rev-parse --short feature-branch) third commit
> 
> This is still incorrect, as the \r\n (which $(echo . | tr \.\ '\015')
> would emit) is interpreted correctly as a line break on Windows, meaning
> that cr is now *empty*. Not what we want.
> 
> What I did is to replace the `cat` by `q_to_cr` (we have that lovely
> function, might just as well use it), replace `${cr}` by `Q` and skip the
> cr variable altogether.

You beat me to it. I came up with the identical q_to_cr changes, but 
haven't dug the remaining failure regarding the swapped output lines. 
You seem to have nailed it. Will test your proposed changes tomorrow.

-- Hannes
