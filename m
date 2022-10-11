Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA30C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJKOtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKOtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 10:49:06 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E67F5B078
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 07:49:05 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oiGZ5-0003uw-Ba;
        Tue, 11 Oct 2022 15:49:03 +0100
Message-ID: <637a5629-66cf-7429-afc2-92709825e66d@iee.email>
Date:   Tue, 11 Oct 2022 15:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
 <86355292-cb54-32c8-abf5-542fb4cf9ade@iee.email> <xmqqfsfx8akc.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqfsfx8akc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/10/2022 13:07, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Is there also a need to update SubmittingPatches to clarify the
>> distinctions between the generic name 'maint', the specific `maint-xx`
>> branches, and the symbolic ref linkages from `maint`.
> Not at all.  Perhaps you are thinking about MaintNotes, but even
> there, general public do not have to be concerned about maint-xx
> most of the time.  I myself would not be keeping branches for
> ancient maintenance tracks anywhere.  As the older maintenance
> tracks, other than the most recent ones, do not get topics graduated
> to 'master' merged down by me (even though topic branches that fix
> notable bugs may fork from an older version to allow motivated third
> party maintainers to merge them down to older maintenance releases),
> there is not really a reason to keep branches like maint-2.15 for
> daily operation.  Only when we need security updates that go back to
> older maintenance tracks, I may do
>
>     $ git checkout -b maint-2.30 v2.30.5
>     $ git merge cve-something-fix
>     ... edit release notes etc. ...
>     $ git commit -m 'Git 2.30.6'
>     $ git tag -s -m 'Git 2.30.6' v2.30.6
>
> but after that is done, there is no reason to keep an old branch
> like maint-2.30 lying around, other than to make it easier to
> prepare for v2.30.7 (as maint-2.30 will remember what tag was the
> latest on that particular maintenance track).
>
>> The descriptions give the impression there is just a single main branch,
>> with a singular name, and that was the end of it.
> And that is the correct world view for most of the  general public.
>
>     https://github.com/git/git/
>
> shows 'maint', 'master' ('main'), 'next', and 'seen' from the
> project code, plus 'todo' which holds an unrelated history that
> keeps track of maintenance tools and misc stuff.
>
> By the way, I do not personally have 'main' in my working
> repository.  The only trick I have to help folks who expect to see
> 'main' instead of 'master' is the push refspec to distribute the
> integration results to various repositories.  My 'master' is pushed
> to both 'master' and 'main' in destination repositories.
>
> The mirror/backup repository of my private working repository does
> have tentive branches, like the broken-out topic branches that are
> still active, which are pruned when they no longer are needed.
> Some maint-xx branches are also there but they are there not because
> they are necessary but because I just haven't bothered to clean them
> up ;-)
>
Thanks for the clarification.

My confusion about `maint` started quite a few years back and may be a
mixture of a number of different issues, or simply my misunderstanding.

I'm guessing here, but it may have been, that back then, that the maint
branch was a link to the relevant maint-xx, rather than a 'symref' and
that at that time the Git-for-Windows didn't really handle them, so
`maint` may not have shown for me (similar to how RelNotes is configured
in the Git repo).

It may also have been early confusion about remotes and their branches,
and the impression that I needed (or should expect) a local branch of
the same name and this wasn't happening (obvious in retrospect), so I
never found any `maint` in my repo.

The whole 'remote tracking branches' stuff took a long time to
understand and was non-obvious from my perspective. I suspect many
newbies have similar issues (e.g. the current thread
https://lore.kernel.org/git/DU2P194MB15841850A17436C7AE34C149E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM/T/#t)

--
Philip
