Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94179C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36630207F7
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgK3UT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:19:29 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:44604 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgK3UT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 15:19:29 -0500
Received: from client3368.fritz.box (i5C746518.versanet.de [92.116.101.24])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 5EBEA3C1F19;
        Mon, 30 Nov 2020 21:18:47 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: use gray selection background for inactive text widgets
Date:   Mon, 30 Nov 2020 21:18:36 +0100
Message-Id: <20201130201837.19091-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.21.g59e7d82785.dirty
In-Reply-To: <20201130180827.2oimhr3vmjq7tzaq@yadavpratyush.com>
References: <20201130180827.2oimhr3vmjq7tzaq@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.11.20 19:08, Pratyush Yadav wrote:
> On 30/11/20 03:41PM, serg.partizan@gmail.com wrote:
>> On Sun, Nov 29, 2020 at 18:40, Stefan Haller <stefan@haller-berlin.de>
>> wrote:
>>> After spending quite a while single-stepping through lots of Tk code, I
>>> found the reason. On Mac, disabled text widgets simply don't draw the
>>> selection background. [1]
>>>
>>> I can see three options for solving this:
>>>
>>> 1) Don't use "state focus" and "state !focus" on the text widgets, but
>>>    instead set the selection color manually using "text conf sel
>>>    -background". Disadvantage: have to calculate the disabled color
>>>    using a heuristic like I did for the file lists in my v2 patch.
>>>
>>> 2) Don't use "configure -state disabled" to make the diff text widget
>>>    read-only; instead, use one of the other methods from [2].
>>>    Disadvantage: quite a big change, and seems complex to me.
>>>
>>> 3) Enable the the diff widget when it loses focus, and disable it again
>>>    when it gets focus. I tried this in a quick prototype, and it works
>>>    very well. It just *feels* wrong to enable a read-only text widget
>>>    while it is unfocused; but I couldn't find any situation where it
>>>    would behave wrong, because as soon as you try to interact with it,
>>>    the first thing that happens is that it gets disabled again.
>>>
>>> I tend towards option 3, because it's reasonably simple and works. I'll
>>> work on a patch tomorrow unless anybody has objections.
>>>
>>
>> I don't like any of this options, as it makes code complicated. I personally
>> would prefer to not implement this feature at all, but that's just me.
>
> That is my first thought as well. All 3 alternatives are less than
> ideal. I don't think the problem is big enough to warrant adding hacks
> like this. They will come back to bite us sooner or later.
>
> If you _really_ want to fix this, maybe try convincing the Tk devs about
> fixing it.

Yeah, maybe. Just for the record, here's a patch that does it (in the next
message), and frankly, I don't think it's so bad. I do think it's enough of an
improvement that it's worth having. I guess I'll have to maintain it in my local
build if you don't like it.

-Stefan
