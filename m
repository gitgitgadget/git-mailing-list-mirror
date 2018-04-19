Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16371F424
	for <e@80x24.org>; Thu, 19 Apr 2018 09:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDSJRn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 05:17:43 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:13713 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDSJRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 05:17:42 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 95hEfjNg8LjjA95hFfWsES; Thu, 19 Apr 2018 10:17:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524129461;
        bh=kvOKs0hegcoocIG3MXd8okGLwqfTGC12Oh7DGvW/ayY=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GAwXIY7EIsStyrdoFD4KFx9t4+R0TxlIPZwQoO8BR+nkr2AXwA6IfBouD5++dBkgg
         Du/FGbhflp8329MiGrWN+1w/DsBO1O/Upe0MtuVUeGU45cV2z8/Q8F+BI1ha5rTjQY
         ELQSw+98d9DpJ2nhasPaMVFBawiNiR92EB4wdLZs=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=412aXg1qx79Wy9O4sIwA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <f56b84fa-9286-3a7b-fc5b-2307c9ff5b5e@philandanna.no-ip.org>
 <nycvar.QRO.7.76.6.1804141444060.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <ba17074b-865e-32ba-908d-0d94bedc50ad@talktalk.net>
Message-ID: <041aabb4-4e61-30a1-2ab0-3ae1ddd47c38@talktalk.net>
Date:   Thu, 19 Apr 2018 10:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba17074b-865e-32ba-908d-0d94bedc50ad@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAx2hm+E2uog78J1z5HYBzeakKWuGZreYfTREFHPqB38KGpBEhnJ4s8T4dwcgqsu1CH9rqqjBboCWUJI/yRPvI0yjkJcMpX/pgZM68sUjm41Xld9U7tO
 0/m4U64suYStHS8Ht25vPRfnHl6qjQez4kpn6WESKfrY2MnOgtK+Xj5uu/tSLYGp32x4SwEiXQqzFVST/lj5fLXnzroTJiAbyQP/FzY1v8XKoB31MhhGBox/
 3uniPbk+sDaR00y7gcviAuBAHbCG9SCl28vltpoCoVbMgRcAuilVxe657RncQgl2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04/18 10:48, Phillip Wood wrote:
> On 14/04/18 14:11, Johannes Schindelin wrote:
>> Hi,
>>
>> On Sat, 14 Apr 2018, Phillip Wood wrote:
>>
>> FWIW I agree with Hannes' patch.
>>
>>> I think 'git am' probably gives all patches the same commit time as well
>>> if the commit date is cached though it wont suffer from the time-travel
>>> problem.
>>
>> I thought that `git am` was the subject of such a complaint recently, but
>> I thought that had been resolved? Apparently I misremember...
> 
> I had a quick look and couldn't see anything about that, it looks to me
> like it just calls commit_tree() and only does anything to change the
> default commit date if '--committer-date-is-author-date' was given.

Ah you were right, I just didn't look far enough back in the history
.(it's a shame it calls reset_ident_date() in a different function to
the one that creates the commit otherwise I would probably have noticed
it when I wrote the original patches)

Best Wishes

Phillip

> 
> Best Wishes
> 
> Phillip
>> Ciao,
>> Dscho
>>
> 

