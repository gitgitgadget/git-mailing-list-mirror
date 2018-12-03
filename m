Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE7F211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeLCOcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 09:32:55 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35247 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeLCOcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 09:32:54 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id TpG6gZTjbAGVrTpG6gpQ7g; Mon, 03 Dec 2018 14:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1543847499;
        bh=eAwU//0ZIG3Jml9zi7gflwJi1++H5GRXCJQWZlYCUCg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aPuN04mk6Mdd8d8iO/YFiz3JdlNEp6/+lk2VjGlWecB99TGewqjZ7pRaj6SvDmh+o
         U8nvlih657yOnrl6/RD3kBju6fJT+XhObEMcBAyHkUibdeS7CG9+Go3+nIseL1sW45
         lMNs+/wMhmGUisqD+wUJlIZJUCQuPe7qtgz57yls=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=UTdqEtw7r-cg2FXCxrkA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ab4b0a47-858e-659f-f970-944b7c5313fc@talktalk.net>
Date:   Mon, 3 Dec 2018 14:31:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181201200209.GC29120@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIAuTRSHJ6c4uBsjINPrW9umrtr8miJYrBvliKBLlXAUjqq5ZzB5W07SORXhVIRw4WGk0OEF3Ggrc6mqksrILFOM0P6+OgFWUTlEYTUUaJmLbz+aTaBd
 +FuP4HjA2mQ+HyvzhGwO7dIdVHYcdan2iiKPt6HoENuorh3XnnLNyLevRpb7nnJbZK7+GbCaT7+L06Oquryush8lD1nMoHwEILLVqR0nZtMfIHX9kLQBy9Gu
 oMQFxkPJdqv5FkrlGmBob9DSG8jkmHz/5sMh+PSIzrQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/2018 20:02, Jeff King wrote:
> On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> 
>>>> Would it not make more sense to add a command-line option (and a config
>>>> setting) to re-schedule failed `exec` commands? Like so:
>>>
>>> Your proposition would do in most cases, however it is not possible to
>>> make a distinction between reschedulable and non-reschedulable commands.
>>
>> True. But I don't think that's so terrible.
>>
>> What I think is something to avoid is two commands that do something very,
>> very similar, but with two very, very different names.
>>
>> In reality, I think that it would even make sense to change the default to
>> reschedule failed `exec` commands. Which is why I suggested to also add a
>> config option.
> 
> I sometimes add "x false" to the top of the todo list to stop and create
> new commits before the first one. That would be awkward if I could never
> get past that line. However, I think elsewhere a "pause" line has been
> discussed, which would serve the same purpose.
> 
> I wonder how often this kind of "yes, I know it fails, but keep going
> anyway" situation would come up. And what the interface is like for
> getting past it. E.g., what if you fixed a bunch of stuff but your tests
> still fail? You may not want to abandon the changes you've made, but you
> need to "rebase --continue" to move forward. I encounter this often when
> the correct fix is actually in an earlier commit than the one that
> yields the test failure. You can't rewind an interactive rebase, so I
> complete and restart it, adding an "e"dit at the earlier commit.
> 
> How would I move past the test that fails to continue? I guess "git
> rebase --edit-todo" and then manually remove it (and any other remaining
> test lines)?

Perhaps we could teach git rebase --skip to skip a rescheduled command, 
it could be useful if people want to skip rescheduled picks as well 
(though I don't think I've ever had that happen in the wild). I can see 
myself turning on the rescheduling config setting but occasionally 
wanting to be able to skip over the rescheduled exec command.


Best Wishes

Phillip

> That's not too bad, but I wonder if people would find it more awkward
> than the current way (which is to just "rebase --continue" until you get
> to the end).
> 
> I dunno. I am not sure if I am for or against changing the default, so
> these are just some musings. :)
> 
> -Peff
> 

