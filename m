Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB87C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 02:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiLACXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 21:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLACXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 21:23:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8199581E
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 18:22:52 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so321725lfb.13
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dXtdGYVQVnGp2B4DiT9F3pFYXYFmcJkqXYuDwg+Ww=;
        b=CB+HIKyOyfhyWXEgYGRsOJ7OE2Wy977rJKkrUxkvBIytxmbALlIhqih+BVfvxc3CMO
         4UcL4FrUvgO3RtTHkK/xGEvxebj/CAtDRRfN+N9yE4A5etWtIMW+axHC5sXKxINKNznZ
         dG9AAo7ZKfpDbCrLIINM5yTmL99F0vwPKVwAejH14C05hWLwS2vp4d5ONklwwrx4Lr7s
         2TJdS/DGaYla7rPFRWT6Dh38Q+kh/zeEUm8G4+APo2uIxanlFGitpbS4c4baaSndstLi
         ghAlRzoGnNAL3rYSJG3ZCIRlBz1+TXF6/sy5UgZ1esGmeMcVE40YD4bsGQ3RDIey/pfQ
         hlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5dXtdGYVQVnGp2B4DiT9F3pFYXYFmcJkqXYuDwg+Ww=;
        b=c6ifKBFz4nMo6OG4WPi4+iR6w+YKEmBaeu7bW+ESAoa/Ezp3ZVz6hYBaFz93jqlxce
         Zhrwmlnr+DrjbkiNyBtaaRA0xFxBb2XHrqzm68X/SFJ0uy3uwX3Agp4UjY7cwKHZ+dE4
         NUeD+xhHZU5YQGW6JFE22XxXN0Hv2DYETBRkax4wek9FVchcfSCyyCawbo/YOIoRv04c
         T1K0OUnxV0VhshqoBm53MQHlg5zbYf6EfxQPzOcyg5zv/g/iFGSR612e3yv/xsLGTUyO
         BsFgqh8aRAY8KxWwwa+o0x4Hc8fl3Ax9xdFYQPR5kulflUIh/FWVA+AUynSvAv8rysV/
         tk7A==
X-Gm-Message-State: ANoB5pk4kirS4lU5Tfxn/pmQmQTZb+KoIkskT+aZx4w93GWntweuL27b
        0QU7DqQ2/fKRhJKzFm1+YvXclxh6zjlJgd9Q4L0=
X-Google-Smtp-Source: AA0mqf6lRixppVzxtirdg3KxfSVYV4bkNcwGo4dg9lq6soIdldX/swtYu/UtYOvMbdeEr6HowwLDVsM/1boSUrbiRLw=
X-Received: by 2002:a05:6512:280e:b0:4a2:5154:ead9 with SMTP id
 cf14-20020a056512280e00b004a25154ead9mr22679998lfb.32.1669861370586; Wed, 30
 Nov 2022 18:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com> <CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com>
 <87lenstwfh.fsf@osv.gnss.ru>
In-Reply-To: <87lenstwfh.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Nov 2022 18:21:00 -0800
Message-ID: <CABPp-BEY-Xma8=MbXpw+En7TayzhYOmYYAHD6hudOQv=GnOT=Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] diff-merges: more features
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 5:16 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> 1. --diff-merges=[no]-hide
> >
> > This seems problematic to me.  Currently, all the options to
> > diff-merges are exclusive of each other; the user is picking one of
> > them to determine how to format diffs for merges.  Now you are
> > introducing the ability to combine various options, leading users to
> > think that perhaps they can run with all three of
> > `--diff-merges=combined-dense --diff-merges=remerge
> > --diff-merges=separate` or other nonsensical combinations.  Shouldn't
> > this [no-]hide stuff be a separate flag rather than reusing
> > --diff-merges?
>
> Yes, it's a precedent indeed, but I don't see any actual problem here.
> Unlike git silently dropping changes on rebase, this can cause no
> damage.

Sure, read-only options for querying things won't cause future damage.
That doesn't mean that the UI for commands like diff/log/grep/etc are
unimportant, though, and certainly doesn't excuse intentionally
creating bad UI for them.

> I think I can emphasize that we now have "formats" and "flags"
> in the documentation, where "formats" are mutually exclusive (the latest
> specified wins), while "flags" are cumulative.

Why not just give it a different flag name, so that "formats" and
"flags" are clearly separated without even needing a lengthy
explanation?  That'd be much simpler to understand and explain.

> >> The set of diff-merges options happened to be incomplete, and failed
> >> to implement exact semantics of -m option that hides output of diffs
> >> for merge commits unless -p option is active as well.
> >>
> >> The new "hide" option fixes this issue, so that now
> >>
> >>   --diff-merges=on --diff-merges=hide
> >>
> >> combo is the exact synonym for -m.
> >
> > Why is completeness important here?  Perhaps I should state this
> > another way: when would users ever want to use this new "hide" option?
> >  I got through your cover letter not knowing the answer to this, but
> > was hoping it'd at least be covered in one of your commit messages or
> > documentation changes.  Maybe it was there, but I somehow missed it.
> >
> > Is the only goal some sense of developer completeness for these
> > options, or are these end-user-facing options of utility to actual end
> > users?  I'm hoping the latter, but if so, can that be documented and
> > explained somewhere?  I'm pretty sure this is explained somewhere in
> > an old mailing list discussion, but where?
>
> Completeness is essential as I want '--diff-merges' to provide all the
> needed capabilities, and one of them was actually missing, that is there
> in the '-m' semantics, exactly as I said in the descriptions.

I ask you why a user would want to use this option, and you simply
assert that it's a "needed capabilit[y]"?  Could you explain *why*
it's needed or helpful for users instead of just repeating the
assertion that it is needed?

If I can't figure out why it's needed or useful for users despite
having read your cover letter, commit messages, underlying source code
and documentation, and this full thread, then there may well be
something wrong with me...but it seems likely that many users will
also have difficulty figuring out why this option is useful.
