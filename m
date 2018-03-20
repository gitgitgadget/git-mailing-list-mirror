Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CF31F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeCTJ6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 05:58:21 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:29707 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeCTJ6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 05:58:17 -0400
Received: from [192.168.2.201] ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yE22eoVYawheayE23eplyI; Tue, 20 Mar 2018 09:58:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521539895;
        bh=77okogVq+dX5T0+Rc2wGwPyFvoPQl+ECXxkrxc4nE/A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BK9zsMlgBk/PnW+Q9gMdzPfpEHYzqn+ti7ImAaUix0tBLpBE7bxFQ9RRyAIUlQgFt
         nilTWxZk/zzC+JiKKC4BQJMyV2atITZqtaW/tT2nfcfcBO9/xp+t3PEqZDVK6kv2t/
         c4zZ80bAjtfle2bJJNp8XTxLkEsJE5ESg1h8QuoA=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=x8BiJvVRnUmoVPvM7kgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] log --graph corrupts patch
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
 <20180320060931.GE15813@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1e686ea0-90ac-f3f4-7bcf-6951c9253598@talktalk.net>
Date:   Tue, 20 Mar 2018 09:58:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320060931.GE15813@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK8S5Vc9EScMbLSUCMoj5GPMZObda399/g99yvxdVBS3GAcz35KjVbEX6XXTmdFDuYEZfyw5IMQ+5F9887ZnIg7BYwNqBiZgEpJpGwrhCrZ/HLMOtvit
 7JxV/IYGQMyu6BQfI3NKDiOqCCK8p84ccR78nyV+qyUq/+fO5KXilwUEI+ivlzUhyviFB9c6fvS4eAJZosRQsG/td+KzztnqPWwMIA21BU84PvanvVyUjnC/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/18 06:09, Jeff King wrote:
> On Mon, Mar 19, 2018 at 10:21:56AM +0000, Phillip Wood wrote:
> 
>> I've just been reviewing some patches with 'git log --graph --patch' and
>> came across what looked like a bug:
>>
>> | @@ -272,6 +272,9 @@ do
>> |       --keep-empty)
>> |               keep_empty=yes
>> |               ;;
>> |       --allow-empty-message)
>> | +     --no-keep-empty)
>> | +             keep_empty=
>> | +             ;;
>> |               allow_empty_message=--allow-empty-message
>> |               ;;
>>
>> However when I looked at the file it was fine, "--allow-empty-message)"
>> was actually below the insertions. 'git log --patch' gives the correct
>> patch:
>> [...]
>> git fetch https://github.com/phillipwood/git.git log-graph-breaks-patch
> 
> That's really strange. I can't seem to replicate it here, though; it
> looks correct with our without --graph. Knowing how the graph code is
> implemented, it seems like an unlikely bug for us to output lines out of
> order (but of course anything's possible).
> 
> Are you using any exotic filters for your pager? If you use "git
> --no-pager" does the problem persist?

Hi Peff, thanks for taking the time to check this, I had forgotten about
the pager. I'm using diff-highlight and it seems that is causing the
problems.

Thanks again

Phillip

> -Peff
> 

