Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909DF1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdFEXUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:20:11 -0400
Received: from avasout07.plus.net ([84.93.230.235]:60332 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdFEXUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:20:11 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id VBL71v0041keHif01BL9B1; Tue, 06 Jun 2017 00:20:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=FEWp7enXAAAA:8 a=nHNMV_B3k5owbSXAjKQA:9 a=QEXdDO2ut3YA:10
 a=IjYSrUNMXUflr7qE6tl5:22
X-AUTH: ramsayjones@:2500
Subject: Re: Git v2.13.1 SHA1 very broken
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20170605203409.GB25777@dinwoodie.org>
 <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <15c976f0-9203-dbba-86b6-240e44a1a56f@ramsayjones.plus.com>
Date:   Tue, 6 Jun 2017 00:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/06/17 22:05, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jun 5, 2017 at 10:34 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>> I'm trying to compile Git v2.13.1 to release for Cygwin, but it appears
>> a010391 ("sha1dc: update from upstream", 2017-05-20) is breaking a very
>> significant number of test cases in both 32-bit and 64-bit Cygwin
>> builds.
>>
>> The first failure is t0000.46 "validate object ID of a known tree"; output with
>> -x and -v is below, although it's not very interesting:
>>
>>     expecting success:
>>             test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>>
>>     ++ test ceb282701536fe61bea01075664405caa7d6343f = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>>     + test_eval_ret_=1
>>     + want_trace
>>     + test t = t
>>     + test t = t
>>     + set +x
>>     error: last command exited with $?=1
>>     not ok 46 - validate object ID of a known tree
>>     #
>>     #               test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>>     #
>>
>> I have no idea where to even begin debugging this, but I'm happy to take
>> pointers / try things out on my box.
> 
> That looks scary, can you please comment out this:
> 
>     #define SHA1DC_ALLOW_UNALIGNED_ACCESS

No, that doesn't fix it.

> 
> In sha1dc/sha1.c and see if that helps, alternatively comment out the
> ifdefs guarded by "#ifdef _MSC_VER" calls in sha1dc/sha1.c

This can't possibly make a difference! ;-)

However, rebuilding with:

    $ make OPENSSL_SHA1=YesPlease >out2 2>&1

... make t0000-basic.sh pass just fine, so ...

ATB,
Ramsay Jones

