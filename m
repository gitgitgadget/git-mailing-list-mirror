Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C365A1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 10:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeIMP3V (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 11:29:21 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53186 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeIMP3V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 11:29:21 -0400
Received: from [192.168.2.201] ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id 0OjegeynRdJAe0OjegxyVM; Thu, 13 Sep 2018 11:20:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536834031;
        bh=kB6vH3EfXTQ+NEkAJj86k/aiFt2Own0RCSBt/nL5dLY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eAjFjwMQF1xDjfVCpbiIXjhuk0fJ7T2JXJswu5AoFHtY7eST+wln34M67HBrYSCL1
         vvnyzUgykNT+NUMBZclEGu9t+rkZcM59Xfr+XYPa+RZzY4c8Ku4MDMeJ9y9nX4xUwc
         vliiVcXf6AIA5P72AJraOG4lIUq2rI6tNQHD1ivw=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=N659UExz7-8A:10 a=nN7BH9HXAAAA:8
 a=tXJ75voj_gphT1wQjx8A:9 a=pILNOxqGKmIA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
To:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
 <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
 <20180903190114.GC17416@vis>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
Date:   Thu, 13 Sep 2018 11:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180903190114.GC17416@vis>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIGg/dRvtvbSwX9BEh5Qcf9e+cD8CuJd7XQp/66d/TMk5Yr0vjkfj0zf9aLfoZ/UYRq83aqBhEJJoZ9JJyqH9pd6QUQqf+kK0e+znePfRP26Pi9NVSEY
 AdHyo1SXQSAotA95p5YDv2rWYwEMAovVbO5l/d+bpG0jlWt30/rcplXM7g4VnRFOUOuo9Z/7r5ZFeYHYHZsb3gsf5loYKOHshFLZwo5vWjGikQPLUz/xumNt
 /rmJJSEXHaHDMxyR7Gcv4qXNdLVDS/xev6kU7IVlGYPbI+p4IdXtjw3UbFYD67ma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jochen

On 03/09/2018 20:01, Jochen Sprickerhof wrote:
> Hi Phillip,
> 
> * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
>> When $newhunk is created it is marked as dirty to prevent
>> coalesce_overlapping_hunks() from coalescing it. This patch does not
>> change that. What is happening is that by calling
>> coalesce_overlapping_hunks() the hunks that are not currently selected
>> are filtered out and any hunks that can be coalesced are (I think that
>> in the test that starts passing with this patch the only change is the
>> filtering as there's only a single hunk selected).
> 
> Agreed here. It would be enough to include the first hunk in the test to
> make it fail again. Still I would see the patch as going in the right
> direction as we need something like coalesce_overlapping_hunks() to make
> the hunks applicable after the edit.

Yes in the long term we want to be able to coalesce edited hunks, but I
think it is confusing to call coalesce_overlapping_hunks() at the moment
as it will not coalesce the edited hunks.

>> This is a subtle change to the test for the applicability of an edited
>> hunk. Previously when all the hunks were used to create the test patch
>> we could be certain that if the test patch applied then if the user
>> later selected any unselected hunk or deselected any selected hunk
>> then that operation would succeed. I'm not sure that is true now (but
>> I haven't thought about it for very long).
> 
> I'm not sure here. If we use the same test from t3701, do s(plit),
> y(es), e(dit), it would fail later on. Can you come up with an example?

I think that if you split a hunk, edit the first subhunk, transforming a
trailing context line to a deletion then try if you try to stage the
second subhunk it will fail. With your patch the edit will succeed as
the second subhunk is skipped when testing the edited patch. Then when
you try to stage the second subhunk it will fail as it's leading context
will contradict the trailing lines of the edited subhunk. With the old
method the edit failed but didn't store up trouble for the future.

>> We could restore the old test condition and coalesce the hunks by
>> copying all the hunks and setting $hunk->{USE}=1 when creating the
>> test patch if that turns out to be useful (it would be interesting to
>> see if the test still passes with that change).
> 
> We set USE=1 for $newhunk already, or where would you set it?

To match the old test it needs to be set on the hunks we've skipped or
haven't got to yet so they're all in the patch that's tested after
editing a hunk.

Best Wishes

Phillip

> 
> Cheers Jochen

