Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F8F1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 11:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfBALI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 06:08:59 -0500
Received: from siwi.pair.com ([209.68.5.199]:23781 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBALI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 06:08:59 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 56F493F40F0;
        Fri,  1 Feb 2019 06:08:58 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2BF5C3F40EB;
        Fri,  1 Feb 2019 06:08:58 -0500 (EST)
Subject: Re: [PATCH v4 14/14] trace2: t/helper/test-trace2, t0210.sh,
 t0211.sh, t0212.sh
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <8d47cd71ede3fd4e932e26756ef8f3f82b41d659.1548881779.git.gitgitgadget@gmail.com>
 <20190131232851.GD10587@szeder.dev>
 <xmqqtvhoz96z.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <75c87033-0e1f-b119-5856-44a8c91a675b@jeffhostetler.com>
Date:   Fri, 1 Feb 2019 06:08:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvhoz96z.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 6:41 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> On Wed, Jan 30, 2019 at 12:56:34PM -0800, Jeff Hostetler via GitGitGadget wrote:
>>> Create unit tests for Trace2.
>>
>>> diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
>>> new file mode 100755
>>> index 0000000000..517d5514df
>>> --- /dev/null
>>> +++ b/t/t0212-trace2-event.sh
>>> @@ -0,0 +1,234 @@
>>
>>> +test_expect_success 'event stream, return code 0' '
>>> +	test_when_finished "rm trace.event actual expect" &&
>>> +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
>>> +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
>>> +	sed -e "s/^|//" >expect <<-EOF &&
>>> +	|VAR1 = {
>>> +	|  "_SID0_":{
>>> +	|    "argv":[
>>> +	|      "_EXE_",
>>> +	|      "trace2",
>>> +	|      "004child",
>>> +	|      "test-tool",
>>> +	|      "trace2",
>>> +	|      "004child",
>>> +	|      "test-tool",
>>> +	|      "trace2",
>>> +	|      "001return",
>>> +	|      "0"
>>> +	|    ],
>>> +	|    "child":{
>>> +	|      "0":{
>>> +	|        "child_argv":[
>>> +	|          "_EXE_",
>>> +	|          "trace2",
>>> +	|          "004child",
>>> +	|          "test-tool",
>>> +	|          "trace2",
>>> +	|          "001return",
>>> +	|          "0"
>>> +	|        ],
>>
>> Just curious about the vertically aligned '|'s: are they there to
>> circumvent 'git diff's big red whitespace warnings on these deeply
>> indented lines?
> 
> I suspect that the reason is some of the lines have 8-spaces or more
> after '|', that can be tabified, but when tabified, <<-EOF will strip
> that second and subsequent tabs.
> 

Yes, the TAB BAR prefixes are to avoid the red whitespace warnings
and indicate the exact whitespace in actual output and avoid the
effects of the <<-EOF.  This technique has been used before in other
tests.  See t0019 and t1502.

Jeff


