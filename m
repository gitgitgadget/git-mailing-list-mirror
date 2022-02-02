Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8AC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiBBV5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiBBV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:57:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B266C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:57:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j23so1357476edp.5
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LB3b1A9T98ao40dyuTSxgnev034lPBQ97xzcIrcKlI=;
        b=k/NLfXGkG8AfM/F63S4Tm9f/anMnDRk35TOMWyxPAslWvx9SfPfLpuPZNC0mi9wm/Y
         rJ/UypN/APUvm5rzL22UIaeKk1y9xgldJIS8FZ/ABgTW8stY1ecVp1my66S765EV6Qr+
         NhlBwVprBXVsN2/GwUhbBXcW+aYeVUK4ledTpCRwdZ/P2nsDQF12UCxzFgfBIXzZaL7f
         FS2cj2edpXp/29sJj9EpRQkZwgcaymWqNlRe+IiyDqAf6NJAJclrQ5TEB7mv5TBln+AQ
         JTP+0YuvF/Hg5qaYrEGgNETHXWQtiH94qlVpm/Fg10ss2FU70Ly9dM2R0lBHePePJDm9
         vQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LB3b1A9T98ao40dyuTSxgnev034lPBQ97xzcIrcKlI=;
        b=h64Y2mguUdF21UOvO1n3LT6KR+htB4aWduZ/lvOsRJLEoq31fy8bFRAXt3CFHJv+CD
         F76apPxlGizJveQo+3ba897RfwSdPWwBlsoncHnLpQcGtBowbSCzFHS7a597i6ubwY+i
         sFrg2y8hDwEB5b18rHN/M3ZyEpdO+vLirkrk1EFU/OvfkGaRPxVrJAQWOJynyehZEroj
         zbDUsWNwjhFUlxRQIEJqshZjCtzeXrvisUQX9PakoN2M9r+1mtIhhs+FEKOPBTheLRz2
         QBakjLd3t/z1XU2FOeMHoO8BL73EY4BrR1ye3iJUa1v4IDWmzyKMGfP5zgSf3B/u6NbF
         yyRg==
X-Gm-Message-State: AOAM5332LzyyLVa0s1wOMxVVzopDsg7hZH5ugatyleNMyOGF/H/VN6gV
        mudaMVtkfRJmOLqGRpqG8P8pL4cXWhLTkODjKgA=
X-Google-Smtp-Source: ABdhPJxo/jMv8B54B14YabIPoDjlZbVuVfGm10pfVqRoPZfSAIn17jQSg6BKTxiaNG/Dpj5If7zp1JhMPuwBLkTq05E=
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr32308267edb.309.1643839027968;
 Wed, 02 Feb 2022 13:57:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g>
In-Reply-To: <xmqqy22tx8t1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Feb 2022 13:56:56 -0800
Message-ID: <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 1:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -392,7 +395,46 @@ struct merge_tree_options {
> >  static int real_merge(struct merge_tree_options *o,
> >                     const char *branch1, const char *branch2)
> >  {
> > -     die(_("real merges are not yet implemented"));
> > +     struct commit *parent1, *parent2;
> > +     struct commit_list *common;
> > +     struct commit_list *merge_bases = NULL;
> > +     struct commit_list *j;
> > +     struct merge_options opt;
> > +     struct merge_result result = { 0 };
> > +
> > +     parent1 = get_merge_parent(branch1);
> > +     if (!parent1)
> > +             help_unknown_ref(branch1, "merge-tree",
> > +                              _("not something we can merge"));
> > +
> > +     parent2 = get_merge_parent(branch2);
> > +     if (!parent2)
> > +             help_unknown_ref(branch2, "merge-tree",
> > +                              _("not something we can merge"));
> > +
> > +     init_merge_options(&opt, the_repository);
> > +
> > +     opt.show_rename_progress = 0;
> > +
> > +     opt.branch1 = branch1;
> > +     opt.branch2 = branch2;
> > +
> > +     /*
> > +      * Get the merge bases, in reverse order; see comment above
> > +      * merge_incore_recursive in merge-ort.h
> > +      */
> > +     common = get_merge_bases(parent1, parent2);
> > +     if (!common)
> > +             die(_("refusing to merge unrelated histories"));
>
> It appears to me that "merge-tree" in this mode, with the above
> code, cannot be used as a workhorse to implement server-side
> cherry-pick (or revert), which needs to allow the user to specify an
> arbitrary "common ancestor", instead of computing on its own.
>
> To replay the change made by commit A on top of commit X (i.e.
> "cherry-pick A on X"), we have to be able to say "compute the
> three-way merge between A and X, pretending as if A^ were their
> common ancestor".  The story is the same for revert---we compute
> three-way merge between A^ and X, pretending as if A were their
> common ancestor.
>
> The above interface into this function, sadly, does not seem to
> allow such a request, unless I am missing something.
>
> And if I am correct, it is a shame---after all, the point of the
> merge-trees command is to take three trees and run a three-way
> merge, and not being able to merge three "trees" and require
> "commits" makes this mode much less useful than its potential.

Yes, you are reading right.  I think the cherry-pick/rebase
replacement actually deserves a separate command from what merges
should use; replaying a sequence of commits just has a number of UI
differences and abilities that I think pull it in a different
direction.  I didn't want to wait and submit everything all at once
(this series is long enough), and I figured that providing the in-core
equivalent to `git merge` was a simpler first step worth submitting
first before later providing the in-core equivalents to `git
rebase/git cherry-pick`.

(Also, I'm a bit wary of providing a command meant to just do a single
three-way merge with a defined merge-base, because that seems to be a
path towards returning to a scripted rebase.  Having a way to do only
a single such special merge is fine but we should avoid encouraging
people to go down that route.)
