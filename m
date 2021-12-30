Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4EC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhL3IQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 03:16:14 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:52203 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhL3IQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 03:16:13 -0500
Received: by mail-pj1-f44.google.com with SMTP id v16so20695952pjn.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 00:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wijTVCp+55NbHGNJMGuqI2J+6INs7BtsDLZ/BFjdNbc=;
        b=s2secju66YttWL2Q6eEgLazceDbxxwghcgz6nsj7+hVWg3SbPIqYJUe96OROYC2lIZ
         dgArD3mIA8LywzxRfaWZW92J9FpxwML/M1iwSmfFtKUxllkNC+iU9rf/wGmhy45m8Nug
         v/KE/wFxeHCrrkBz1RxbqzNd9owjiuyDMRbbEq6uVEvRdIw3aZ3ct8/obfNQx5RZT/G5
         xs6r+bDru/824cFAqLz/V6eEAdkrNK5MWttmYl8jfn2w82Vt/eWUBWJnLrgxwpeF3KAe
         Tg5WtwYK6xax+Fi1Ej6yMI9HIo4iMNqYs1sYIglCz9I/o0K5BXizWRqs9NRYFW+gDcik
         pKpw==
X-Gm-Message-State: AOAM533DKVcid3VRm0BbbpIzOkq6vev6D2O1KEKVPlBcXEVtG4XefF9l
        K4mWZxCXYJZ6nbRkW9WL1XGC/lXzTLRSB63T/9Y=
X-Google-Smtp-Source: ABdhPJwwNz+cXrCoLrnV5FIjQLFBWG70W0tNzKnLgKql0og5EBxSFqBiOoKsK4qKwnXChKSVghQM6PRpl6wOYA7o1Cs=
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr36444964pjb.236.1640852172619;
 Thu, 30 Dec 2021 00:16:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
 <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com> <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
 <0aa32f4d-9101-16ff-58b8-29a8651a69f8@gmail.com> <CABPp-BFdVPRgFy8DLFEB13Trh5J4S+xma-U5FUnUvQLNMfNNjA@mail.gmail.com>
In-Reply-To: <CABPp-BFdVPRgFy8DLFEB13Trh5J4S+xma-U5FUnUvQLNMfNNjA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 03:16:01 -0500
Message-ID: <CAPig+cRVePM7AtoMc=czDPqZed=VQqKGUBKCBpYA0QQm18cofg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 5:45 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 29, 2021 at 1:39 PM Derrick Stolee <stolee@gmail.com> wrote:
> > I think the motivation is that worktree config is something that is
> > harder to set up than to just run a 'git config' command, and we
> > should guide users into a best practice for using it. The
> > documentation becomes "run this command to enable it".
>
> Okay, but that's an answer to a different question -- namely, "if
> users want/need to explicitly set it up, why should we have a
> command?"  Your answer here is a very good answer to that question,
> but you've assumed the "if".  My question was on the "if": (Why) Do
> users need or want to explicitly set it up?
>
> Secondarily, if users want to set it up explicitly, is the work here
> really sufficient to help guide them?  In particular, I discovered and
> started using extensions.worktreeConfig without ever looking at the
> relevant portions of git-worktree.txt (the references in
> git-config.txt never mentioned them).  I also pushed this usage to
> others, including even to you with `git-sparse-checkout`, and no
> reviewer on this list ever caught it or informed me of the `proper`
> additional guidelines found in git-worktree.txt until this thread
> started.  So, relying on folks to read git-worktree.txt for this
> config item feels a bit weak to me.  Granted, your new command will be
> much more likely to be read since it appears near the top of
> git-worktree.txt, but I just don't think that's enough.  The
> references to extensions.worktreeConfig in git-config.txt should
> reference any special command or extended steps if we expect users to
> manually configure it (whether via explicit new subcommand or via also
> playing with other config settings).

Agreed about it being a good idea to update git-config.txt to mention
the extra bookkeeping related to `extensions.worktreeConfig=1` (though
it doesn't necessarily need to be done by this series).

> Anyway, if we think users want to set it up explicitly, and we address
> the discoverability problem above, then I'd vote for
> "independent-config" or "private-config" (or _maybe_
> "migrate-config").  Because:
>   * no sense repeating the word `worktree` in `git worktree
> init-worktree-config`.  It's redundant.
>   * The words "independent" or "private" suggest what it does and why
> users might want to use the new subcommand.
>   * It's not an "init":

I had some similar thoughts/objections to the name
`init-worktree-config` (not that I was able to come up with anything
better). Thanks for enumerating them here. Anyhow, as you say below,
the new subcommand isn't really needed.

>     * The documentation makes no attempt to impose a temporal order of
> using this command before `git worktree add`.  (Would we even want
> to?)

Aside from possible(?) sparse-checkout issues, I don't think there is
a reason to impose temporal order in general.

>     * As per my recommendation elsewhere, this step just isn't needed
> for the vast majority of users (i.e. those with non-bare clones who
> leave core.worktree alone).
>     * ...and it's also not needed for other (core.bare=true or
> core.worktree set) users since `git worktree add` will automatically
> run this config migration for them

Your enumeration at the very end of [1] pretty well convinced me that
we don't need this command; certainly not at present, and perhaps
never.

> And, actually, with the name "independent-config" or "private-config",
> I might be answering my own question.  It's a name that speaks to why
> users might want it, so my objection to the new command is rapidly
> diminishing.

Perhaps some day it might make sense to add such a subcommand (more
suitably named), but with your proposal in [1] it's hard to justify
adding it now, and it certainly doesn't need to be part of this patch
series.

[1]: https://lore.kernel.org/git/CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com/
