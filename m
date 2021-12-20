Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73622C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhLTTJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbhLTTJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:09:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B2C061401
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:09:09 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id s16-20020a17090a881000b001b179d3fbf3so408323pjn.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FvdR6kkvwGGatlqw5bzMyhulxGTevXAlqoR/HsgZ4rs=;
        b=P6GN4KCjeh+DAbGSywFBF3XIhcsWxXWanKGGFLqvqi2UdJpQ51Gxh0eMcqEnq74S6f
         9yGLG7oMokXm1EYuGtc6G001KD4pu8rTBA3zJEQysIYWNcoAjNgJ+Osx0r2J3ailnVoD
         igQiOwJsIl5wUf9oxsCOCdAAAW0TtNc8VRLWIkMpM5+3NTo9O6qTUVTWmib454nyzdZy
         WLW29wzs+XDkeck7LpZdGAeePidur4G+HNqknOZAco2D/EbwMmRsMiD4lwWwfbY8fSy+
         HxlM9CUlzke8UQJXSbpLyLtUJcAPDG75x+FfuYWCge3OqITX9m5y/InDa0a1T2U3ta0l
         62Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FvdR6kkvwGGatlqw5bzMyhulxGTevXAlqoR/HsgZ4rs=;
        b=hqULdPoB/Q2h5FwR9AbQ3/ehKgnNm/e6gLGtvrowaAzu1Alo9d/w0aBg3O8qTSl2mP
         gc5UgHfOD+xBx9VUvsZKYCEKSdvSKWHjXb30prWjNh+ZQVYsOjdoqkWoFcwP1jrOBaQD
         P7a1O2UQnlSFSkZmLqgc86vOcTdfgfo4gFOMvvP8R9bWlhvLhv/gSi+TDe98e0Ta7507
         4M8uC4YBN7vHocrRzZE7G9KA+W3lPkmHMu9rksv1JcrFgBK+PInGXAOy7dHEwfK9pf00
         iqi3S0YXECU9ChjfzOteulj/palw0UVxwA94jMIwFj+oZR5xnXqvjMSNf4i19FzD1yJM
         m1Eg==
X-Gm-Message-State: AOAM530aOX8MpisUInbJu4pzlTQVy5UBnZqT370RQrYDZfEfCbLKNJf7
        fgfhW6KBVV0hmz8FRHNa4IR3u8QDIUdy/Q==
X-Google-Smtp-Source: ABdhPJzQTJktmIlEc9cnT04N9PosyjnzKcnNN4UDMnKbDpyZyghRVjdD25pM6hydWgWZJejUEvJPvdUzB1iUgw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3a92:: with SMTP id
 om18mr426909pjb.159.1640027348492; Mon, 20 Dec 2021 11:09:08 -0800 (PST)
Date:   Mon, 20 Dec 2021 11:09:06 -0800
In-Reply-To: <xmqqwnk45aah.fsf@gitster.g>
Message-Id: <kl6lwnjzytyl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
 <xmqq35ms6pd3.fsf@gitster.g> <xmqqwnk45aah.fsf@gitster.g>
Subject: Re: [PATCH v5 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> This series implements branch --recurse-submodules as laid out in the
>>> Submodule branching RFC (linked above). If there are concerns about the
>>> UX/behavior, I would appreciate feedback on the RFC thread as well :)
>>>
>>> This series is based off js/branch-track-inherit.
>>
>> Sigh.
>>
>> When a series is labelled as "based off of X", I expect that the
>> series either apply on the tip of branch X I have, or it applies on
>> top of the merge result of branch X into 'master'.  It shouldn't be
>> forked at a random point on the 'seen' or 'next' branch, as you'd
>> end up depending on not just X but all the other topics that are
>> merged before X is merged to these integration branches.
>>
>> This seems not apply on either c99fa303 (config: require lowercase
>> for branch.autosetupmerge, 2021-12-14), which is the tip of the
>> js/branch-track-inherit topic, or 47e85bee (Merge branch
>> 'js/branch-track-inherit' into gc/branch-recurse-submodules,
>> 2021-12-15), which is a merge of that topic into 'master' I prepared
>> to queue the previous round of this topic the other day.
>
> Ah, I figured it out.
>
> These are based on the merge of the other branch into 'seen'.  I
> have (deliberately) merged js/branch-track-inherit and the previous
> round of this tipc in 'seen' next to each other.

Oh my goodness.. I'm sorry, I didn't mean to complicate matters like
this.

If it's alright with you, I'd like to check my understanding so that I
can avoid this mistake in the future.

What happened was that I got confused by [1], where it reads:

  [...]
  find the tip of js/branch-track-inherit from 'seen' [*]
  [...]

  [Footnote]

  * One way to do so would be:

    $ git fetch
    $ git show 'remote/origin/seen^{/^Merge branch .js/branch-track-inherit.}'

The commit that I got was the "merge of js/branch-track-inherit into
'seen'", but what you intended was the "merge of js/branch-track-inherit
into gc/branch-recurse-submodules"; I didn't realize that there might
have been more than commit matching that regex.

This makes much more sense in the context of your comment:

  That's OK; please do not ever rebase anything on top of 'seen' or
  'next'.

> And when these five are applied on top of that merge of the other
> topic into 'seen', we get an identical tree as the merge of the
> previous round of this topic into 'seen'.
>
> So unless you updated some commit log message, nothing is lost if I
> ignore this round.

I made some commit message changes. Unless you think it's a good idea, I
won't re-roll this to fix the issue.

> Just to save time for both of us the next time,
> plesae fetch from any of the public tree, find on the first parent
> chain leading to 'origin/seen' a commit labelled as "Merge branch
> 'gc/branch-recurse-submodules'", and check out its second parent,
> and what we have there.
>
>     $ git checkout "origin/seen^{/^Merge branch .gc/branch-rec}^2"
>     $ git log --first-parent --oneline origin/main..
>     35bb9f67f9 branch: add --recurse-submodules option for branch creation
>     ce3a710d42 builtin/branch: clean up action-picking logic in cmd_branch()
>     f368230ca9 branch: add a dry_run parameter to create_branch()
>     d77f8a125b branch: make create_branch() always create a branch
>     f8a88a03b9 branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>     47e85beee9 Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules
>
> If you "rebase -i 47e85beee9" (the exact object name might differ,
> as that commit needs to be recreated when 'js/branch-track-inherit'
> is updated) these five commits, and format-patch everything on the
> topic with --base=47e85beee9, it is guaranteed that I'll be able to
> cleanly apply what you meant to send out on top of 47e85beee9.

So if my branch were not in 'seen', I should have based my changes on
'origin/js/branch-track-inherit'. If my branch is in 'seen', I should
base it off the merge of js/branch-track-inherit' into my my branch?

I'll continue to use format-patch --base because I see how that can be
useful for you.

[1] https://lore.kernel.org/git/xmqqlf0lz6os.fsf@gitster.g/
