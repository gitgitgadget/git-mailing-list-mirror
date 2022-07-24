Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F4C433EF
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 05:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiGXFJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 01:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXFJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 01:09:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F431582D
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:09:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v28so6381365qkg.13
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1KKY2IjLRx0UU8HCDA+J3rEyoW+60FFQsFzyn6a7wY=;
        b=IDdCdoSvx83YhFVqH3ZcihcTk+TVLVU29uawIfeAAiHefvJun5QvdBpwjW8mpWrd9j
         mQ6/x0iXUdlD57HpeWFnBPkxd3wXaASpVZfAf+Kj/B3PE0mxommiZfFmSWQnJKFMoAMy
         gL12GWcZwsc0suUZAMfFjkg7lPpnr3WrtsVc4qihyUPIAVc+LVJqcCT+PDrOtLCEByGi
         G+XfY4yTM6C0p1qwjoc4ox/o39GqTLxFibtRavJ+66B1rhfuO77FjABFCMHbN/mxGce2
         2P9HXRNp5hG5//EdHTGRvnZ6f8v1Bb1yckwzYs/T9+/vG71H/asXU9xbz4HoisFUsdwJ
         ZctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1KKY2IjLRx0UU8HCDA+J3rEyoW+60FFQsFzyn6a7wY=;
        b=rzzkCJ9JQE4+SQ4ucCg6U63bXQX/f2D+GdtLq46osyOwBIgibS8ei+25vFc4Iqz74x
         ArQFUk9QBQsAn2ZahXFcJCVPkwSsbe0WmVVhKimXl1NEypqrXhY/eGzJ0XBpA+R2+Ggx
         laPuH0dBmvIJZ4c3kZumzjkHRI06sOhgFsvUCrXjmHWAcpiDbRURNFTIewJm2lXltEnv
         jj4XqFtRLUobCdvk6D/60pUa/pk2M2UyGTvQDb1wHcNSsnzhwqyS7uPnrvPdtTYWy00o
         L8gtLModcTAzQwDKOTER7Di1M25RkCBhqkmrHVuKxUgWfgNnuTM2YQWi0MctS5yb+kBM
         8BuA==
X-Gm-Message-State: AJIora9P7may0ddt7n8ZSjk+C0/u9DMOp/2nXwFA1W3bHKTs4XHx48Xj
        WJe/wDlSj6WsjXrj0UXemz7A20XiQG+e/T8d8WU=
X-Google-Smtp-Source: AGRyM1tNykvqxYZ+e7+G1I5vVtBRu8GLAcyn6x8DzksPu9HLgzgN0mgrmxj9Uirw7hjIER5+bCZGNi1tWwK6nuH8vkk=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr5168201qki.131.1658639353434; Sat, 23
 Jul 2022 22:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local> <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jul 2022 22:09:02 -0700
Message-ID: <CABPp-BHNYbLEWeG+XSzGxcTxsQ2wA2COX6DqtvVZ6Nm1KG7CEQ@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     Glen Choo <chooglen@google.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Stephen Finucane <stephen@that.guru>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 2:29 PM Glen Choo <chooglen@google.com> wrote:
>
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>
> > On Mon, Jul 18, 2022 at 06:18:11PM +0100, Stephen Finucane wrote:
> >> ...to track evolution of a patch through time.
> >>
> >> tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 l=
a the 'Change-
> >> ID' trailer used by Gerrit into git core?
> >
> > I just started working on this for b4, with the notable difference that=
 the
> > change-id trailer is used in the cover letter instead of in individual
> > commits, which moves the concept of "change" from a single commit to a =
series
> > of commits. IMO, it's much more useful in that scope, because as series=
 are
> > reviewed and iterated, individual patches can get squashed, split up or
> > otherwise transformed.
>
> My 2 cents, since I used to use Gerrit a lot :)
>
> I find persistent per-commit ids really useful, even when patches get
> moved around. E.g. Gerrit can show and diff previous versions of the
> patch, which makes it really easy to tell how the patch has evolved
> over time.
>
> That's not to say that we don't need per-topic ids though ;) E.g. Gerrit
> is pretty bad at handling whole topics - it does naive mapping on a
> per-commit level, so it has no concept of "these (n - 1) patches should
> replace these n patches".
>
> I, for one, would love to see some kind of "rewrite tracking" in Git.
> One use case that comes up often is downstream patches, where patches
> are continuously rebased onto a new upstream; in those cases, it's
> pretty hard to keep track of how the patch has changed over time

Two angles I can think of that partially address this:

1) If you have the old commits still around and know what they were,
you can run range-diff to see differences between any pair of versions
of the commits.

2) cherry-picks and reverts might already include a link to an "old"
commit for you in the commit message ("cherry picked from commit
<hash>" or "This reverts <hash>").  Those could be used to show how
the new commit differs from what would have been done with an
automatic cherry-pick or automatic revert.  (By "automatic", I
basically mean what the state of files in the working tree would be
when the operation stops to allow users to resolve conflicts.)  In
fact, I wrote some patches to do precisely this quite a while ago
which are up at https://github.com/gitgitgadget/git/pull/1151 if
you're curious.  But this approach is not useful for general rebasing,
because there's no automated way to find out what the original commit
was so that you can take a look at such a difference.
