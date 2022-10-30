Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B17C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 15:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJ3PqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ3PqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 11:46:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CCB1F2
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 08:46:08 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1opAVf-0005hi-AP;
        Sun, 30 Oct 2022 15:46:06 +0000
Message-ID: <95d2474c-4f74-414d-4aef-e46f736d21c5@iee.email>
Date:   Sun, 30 Oct 2022 15:46:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Maybe default Commits History Simplification could be more
 sensible
Content-Language: en-GB
To:     Laurent Lyaudet <laurent.lyaudet@gmail.com>, git@vger.kernel.org
References: <CAB1LBmsxiRHRpOibHC2c_LLAn-QSQ+qeaKF0TxQ2y8mBqTXoNQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAB1LBmsxiRHRpOibHC2c_LLAn-QSQ+qeaKF0TxQ2y8mBqTXoNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent,
On 29/10/2022 15:53, Laurent Lyaudet wrote:
> Hello,
>
> From here :
> https://git-scm.com/docs/git-log#_history_simplification
> I read :
>> Default mode
>> Simplifies the history to the simplest history explaining the final state of the tree.
>> Simplest because it prunes some side branches if the end result is the same (i.e. merging branches with the same content)
> But I am kindly questioning if the "explaining the final state of the
> tree." is correct.

Importantly here, we have that a commit is a "snapshot" (of the tree),
not a 'diff'. Despite all attempts (often within Git) to the contrary, a
commit is never 'just a diff', though it's easy to be misled.
> Because I had the following case :
>
> If :
> - commit 1 modifies some lines of file f on a branch b,
> - then commit 2 modifies some of the same lines of f on master,
> - and commit 3 revert commits 2,
> -  and then commit 4 merges b on master,
> then without --show-pulls, with git log on file f you see first 3 commits only ;
> and there is no way you can apply these 3 commits

Here, we have that distinction between the snapshots [i.e. the tree
states], and the [false] expectation that commits are [just] diffs that
can be applied.

>  in sequence,
> as depicted, and obtain the master's current state.
>
> When you use git log on a branch, you expect the default :
> - to give you all that happened to your branch,

If it was "all" the commits, it wouldn't be a simplification.. ;-)

> - or to give you a list of commits that applied successively explains
> the current state of the branch.

If we swap that to being .. a list of commits that can be diff'd to
explain...,
then it may be a better statement about the simplification.. ?
> I know that with trees a sequence of commits is not sufficient.
> But it would be a good property of default history simplification that
> your current branch state can be obtained with the first parent
> subsequence of displayed commits.
>
> Currently, default history simplification for git log on some branch b
> also gives merges of branch b on branch b2, if later on branch b2 is
> merged back on branch b.
> To me this merge commits are less interesting than the merge commit of
> branch b2 on branch b at the end.
>
> I assume that the simplification of merge commits was intended for the
> simple case :
> - create branch b2 from branch b1
> - n commits on branch b2
> - merge branch b2 on b1
> If no modification was made on b1 during that time, I agree that the
> merge commit of b2 on b1 is not interesting.
> In that case, it could explicitly say it displays commits on other
> parents that could have been automatically rebased.
> Like :
> commit hxhxhxhxhxh
> date
> done on branch b2
> merged on branch b1 at date, could have been automatically rebased
> Message : It was a nice commit
> ...
>
> But in the case, some common file was touched on b1 during that time,
> then it should give the final merge commit. (Solution 1)
> (I said touched instead of modified because of the revert.)
> Or it should also simplify and remove the commit and its revert on b1.
> (Solution 2)
> I would prefer either Solution 1 or Solution 2 to the current default.

As I understand it, the defaults are, effectively, set relative to the
needs of the Linux project, for which it was designed.
> Many UIs above git use default history simplification.
> Github for example uses default history simplification.
> And you cannot customize the commands used with options in these UIs.

That sounds useful, but is in the hands of those 'forges'.
> So I hope you will find that having better default is an important topic.
>
> Best regards,
>     Laurent Lyaudet
There is a github repo https://github.com/ChuckTest/git-history-test.git
[1] that can be used to explore the History Simplification man page
example with files foo, quux and side going through all the different
TREESAME dances shown in the manual.

I have a side project to see if such repos that demonstrate the man page
example can be brought into the main Git 'documentation'.

Note that the --graph option also brings in some options as well.

--
Philip


[1] https://groups.google.com/g/git-users/c/n8Rj-YBUJEw/m/S-ADI3sQCAAJ
