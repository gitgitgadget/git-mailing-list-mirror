Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA623C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 04:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbiA2EJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiA2EJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 23:09:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F8C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:09:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j23so14003041edp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mL9nMfZk2MV2ZNhei71XsCb/w/eEUU/A+BoZJelNy+w=;
        b=XmzHyc6A/b5V0XvSwkre6EqwGNI60HWMb5xAoAn1ARltQHbuqx/Ewi+N8g+4yLzBiw
         LhXjgbnCAEV/wYYsUcER90Ddm86tQVvBMAiWu6qn8yNlvtsre6b7zpgBL5SjERnCtkEZ
         Ks5guC/2wpV3PVgIYMq0JnHK4p96atS2jmd3zxHBNd4FCCrj5ihvYwGxlYbS/prDnnzQ
         UB+4XNQmeKawN/yKmaGe7BS5UhLpTzfOe2g5gdWMA4G9mtRTs/gQ9MUC1rXoLvM+UnKj
         PMhWHzVFvuhRjFS6gjXR1Cobfk8vmB6nvfmEO171hMleZTywlPtUtl6cpApm865qg3tD
         P/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL9nMfZk2MV2ZNhei71XsCb/w/eEUU/A+BoZJelNy+w=;
        b=rTpGIaJGYu/FE/CpwE0bEu+bab7A1rbN6L9WnQ1ZfyDMHP2+/QTG/GCAEXxYEwWrVA
         6ItnQJ7hNOSiKfkkOwbVmCug3iFGgt75H7dVr4BiJYJNmAzCnDk30H/6EbKf4VaUpl1W
         t+nlyJH14Gwg0mtrWgoixAd/mW3xalFFrnm74F5vaxH23Le3S0mq0OV04EWoio8MX10+
         sqc11uhbuwO/JFZCt0+ckw1EdVNoI5ZVB4v7FfZIMkFaHUhitFz2meZLNSFYQrJz8BAR
         kqE3+c414J/CSMgltHCwPpWzmyOuVRFSiYSlFNBcbNO+WgzVdcU05S0yoAsWGpmV5sk3
         npeg==
X-Gm-Message-State: AOAM530BxZUZIr+IzKddklTWNMp+o4u1S3V8/vd9BekwRGnqKBETPBUt
        X7Nsuos1IkvC5SxgfIx2zlJz1XiHU1yn1GJqieI=
X-Google-Smtp-Source: ABdhPJx1MgnyxAJCWWxBZFzFPa2VxwFPSS8C14kynv7uZVNJzWLDAKbLjJwSnNDQIyhr9Czb2KkHpnu7r7tG3yl1nSY=
X-Received: by 2002:a05:6402:40c8:: with SMTP id z8mr11446589edb.94.1643429364373;
 Fri, 28 Jan 2022 20:09:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
 <CAP8UFD3_Dx2aZObbUp7dHkFCp5w9mJG-s03Soz=9YDU=yE2NoQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3_Dx2aZObbUp7dHkFCp5w9mJG-s03Soz=9YDU=yE2NoQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 20:09:12 -0800
Message-ID: <CABPp-BHrjpEr=Pmea1Em+cntNavd_juO1+jV-OYCEs7G1qDGSw@mail.gmail.com>
Subject: Re: [PATCH 04/12] merge-tree: implement real merges
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 1:45 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Elijah Newren <newren@gmail.com>
> >
> > This adds the ability to perform real merges rather than just trivial
> > merges (meaning handling three way content merges, recursive ancestor
> > consolidation, renames, proper directory/file conflict handling, and so
> > forth).  However, unlike `git merge`, the working tree and index are
> > left alone and no branch is updated.
> >
> > The only output is:
> >   - the toplevel resulting tree printed on stdout
> >   - exit status of 0 (clean) or 1 (conflicts present)
>
> The exit status can now actually be something other than 0 and 1
> according to the doc and code below.

Thanks for catching; will fix.

> > +Performs a merge, but does not make any new commits and does not read
> > +from or write to either the working tree or index.
> > +
> > +The first form will merge the two branches, doing a full recursive
> > +merge with rename detection.
>
> Maybe this could already tell that the first form will also write a
> tree with the result of the merge (even in case of conflict) as this
> could help understand the reason why the associated option is called
> '--write-tree'. It could also help to say that we call such a merge a
> 'real' merge.

Makes sense.

> > The rest of this manual (other than the
> > +next paragraph) describes the first form in more detail -- including
> > +options, output format, exit status, and usage notes.
>
> >  static int real_merge(struct merge_tree_options *o,
> >                       const char *branch1, const char *branch2)
> >  {
> > -       die(_("real merges are not yet implemented"));
> > +       struct commit *parent1, *parent2;
> > +       struct commit_list *common;
> > +       struct commit_list *merge_bases = NULL;
> > +       struct commit_list *j;
> > +       struct merge_options opt;
> > +       struct merge_result result = { 0 };
> > +
> > +       parent1 = get_merge_parent(branch1);
> > +       if (!parent1)
> > +               help_unknown_ref(branch1, "merge",
> > +                                _("not something we can merge"));
>
> The second argument is supposed to be the command (it's called "cmd"),
> so maybe "merge-tree" instead of "merge".

Oh, good catch; thanks for pointing this out.

>
> > +       parent2 = get_merge_parent(branch2);
> > +       if (!parent2)
> > +               help_unknown_ref(branch2, "merge",
> > +                                _("not something we can merge"));
>
> idem
>
> > +       opt.show_rename_progress = 0;
> > +
> > +       opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
> > +       opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
>
> I think just:
>
>        opt.branch1 = branch1
>        opt.branch2 = branch2
>
> might be better for users as it should show the name as it was passed
> to the command.

After digging for a bit, I think in this case there actually isn't a
difference to users because both will give the same result.  But, if
that's the case, the simpler code is warranted.

> > +       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> > +       printf("%s\n", oid_to_hex(&result.tree->object.oid));
>
> I wonder if we can actually always output a valid tree when
> result.clean < 0. In case we might not, the printing should go a few
> lines below.

Yeah, I caught that and fixed it, but got it squashed into a later
commit.  I'll fix it up.

> > +       if (result.clean < 0)
> > +               die(_("failure to merge"));
> > +       else if (!result.clean)
>
> The "else" is not necessary above.
>
> > +               printf(_("Conflicts!\n"));

Yes, and the else clause should just be ripped out.

> > +       merge_finalize(&opt, &result);
> > +       return !result.clean; /* result.clean < 0 handled above */
> >  }
>
> > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > new file mode 100755
> > index 00000000000..e03688515c5
> > --- /dev/null
> > +++ b/t/t4301-merge-tree-real.sh
>
> I wonder if it would be better named 't4301-merge-tree-write-tree.sh'...
>
> > @@ -0,0 +1,87 @@
> > +#!/bin/sh
> > +
> > +test_description='git merge-tree --write-tree'
>
> ... especially given this description.

Makes sense; will rename.
