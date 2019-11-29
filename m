Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22120C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0320869
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfK2Nb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:31:27 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59968 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2Nb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 08:31:27 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iagMl-0000a2-6H; Fri, 29 Nov 2019 13:31:24 +0000
Subject: Re: git-rebase produces incorrect output
To:     Pavel Roskin <plroskin@gmail.com>, git@vger.kernel.org
References: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <eadb7c7e-5c8c-7e0b-2be0-ddc31d6ff7d4@iee.email>
Date:   Fri, 29 Nov 2019 13:31:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/11/2019 08:21, Pavel Roskin wrote:
> Hi!
>
> I've discovered an issue with "git rebase" producing a subtly
> incorrect file. In fact, that files even compiled but failed in unit
> tests! That's so scary that I'm going to stop using "git rebase" for
> now. Fortunately, "git rebase --merge" is working correctly, so I'll
> use it. Too bad there is no option to use "--merge" by default.
>
> The issue was observed in git 2.23 and reproduced in today's next
> branch (2.24.0.449.g4c06f74957) on up-to-date Fedora 31 x86_64.
>
> I've created a repository that demonstrates the issue:
> https://github.com/proski/git-rebase-demo
>
> The branch names should be self-explanatory. "master" is the base,
> "branch1" and "branch2" contain one change each. If "branch1" is
> rebased on top of "branch2", the result is incorrect, saved in the
> "rebase-bad" branch. If "git rebase -m" is used, the result is
> correct, saved in the "merge-good" branch.
>
> The files in "rebase-bad" and "merge-good" have exactly the same lines
> but in a different order. Yet the changes on branch1 and branch2
> affect non-overlapping parts of the file. There should be no doubt how
> the merged code should look like.
>
> I believe the change on branch2 shifts the lines, so that the first
> change from branch1 is applies to a place below the intended location,
> and then git goes back to an earlier line to apply the next hunk. I
> can imagine that it would do the right thing in case of swapped blocks
> of code. Yet I have a real life example where it does a very wrong
> thing.
>
> Indeed, "git diff origin/branch2 origin/rebase-bad" and "git diff
> origin/branch2 origin/merge-good" both produce diffs of 9957 bytes
> long, different only in the order of the hunks.
>
> Another interesting data point - "git rebase --interactive" is working
> correctly.
>
Which specific lines is this on?

Using the Github compare facility [1], I see multiple changes, some of 
which are probably just noise from the example.
  https://github.com/proski/git-rebase-demo/compare/merge-good...rebase-bad

Philip

[1] 
https://help.github.com/en/github/committing-changes-to-your-project/comparing-commits-across-time
