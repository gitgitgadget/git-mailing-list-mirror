Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89874C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB620737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvatKUTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgDCJIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:08:25 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36163 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgDCJIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 05:08:24 -0400
Received: by mail-wm1-f42.google.com with SMTP id d202so6872949wmd.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scRZeV8r5xilCksRmuI8Fb1/4O2DuVDGKUtVbDCTfvo=;
        b=pvatKUTD3M53HNm/Hx3iYUmz9satejXLgs3DSUQ95rUGhoGEQU3U67qpSi94hpRvNJ
         MgA04eFKTzzRedF4dxa/AQTNMEjW+4ME5VUmvQf7p4tcFTpxknebS6CpZpy4EYeKVG0t
         b1JBayXrkpl9Xdrj/2NEQnBFLy1Z9llOT87gnTcCDMQvZYdV0gEsstlnx0ljRdExBAGM
         VaIfxSHvdHbqa1/Dwg5pe7+J2jSYT6gdmx7/R94gFwe0dYwUof895io0Q0z19Dw865vB
         J7sMyk4TfGwEdR42FJl2QGUraXeLIrQEEWgYRKtV2V6Q4ow1bWBUEAJcCXtLWM5OxYOa
         4kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=scRZeV8r5xilCksRmuI8Fb1/4O2DuVDGKUtVbDCTfvo=;
        b=YOehxAjHzlqAkv/rU64Vm6ipdkgbzoczAzGb1+cWoKYr/5nw1BstBlqBxNUxS6hWwk
         6/KVA55FMuBcGFGJBmOdiqAEUJtugO/KnDglaMQ6TyPvsfjw9ZsYbXUXYQzS2CCmVHY2
         QxE0qvclyG8PUwHD4DkCONHBxn0r1xKKN1I5dODq5nCA0gbNIzLWHdVHhhPzkjvn2zrQ
         7bMOval4M++ah6vJgaD3fRIUyT/RJs5cImmO+MVH9wmEBHIqrLs1siAg7DQRjlDDMCW6
         FjxNUKzOcrPsnjo1K4VVsYK0ddfsP6jRMyAXgFEbSVA9JQJwxL2hTadCytMz/DMlgXiu
         +xnw==
X-Gm-Message-State: AGi0PuZ9z5/IPZeUE281LKMhISWbjiHhVjLagU880hmpAAqfg/smzdy/
        gdClzTJmEP+AENntcjJMUxA=
X-Google-Smtp-Source: APiQypI7ZmSNuWsRK/gDp/h3XiAPP+o+QXNYpdGrlBJkcmS4Ky0mUGxnz9oe2xWvxr+ocyAjyQ3ZBg==
X-Received: by 2002:a1c:7f55:: with SMTP id a82mr8322992wmd.16.1585904901624;
        Fri, 03 Apr 2020 02:08:21 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j31sm1345904wre.36.2020.04.03.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 02:08:21 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase backend change: post-checkout hook is not ran by
 'merge' backend
To:     Elijah Newren <newren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
 <CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6c413abc-f48d-5a02-ac8b-09a0fa80b98d@gmail.com>
