Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBEC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352476AbiDTVe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiDTVe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 17:34:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165134654
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 14:32:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v15so3969807edb.12
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3b12WNjWt+iw3+MU+wxJyabdYL6Z2+t/H7bi0DBirPE=;
        b=RrszTZenkZc2QsRDqvUGbejNd3MLpMLW/TTeS+2llLT7LjN9/bfsK0kUKZZHnpStVr
         y96/UzBRa/EX1iYov7njmJxpzys8afXSk+AALiwpvVBoKbBYuRztLQNh3Xkv34YaWUd+
         UBsFHUG2355NVMOLJd5kMtRJAV+wQQwVPb/0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3b12WNjWt+iw3+MU+wxJyabdYL6Z2+t/H7bi0DBirPE=;
        b=v1MrzvrS2Ufk7zg8nX9tzQwTxUJpA5VxCbsVAjdK0z9A86EmgAEvbmZEkFn3ekvhJZ
         F+UhZKNlFwquFQtJH2qAhnmHz+v7Od4ec3khtw4wbgF2D9qc3uimJk03V1HB80YtLChp
         k3UbO2g6LLiviurHn3rmfTd8W3qcWSblbor1Sn9Lgl/QcoL7V4bt1PHVV9nXvvpdR75C
         19LMjyu87aTRZskebSOjss4kk7YQzUAsRIbtDkmfXqDFI9QywAU/ogFErAztiO4J7EDX
         ZGAkHnMbICDUyt1h0jXFEr9MdCEY36S4czcjJ6t7ZP7cmx181VUU/HXzA3upL+5ZisIQ
         c3bA==
X-Gm-Message-State: AOAM530iaGPycmUOsP3EJm2xDDlv2x6gDAAk8QNFBtOSDH8IgMt3M9rZ
        vweycfbw9o/KTnrgAXIzMvhi0OahxddwTnBiReKvcQ==
X-Google-Smtp-Source: ABdhPJyjjIOPElhuJTkUqop5bSFOXvHA5Fwaj3QSWvbjezDD3NO8HAN0oMPMXsgzZfL8XqJbq8hYoajLXTsALqdBtRs=
X-Received: by 2002:aa7:c6d7:0:b0:41d:8afe:4a6a with SMTP id
 b23-20020aa7c6d7000000b0041d8afe4a6amr25511280eds.281.1650490328529; Wed, 20
 Apr 2022 14:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com> <xmqqczhbr6pv.fsf@gitster.g>
In-Reply-To: <xmqqczhbr6pv.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 20 Apr 2022 23:31:57 +0200
Message-ID: <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 7:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > ...
> > To choose either option permanently, see push.default in 'git help config'.
> > ---
> >
> > I would propose to add one sentence at the end along the lines of:
> > ---
> > To instead avoid automatically configuring upstream branches when
> > their name doesn't match the local branch, see option 'simple' of
> > branch.autosetupmerge in 'git help config'.
> > ---
> >
> > Does that make sense to you?
>
> Two questions.
>
>  - If a user follows the push.default advice, does it have any
>    advantage to set branch.autosetupmerge=simple at all?

Probably not?

It really depends what they set push.default to:
* If they set it to upstream/tracking, then
branch.autosetupmerge=simple doesn't make much sense. You can set
both, but the outcome is effectively the same as setting push.default
to simple - not very useful.
* If they set it to "current", then it probably doesn't make sense
because what they're angling for is probably a triangular workflow,
which branch.autosetupmerge=simple very explicitly doesn't support /
doesn't make sense for. "matching" seems to be an extreme version of
the same setup.
* If they set it to "nothing" I'm not sure - I haven't understood in
what workflows that makes sense.

Generally, I expect that branch.autosetupmerge=simple makes the most
sense with push.default left at the default of "simple", for...
"simple" workflows :)

>
>  - If a user follows the branch.autosetupmerge=simple advice, what
>    happens their "git push" on a branch that the .merge is not set
>    due to this configuration?  Shouldn't they have to set up the
>    push.default for these branches anyway?

If the user follows the branch.autosetupmerge=simple advice (and
leaves push.default at the "simple" default), what they get at push
time will depend on whether they branched from a same-name remote
branch or anything else:

If they branched from a same-name remote branch, their "git push" will
be perfectly uneventful / unsurprising: they will simply push to the
remote branch. This is the same as without
branch.autosetupmerge=simple.

If they branched from a different-name remote branch (they created an
new / independent local branch), then no remote tracking relationship
will have been set up, and instead of the "fatal: The upstream branch
of your current branch does not match
the name of your current branch" error and advice, they will get a
much simpler error and advice:

---
fatal: The current branch whatevs has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin whatevs
---

When they follow those instructions, they will be in the "simple"
setup same as if they had just branched from same-name.

Importantly, as soon as they enable branch.autosetupmerge=simple, they
never see the original mismatching-name error and advice anymore -
they never again end up with mismatching names at all. (except in edge
cases like branch renames)

>
> While it might be a good thing to mention branch.autosetupmerge
> configuration variable, I am not sure if "To instead avoid" is a
> good thing to say here.  It sounds as if the user can ignore
> push.default as long as branch.autosetupmerge is taken care of, but
> I suspect that is not the case.

I disagree. If they get that error and advice, then their push.default
is set to "simple". If they then set their branch.autosetupmerge to
"simple" also, this is the simple coherent setup that I, at least,
would recommend to non-experts.

> Setting the latter to 'simple'
> means there are *MORE* branches that do not have .remote/.merge set
> up, doesn't it?  Which in turn means that we are relying more on
> what push.default is set to, right?

No - the idea here is that instead of telling push.default to do
something *independent* of the tracking branch (like, for example,
"current"), the setup the user ends up with is one where the tracking
branch, if there is one, is always the same-name where you will push
to.

When you create a new branch (by branching with a new name), your new
branch doesn't initially have an upstream tracking branch - and that's
right and correct, there's literally nothing on the server for you to
track yet - but the first time you push, the (existing) advice
encourages you to set up that tracking relationship. In this flow you
very explicitly *don't* rely on push.default, because you never want
to end up in a confusing (un-simple) situation where what you're
pulling from and what you're pushing to aren't the same thing - a
triangular workflow.

The "push the current branch and set the remote as upstream" advice is
consistent with how many/most GUIs will handle first push for a branch
that does not have an upstream tracking relationship yet - GUIs will
typically automatically specify (or set the UI default to) the
"--set-upstream" option on that first push.
