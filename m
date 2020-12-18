Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036BCC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C833123A7B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbgLRKgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:36:42 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:55470 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389021AbgLRKgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 05:36:42 -0500
Received: from client3368.fritz.box (i5C747512.versanet.de [92.116.117.18])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id D58283C01D9;
        Fri, 18 Dec 2020 11:36:00 +0100 (CET)
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
To:     Johannes Sixt <j6t@kdbg.org>,
        Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <1271e604-d016-1ddf-8370-49f5d3db44be@haller-berlin.de>
Date:   Fri, 18 Dec 2020 11:36:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thanks for testing! It's good to have people who care about details.


On 17.12.20 20:45, Johannes Sixt wrote:
> Am 01.11.20 um 18:05 schrieb Stefan Haller:
>> Do an automatic rescan whenever the git-gui window receives focus. Most other
>> GUI tools do this, and it's very convenient; no more pressing F5 manually.
>>
>> People who don't like this behavior can turn it off using
>> "git config gui.autorescan false".
>>
>> Stefan Haller (2):
>>   git-gui: Delay rescan until idle time
>>   git-gui: Auto-rescan on activate
>>
>>  git-gui.sh | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
> 
> I've been using these patches in the past days.
> 
> I am still a bit ambivalent on whether I like the behavior. I do switch
> among windows *a lot* and there is a short flicker on every rescan. And
> there is muscle memory...

Yes, the flicker is annoying. It also happens when you manually rescan
(F5) though, so it's not a new problem. You just see it more often now.
I didn't succeed to fix it yet, but I also didn't try very hard.

Another problem that's related and can be annoying is that the text
selection is lost on rescan; so if you select some lines because you
want to stage them, and then before staging you briefly switch back to
your editor to check something else, then you have to start over when
you come back. I guess this could be fixed by remembering the selection
on rescan, in a similar way how we remember the scroll position.

As for muscle memory, in my experience this is something that you
unlearn pretty quickly. On the contrary, I'm now having having trouble
using git gui on machines that don't have the patch, because I got so
used to relying on the window to always be up to date automatically.

For me, I have to say that the auto-rescan is a total game-changer, even
with all the problems that it still has. I don't want to do without it
any more.

> It is unclear which file is selected automatically when there are
> unstaged changes. But there is one misbehavior: after I have invoked the
> merge tool, resolved the conflict, and then switch back to Git GUI, the
> conflicted file is not selected anymore when it is not the first file in
> the list. That is *very* annoying.

I tried to reproduce this, but couldn't. It would be helpful if you
could post a more detailed reproduction recipe.

Another related aspect: if you select an untracked file and then trigger
a manual rescan, the file is no longer selected; it selects the first
tracked, modified file instead. I don't know why it does this, I find
this annoying. The auto-rescan doesn't have this behavior, it keeps the
untracked file selected, which I like.

> And then there is the following use-case. While Git GUI is not active
> (think Git GUI and Gitk side-by-side and Gitk active), I click on a
> particular file that is not at the top of the list; then Git GUI becomes
> active and rescans, but also forgets on which file I have clicked. But I
> expected the clicked-on file to become visible, which it doesn't, and I
> have to click again. This is mildly annoying.

Like Pratyush, I can't see why this should happen, and I can't reproduce
it on my machine (Mac). What system are you on?

-Stefan
