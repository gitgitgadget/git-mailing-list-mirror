Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D7C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhLGUqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhLGUqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:46:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B0C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:43:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so780501edq.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PePUutyZf5obsqts0/IdNsQ9M6AXduswK+PBftikWLY=;
        b=fR82WpZUoornYv/mOlcSK22HOjopABBuXmkulOtiDyKA6MarKivW1q8z1JO3Ri66yq
         18rgqHqRrc80DPUd6UXg5grYJ6uhrvQrmfyEurx0Q4IlM9IWNVQPH28ZGjz+wiYIpfoz
         JJf0urfAtkB/hp7nk3wUSCjOcF8GrLGyb1DQJ7+j7drmT+sI1bmqp42n4kI9y8/pp8Hi
         VY24ZzfoWRWA7QKnv/OXcIHBw1PAgWX+CTAapnw/jCi9DCq/OWxlF+JJW/NWj7gw1bUZ
         v7mOuyn9miiu+N2nhNFEcaMXNkuqjwx1zZpKNK7NgMC+hZcU+v8u6k3yGsTw42O2VD7k
         7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PePUutyZf5obsqts0/IdNsQ9M6AXduswK+PBftikWLY=;
        b=f7RmbwaXYhhlrPxCnpQ1NYydHH+/k+uicsdCHgh69uLN8LxgEeHMSE3LB3EOX6Owv3
         6uXvj22QbAbYROUNv3MIFku5BY5DF+gxeYnntUpBLIS11ZY4Hvh1gpV6xbXtJ8Czp1RF
         TpilBKzsXZ0OqnnKgqrMVFUQmzgX9COpYKjsfEiKVFt16nx2uOqVJC3fJsIr2ncnys9+
         iELcGYpfK4pxmJDle4CFY8rwqhc2Og+68AdtYJbSMRKlodO839sKgmGpx9UZtn4Qc/HZ
         6DvL+EtDSD9GrpMHPdz+8V91HI50fCQ86mZJp+PcpNmODgBrGh6jZDLsZjzjZ64QHyOE
         IuEw==
X-Gm-Message-State: AOAM5308xtWjU3cewhU2i1OD6Tn8i+7pDcUVxZa76LQsGgdSymHAVf0s
        CPAwi4P46RG/aIqGgKq3wPMmc2HPZ9mEDXw6+lw=
X-Google-Smtp-Source: ABdhPJyZUn7hI5j7J17RQjCN2Ohn13d3uoAFo8jrhOUaA6VbOnkc6Gq/QHAZrzUEar04iuyo91pgvggaRQKTf/3T79c=
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr12547752edv.333.1638909795872;
 Tue, 07 Dec 2021 12:43:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
In-Reply-To: <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 12:43:03 -0800
Message-ID: <CABPp-BHRse4BwXTjd4cRruOdymt=DJRPDL1jyPzX5HDqx4ymDw@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/1/2021 1:40 AM, Elijah Newren via GitGitGadget wrote:
> > Traditionally, if folks run git commands such as checkout or rebase from a
> > subdirectory, that git command could remove their current working directory
> > and result in subsequent git and non-git commands either getting confused or
> > printing messages that confuse the user (e.g. "fatal: Unable to read current
> > working directory: No such file or directory"). Many commands either
> > silently avoid removing directories that are not empty (i.e. those that have
> > untracked or modified files in them)[1], or show an error and abort,
> > depending on which is more appropriate for the command in question. With
> > this series, we augment the reasons to avoid removing directories to include
> > not just has-untracked-or-modified-files, but also to avoid removing the
> > original_cwd as well.
>
> I did not clearly voice my approval of the core idea here, but I do like it.
>
> I think this fits squarely into a category of "help the user not get stuck"
> which Git has enough of those situations that we don't need this one. Even
> expert users won't know for sure if a 'git checkout' will cause their current
> directory to be removed, however unlikely.
>
> In the Git project, we spend a lot of time in the root of our workdir, but
> this is not the typical case for large projects. I remember spending most of
> my time in a previous role working four levels deep in the directory hierarchy.
>
>
> I read the previous two range-diffs and took another pass at this v5 and
> didn't see anything worth commenting on. This version is good to go.
>
> There is _also_ more work to do, as follow-ups. In particular, the thing
> that I thought about was sparse-checkout and created this test which still
> fails at the end of your series (as an addition to t1092)

Interesting testcase...

> test_expect_success 'remove cwd' '
>         init_repos &&
>
>         test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
>         for repo in sparse-checkout sparse-index
>         do
>                 (
>                         cd $repo/deep/deeper1 &&
>                         test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
>                         git sparse-checkout set &&
>
>                         test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
>                         test_sparse_match git status --porcelain &&

However, this line is broken even if the directory weren't removed.
Not because of the "git status --porcelain" part, but because of two
other reasons:

1) test_sparse_match presumes it is run from the directory above the
repos while you still have it in $repo/deep/deeper1
2) The point of test_sparse_match is to compare the results in two
different repositories, but it'll do this twice and the first time
without the changes having been made to the sparse-index repo.
Perhaps this belonged outside the surrounding for loop?

I think I'd either drop the "test_sparse_match" or else just drop the
whole line; the real comparison is the expect/actual files.  Dropping
this line makes it a good test.

>                         cd "$TRASH_DIRECTORY" &&
>                         test_cmp expect actual
>                 )
>         done
> '
>
> Please do not let this test delay the advancement of this series. As we
> find these kinds of issues, we can fix them one-by-one as needed.

Yeah, sounds good.  Since you piqued my interest, though, the problem
is that we're passing an absolute path to remove_dir_recursively()
inside clean_tracked_sparse_directories() when we should be passing a
relative path.  (We always chdir(r->worktree) in setup.c, so there's
no need to prepend the path with r->worktree+'/'.)

Still, the current series is long enough and unless there are issues
others have spotted with it, I'd rather just let it proceed as-is and
then send this fix and a correction of your testcase in separately.
