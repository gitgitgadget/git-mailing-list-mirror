Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB78C35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052C5208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QHBEzwLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgBUGIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:08:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52770 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUGIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 01:08:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so419000wmc.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 22:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ym08PZJohErWX8JKpl8YOoZb2slgJgGmBIlp5FKBSo=;
        b=QHBEzwLyaFMwHua+sgxWGk/l1zllLfeH1aKewVjshPE8Ue8hISnA6lWWTJFU68GYFB
         hHWuN3qgySQ/QvC0OtK33TDxMwttFNWy0a3b6o1xfOGdpO+2WPXy7qPMZn0KrfdYrwwq
         fsJb1l4X7S3p9z7n05Q5/jMeMRS0aYgRhsL5mEd/PjKL+Ev/LVhfVK5JpvbSFubGRgFk
         hXvlHNYHGSDeivDYzN6mCMTixnM6EbzUwUYvohsCmhYptqfk0wbD2NoRFiYs3pynJjOl
         GIzwi+WpB/dTXhuNhpKgTPsjC3f6eqWmI95CBLP7Uszw16CqwE33PMNhMnHDzmDzoQO9
         iCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ym08PZJohErWX8JKpl8YOoZb2slgJgGmBIlp5FKBSo=;
        b=fN6othBcII2fnTTXJs1UY1gfYKeTIyTIrfeGvEXneQDpuoq56C6kxnyec0hK0pHDfv
         G1qHJpcZ5/fHdBazQG3ZEfpYV1It0sYiISdi51EZH+u0ZuZ6vlb5XQBg5XP43ol4g0bj
         4yNf1hwDLh/XA3vNLnlFyZSQKdMAM4EPFH9S3MtKLGwkPYGGs749GMDlbNhGlDHperZ2
         R9FrYPIgHdAU505s2uzk6Y3h97GY5syjJC9sFDQHfYBdxYeCgsGdnxczE2YFAEhPsFo/
         qRLin8QJI5UiTqNRuFcZyPItgZaqjgVKNGgQw42ulPYXV3liaGrBPnFFwVeY3bpJQbdp
         BZsA==
X-Gm-Message-State: APjAAAWloV2Etd8MNDGs/qzAmFvI30vvTZd6QXl3mTPMQL2RgpIgh9ZB
        C5UttlC2WCpciZsSSDgZRCbL8WkvJyBTpkV8nvL+GdmM
X-Google-Smtp-Source: APXvYqz8UnrZDsLo82lRcpLCBVPlRjbzq48mZBQERiXCmqKzJEIGsVSR5DDjsvl9tI8LSQBHgTQ13lSaz59h913nUbU=
X-Received: by 2002:a1c:e388:: with SMTP id a130mr1496473wmh.176.1582265298867;
 Thu, 20 Feb 2020 22:08:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net> <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
 <20200221011138.GB6462@camp.crustytoothpaste.net> <CA+dzEBk5D9x=sQnKDwAPHXOS_8gnA37X9sn+ccpfViEauiC5ww@mail.gmail.com>
 <20200221022558.GD6462@camp.crustytoothpaste.net> <20200221053221.GC1280313@coredump.intra.peff.net>
In-Reply-To: <20200221053221.GC1280313@coredump.intra.peff.net>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 20 Feb 2020 22:08:08 -0800
Message-ID: <CA+dzEBkGWdBm_=fbw97UmWg8DXtVrfGUFLDDrtmX-+bmkQaFjA@mail.gmail.com>
Subject: Re: git does not wait on hook exes (^C)
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 9:32 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 21, 2020 at 02:25:58AM +0000, brian m. carlson wrote:
>
> > On 2020-02-21 at 01:20:51, Anthony Sottile wrote:
> > > My hook in question is a python process: https://pre-commit.com
> > >
> > > It doesn't really do all that much on SIGINT but prints "(^C)
> > > Interrupted" and offers a crash log when receiving ^C -- this races
> > > with the git process terminating and causes terminal spew (sometimes
> > > with pretty bad consequences with input breaking until `reset`
> > > depending on which thing wins the tty reset race).
> >
> > Thanks, this is helpful context.  I don't know that Git waiting for the
> > process is going to fix the broken terminal state, although it will
> > likely fix the jumbled output.
> >
> > I'm not planning on writing a patch, but I think an interesting patch to
> > see might be if we called wait(2) in a loop in a SIGINT handler but
> > didn't reinstall the signal handler, which means that a second Ctrl-C
> > would kill Git.  I believe that's what certain other programs do, and
> > that might address many of the problems in both scenarios.
>
> The run-command struct has a clean_on_exit flag, as well as a
> wait_after_clean flag, that would do what you want: when we're killed by
> SIGINT, we'd pass the signal on to the child and then wait for to
> finish.  That first step should generally be unnecessary for SIGINT
> (since as you noted, it will usually be delivered to the whole process
> group), but it shouldn't hurt.
>
> To get the double-^C behavior, I think cleanup_children_on_signal()
> would have to be reordered to pop the signal handler first before
> calling cleanup_children().
>
> I'm not quite convinced that's all worth doing, or wouldn't have other
> unforeseen consequences. But if anybody is interested in experimenting,
> I think the patch would only be a few lines (set those flags when
> running hooks, and then that reordering).
>
> -Peff

The small patch at least solves my issues and prevents the zombie
processes so I've sent it to the mailing list -- thanks for the
pointer.  I had found `wait_after_clean` in my initial investigation
but had missed the `clean_on_exit` flag!

Anthony
