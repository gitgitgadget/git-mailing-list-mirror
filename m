Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11ABC433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiAAVLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 16:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiAAVLV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 16:11:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5FC061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 13:11:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so120934664edv.1
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 13:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+lqEnedWahtWcBi9Ih9gVueIT0iSxO8csNnW6xKPQQ=;
        b=eBsaAduAyTMKpeYJfa+Lz4Mu6RqgbvedG3Z4uH3RKfmrfo6OQJLVmB3mtkLGArUlUI
         05wLv2heW0uJXBA6SpiffrfIscFXK5Rjm7zviBtX9rHZtbFsAbC1PWK4ThHIWx7po95j
         L8WXSslsdXWQ2VagO3s9uK3uTP6rumvlwpARhQ/pGaoTTHghfTuo7Pc/LBW+DoCKwbO1
         CfIbISCvfb5cxR02BV9q+4H+8bvgG8VAKbx8i4PF7TSCAkpAEgQ0gdN4xXJZBFh8C9se
         OIf83nRsM++L+xH23JeGr+DXuqj7HQrMrSkJX/7QGjj4OVhKM/MCrR6uTv029p+VBSBw
         KofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+lqEnedWahtWcBi9Ih9gVueIT0iSxO8csNnW6xKPQQ=;
        b=tVqzHps/+xb0bKvW4J6DSU7eGQHvSWxs+8zu+kQfjD3CG9Lz9jrP3n8WwwhegqufmN
         7RuF/+ikDS/7iqqAs+wMmQPtOzYgE+6653Jtwh1gaP6AOrppZJZXwPQHCR7lDWaMvfhH
         2z1DqvaNlkUqhzH3OF05i3K4S7yuhv2p4EXaVb7TBBx9TpvWl3JaJApIagZQ6eYzODib
         6mOA8YXBXUlz+iO4SMkL1m4VRtOOGXGh+02cUK1+7GcQNFJlWGV4cVAGeYh/T7Q70LpK
         tvppWmmrn1JQ1BYcGCg/bC6839VQigL5RQbGrvwS/k1ROpCHlTXPQIaqGLwFzPsWhQjO
         ewaQ==
X-Gm-Message-State: AOAM533jjszYhhiArlOdjoI4Q8r03dR8mNtX1aDFI6XrSWtVqt/oDJVW
        m3A97NMr24ig7vJ23JqZ6gm3EAIRVrfBmgI+meg=
X-Google-Smtp-Source: ABdhPJygOqnCw33w/NAzrPQIbhHpS3wuUdta6Cp4iXT/iyy3tUaFxUOxcNOtJnm2dr3Cs62p3k/wGICAS2/WSzifkDY=
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr39502475edb.33.1641071479032;
 Sat, 01 Jan 2022 13:11:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
 <20220101200824.isvinnb2zmobhfqq@gmail.com>
In-Reply-To: <20220101200824.isvinnb2zmobhfqq@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Jan 2022 13:11:07 -0800
Message-ID: <CABPp-BHpK8hPsiuHoYsf5D_rjcGLSW-_faL3ODoh56pG_2Luwg@mail.gmail.com>
Subject: Re: [PATCH 4/8] merge-tree: implement real merges
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 1, 2022 at 12:08 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Fri, Dec 31, 2021 at 05:04:00AM +0000, Elijah Newren via GitGitGadget wrote:
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
> >
> > This output is mean to be used by some higher level script, perhaps in a
> > sequence of steps like this:
> >
> >    NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
> >    test $? -eq 0 || die "There were conflicts..."
> >    NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 $BRANCH2)
> >    git update-ref $BRANCH1 $NEWCOMMIT
> >
> > Note that higher level scripts may also want to access the
> > conflict/warning messages normally output during a merge, or have quick
> > access to a list of files with conflicts.  That is not available in this
> > preliminary implementation, but subsequent commits will add that
> > ability.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-merge-tree.txt | 28 +++++++----
> >  builtin/merge-tree.c             | 55 +++++++++++++++++++++-
> >  t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
> >  3 files changed, 153 insertions(+), 11 deletions(-)
> >  create mode 100755 t/t4301-merge-tree-real.sh
> >
> > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> > index 58731c19422..5823938937f 100644
> > --- a/Documentation/git-merge-tree.txt
> > +++ b/Documentation/git-merge-tree.txt
> > @@ -3,26 +3,34 @@ git-merge-tree(1)
> >
> >  NAME
> >  ----
> > -git-merge-tree - Show three-way merge without touching index
> > +git-merge-tree - Perform merge without touching index or working tree
> >
> >
> >  SYNOPSIS
> >  --------
> >  [verse]
> > +'git merge-tree' --real <branch1> <branch2>
> >  'git merge-tree' <base-tree> <branch1> <branch2>
>
> This is really exciting. It could replace the merge-machinery of git-revise
> (which is a "fast rebase" tool).
> I think for cherry-pick/rebase we need to specify a custom merge base,
> would that suit the new form?

I'm glad you're excited about it.  :-)

I think having a server side tool for replaying commits (which can
double as a fast rebase/cherry-pick tool on the client side) is also
important, but I think it should be part of a proper builtin, not some
script that calls out to `merge-tree --real`.

`merge-tree --real` is simpler, though, so I implemented and submitted it first.
