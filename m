Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA4CC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5264F09
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBBJbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBJbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:31:35 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF3AC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:30:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u4so21620227ljh.6
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7j3f/+9rX9v6Febx/3QlaYP1smPUrvP4Obb3g75ZLfk=;
        b=XD6ivtakWJpIsv99mHZPlig5DQJtAAeohUKQHxBYTiP4dx5wt6MmtWG4U/5hYsA9x7
         CAGAEEsuF/ZcB2nlgACyyyHuPcJ/IvLaypt7iUsp/eL33SHqzoQc8vWKjeNQCW1bMvvv
         o5LodjQlCPg4iJ4u/ihbBiNRD/0BOmIGmMwJzxz3na3Bvk7COvDAImnL+Cmj/s5YeY44
         bnaNHBtEjBzij2cLnbVf61zzm/tWKTxGY/x6R4PQU+GqEFDPAOTXzsLytZFEumHHzJTv
         yo4Xl6YLcFNCJ/M53gZuOpE/jicUGWDZXnspfxEJxQup2XLCwe/HfnYtN9YweXAV6VWL
         spgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7j3f/+9rX9v6Febx/3QlaYP1smPUrvP4Obb3g75ZLfk=;
        b=N+Hhle114WHJhDOQ36tezeNxFh5yTMEVv4ebWaTYxkPs0BMHNhX6I8syLADgQq5WiQ
         DL0sgzTkz0W3ZmTUVOOs+PL+ovHgZu4KHA6ZwAJEwnNuCW7xqkjGGNOhZHwYkCV6l9Aw
         CYA45PeRCNRBiLt9e3pxCnoDXxyawhePLBOhS1IVwDXaom6T/3r8fYDjjmS6oo2nWKGX
         +XDOBcn6jWtXF3vquG0Sok424rC+gzCezLTr33yJ1tDw/ySbc1vDb65tgpGRK9NBpXLW
         TSLKPkXvaG9NXyl2qeUh72281BhPGSwQD1gPSowBM8fXZC/HuC38qwlkytwtaVu0IvaS
         yYGg==
X-Gm-Message-State: AOAM532uf+70xq1VW8IGPwV5Zfq9W29IcuuFzphOmmVZydPkuLg309Cg
        MHFhzcvTpeHq+BZ+qLlFxuHjsbv8ale/Azm2sMs=
X-Google-Smtp-Source: ABdhPJwdv3l13Fbed+q29/tWR8BKBkgIluSm7Uw/J5reAlwm8Z60ATKEBMZM1uPWi1bkFkaudd0PJpTLHf/D+Aes0sI=
X-Received: by 2002:a05:651c:151:: with SMTP id c17mr12631179ljd.246.1612258253804;
 Tue, 02 Feb 2021 01:30:53 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net> <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
 <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
In-Reply-To: <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 17:30:42 +0800
Message-ID: <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 5:20 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 02, 2021 at 05:02:53PM +0800, Hongyi Zhao wrote:
>
> > > If you only care about topics that you have participated in, the easiest
> > > thing is to simply unsubscribe from the list.
> >
> > Do you mean I still can post to this list without subscription to it?
>
> Yes.

Does this rule apply to all the lists residing on <http://vger.kernel.org/>?

>
> You can also read the archive at https://lore.kernel.org/git if you
> later feel like checking for threads you might have missed.
>
> -Peff



-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
