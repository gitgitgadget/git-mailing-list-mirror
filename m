Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF7C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiKWHfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKWHfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:35:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC7F72FD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:35:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so12438576wmc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG7P86kIj0Mt9+EBRQazFcobpC+zfoaJro3xX9XEi/U=;
        b=KI1hm3mqgTtxz9OOO3nvxRl3zROH+ifxMXKxR/lMRGbNpqEHJB4Rn/KXhWVUkR3OWc
         +k1tmUUUqWrNuRofx+xYP2P+2jv3xkfR1wtY9LBxP4neW+ph5YSF9RJRmElBHnXJ5huN
         oOYqonKo4vxUyTnKensKU9ZVszVPyOIQ72cXXrtOEZ0DjaqpjcEvD25HlVWCphXR3O+o
         zWgawrAY6t/jG5YrEBs9Q6yp1Toen7SKHxQqu9VNkrKIKgsGDM3eE7sVdols0ndUTYgg
         M3fq9alQsQnhWIwG+0Ys7voAErNS6x1n/vZ9qbtKtBzgB1plyveonJb9vAbMB5XXEIZk
         p8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG7P86kIj0Mt9+EBRQazFcobpC+zfoaJro3xX9XEi/U=;
        b=8INd237JnkiV6Fw5mrfKqDzWya0jmLblZCdWlgUl1JGuaGX2zA8D0xDLNTkqHZ3KYA
         xRiWs8L0VlHW1zRjiIU0Cggxg230K2h5d8FuJRD9YoAcwu0Zlmo35xnzfEeuQXCcc2p3
         TJfAagikyJUyH0y1AeyhLGAanv0rEogTmQ8moC2fQd1Vnlp6llopxw0Ec3X/p6X0aDcV
         fpxDgQyEC9AoKkzu8sPgu/ycaZPAQkzpgEUE3LFLjRsNSbg4lAXxNkv62QJ8mnEW8PHg
         kF91A7VizvXRC4KKPIOARHfx5Y4bJQX4YlXJ3pkQd0SUB5kUbzWQT6pYejgBD2hzIaU9
         O0jw==
X-Gm-Message-State: ANoB5plLdY1x+cqz27CdL3gMRgRH2eRrweZJVzjJrTNv09fZPldtuBwS
        v+8oPYhltRVovBk0q8gUtqGvYguYqrcEUw==
X-Google-Smtp-Source: AA0mqf4urLbmJpFW2pYy8SkrF2U5tgeN+OSLoW/otIv3zR52bJ6YirZLFGPBoIo0ji5dVlBGIj7dMQ==
X-Received: by 2002:a1c:7212:0:b0:3cf:7a77:589a with SMTP id n18-20020a1c7212000000b003cf7a77589amr5232032wmc.194.1669188904338;
        Tue, 22 Nov 2022 23:35:04 -0800 (PST)
Received: from [192.168.2.52] (14.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.14])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b003cfd64b6be1sm1485240wmq.27.2022.11.22.23.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 23:35:03 -0800 (PST)
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
 <20221119034728.m4kxh4tdpof7us7j@phi>
 <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
 <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
 <20221122232647.2jdsp5kioq7muymb@phi>
 <e027dc5b-dbb9-c511-038e-5440d59d976c@gmail.com>
 <20221123053708.rrbcphg7uukafdsg@phi>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <3a48123b-a43a-b8b5-b696-e9edb2e3fc28@gmail.com>
