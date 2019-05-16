Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B8C1F461
	for <e@80x24.org>; Thu, 16 May 2019 12:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEPMMR (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 08:12:17 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:16057 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 08:12:16 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id RFF6h12V6draxRFF6h104F; Thu, 16 May 2019 13:12:13 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=KeO95FaKZyvkMel1GBsA:9 a=QEXdDO2ut3YA:10
Subject: Re: Feedback on git-restore
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Poughon Victor <Victor.Poughon@cnes.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
 <20190515103031.GA29149@ash> <xmqq7ear5egz.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d8fd0d06-ec83-941f-c29f-2fea0efb6fd3@iee.org>
Date:   Thu, 16 May 2019 13:12:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq7ear5egz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKj0s784i/d/NE/tfgS/FLsIWfdo6/91PkM4tW/2RmmBt0Nvuraoi60WNULW8ha/IMRxq/tG5hhjJq/FWo9KGo7KlxGg5DatDML0w9yQzly6B+Sd82Kb
 +JM5ToDnXpqMcSfDiLHLqQuv1A0qMs6fu5RV/BAaqc/TQ2fdMxobnmLNem+UaCQAiDke4T3gPpGuqTmqjOpzOCXYZGpHBXyGXmHVVmGQGkb7tQz9JYBpiw7R
 DkUPEX0xkNgTTz85BEezDnaXRKI0Y6N+XLPEmI2Vvvc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05/2019 03:18, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I think it depends on whether use actively use the index, or you
>> mostly ignore it and always do "git commit -a" and friends.
>>
>> When you do use the index, the "worktree <-> index <-> HEAD" is the
>> three stages that you are aware, in that order, and restoring from the
>> "next" stage is expected.
>>
>> It does feel natural for me that we "restore worktree from the index"
>> and "restore index from HEAD". But maybe I'm just too used to the old
>> way of thinking? Let's see what other people say.
> I am somewhat sympathetic to unexperienced users who do not "get"
> Git here, but because I still think you cannot make effective use of
> Git without understanding the workflow using the index as an "extra"
> level sitting between the working tree and the commits, I think it
> is a learning experience worth investing in for a new user to get
> used to the way of thinking you showed in the above paragraphs.
I would agree.

"the Index" is grossly under-documented and explained. I still don't 
have a proper understanding of all the multiple Nuances regarding the 
Index concept. Only a moment ago I was reading a thread that talked 
about having multiple indexes and the wrong one being referenced or locked.

I tend to map the Index to an old-fashioned 'out-box' on the corner of 
one's desk (from the days when everything was paper and cc really meant 
a carbon copy made with carbon paper). One would work on a document and 
when 'finished' place it in the out-box, which also acted as a 
work-in-progress (wip) box. Only later would a secretary/mail-person 
come around to see what needed filing/sending.

The fact that there can be many indexes, with multiple stages (all 
un-named) is a further source of confusion. For the average user, the 
only visible artefacts are those in the file system, and perhaps the 
crisp memory of the last commit. So I can see where Victor is coming 
from. I don't think we should be solely relying on the experience of 
user mistakes for their learning.

Maybe we need a `git index` command to make it far more visible to 
average users (or `git staging-area --show`, with a --cached option ;-).
>> This is also consistent with other commands, for example "git diff
>> --staged/--cached" compares the index and HEAD and "git diff" compares
>> worktree and the index. You would need extra effort e.g. "git diff
>> HEAD" to compare the worktree and HEAD.
> Exactly.
>
>> This --index vs --staged was discussed and --staged is a compromise.
>> The problem is --index means something different in existing
>> commands. It specifies that you want to target both the index _and_
>> worktree. --cached on the other hand only targets the index [1].
>>
>> It's confusing, yes. But --index/--cached is part of Git and we cannot
>> just ignore our baggage and redefine --index to "just index".
> Another thing worth pointing out here may be that a user would stop
> feeling it a baggage once the index-centric way of thinking sinks
> in.  Because the index is so central to the local use of Git
> workflow (i.e. "I am just cloning and pulling from the outside world
> to fllow along" does not count), "just the working tree and not the
> index" mode is an anomaly, until/unless you start talking about
> going backwards (e.g. "I've smudged my working tree by mistake, and
> need to recover by copying something out to it", which is the mental
> model of "restore").
>
> 	Side note: while at the mechanical level what it does is an
> 	equivalent to what "checkout -- <paths>" does, the mental
> 	models are different.  "checkout" is still a way to move
> 	forward "I need the contents of these paths in my next
> 	commit to look like those in that tree-ish, so copy them out
> 	to the working tree (to e.g. compile test) and also to the
> 	index (for e.g. the ease of committing after testing is
> 	done)".
>
>> So the compromise is we leave --index/--cached alone and gradually
>> move to the --staged/--worktree combo (for other commands as well).
> I think what is truly new and valuable is the "working tree only,
> bypassing the index" mode, but I am not sure if we want to always
> force us to say both when we want to affect both the index and the
> working tree, as the index is still central to the local workflow.
> I am not sure if there is a wide agreement with such a "gradually
> move to" plan.
>
> Also, when you want to only affect the indexed contents, wouldn't
> existing "--cached" suffice?
>
> IOW, I do not mind --staged as a synonym for --cached, and --worktree
> as a useful addition, but I do not think these new pair should replace
> the existing ones.
If the Index is central it need to be to get out from behind the 
curtain. Just sayin'.

--
Philip
