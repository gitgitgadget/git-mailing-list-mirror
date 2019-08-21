Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFB51F461
	for <e@80x24.org>; Wed, 21 Aug 2019 18:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfHUSX0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 14:23:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50189 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfHUSX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 14:23:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46DGHw2mH7z5tl9;
        Wed, 21 Aug 2019 20:23:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F1DBD1D1B;
        Wed, 21 Aug 2019 20:23:23 +0200 (CEST)
Subject: Re: [PATCH] t0021: make sure clean filter runs
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org> <20190821145616.GB2679@cat>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a8de9661-7f6a-f953-93a0-8ef88e9a490a@kdbg.org>
Date:   Wed, 21 Aug 2019 20:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821145616.GB2679@cat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.08.19 um 16:56 schrieb Thomas Gummerer:
> On 08/20, Johannes Sixt wrote:
>> Am 20.08.19 um 08:56 schrieb Thomas Gummerer:
>>> Fix the test by updating the mtime of test.r, ...
>>
>>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>>> index e10f5f787f..66f75005d5 100755
>>> --- a/t/t0021-conversion.sh
>>> +++ b/t/t0021-conversion.sh
>>> @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
>>>  		EOF
>>>  		test_cmp_exclude_clean expected.log debug.log &&
>>>  
>>> +		touch test.r &&
>>
>> 		test-tool chmtime +10 test.r
>>
>> would be more reliable.
> 
> Hmm, is touch unreliable on some platforms?  I didn't think of
> 'test-tool chmtime', but I'm also not sure it's better than touch in
> this case.
> 
> To me te 'touch' signifies that the timestamp must be updated after
> the previous checkout, so git thinks it could possibly have been
> changed, which I think is clearer in this case than setting the mtime
> to a future time.

touch does not guarantee that the current time is different from the
timestamp that the file already carries, particularly not when the
filesystem stores just a resolution of 1 second, and commands are
executed quickly.

But when we use test-tool chmtime +10, then the timestamp is definitely
different. If you don't like a timestamp in the future, use -10, or
anything else that is different from zero.

-- Hannes