Date:   Wed, 23 Nov 2022 08:35:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20221123053708.rrbcphg7uukafdsg@phi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-nov-2022 05:37:21, Jacob Abel wrote:
> On 22/11/23 03:43AM, Rubén Justo wrote:
> > On 22-nov-2022 23:26:57, Jacob Abel wrote:
> > > On 22/11/22 12:16AM, Eric Sunshine wrote:
> > > > On Sat, Nov 19, 2022 at 6:49 AM Ævar Arnfjörð Bjarmason
> > > > <avarab@gmail.com> wrote:
> > > > > On Sat, Nov 19 2022, Jacob Abel wrote:
> > > > > > I'd support adding an `advise()` for at least the basic case where you try to
> > > > > > create a worktree and no branches currently exist in the repository.
> > > > > > i.e. something like this:
> > > > > >
> > > > > >     % git -C foo.git worktree add foobar/
> > > > > >     hint: If you meant to create a new initial branch for this repository,
> > > > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > > > >     hint:
> > > > > >     hint:   git worktree add --orphan main main/
> > > > > >     hint:
> > > > > >     fatal: invalid reference: 'foobar'
> > > > > > and
> > > > > >     % git -C foo.git worktree add -b foobar foobardir/
> > > > > >     hint: If you meant to create a new initial branch for this repository,
> > > > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > > > >     hint:
> > > > > >     hint:   git worktree add --orphan main main/
> > > > > >     hint:
> > > > > >     fatal: invalid reference: 'foobar'
> > > > >
> > > > > I think those would make sense, yes.
> > > >
> > > > Yes, this sort of advice could go a long way toward addressing my
> > > > discoverability concerns. (I think, too, we should be able to
> > > > dynamically customize the advice to mention "foobar" rather than
> > > > "main" in order to more directly help the user.) Along with that,
> > > > explaining this use-case in the git-worktree documentation would also
> > > > be valuable for improving discoverability.
> > >
> > > Perfect. I think I've got this working already on my end using more or less
> > > the following:
> > >
> > >     diff --git a/builtin/worktree.c b/builtin/worktree.c
> > >     index 71786b72f6..f65b63d9d2 100644
> > >     --- a/builtin/worktree.c
> > >     +++ b/builtin/worktree.c
> > >     @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const char *prefix)
> > >         if (!opts.quiet)
> > >             print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> > >
> > >     -	if (new_branch && !opts.orphan_branch) {
> > >     +	if (opts.orphan_branch) {
> > >     +		branch = new_branch;
> > >     +	} else if (!lookup_commit_reference_by_name("head")) {
> >
> > I haven't read the full thread and sorry to enter this way in the
> > conversation, but this line got my attention.
> 
> No worries. It's always nice to have more eyes to catch mistakes.
> 
> > This needs to be "HEAD", in capital letters.
> 
> Ah yes. I wasn't paying attention when I copied it into my MUA and must have
> accidentally typed `ggvGu` instead of `ggvGy` and lowercased it before I copied
> it (thanks vim/user error). It should be:
> 
>     diff --git a/builtin/worktree.c b/builtin/worktree.c
>     index 71786b72f6..f65b63d9d2 100644
>     --- a/builtin/worktree.c
>     +++ b/builtin/worktree.c
>     @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const char *prefix)
>         if (!opts.quiet)
>             print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> 
>     -	if (new_branch && !opts.orphan_branch) {
>     +	if (opts.orphan_branch) {
>     +		branch = new_branch;
>     +	} else if (!lookup_commit_reference_by_name("HEAD")) {
>     +		/*
>     +		 * If HEAD does not reference a valid commit, only worktrees
>     +		 * based on orphan branches can be created.
>     +		 */
>     +		advise("If you meant to create a new orphan branch for this repository,\n"
>     +			 "e.g. '%s', you can do so using the --orphan option:\n"
>     +			 "\n"
>     +			 "	git worktree add --orphan %s %s\n"
>     +			 "\n",
>     +			 new_branch, new_branch, path);
>     +		die(_("invalid reference: %s"), new_branch);
>     +	} else if (new_branch) {
>             struct child_process cp = CHILD_PROCESS_INIT;
>             cp.git_cmd = 1;
>             strvec_push(&cp.args, "branch");
> 
> 
> >
> > Thank you for working on this, this is a thing that has hit me several
> > times.
> >
> > The first impression got me thinking.. Why do we need this advise?
> > Why not make the orphan branch right away? And why the argument for the
> > --orphan option?
> 
> I went into my concerns with further overloading `worktree add -b/-B` and
> `worktree add` (DWYM) over on the other side of this thread [1]. I won't echo
> it all here but I wanted to mention a few things.
> 
> As for why we want the advise, by not short circuiting with the advise and
> instead just trying to DWYM, we can catch the following edge case:
> 
> A user less well acquainted with git tries out worktrees on a new project (no
> branches). They create multiple worktrees and since there are no branches, they
> are all orphans. Unless they've read the docs, they are now accustomed to this
> "new worktrees have no history" behavior. Then they make a commit on one of the
> orphans and the behavior changes and all new worktrees derive from that branch
> unless `git worktree add` is run from inside another worktree with a non-orphan
> branch.
> 
> There's more to it in the other thread but it gets kinda messy for the user if
> they walk off the well trodden path inadvertently. I'd like to avoid that all
> together where possible.
> 
> As for the argument, the reason is so that the syntax matches
> `git switch --orphan <new_branch>` (and the `git checkout` variant).
> 
> > I like what this new flag allows: make a new orphan branch when we
> > are in any branch.  But if we are already in an orphan branch (like the
> > initial) what's the user's expectation?
> 
> Like mentioned above (and in [1]), further overloading DWYM and `-b` impacts the
> already somewhat complex/unclear expectations for `git worktree add`.
> 
> When using the flag and not adding to `-b` and DWYM, we can short circuit this
> confusion for the most part by requiring the user to explicitly request
> `--orphan`.
> 
> As for creating a new orphan in a repo with existing branches but from a
> worktree containing an orphan branch, that fails cleanly as shown below:
> 
>     # in worktree with orphan branch
>     % git worktree add -b foobar ../foobar
>     Preparing worktree (new branch 'foobar')
>     fatal: invalid reference: foobar
> 
> and in the next revision should fail with the following:
> 
>     # in worktree with orphan branch
>     % git worktree add -b foobar ../foobar
>     Preparing worktree (new branch 'foobar')
>     hint: If you meant to create a new orphan branch for this repository,
>     hint: e.g. 'foobar', you can do so using the --orphan option:
>     hint:
>     hint:   git worktree add --orphan foobar ../foobar/
>     hint:
>     fatal: invalid reference: foobar
> 
> > Maybe we can use the new flag to indicate that the user unconditionally
> > wants an orphan branch, and use the rest of the arguments as they are,
> > '-b' included.
> 
> I wouldn't necessarily be opposed to this however I do think changing it from
> `--orphan <new_branch>` to `--orphan -b <new_branch>` would be a departure from
> the syntax used in `git switch` and `git checkout` and that may make it harder
> for users already familar with those other commands.
> 

Understood.  Maybe allowing a mixed DWYM...

	$ git worktree add --orphan foobar

I'll wait for your next version.

Thank you for the wrap up, and sorry again for reading the thread bottom
up.
