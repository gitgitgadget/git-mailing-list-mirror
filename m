Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70128C282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53320866
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+7aEkft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgAKOll (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:41:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgAKOlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 09:41:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so4446410wru.4
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PFXx6KeWVcBt68u7uFm9DHafBbpyCgjzjub6rcQDhaY=;
        b=Y+7aEkftV8W4fitYwzOzm/AEi+PTeGek8mKJ7rVW+28ESutJK8kVfwH8rhcZdLvP4Z
         KJkzsQxUGyjsiedhZ4+1la6Zz7ZHVZ7h5ARyd05DvJZkwuGNQmuX47pzM8jJ3eM27Yow
         ZLEdETSfRWTTMG4kUZc83NS08UVBE9hmmVqjyQEns1QYXjIUMPXu20b4oAvuWSxU9EcA
         /grvgbV4XmUfgQNoJdJ7nM87w8h3YHAQrHxH5Z/w1mTSJPyeJtPaCsEBauSO0+AkH40C
         sMZFgkrULbxcrgotXQtTSxM+hUKR5l9XC4zkiGeBSIXSSLUcvhcHnB6x7cFrs+71buR4
         0DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PFXx6KeWVcBt68u7uFm9DHafBbpyCgjzjub6rcQDhaY=;
        b=Kb9r0yrF5GFglJN7v6F1v5lhIgnwbcAk2UwjeJbUjuyd1t/hMG19i+8xS3djyfjtxq
         jD0hCqBnRyWnQ327pZceuUdgRUw1eXV0NniwjK3+Vu4RiLqpTetdryqEdsa5/tJDkHCB
         wXdLn8Q+9D5C3R8jLLTGTG7NFvQcXqnet+Q8kVkNlVXVwzTBTojxtZWZUPuyQnQFUzp+
         dm1QxgIE/roS2ii0JmbRhzqOlYy8DWpdzPDgUGiBUu1F+GcroYs3mfo77QC8CPEf+7F2
         y+ErFghnTU5sDc/MuoJejln07zMGUPZLdZ8MgQCXglYYqP+UnY4o/GINewcXHmpGbeBm
         WTpA==
X-Gm-Message-State: APjAAAUa6n8OjjSgmJggvEa9P2cBlXLon0L0/57mI1TRNG1xaEsD4c5r
        F+d9GkiT99mNMaCQZr4A6L6fU06wYNY=
X-Google-Smtp-Source: APXvYqwskwiUIJf/L0Bbxx1Je76oXabdk+uR/k0pILpRsrhX55UfkDylQlIHEvzvI4qamYIvysALQw==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr9587946wrq.72.1578753698561;
        Sat, 11 Jan 2020 06:41:38 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id a9sm6278611wmm.15.2020.01.11.06.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 06:41:38 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
To:     Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
Date:   Sat, 11 Jan 2020 14:41:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan & Elijah

On 11/01/2020 01:16, Elijah Newren wrote:
> Hi Jonathan,
> 
> On Fri, Jan 10, 2020 at 3:14 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> Hi,
>>
>> Elijah Newren via GitGitGadget wrote:
>>
>>> The am-backend drops information and thus limits what we can do:
>>>
>>>    * lack of full tree information from the original commits means we
>>>      cannot do directory rename detection and warn users that they might
>>>      want to move some of their new files that they placed in old
>>>      directories to prevent their becoming orphaned.[1]
>>>    * reduction in context from only having a few lines beyond those
>>>      changed means that when context lines are non-unique we can apply
>>>      patches incorrectly.[2]
>>>    * lack of access to original commits means that conflict marker
>>>      annotation has less information available.
>>>
>>> Also, the merge/interactive backend have far more abilities, appear to
>>> currently have a slight performance advantage[3] and have room for more
>>> optimizations than the am backend[4] (and work is underway to take
>>> advantage of some of those possibilities).
>>>
>>> [1] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
>>> [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
>>> [3] https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/
>>> [4] https://lore.kernel.org/git/CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com/
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>   Documentation/git-rebase.txt           |  2 +-
>>>   builtin/rebase.c                       |  4 ++--
>>>   t/t5520-pull.sh                        | 10 ++++++----
>>>   t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
>>>   4 files changed, 11 insertions(+), 8 deletions(-)
>>
>> Thanks for writing this.  We finally rolled this out to our internal
>> population at $DAYJOB and ran into a couple of issues:
> 
> Cool, thanks for testing it out.
> 
>>   1. "git rebase --am" does not invoke the post-commit hook, but "git
>>      rebase --merge" does.  Is this behavior change intended?
>>
>>      Noticed because jiri[1] installs a post-commit hook that warns
>>      about commits on detached HEAD, so this change makes rebases more
>>      noisy in repositories that were set up using jiri.

Perhaps that hook could learn not to warn if a branch is being rebased? 
git could be more helpful there by having a porcelain option to status 
that prints the branch name if we're rebasing (`git worktree --list` 
shows the branch correctly when it's being rebased but does not (yet - I 
have a patch to do it) mark the current worktree so isn't very helpful.)

> I've never used a post-commit hook or seen one in the wild.  Certainly
> wasn't intentional, but it's not clear to me if it's wrong or right
> either.  I don't see why it would make sense to distinguish between
> any of git rebase --am/--merge/--interactive, but it isn't too
> surprising that by historical accident the two rebase backends which
> happened to call git-commit behind the scenes would call a post-commit
> hook and the other rebase backend that didn't call git-commit
> wouldn't.

Looking through the history the am based rebase has never run the 
post-commit hook as am has its own set of hooks and the scripted version 
used commit-tree. The merge based rebase ran `git commit` which ran the 
post commit hook. The interactive rebase ran the hook until and I broke 
it in a356ee4659b ("sequencer: try to commit without forking 'git 
commit'", 2017-11-24) and after I fixed it in 4627bc777e ("sequencer: 
run post-commit hook", 2019-10-15). As it was broken for two years with 
no one noticing it can't be that popular.

> But the big question here, is what is correct behavior?  Should rebase
> call the post-commit hook, or should it skip it?  I haven't any clue
> what the answer to that is.

It's creating a new commit so I lean towards thinking it should run the 
post-commit hook. As an example I have a post-commit hook that prints a 
warning if a commit is created on a branch that is being rewritten by 
one of my scripts in another worktree. There are pre-commit and 
pre-rebase hooks to try and prevent that, but the warning is there as a 
last resort if those hooks are by-passed.

>>   2. GIT_REFLOG_ACTION contains "rebase -i" even though the rebase is
>>      not interactive.

If this is important to people I think it should be easy enough to set 
GIT_REFLOG_ACTION to the appropriate string in builtin/rebase.c (so long 
as it hasn't already been set by the user) rather than relying on 
sequencer.c to do it.

> Yep, as does --keep, --exec, --rebase-merges, etc.  There are lots of
> rebases which use the interactive machinery even if they aren't
> explicitly interactive.  I've never seen the "-i" in the reflog
> message defined, but clearly it has always been used whenever the
> interactive machinery was in play regardless of whether the rebase was
> interactive.  In that regard, I figured that --merge fit in rather
> nicely.  (And I noted the fact that reflog messages were different
> between the backends among the "BEHAVIORAL DIFFERENCES" section of
> git-rebase.txt).  But if others think we should just drop the -i (much
> as we did for the bash prompt), I'd be happy with that too.  If we go
> that route, I think I'd rather drop the -i in the reflog for all
> rebases, not just the
> using-the-interactive-machinery-but-not-explicitly-interactive ones.
> 
>>   3. In circumstances I haven't pinned down yet, we get the error
>>      message "invalid date format: @@2592000 +0000":
>>
>>          $ git rebase --committer-date-is-author-date --onto branch_K branch_L~1 branch_L
>>          $ git checkout --theirs file
>>          $ git add file
>>          $ git rebase --continue
>>          fatal: invalid date format: @@2592000 +0000
>>          error: could not commit staged changes.
>>
>>      This isn't reproducible without --committer-date-is-author-date.
>>      More context (the test where it happens) is in [2].
> 
> Interesting.  Do you happen to know if this started happening with
> ra/rebase-i-more-options, or did it just become an issue with
> en/rebase-backend?  I looked around at the link you provided and feel
> a bit confused; I'm not sure which test does this or how I'd
> reproduce.

I'm confused by the test as well. As ra/rebase-i-more-options only 
touched the sequencer then any bugs would only show up in this test 
(which runs a non-interactive rebase) once en/rbease-backend switched to 
that backend. It seems likely that ra/rebase-i-more-options is to blame.

Jonathan - do you happen to know if your users create empty commits at 
all? and if so what do they expect rebase to do with them (and any that 
become empty when they are rebased) - cf 
https://lore.kernel.org/git/<CABPp-BEH=9qejeqysHYE+AJ+JPaBympZizq-bx_OjArYFa4xUQ@mail.gmail.com>

Best Wishes

Phillip

>>   4. I suspect the exit status in the "you need to resolve conflicts"
>>      case has changed.  With rebase --am, [3] would automatically
>>      invoke rebase --abort when conflicts are present, but with rebase
>>      --merge it does not.
>>
>> Known?
> 
> Nope, but I would certainly hope that "you need to resolve conflicts"
> would result in a non-zero exit status.  If it doesn't, that sounds
> like a bug in the interactive backend that we need to fix.  I'll dig
> in.
> 
> 
> 
> Thanks for the reports!
> Elijah
> 
