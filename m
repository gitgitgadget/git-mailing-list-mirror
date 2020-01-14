Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6251DC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590E24672
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNtQDvPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgANQxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:53:10 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46388 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgANQxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 11:53:09 -0500
Received: by mail-oi1-f179.google.com with SMTP id 13so12419741oij.13
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NKIBl9yQgBCzdFa5TGyYmzCD/irpb//VtmUIWf9xjC8=;
        b=gNtQDvPQ3Dhvfef9OS5KLg9WL+da0Wqms56MMXbHeDeV9RF7Pl0b5P5Qq+GXUvfgxg
         qcTm8+6xTqXuyTyn1Efl4+QKmVt6FUVPfNqI/zDQ21yfe6VLb7a8YW6KdVq0Od6VXERy
         zV5ARohxwcKFB4x0ymLra7E8mOBmuOPAJ43JulgAVo/lKbxJ4fC2FxFt/YFpauneAKG9
         0y+hnaYC4FjAKRNzKhYZ7hcs0uindjKgrsc4Bne72E6/FKavNBOTvxeBIfrfmAWId16M
         Uce9at4pBJ7+kEOMeET8exAMol7LsltI9QfKUCYo4cFfN79cIwJSUyVnjNM5YH7Lx7l/
         qpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NKIBl9yQgBCzdFa5TGyYmzCD/irpb//VtmUIWf9xjC8=;
        b=aeqVfkOj4wircc9r/F72ENmOgLnOmb99c1M4ML1ylXWatiOpwMXsVF6kIKbwxy5ajp
         g6xS3wB2lIH6O+iVnjpaIo+CY62sHOhnqQFNKJeAnOl/xX6ww2Vp4KCp+xq1YzrT50SU
         XudUheNPbVWgfRn1Fn2Nl8YW+Qwv/KfrmKLUr1IgZhCowBnQsgbKQA/r0XnlwfkN9rXP
         alvNY6FeABgDh6ryR4cJ7nH7shLtjJkpIwd1CrkVWHgvatBwaPGBJ0Yu645fNZb9j9CY
         SmFa0RVujd5qqKEGMaBjHH04utkJ9oVjW+ONMCfvQ4kBpQqOtwk2lwLLTUG9KqgynT7M
         t3GQ==
X-Gm-Message-State: APjAAAXw56h0pJeQC1izaySIFka+JQrtQODKdeNyAdEraKIbVzNuwn5q
        8wdBOLjXP+bN+0dmPsZoevs+0h60omqJ+JNQCAg=
X-Google-Smtp-Source: APXvYqwglqKamH4xL1Iif/PTeaJ0wAeNGSh5xroftZg+5RuGHFGIZ+cvp4qFhimy5QoD/kWJfhWCHXwYs666FlFtLtw=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr16402578oib.6.1579020788567;
 Tue, 14 Jan 2020 08:53:08 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Jan 2020 08:52:57 -0800
Message-ID: <CABPp-BG9eqbhnzU8gzJ_h+=XH4mSOj-Wb5SU7OjXz5ik6c+NnQ@mail.gmail.com>
Subject: en/rebase-backend (was Re: "rebase -ri" (was Re: Problems with
 ra/rebase-i-more-options - should we revert it?))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Jan 13, 2020 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> I will push out what I wish to be able to tag as the final [*1*]
> >> shortly but without actually tagging, so that it can get a bit wider
> >> exposure than just the usual "Gitster tested locally and then did
> >> let Travis try them" testing.
> >
> > I haven't heard from any failure report so (taking no news as good
> > news) I'll cut the final today based on what is already on the
> > public repositories everywhere.
>
> By the way, as one of the methods to double check that my result of
> reverting the merge made sense, I ran "git rebase -ri v2.24.0 pu"
> and excised the merge and the problematic topic out of the todo
> list.  With the rerere database populated beforehand, it was more or
> less a painless exercise (except for one topic, en/rebase-backend,
> which is one of the topics that was queued forking 'master' after
> the topic got merged *and* actually depended on what the topic did)
> and after about 1700+ steps (which did not take more than 20
> minutes, including the time spent for the manual rebasing of
> en/rebase-backend topic) I got the same tree for 'pu' I pushed out
> last night.

I wonder if I should have been the one fixing up the en/rebase-backend topic...

Also, with the new release and the review comments Phillip posted on
the en/rebase-backend series, would you rather see me address those as
additional patches on top of en/rebase-backend, or should we kick that
topic out of next and have me send a full re-roll?  I'm not sure
what'd be better and I don't mind going either direction...
