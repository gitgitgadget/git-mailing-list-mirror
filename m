Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356BC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7E920674
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKZA6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:58:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45555 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:58:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so20316007wrs.12
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJzKokL8xqsvjvUU7DHQ6DDKXZMTLNDrEt7neI6m4P8=;
        b=IUe5+IrCUR5TnyOG2CFaqz0RAE1hYEEZnw0SIWmSX0GTHxrS5qCCezVvePK0SMMNAf
         NAlZmqdZWFg55okdx+qWJgSObBVb9HE8L/KIM4w0TLmPpUKXOBHrLmrwTHNNBgcEeDmc
         qmS0gJYVjexxpMHoGsjVQmz640mQbiXCwOvx5AfXQ7tWIgNWCxBuJkm+dwqOoSk9TjBM
         EHfAt+ElGAeeD3FElq1l1IdGOgpLOX9wc3oGrbHNmqnSa1VePXlnRI5P4MrC9NbqJeQV
         DocVGbRhDpAydrvhnu6OfexqH35TqVF/MuD9vU4c/uBTrOuppnMGhAXIJ8luD1xKQiu4
         +TBA==
X-Gm-Message-State: APjAAAUw2iL8qTZe6v15bB6uaCFOyCmB7uCcXIX4pN6te+D9hq3PXsv3
        owWCV45m0wpeyp1z9m1qGr9DbzKEmOC5hsNEa69nEQ==
X-Google-Smtp-Source: APXvYqxvTLoPsuDa7FEWUVZLwJzoGZBDMnFGLyOOOkUVEo6tRZIrVNeJqyNt/Q7C0134P9/bQCSEOXk8b/7Qw2Z2MwE=
X-Received: by 2002:a5d:6083:: with SMTP id w3mr35836265wrt.308.1574729924045;
 Mon, 25 Nov 2019 16:58:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574296987.git.liu.denton@gmail.com> <cover.1574449072.git.liu.denton@gmail.com>
 <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
 <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com> <20191125235702.GA6250@generichostname>
In-Reply-To: <20191125235702.GA6250@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Nov 2019 19:58:32 -0500
Message-ID: <CAPig+cQqK-HiDjmnBFo-qeE6cZ73EveWg6Ygb-4BX3X_iPSJZA@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] t7700: stop losing return codes of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 6:57 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Sat, Nov 23, 2019 at 10:49:44AM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > > -   objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
> > > -           sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> > > +   git verify-pack -v pack-$packsha1.idx >packlist &&
> > > +   objsha1=$(head -n 1 packlist | sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> >
> > We probably should lose reference to SHA-1 and use $OID_REGEX; this
> > is obviously a #leftoverbits material that is outside the scope of
> > this series.
>
> Since the theme of this series is test cleanup, I believe that it's
> probably appropriate to roll these changes (and the ones below that I
> omitted) into the current series. Since it isn't too much work, I'll
> send them out in my next reroll.

It may not be too much work for you to keep adding more (unrelated)
changes to a series, but doing so increases the burden on reviewers
unnecessarily, especially for a long patch series such as this one.
Generally speaking, each iteration should help the series converge to
the point at which it can finally land (be merged to "next"). Thus,
ideally, each iteration should have fewer changes than the previous
one.

When you add entirely new changes which are not directly related to
the changes which begat the series, that iteration diverges (not
converges). It creates extra work for reviewers (who are trying to
help you land the series) and makes it less likely that people will
want to review each new iteration since a series which diverges with
each iteration makes the goal of landing the series a moving target
(thus, represents never-ending review work).
