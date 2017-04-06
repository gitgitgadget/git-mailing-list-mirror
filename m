Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278861FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935049AbdDFOZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 10:25:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:21958 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934924AbdDFOZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 10:25:07 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0E99B84658;
        Thu,  6 Apr 2017 10:25:06 -0400 (EDT)
Subject: Re: [PATCH v5 3/4] test-strcmp-offset: created test for strcmp_offset
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170405224752.2242-1-szeder.dev@gmail.com>
 <alpine.DEB.2.20.1704061014120.4268@virtualbox>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <afdbf105-9dee-3779-6c1b-a6c65c773f23@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 10:25:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704061014120.4268@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 4:21 AM, Johannes Schindelin wrote:
> Hi Gábor,
>
> On Thu, 6 Apr 2017, SZEDER Gábor wrote:
>
>> I think this patch should be squashed into the previous commit;  I
>> don't see any reason why the tests should be added in a different
>> commit than the function they are testing.

Will do.

>
> I am of two minds there. In some cases, the newly added test demonstrates
> the intended usage, and therefore makes for a nice documentation. In other
> cases, the new test is large enough to stand on its own, i.e. to merit a
> separate patch (also to make reviewing easier).
>
> In this particular case, I tend to the latter: it is large enough a patch
> that it is easier to review as a separate patch.
>
>>>  t/helper/test-strcmp-offset.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>>>  t/t0065-strcmp-offset.sh      | 11 ++++++++
>>>  4 files changed, 77 insertions(+)
>>>  create mode 100644 t/helper/test-strcmp-offset.c
>>>  create mode 100755 t/t0065-strcmp-offset.sh
>>
>> Sure, tests are good, but I have to wonder how this would scale in the
>> long term, when even such simple functions would get their own
>> t/helper/test-func executable and t/tNNNN-func.sh script.

I think this is the start of a larger conversation on
how we want to handle function-level unit-testing and
outside the scope of this patch series.

>
> True. The proliferation of executables in t/helper/ got a little out of
> hand.
>
> But there is nothing preventing us from consolidating a few of them into a
> single executable, using our wonderful option parsing function with
> OPT_CMDMODE to switch between the different functions.
>
> I could see, for example, how we could consolidate all string-related
> test helpers into a single one, say, test-strings:
>
> t/helper/test-ctype.c
> t/helper/test-regex.c
> t/helper/test-strcmp-offset.c
> t/helper/test-string-list.c
> t/helper/test-line-buffer.c
> t/helper/test-urlmatch-normalization.c
> t/helper/test-wildmatch.c
>
> Also, these helpers seem to be related to index handling and could go into
> a new test-index helper:
>
> t/helper/test-dump-cache-tree.c
> t/helper/test-dump-split-index.c
> t/helper/test-dump-untracked-cache.c
> t/helper/test-index-version.c
> t/helper/test-scrap-cache-tree.c

This is an interesting proposal.  I could go one further and
say we have a single "t/helper/unit-test.c" that has series
of "t/helper/builtin/*.c" commands (using the same mechanism
as the builtin commands in git.exe).  The question then is
how much of the test logic and/or parameters go into the shell
scripts.

But again, all of that is outside my scope here.
Jeff

