Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2128C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9111C60F6E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhIPTkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:40:35 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:42966 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhIPTke (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 15:40:34 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 516EE348A8;
        Thu, 16 Sep 2021 21:39:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 7212F3473C;
        Thu, 16 Sep 2021 21:39:11 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dBZ1it_FWOPV; Thu, 16 Sep 2021 21:39:11 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id C3610347E3;
        Thu, 16 Sep 2021 21:39:08 +0200 (CEST)
Subject: Re: Possible git bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
 <20210916124709.2824551-1-wesley@schwengle.net> <xmqqzgsctu10.fsf@gitster.g>
From:   Wesley Schwengle <wesley@schwengle.net>
Message-ID: <3b4270f9-6139-7007-301b-8a084f4336cf@schwengle.net>
Date:   Thu, 16 Sep 2021 15:39:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgsctu10.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=U7vs8tju c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8
        a=WT8wj7CcPzrvMoH3DZgA:9 a=QEXdDO2ut3YA:10 a=5NxO59_FqQjEf5CpAN6O:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/21 11:33 AM, Junio C Hamano wrote:

>> We are on a branch, we merge it into another branch.
>> We undo the merge because reasons.
>> Now we git rebase, without the upstream, because we've set it.
>> Fork-point is used now, because we haven't specified an upstream, but
>> we did set it and git merge-base decides, oh, we had those commits in
>> master but these where dropped so we drop them in this branch as well.
> 
> If you feel "It doesn't make sense to me", either
> 
>   - the behaviour does not make sense because it is simply buggy, in
>     which case, adding a sentence to the documentation and explaining
>     how not to use it is missing the point---don't you rather want it
>     to behave in a way that makes sense to you instead?
> 
> or
> 
>   - it appears as nonsense to you only because your understanding of
>     the behaviour is faulty but the feature is working correctly and
>     is not a bug, in which case, adding a sentence to the
>     documentation and explaining how not to use it is missing the
>     point---don't you rather want the existing documentation extended
>     to help you and other users to understand the behaviour better
>     first?
> 
> Between "buggy behaviour" and "bad documentation of a well-designed
> behaviour", I offhand do not know which side "--fork-point" is for
> this particular case, but I've always felt that it is a bad
> heuristic that should be used with care, and my gut feeling is it
> might be the third possibility: "bad heuristic that sometimes
> misbehave badly and that is unfixable".  If that is the case,
> perhaps the documentation should tell readers the unreliable nature
> of the option and warn them to double check the result before
> teaching them how to turn it off permanently.

I feel like it is a bad default, it caught me by surprise. Especially 
because in the reproduction path I wanted to explicit in my rebase 
action and this caused different behavior. After this was pointed out I 
read the man page because I thought `git rebase' and `git rebase master' 
was the same thing if that was configured as an upstream. It took me a 
while to figure this out, because I kept typing `git rebase' instead of 
`git rebase master' when quickly trying to find out why it wasn't 
behaving like it did earlier.

I'm clueless about "buggy behavior", "bad documentation of a well 
designed feature" or "bad heuristic that sometimes misbehave badly and 
that is unfixable". To me `git rebase' with a configured upstream should 
behave the same as `git rebase @{u}'. Only when adding --fork-point it 
should behave as it does currently. I'm not sure when I would want to 
use it, but I'm thinking people want it, otherwise it wouldn't be a default.

As for the patch. The reason why --fork-point is default I do not know, 
but how to disable it isn't documented and I think it should. It is 
hidden in the source code and the release notes of 2.31.0. It should be 
more visible. Which is the reason I submitted the patch.

Cheers,
Wesley

-- 
Wesley Schwengle
E: wesley@schwengle.net
