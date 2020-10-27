Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1801C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A720809
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakanov-su.20150623.gappssmtp.com header.i=@bakanov-su.20150623.gappssmtp.com header.b="JnIIt5vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759455AbgJ0WCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:02:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40921 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756627AbgJ0WCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:02:23 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so3241840ioo.7
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakanov-su.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzVOTP+BEeQkUhQrXmvFuPXVYHoZ5gu1+f4gDuarbf0=;
        b=JnIIt5vnWJitPaIYKAQdmZWfrGf00rvuZ/E2Y5r9VrBhI1OgoiQHJRB7oh2aYXeth8
         fwmzq64dijS0j/+HpkCBgoaMGt3NtRl6GaPO2krKFkH9imhbe/V7/5YiUl9I3+bFQHsV
         7hpdYkPIWfsyESdt4pNsT/79nA0QiKSJx1HIA11CYd0to5r9b1tJEmytDzDOceJE4P1z
         RY+z2M2+nkdFFZYavi3OM1GknHpHFYQMT8NGpp/ozSSEfhfAEDkXXZP5LyXjfL6zpeZd
         FzD7cf8xUaUCkYeV5UMTLzDQsr+Xfuz7dRoP+L/TvhX/iwv+XhU4UbfkQokcxanhf7rz
         ofcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzVOTP+BEeQkUhQrXmvFuPXVYHoZ5gu1+f4gDuarbf0=;
        b=m88nse7ezIIW/j0T8d3o+o/cM0oVV2jXaNHZMIvUY+4G5tAlLqxOKQTPrqO9RxhQH5
         I/XM7uqGn/SnW1m0HWH6J+JLssWpzWLnyJiuFIaH9bqXR/S+mYouWena+y8MGQ00o2jQ
         Ly9Ap0egx8UWdVb/bBnI+3d5h0QAynVYFD6/0A7U4IWhSTB4VGFaMQQIOlEi/wghuK1x
         HTnaM6otAQzaGl4MsvYh5xpCSp9/Ot6YMhr3CVosxsAKCPfYYwc4XA+WrVHqaQyoAGSp
         u8oFAlMjhNVuD731vO795de5Vg4SPfm7m0MJjS2UbDGTrZCCeaWQIJCN+xbGbE6/7O7a
         7GSA==
X-Gm-Message-State: AOAM530e7e77e688Is2rzj54vjfbtX7IlK27kGB1kDEX+U6uJ5R3C2ur
        h1ZMnpVP9E+inpc1B0hfL/7luv3Ch2fdIpZURhTrxKWcphbNEMFQJ4w=
X-Google-Smtp-Source: ABdhPJza8h6TXzWXW72wmacoZP5dnWWDdVPYtehkA6axFyMi/tM6u9PlFKki5fzfxC8+erQxRnveRedOzKSgfgU9J8Q=
X-Received: by 2002:a5d:9813:: with SMTP id a19mr4002077iol.194.1603836141980;
 Tue, 27 Oct 2020 15:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <xmqqblgnbea5.fsf@gitster.c.googlers.com> <20201027215638.GI5691@mit.edu>
In-Reply-To: <20201027215638.GI5691@mit.edu>
From:   Filipp Bakanov <filipp@bakanov.su>
Date:   Wed, 28 Oct 2020 01:02:11 +0300
Message-ID: <CAAdniQ4vx4z9KnfvG7thzxf1xBa=P_nnbY1G=RTFUBb4Zxqeaw@mail.gmail.com>
Subject: Re: Proposal: "unadd" command / alias.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Indeed, I have a similar alias in my ~/.gitconfig

Why not just add it to git by default for everybody? revert-file is
also ok, anything except `checkout HEAD --` will be good.

On Wed, 28 Oct 2020 at 00:56, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 27, 2020 at 01:32:50PM -0700, Junio C Hamano wrote:
> > Filipp Bakanov <filipp@bakanov.su> writes:
> >
> > > Hi! I suggest to add "unadd" command, that will undo a git add command.
> > >
> > > git unadd path/to/file
> > >
> > > It will be an alias to:
> > >
> > > git reset HEAD -- path/to/file
> > >
> > > The motivation is that I always forget syntax and have to google each
> > > time I want to undo accidentally added files. Unadd is just much
> > > easier to remember and quite obvious.
> >
> > The alias is for you to do the above, I think.
>
> Filipp,
>
> Indeed, I have a similar alias in my ~/.gitconfig
>
> [alias]
>         revert-file = checkout HEAD --
>
> Adding
>
> [alias]
>         unadd = reset HEAD --
>
> to your .gitconfig would do what you want.  As a BTW, my favorite
> alias is:
>
>    lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>
> Sample usage: "git lgt origin.." or "git lgt -10".
>
> Cheers,
>
>                                         - Ted
