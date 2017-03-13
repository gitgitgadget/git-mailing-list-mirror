Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D131FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdCMTNu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:13:50 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:36635 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdCMTNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:13:48 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2DJDXTL001297
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 13 Mar 2017 19:13:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v2DJDW8A012827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 13 Mar 2017 19:13:33 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v2DJDVFl008645;
        Mon, 13 Mar 2017 19:13:31 GMT
Received: from [10.175.235.212] (/10.175.235.212)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Mar 2017 12:13:31 -0700
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Junio C Hamano <gitster@pobox.com>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
 <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
 <xmqq7f3uuzuu.fsf@gitster.mtv.corp.google.com>
 <ee3f01f0-2dc1-f919-223c-dad6032fa396@oracle.com>
 <xmqqbmt5t83o.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <2ec3df43-6ca6-9642-89b9-b118c60a62fc@oracle.com>
Date:   Mon, 13 Mar 2017 20:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmt5t83o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2017 18:11, Junio C Hamano wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
>
>> However, I think it's more useful to think of these testcases not as
>> "binary test that nobody knows what they are doing", but as "(sometimes
>> invalid) packfiles which tickle interesting code paths in the packfile
>> parser".
>>
>> With this perspective it becomes clearer that while they were generated
>> from the code, they also in a sense describe the packfile format itself.
>
> I do agree with these two paragraphs (that is why I said that
> continuously running fuzzer tests on the codebase would have value),
> and I really appreciate the effort.
>
>> I did a few experiments in changing the code of the packfile reader in
>> various small ways (e.g. deleting a check, reordering some code) to see
>> the effects of the testcases found by fuzzing, and I have to admit it
>> was fairly disappointing. The testcases I added did not catch a single
>> buggy change, whereas the other testcases did catch many of them.
>
> In short, the summary of the above three paragraphs is that we still
> do believe the general approach of using fuzzer has value, but your
> experiment indicates that data presented in the patch in this thread
> weren't particularly good examples to demonstrate the merit?

Correct.

I thought a priori that the testcases found by AFL would work well as a
regression suite in the face of buggy code changes, but this turned out
not to be the case in practice when I tried introducing bugs on purpose.

The testcases would still have value for the following purposes:

- as a seed for continued fuzzing (as the fuzzing effort would not have
to start over from scratch)

- as a way to quickly find an input that reaches a specific line of code
without having to manually poke at a packfile

- as a basis for writing new testcases with specific expected results


Vegard
