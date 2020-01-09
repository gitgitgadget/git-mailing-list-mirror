Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585BC32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58952206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgAIJrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:47:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgAIJrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 04:47:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so2056428wmc.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 01:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeZb7+WJDghNWZxruD9gRpwZOz3HwFZwPVl0YBOQObs=;
        b=BEnB1M1yrhR+7NQijMs+wIezMxbgtm7CrcX+0Vk/luCEuN47A7dRFCf5zko0ED/M6m
         fx8pWFiNhXRUsuGL2MR1FvPR57wGqHojWmW2E0jccAaR8LmoC6H6ombGIBUXNLRSBfnt
         XlIF1PIZ7oAPKeEOvj9k7ACyYA2XbhDv4b738aYlG8vopdkYbNQGKE5QYYGFjbR1WsdA
         lZdWshq3a7vBucn1K6jpTspwHToY5zpstB740FB2bOwfWoxwAtPyeg1PRZUoHVSBrILM
         cbd4tzNhmUz4FHEFfWNtAAldEsDw4jXQI7nRJzorq2b5fHLdyRuucNYnUXu1ctwaKq9V
         1/Zw==
X-Gm-Message-State: APjAAAWOxcw3nIx5aMFfyAlLuM6qo5yrJgRF2h7EZEvXDxK6fLPfoGwk
        shHgKMWyn5+tusUS55yuxOAolCJfWPgz2VCSupc=
X-Google-Smtp-Source: APXvYqxibIeahZq3F5blbkUmLfYJ9bmd+3z0w4rt9ZjkJuAXXEOBz89XIIr8JUdqmjoaNsQgA0mhQTm3Ph+N3ZEfmfE=
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr3746492wml.43.1578563228653;
 Thu, 09 Jan 2020 01:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20191214161438.16157-1-me@yadavpratyush.com> <20191214161438.16157-2-me@yadavpratyush.com>
 <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
 <CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com> <20200106180101.wwznvthla35x3qd2@yadavpratyush.com>
In-Reply-To: <20200106180101.wwznvthla35x3qd2@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Jan 2020 04:46:57 -0500
Message-ID: <CAPig+cTva89t8Zco-Ke0oD5xDZF_uuGH-gSkLXE2r31NtSE8nw@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree add'
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 1:01 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 05/01/20 11:20PM, Eric Sunshine wrote:
> > On Fri, Dec 27, 2019 at 6:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > As an alternative to this patch, would the simpler approach of
> > improving git-worktree documentation to do a better job of pointing
> > people at -d/--detach as a way to side-step unwanted branch creation
> > make sense? That is, at minimum, enhance the "Description" section to
> > prominently talk about throwaway worktrees (created with -d/--detach),
> > and add an example to the "Examples" section (perhaps as the first
> > example) showing creation/use/deletion of a throwaway worktree.
>
> FYI, I'm running Git v2.24.1 and 'git worktree add' doesn't accept the
> option '-d'. It only accepts '--detach'. And looking at the current
> 'next', I don't see the option mentioned in git-worktree.txt. So at the
> very least, we should start by actually adding the option.

I forgot that -d was never added as shorthand for --detach, and didn't
bother checking the man page. But, yes, adding -d would be a good
start.

> > Of lesser importance, it might make sense, as a followup, to add a
> > configuration which changes the default behavior to detach instead of
> > auto-creating a branch. I wonder if this could be piggybacked on the
> > existing "worktree.guessremote" configuration. Or rather,
> > retire/deprecate that configuration and add a new one which affects
> > DWIM'ing behavior such that it becomes multi-state. Some possible
> > values for the new configuration: "auto" (or "dwim" or whatever),
> > "guessremote", "detach". (I haven't thought this through thoroughly,
> > so there might be holes in my suggestion.)
>
> Honestly, coupled with a configuration variable this alternative fits my
> use-case really well.
>
> I think 'guessremote' does not describe very well what the config
> variable would actually do. So I think deprecating it would be a better
> idea.
>
> Does 'worktree.newBranch' sound like a good name? (Disclaimer: I am
> terrible at naming things).

Maybe 'worktree.addFlags' or something? I'm thinking that this might
be a multi-value configuration variable which is a combination of the
various option flags which can be used with "git worktree add". For
instance: 'worktree.addFlags=detach' or
worktree.addFlags=auto-create-branch,guess-remote. Possible values
might include:

[no-]auto-create-branch
    enable/disable automatic branch creation when <commit-ish> is
    omitted

detach
    create worktree with detached HEAD

[no-]checkout
    perform/suppress checkout of <commit-ish> in the new worktree

[no-]guess-remote
    create local branch from remote-tracking branch if present and
    <commit-ish> omitted

[no-]track
    make new branch track <commit-ish> if the latter is a branch name

[no-]lock
    keep worktree locked after creation

In fact, I'd like to see 'auto-create-branch' incorporate
'guess-remote' behavior by default since "remote guessing" should have
been the default behavior from day one, but it was overlooked. The
--guess-remote option was added simply to avoid backward compatibility
problems, but it would be nice to one day make it the default. Since
this configuration variable is new, we don't have to worry about
backward compatibility with it, thus can make 'auto-create-branch'
work like it should have from inception -- that is, performing "remote
guessing" DWIMing (just like "git checkout" does by default).

A command-line option would (as expected) override a flag set via
'worktree.addFlags'. So, for instance, --no-detach would override
'worktree.addFlags=detach'.

Anyhow, this is just a rough idea. I haven't thought through all the
ramifications, or even if this is a sane interface.

> > There's at least one point not in favor of merely updating the
> > documentation to promote -d/--detach more heavily, and that is that
> > (presumably) the concept of detached HEAD is perceived as an advanced
> > topic, so it may not be suitable for the newcomer or casual user.
>
> I'm basing this off no data so take it with a grain of salt, but I think
> people who know Git enough to understand the concept of multiple
> worktrees should also understand what a detached HEAD is. And even if
> they already don't know what it is, they should have no trouble quickly
> reading one of the many great explanations available with a simple
> Google search.

I don't necessarily share that opinion, but I do think that if we add
-d as shorthand for --detach, and do a really good job of updating the
documentation to promote the idea of "throwaway worktrees" (which also
happen to be detached), then we have a good path forward.

> My argument in favor of auto-deletion is that we should still try to
> have sane defaults. Leaving behind a branch the user didn't explicitly
> create and didn't use doesn't sound like a sane default to me.
>
> The configuration variable path is easier and suits my needs really
> well, so I am inclined to just go with it. But making the whole user
> experience better for everyone is still something worthwhile. But then
> again, introducing a backwards-incompatible change might not be the best
> idea. So, I dunno.

Yep, the different ideas can co-exist, and each can be implemented
without promising to implement the others. A good first step would be
to add -d as alias for --detach and update the documentation to
promote the concept of "throwaway worktrees". An optional second step
(if needed) would be that new configuration variable (though it still
needs more thought). And, a really optional third step (if anyone
cares strongly enough) would be to implement auto-deletion of
auto-created branches.
