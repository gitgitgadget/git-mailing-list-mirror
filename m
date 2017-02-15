Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D82F2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 20:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdBOUp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 15:45:26 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:47674 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbdBOUpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 15:45:25 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vNrrz3FYgz5tlh;
        Wed, 15 Feb 2017 21:45:23 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9EBF0427E;
        Wed, 15 Feb 2017 21:45:22 +0100 (CET)
Subject: Re: [PATCH] mingw: make stderr unbuffered again
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
 <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702141545380.3496@virtualbox>
 <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
 <alpine.DEB.2.20.1702151312330.3496@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0275af7b-eb7a-1094-a891-674300175e56@kdbg.org>
Date:   Wed, 15 Feb 2017 21:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702151312330.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.2017 um 13:32 schrieb Johannes Schindelin:
> On Tue, 14 Feb 2017, Johannes Sixt wrote:
>> Am 14.02.2017 um 15:47 schrieb Johannes Schindelin:
>>> On Mon, 13 Feb 2017, Junio C Hamano wrote:
>>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>>> What we forgot was to mark stderr as unbuffered again.
>>
>> I do not see how the earlier patch turned stderr from unbuffered to
>> buffered, as it did not add or remove any setvbuf() call. Can you
>> explain?
>
> [ motivation and history of js/mingw-isatty snipped ]
>
> So instead of "bending" the target HANDLE of the existing stdout/stderr
> (which would *naturally* have kept the buffered/unbuffered nature as-is),
> we now redirect with correct API calls.

Your statement implies that at the time when winansi_init() begins, 
stdio is already initialized and the buffered/unbuffered state has been 
set for stderr. I would think that this is true.

Then we swap out the file handle underlying stderr in swap_osfhnd() 
using dup2(). Why would that change the buffered state of stdio?

> And the patch I provided at the
> bottom of this mail thread reinstates the unbuffered nature of stderr now
> that it gets reopened.
>
> Hopefully that makes it clear why the setvbuf() call is required now, but
> was previously unnecessary?

Unfortunately, no. I do not see how dup2() causes a change in stdio 
state. I must be missing something (and that may be a basic 
misunderstanding of how stdio is initialized).

-- Hannes

