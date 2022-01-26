Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17CC63682
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiAZAW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiAZAW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:22:28 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D5C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:22:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 27-20020a63135b000000b0036285f54b6aso1010608pgt.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6DHUeh0UDcSotVsk91c0Dr0zDgXoPEL6xSypDnneDwI=;
        b=krbU84IzyVyDkjFU1RNViIMWd+/l3ZDZ258Lr7GGQsVUjqyCdhI03GSAYoR2xcIA3X
         dy+HcyO0PkPONNh10ABiC/YhwMRJnk2IVn8VktC+7uaJxiSK8p4N1s8S9Nnjpa5/7cZl
         Viouw8lAtD8UO8MPKjYsLfrs7mi5v+8Z1NoccEzIeq1RLv2sOROkKbr1+wp9JTZ8qGTG
         ZWdaog503xILkOoOOdCHDorg2zCL1d2Ss/4AVgNHod+zn8Ll7pN5tSKAM28MSF/J2/c/
         mJBzK3z4su2xMfQ1K1mMxW4L3t+FjDE4Kv3yla7qMtVzV4J8QmFwpEnaERmuHiamwyNh
         EPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6DHUeh0UDcSotVsk91c0Dr0zDgXoPEL6xSypDnneDwI=;
        b=76EjBFk76HdR15P7MXWcGylI/VgOQhe+bdJmO/3IboGowtXWOB4QvFgZpLsvgMzWSW
         hmOHxloeNWy3yyVsgJkItdLP901ED1mJKD9LY9RPKaixGF3WNs+7+B7KF0NPLcH/y0Rf
         +yNBMQccyc0g4EdufOXA7JJi8whH7umHXO6mkHMIzH+trZXV6GUZHoN/dJwT2W8OymrS
         SYNB2n07+OLoYeb2AQWpO4+PmWGS+k4lTz4Bn0mVoWd15r0uaqkY4NXHai6ihEz4HL7h
         B0MbCyYDUv5ABNkhCncGjXzl8PrWWPDY1MSCjleg+yHN6s+6tF7YWV8rPiYtCjNJl2+h
         fOYQ==
X-Gm-Message-State: AOAM532rftuTnejc79XLvgxbmMiQxc4v0vb++EsUVLhnnfv1mmosE0WE
        N3GTj+ITFVg8YePNgQp7WpeZz4VqF+wNsw==
X-Google-Smtp-Source: ABdhPJwSOwA5WwrY+25PCElmA8whaFKCGQNVjRi2xIs0qsjmxe0CInXAcNP7C1yN2YLg1uC1jmmxPTdJnTPxNQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7602:b0:14a:4a48:cabd with SMTP
 id k2-20020a170902760200b0014a4a48cabdmr21162944pll.121.1643156547666; Tue,
 25 Jan 2022 16:22:27 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:22:25 -0800
In-Reply-To: <CABPp-BGkpjD=WFSFSY9g85MAZ2JUh+UCfi6NThevZ4RxZUxtVw@mail.gmail.com>
Message-Id: <kl6lczkf1h32.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220125233612.46831-1-chooglen@google.com> <CABPp-BGkpjD=WFSFSY9g85MAZ2JUh+UCfi6NThevZ4RxZUxtVw@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: set GIT_WORK_TREE in run_git_checkout
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 25, 2022 at 3:36 PM Glen Choo <chooglen@google.com> wrote:
>>
>> When rebasing in a subdirectory of a worktree, Git fails due to a dirty
>> worktree:
>>
>>   error: The following untracked working tree files would be overwritten
>> by merge:
>>           a/b/c
>>   Please move or remove them before you merge.
>>
>> This occurs because "git rebase" invokes a "git checkout" without
>> propagating the GIT_WORK_TREE environment variable, causing the worktree
>> to be assumed to be ".". This was not an issue until bc3ae46b42 (rebase:
>> do not attempt to remove startup_info->original_cwd, 2021-12-09), when
>> the .dir of the "git checkout" child process was changed such that it no
>> longer runs at the root of the worktree.
>>
>> Propagate GIT_WORK_TREE to the "git checkout" child process and test
>> that rebase in a subdirectory of a worktree succeeds.
>
> This is correct, but leaves the reader wondering why the failure to
> set GIT_WORK_TREE fails when in a non-primary worktree, but does not
> fail in the primary working tree.

Ah, that is true. Thanks for digging into it deeper.

> Here's how I described it in the patch I was about to send to the list:
>
> """
> In commit bc3ae46 ("rebase: do not attempt to remove
> startup_info->original_cwd", 2021-12-09), we wanted to allow the
> checkout subprocess to know which directory the parent process was
> running from, so that the subprocess could protect it.  However...
>
> When run from a non-main worktree, setup_git_directory() will note
> that the discovered git directory
> (/PATH/TO/.git/worktree/non-main-worktree) does not match
> DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
> decide to set GIT_DIR in the environment.  This matters because...
>
> Whenever git is run with the GIT_DIR environment variable set, and
> GIT_WORK_TREE not set, it presumes that '.' is the working tree.  So...
>
> This combination results in rebase failing when run from a subdirectory
> of a non-main worktree.  Fix it by also setting the GIT_WORK_TREE
> environment variable along with setting cmd.dir.
>
> A possibly more involved fix we could consider for later would be to
> make setup.c set GIT_WORK_TREE whenever (a) it discovers both the git
> directory and the working tree and (b) it decides to set GIT_DIR in the
> environment.  I did not attempt that here as such would be too big of a
> change for a 2.35.1 release.
> """
>
> (Another fix would also be making sequencer stop forking a "git
> checkout" subprocess; it should be able to call a library function,
> and then quit dropping and re-reading the index.  But that's also a
> much bigger change...)
>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>> Here is a fix for the bug I found in [1]. I didn't look through the rest
>> of the "preserve cwd" thread for other possible bugs pertaining to
>> worktrees, but I didn't find any during a cursory glance at sequencer.c.
>
> We'll need the same fix for stash due to 0fce211ccc ("stash: do not
> attempt to remove startup_info->original_cwd", 2021-12-09) -- in that
> case, though, it's calling git-clean rather than git-checkout.  But
> the same idea.

Let's use your patch [1] instead of mine :)

[1] https://github.com/git/git/pull/1205
