Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817B01F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfHFR0i (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:26:38 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45702 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFR0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:26:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id v18so33954199uad.12
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdFmcIYO+aDOUOgXt/8Nf5YjZcY/xKEaVGFFytxYk28=;
        b=r2iUgjJgNTPdriMJ3wkLKsTmnDGGG8TEvKw2U4aVKrcv1mZM/C/j1TxxdeYemi7vHD
         FmucSivNfnIA9ULRtR3g8MKOAEOQJ2dN9V8g86RJQ13wZy/78lA8JbBMSNYGxar6xINx
         MLliymqTOJ7Dzeiu7S1WmC54M2nqyDpD120qtYrlO4cGKCUJbY1LE4YeAyz6iD4taEyz
         4Q1neqEAJTdnjzqYpN184usjloeB2OeJfwTezyW+yUPWBndzMT5C/dxsliD4GEmsNxXf
         8+HFlHxBd/DvBZIr44vJHdakikxNmjaPKWlAKdEJWr4IwF88mmNdR5mr+BwgZxK4j3Il
         qZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdFmcIYO+aDOUOgXt/8Nf5YjZcY/xKEaVGFFytxYk28=;
        b=AiXfq92u1gIFQQ26DqbGBBQy2VjO+gXnYDJeKr/2tFQ6NMSacCtLE3uerIcDomqKCx
         SIxPRLKo9jJIdx1YR1sYTImNmq15IEl/RLZxGMc1ycNAXr/wql3gsmI5SiideJrIqRre
         UMhR3/Je9Hv5Za0vN0IgpU2l1JOWikKVl4uPH5POOu35CIySdNWEQRkKc1fbv4eL5M64
         8v0JTIyj9loO5Qbn4cZWCh1n3qCkKE6h8C7y1CAub4P8vwXQ9ABYhp/VGAIiPXPYHH6a
         XBMSHnt00Mo+B/tzBwLezGEU2ALilXLrsXKuP6rzCQErpWcCTRuK21tZ9Zuhf5A9AM3K
         420w==
X-Gm-Message-State: APjAAAVwxpTyGXCnOxP7s5NOzTm80/ELQKes8W44tBFsdWCiJ9VXPNVO
        1dVeTBKASLthTfXCGv0BZu8u/4MxcQg2HHYlByo=
X-Google-Smtp-Source: APXvYqxOm1K6WRphbNUNqAHnFXkgyY0a6clBk3ZENt5QpSeI6GrTgi+UjcD6c59FGMko7GMWhEQ+06QlJosfh3gV6+Y=
X-Received: by 2002:ab0:3159:: with SMTP id e25mr2210305uam.81.1565112396722;
 Tue, 06 Aug 2019 10:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190726220928.GG113966@google.com> <20190805223350.27504-1-newren@gmail.com>
 <xmqq1rxykz91.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rxykz91.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Aug 2019 10:26:24 -0700
Message-ID: <CABPp-BHpbmZQyO72N7i_wn9RpE-bA-YGLZCR-9CDt-QGfExmGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 9:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Ever since commit 8c8e5bd6eb33 ("merge-recursive: switch directory
> > rename detection default", 2019-04-05), the default handling with
> > directory rename detection was to report a conflict and leave unstaged
> > entries in the index.  However, when creating a virtual merge base in
> > the recursive case, we absolutely need a tree, and the only way a tree
> > can be written is if we have no unstaged entries -- otherwise we hit a
> > BUG().
> >
> > There are a few fixes possible here which at least fix the BUG(), but
> > none of them seem optimal for other reasons; see the comments with the
> > new testcase 13e in t6043 for details (which testcase triggered a BUG()
> > prior to this patch).  As such, just opt for a very conservative and
> > simple choice that is still relatively reasonable: have the recursive
> > case treat 'conflict' as 'false' for opt->detect_directory_renames.
> >
> > Reported-by: Emily Shaffer <emilyshaffer@google.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >
> > I really should introduce constants like
> >   DETECT_DIRECTORY_RENAMES_NEVER    = 0
> >   DETECT_DIRECTORY_RENAMES_CONFLICT = 1
> >   DETECT_DIRECTORY_RENAMES_YES      = 2
>
> How would they compare with MERGE_DIRECTORY_RENAMES_* macros
> I see at the tip of 'pu'?  init_merge_options() seems to read
> one of those values from the "repo settings" and copies it to
> the detect_directory_renames field, so I am reading that they
> must be identical.

Indeed, it looks like Stolee has done my work for me -- though I would
suspect that his change won't be merged down to maint, and I am
assuming that my patch might be.  If you don't want to merge it down
to maint, I can rebase on Stolee's patch; just let me know.  (And if
you do want to merge it down to maint, I can send a subsequent patch
to modify and adopt Stolee's naming.)

> > and then use them in the code to make it clearer, but I wanted to make
> > the code change as simple and contained as possible given that this is
> > built on maint, fixes a BUG() and we're already in -rc1.
> >
> > I know this bug doesn't satisfy the normal criteria for making it into
> > 2.23 (it's a bug that was present in 2.22 rather than a regression in
> > 2.23), but given that it's a BUG() condition, I was hoping it is
> > important and safe enough to include anyway.
>
> I do agree that it is sensible to avoid doing any funky thing during
> the virtual base merges, whose result is much less observable (hence
> harder to form the right mental model in end user's head) than the
> outermost merge.  Do we want to allow this for inner merges when the
> setting is 2?  Wouldn't that hit the same BUG()?

No, it doesn't hit the same BUG().  Hitting the BUG() only came from
having unstaged entries at the end of an inner merge, which only came
from the 'conflict' setting for directory rename detection.  Having
directory rename detection completely on (detect the rename and accept
it as the resolution), or completely off (don't detect directory
renames, i.e. leave old pathname as the resolution) both have well
defined resolutions.

But that doesn't completely answer your question about whether we want
to have directory rename detection for the inner merges, it just
suggests we have to avoid 'conflict' as a setting in that case.  Let
me look at the same testcase:

> > +# Testcase 13e, directory rename in virtual merge base
> > +#
> > +# This testcase has a slightly different setup than all the above cases, in
> > +# order to include a recursive case:
> > +#
> > +#      A   C
> > +#      o - o
> > +#     / \ / \
> > +#  O o   X   ?
> > +#     \ / \ /
> > +#      o   o
> > +#      B   D
> > +#
> > +#   Commit O: a/{z,y}
> > +#   Commit A: b/{z,y}
> > +#   Commit B: a/{z,y,x}
> > +#   Commit C: b/{z,y,x}
> > +#   Commit D: b/{z,y}, a/x

Here, if the user has directory rename detection fully on
(opt->detect_directory_renames == 2), then the fact that commits C and
D resolved the merge differently is perhaps more surprising, because
the default would be to just accept the rename.  That means one side
(commit C) is likely to have just taken the default resolution, but
someone (whoever created commit D) made a manual effort to undo the
directory rename.  Now, if the virtual merge base doesn't do directory
rename detection, then it'll match commit D which undid the directory
rename detection, and result in commit C winning and using the
directory rename.  That seems like the wrong choice to me.

So, I think that if opt->detect_directory_renames == 2, then we really
do want to use directory rename detection on the virtual merge base so
that we don't silently miss someone manually undoing the directory
rename detection on one side of history.

The trickier choice comes when opt->detect_directory_renames == 1 (or
'conflict') because then we don't have a sane
avoid-accidentally-matching-one-side solution.  I'm not sure there's a
"best" choice for this case, but we should certainly at least avoid a
BUG().  The simple ways to do that were to translate 'conflict' to
either 'false' or 'true'.  I can't give a good rationale for why I
picked 'false' over 'true' in that case with this patch; either seem
equally good, but 'false' has a slight performance advantage over
'true' so I went with it.
