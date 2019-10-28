Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E516F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 06:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfJ1Gj5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 02:39:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39108 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfJ1Gj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 02:39:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so6995347edt.6
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDKochLXLU5YzXAV7KJr8K4mR7/HgK6j65n05KkeE/U=;
        b=Qt20ICLnre0bE3uCx80WFIgZ7vi1dk8hDZUYVV/Z5wh0IcLJCXyWyHKjB38qZg1Fut
         j6FimwRSUOuRKtLRshaAzlz2QrKwpABca07UUApfPpTdyXWpsSLPdmUKK68zNG+Ka91t
         HQD7I7PLJshu2fmepmNH1fjd+lWEnC/C/QoKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDKochLXLU5YzXAV7KJr8K4mR7/HgK6j65n05KkeE/U=;
        b=BQKnHrQQnhFXJeDwxC4zJ+T0zhC5StQeBni4FBgzb90fuS4yCPk6LrHYbu/Hg9ITE7
         NPs5AZwrbEBeX2R9X5ecWGL33FChF8KPlny8B3qdoPZU1CBcZNSmqORVmETBACt6Yy/w
         kNq9IXqhdRZk2uMNXGsFOV2TS53RTG1w1iVfutUks7aiesSvQrSkXgaIRxCrOa4nwJlj
         aI3/agl2gEY+sKW9BX1cZRYZfBfNIlhhJp+8OJ8zJGDCYfByIlLceC8FxAOM5Bd6Rt1k
         uBDdo6XVPJlaUywFhI9iasNvPMXj2/p9cBgVcZNIQ1udJw1cUCTOcbFeMihylxlJT3Ye
         fSSg==
X-Gm-Message-State: APjAAAWZTJ7hIcKR6Gti0w2RiXJRLfh+LksiXnWCe93nvuxIN+im0VDG
        Hz3efHUi18FPj09JuVRWVJv13hSA5EkmQofttGnR2CAB3kV2fQ==
X-Google-Smtp-Source: APXvYqxnKS0A924FIoBJbowgFXTLr52yG7erbUqIptxnRj05jC4LjK8X9YRQWTtYOAhA3BZLrg5x0bSkXSAPOSYKQeQ=
X-Received: by 2002:a17:906:4347:: with SMTP id z7mr5547029ejm.117.1572244793445;
 Sun, 27 Oct 2019 23:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Sun, 27 Oct 2019 23:39:42 -0700
Message-ID: <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.

On Sun, Oct 27, 2019 at 8:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Utsav Shah <utsav@dropbox.com>
> >
> > git stash runs git reset --hard as its final step, which can be fairly slow on a large repository.
> > This change lets us skip that if fsmonitor thinks those files aren't modified.
> >
> > git stash goes from ~8s -> 2s on my repository after this change.
>
> Please line-wrap overlong lines.
>
> More importantly, "stash" may be a mere symptom that does not
> deserve this much emphasis.  What you improved directly is "git
> reset --hard" isn't it?
>
>     The fsmonitor may know that a path hasn't been modified but
>     "git reset --hard" did not pay attention to it and performed
>     its own check based on ie_match_stat(), which was inefficient.
>
> or something like that?
>
> >       if (old && same(old, a)) {
> >               int update = 0;
> > -             if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
> > +             if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
> > +                 !(old->ce_flags & CE_FSMONITOR_VALID)) {
>
> I wonder if !ce_uptodate(old) should say "this one is up to date and
> not modified" when CE_FSMONITOR_VALID bit is set.  Are there other
> codepaths that use ce_uptodate(ce) to decide to do X without paying
> attention to CE_FSMONITOR_VALID bit?  If there are, are they buggy
> in the same way as you found this instance, or do they have legitimate
> reason why they only check ce_uptodate(ce) and ignore fsmonitor?
>

Yes, there are other code paths as well. After reading the code some
more, it seems like there's no legitimate need to ignore fsmonitor.

> If there isn't, would it make sense to get rid of CE_FSMONITOR_VALID
> bit and have fsmonitor directly set CE_UPTODATE bit instead?  That
> would make this fix unnecessary and fix other codepaths that check
> only ce_uptodate() without checking fsmonitor.
>

There's a few issues with replacing it entirely that I've found.

One is the  "CE_MATCH_IGNORE_FSMONITOR" flag. This flag can be set to
let ie_match_stat skip calling refresh_fsmonitor repeatedly. This is
set only in one place right now in preload-index, and it's unclear how
necessary this optimization even is, given that refresh_fsmonitor has
a check whether it's been called already, and returns if true.

The second is that git ls-files has an "f" option that makes it "use
lowercase letters for 'fsmonitor clean' files". I think this can
simply be replaced by checking if a file is up to date instead of
specifically via fsmonitor.

If we do go ahead with the replace, we will have to be diligent about
calling refresh_fsmonitor everywhere, or we will have correctness
issues. I patched git locally to do this, and immediately saw a bug in
git stash where the underlying git reset --hard skipped modifying a
file it should have. In my opinion refresh_fsmonitor should be called
somewhere top level, like an initialization, but I'm not sure if that
makes sense for all git subcommands.

Do you think it's worth cleaning up and sending this patch instead? It
will reduce the surface area of bugs and remove a bunch of functions
like mark_fsmonitor_valid/mark_fsmonitor_invalid
