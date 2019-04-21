Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A901220248
	for <e@80x24.org>; Sun, 21 Apr 2019 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfDUNxt (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 09:53:49 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:37068 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUNxt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 09:53:49 -0400
Received: from [192.168.1.12] ([92.21.144.249])
        by smtp.talktalk.net with SMTP
        id ICughWd78nuQZICughsvSH; Sun, 21 Apr 2019 14:53:46 +0100
X-Originating-IP: [92.21.144.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=Dgn57AdRJ25t4HaDIyq3iQ==:117
 a=Dgn57AdRJ25t4HaDIyq3iQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=F8CdE76t_GhyGNHZFFAA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Subject: Re: [PATCH v2] Give git-pull a --reset option
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, me@jramsay.com.au
References: <20190421040823.24821-1-alexhenrie24@gmail.com>
 <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
 <CAMMLpeRnwrcjn3UAgs5p532pf8=xAwBqh2qg7Cfqun6qsqD06w@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <e816c3d6-5948-5f4b-0a1e-67f7dee43f2d@iee.org>
Date:   Sun, 21 Apr 2019 14:53:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMMLpeRnwrcjn3UAgs5p532pf8=xAwBqh2qg7Cfqun6qsqD06w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFmxpgHtHpS/nGekzSfrZLYE60+j0jhFDoEJutQ9K3Oj9NwpJnPF+yKIRVytBlo303ZEVZ5fduh9ZLt4w9kUv3rN/jYimYSL3kCbKs41DezYmEPWmLnx
 hpoF1y5fLLgBW4aPnEJZxNoKs4gU3Lf46O6YdzB8z443HKKmYICa2g375s19mW2QHI5nn7nf9Q4Adeod/YQ45zD9fdmj0bCRhFqWBvNhB4ho19Lt8nTD6/S7
 WgroCUgoypZ2k+ytKrWBQNwd5j+yKr/g2sy4mLl4ZwyA7tIDgRRKj1atSikvUpxc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 21/04/2019 08:01, Alex Henrie wrote:
> On Sat, Apr 20, 2019 at 11:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>>> A common workflow is to make a commit on a local branch, push the branch
>>> to the remote, check out the remote branch on a second computer, amend
>>> the commit on the second computer, force-push back to the remote branch,
>>> and finally submit a pull request. However, if the user switches back to
>>> the first computer, they must then run the cumbersome command
>>> `git fetch && git reset --hard origin`.
This will be quite a common occurrence especially for personal repos on 
one of the hosting sites (GitHub, GitLab, etc), so we know that we are 
the only user of that repo.

I've certainly used that style of technique for Windows vs Linux machine 
transfers of Git work (when my old hack linux machine is functional:-).
>> Doesn't anybody sense there is a larger problem if such a workflow
>> is "common" in the first place?  In that sequence, when you come
>> back to the first repository there is no guarantee that what you are
>> losing is exactly what you are willing to lose and nothing else
>> (i.e. your earlier WIP you sent to the second repository, which was
>> further polished, making the earlier WIP you had here irrelevant).
I'd agree that a public/joint repository could have issues if a user 
blindly assumes that no one has cooperated with them and added more 
commits, but that becomes a social issue (plus worthy of a documentation 
mention!).

There are still a few blind spots in the functionality of Git regarding 
how users interact with their hosting provider, which is trying to be 
(from a user perspective) both a backup and an independent repo (side 
discussion at Git Merge). This would appear to be one of those cases 
where one is collaborating with no-one (oneself), but from two machines.

It may just be that we need to put aside `pull` because of its old 
semantics, and start with a fresh command name for the 'fetch + sort 
stuff out' for these use cases.
> You may be right. On the other hand, you're expected to think about
> what you're doing before running `git push --force` and clobbering a
> remote branch. Similarly, you would be expected to think about what
> you're doing before running `git pull --reset` and clobbering a local
> branch. It's actually easier to recover from accidentally clobbering a
> local branch than accidentally clobbering a remote branch because you
> can use `git reflog` to find the lost commits.
>
>> If the last "recovery at the first repository" step were "pull --rebase",
>> at least you would realize that you have the earlier WIP locally
>> that either
>>
>>      (1) conflicts with the more polished work that have been
>>          accepted at the upstream, in which case you can tell the
>>          rebase machinery to drop that earlier WIP _after_ making
>>          sure that it is only that stale WIP you not only are willing
>>          to but actively do want to lose that is getting discarded.
>>
>>      (2) replays cleanly on top of the updated upstream, which hasn't
>>          accepted your pull request made from the second repository
>>          with the more polished version, in which case you'd realize
>>          that you may have to work on the topic further.  And you
>>          have a chance to inspect what you ended up with before using
>>          "reset --hard" or "rebase -i" to discard what you no longer
>>          need.
> I understand that `git pull --rebase` followed by `git rebase --skip`
> is a safer workflow. I just feel like an option like `git pull
> --reset` should be there for users who know what they're doing, just
> like `git push --force` is available for users who know what they're
> doing.
>
>> At least, I think the longhand this attempts to replace, "fetch"
>> followed by "reset --hard origin" is better because of two reasons.
>> It is more explicit that the procedure is destructive, and more
>> importantly, it can allow to have (and we should encourage users to
>> make a habit to have) an extra step to inspect what the user is
>> about to lose with "git log origin.." after "fetch" but before
>> "reset --hard".
> I'd be happy to emphasize the destructive nature of this option by
> calling it `git pull --hard-reset` instead.
>
>> So I have a moderately strong suspicion that "git pull --reset"
>> promotes a wrong workflow and should not exist.
> It'd be great to get some feedback from other Git users, but in the
> end it's up to you and I trust your decision.
>
> -Alex
I though it worth chiming in that folks do use these simple dumb use cases.
--
Philip