Date:   Fri, 3 Apr 2020 10:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 02/04/2020 17:58, Elijah Newren wrote:
> Hi,
> 
> On Thu, Apr 2, 2020 at 8:57 AM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm not sure if this has been reported yet (couldn't find it),
>> but I noticed a behavioral difference between the merge
>> and apply backends that is not mentioned in the documentation:
>> The 'apply' backend will run the post-checkout hook just after
>> moving HEAD to the commit we are rebasing onto;
>> this does not happen with the merge backend:
>>
>>      $ echo "echo \"Running post-checkout hook\"" > .git/hooks/post-checkout
>>      $ git checkout -b <branch1> <commit2>
>>      $ git rebase upstream/master --apply
>>      First, rewinding head to replay your work on top of it...
>>      Running post-checkout hook
>>      Applying: <commit1>
>>      Applying: <commit2>
>>      $ git checkout -b <branch2> <commit2>
>>      Successfully rebased and updated refs/heads/<branch2>

The merge backend runs `git checkout` to do the checkout and so does 
actually run the post-checkout hook. However the invocation is wrapped 
in run_command_silent_on_success() which means if the checkout is 
successful you don't see the output from the hook (and if the checkout 
fails you don't see the output from the hook because it is not run). You 
can verify this by changing the first line of your example to

$ echo "echo \"Running post-checkout hook\" >>/tmp/post-checkout" > 
.git/hooks/post-checkout

and examining /tmp/post-checkout

>> Cheers,
>> Philippe.
> 
> Interesting.  We had a report about the post-commit hook, but not
> about post-checkout.  From the description in the githooks manpage
> it's not clear to me that either rebase backend is correct or
> incorrect here, but they should at least be consistent.  Also, if
> rebase should call post-checkout, should cherry-pick?  If cherry-pick
> should, should commit or revert call it?

cherry-pick/revert don't check anything out

>  What about reset or merge?

again they are not checking out an existing commit.

However the 'reset' command for rebase -r is checking out an existing 
commit so if we decide to keep running the hook for the initial checkout 
then I think we should do it after those commands as well as there's 
nothing special about the initial checkout.

As for whether we should be running the hook I think it depends on what 
people are using it for. If they have a pair of pre-commit and 
post-checkout hooks to handle file metadata such as permissions and acls 
they might want to run the post-checkout hook so the file metadata gets 
updated but then there is no support for this when picking the rebased 
commits so it's arguably pointless to do it on the initial checkout.

If they are using it to be notified of branch switches then maybe we 
don't need to run it when checking out the onto commit (unless they want 
to know that we've switched to a detached HEAD). Though we would still 
want to do it for the branch switch in 'git rebase <upstream> <branch>'

As you can see I'm waffling and have no idea what's the right thing to do!

Best Wishes

Phillip


> This hook to me seems to be rather badly defined because If any
> operations other than checkout/switch should call it, then you've got
> various angles of weirdness if you don't include all the others too.
> (Also, digging through the history, the only reason that the apply
> backend called the post-checkout hook was because it was written as a
> script and invoked 'git checkout'.  But then someone noticed that the
> scripted version called the hook and thus ported it to the builtin.)
>  From another angle, maybe you could make the cutoff be only when HEAD
> changes which symref it points to (meaning rebase would only call it
> if you asked it to rebase a different branch than you were on), but
> that has its own weirdness too.  I think this hook is really weird,
> unless we restrict it to only the things already explicitly mentioned
> in the githooks manpage.
> 
> In any event, I guess that means we need to update this section of the
> rebase manpage:
> 
> """
> Hooks
> ~~~~~
> 
> The apply backend has not traditionally called the post-commit hook,
> while the merge backend has.  However, this was by accident of
> implementation rather than by design.  Both backends should have the
> same behavior, though it is not clear which one is correct.
> """
> 
> to also mention post-checkout, note that the situation about which
> backend calls this hook is reversed relative to post-commit, and again
> mention it's not clear which backend is correct.
> 
> My very rough opinion of the moment is:
>    * post-checkout should probably do as the manpage says, and only run
> for checkout/switch plus new worktree situations (worktree add/clone).
> rebase --apply should stop calling it.
>    * post-commit is horribly broken; it hardcodes an assumption of
> exactly one commit.  Also, it's a huge performance problem when things
> want to create multiple commits.  So, let's do as the githooks manpage
> suggest and call this hook from a direct "git commit" -- and _only_
> from there.  Remove it from rebase, cherry-pick, revert, etc.
> Normally, for consistency, I would say that merge should start calling
> that hook (it only creates one commit, and "git commit" is used to
> complete an interrupted merge anyway so why not uninterrupted ones),
> but merge can be called by rebase --rebase-merges right now so that
> pushes us back to the get it out of rebase side.  The hook is kinda
> broken anyway, so maybe limit exposure?
>    * Make a new post-batch-commit hook called by things that create new
> commits, but only call it once per operation (e.g. rebase and
> cherry-pick call it once rather than once per commit).  Have commit,
> merge, and revert all call this too.  Not sure what to do about things
> that change multiple refs simultaneously, e.g. fast-import (or things
> like it, e.g. filter-branch).
> 
> CC'ing Jonathan and Emily since they've thought a lot about hooks, and
> whom I thought might be making changes in this area[1][2].
> 
> 
> Elijah
> 
> [1] https://lore.kernel.org/git/20200116203521.GA71299@google.com/
> [2] https://lore.kernel.org/git/20200115215922.GI181522@google.com/
> 
