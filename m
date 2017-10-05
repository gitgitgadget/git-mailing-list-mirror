Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586291FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJEVWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:22:04 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:63600 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdJEVWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:22:03 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y7QhB2Dx6z5tlD;
        Thu,  5 Oct 2017 23:22:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D1B82120;
        Thu,  5 Oct 2017 23:22:01 +0200 (CEST)
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
 <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
Date:   Thu, 5 Oct 2017 23:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2017 um 21:33 schrieb Stefan Beller:
> On Thu, Oct 5, 2017 at 12:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> +git-post(1)
>> +===========
>> +
>> +NAME
>> +----
>> +git-post - Apply a commit on top of a branch that is not checked out
> 
> Contrasted to:
>    git-cherry-pick - Apply the changes introduced by some existing commits
> Some questions on top of my head:
> * Do we want to emphasize the cherry-pick to say checked out?

Maybe. Maybe "cherry picking" is sufficiently clear that it is not needed.

> * Is it a good design choice to have a different command, just because the
>    target branch is [not] checked out?

I would not want to make it a sub-mode of cherry-pick, if that is what 
you mean, because "cherry picking" is about getting something, not 
giving something away.

> * Naming: I just searched for synonyms "opposite of cherry-picking" and
>    came up with cherry-put, cherry-post, target-commit

With command line completion, we have to type 'git cherr<TAB>-<TAB>' 
currently. If we add another command that begins with 'cherry-', another 
<TAB> is needed. Therefore, I do not want to use a name starting with 
'cherry-'.

> * What was the rationale for naming it "post" (it sounds very generic to me)?

Yes, it is generic, but I did not find a better word that means "give 
away" a commit. Perhaps "tack"?

> * Does it play well with worktrees? (i.e. if a worktree has a branch checked
>    out, we cannot post there, or can we?)

Good point. It should be forbidden, but there are no safety checks, 
currently.

>> +EXAMPLES
>> +--------
>> +
>> +Assume, while working on a topic, you find and fix an unrelated bug.
>> +Now:
>> +
>> +------------
>> +$ git commit                                   <1>
>> +$ git post master                              <2>
>> +$ git show | git apply -R && git reset HEAD^   <3>
>> +------------
>> +
>> +<1> create a commit with the fix on the current branch
>> +<2> copy the fix onto the branch where it ought to be
>> +<3> revert current topic branch to the unfixed state;
>> +can also be done with `git reset --keep HEAD^` if there are no
>> +unstaged changes in files that are modified by the fix
>> +
>> +Oftentimes, switching branches triggers a rebuild of a code base.
>> +With the sequence above the branch switch can be avoided.
>> +That said, it is good practice to test the bug fix on the
>> +destination branch eventually.
> 
> This is a cool and motivating example.

Thanks. Another use case is when you receive a patch to be applied on a 
different branch while you are in the middle of some work. If it can be 
applied on the current branch, then you can post it to the destination, 
rewind, and continue with your work.

>> +BUGS
>> +----
>> +
>> +The change can be applied on `dest-branch` only if there is
>> +no textual conflict.
> 
> This is not a bug per se, it could be signaled via a return code that
> the posting was unsuccessful.

Oh, it does so return an error. But there are some cases that one 
expects that work, but where git-apply is not capable enough.

-- Hannes
