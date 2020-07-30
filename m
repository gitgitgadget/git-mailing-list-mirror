Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5343C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937282075D
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596070693;
	bh=/G1tLcUvjspKM9i+rPeMDBSkxlChSTZPVVgx/UrtLVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ge1VWj5o5twYXTgrYvG0mh3vZWI4n5OwKpj9+lBZCz4iM89an+PNTYMTfKCpRFMhM
	 1qLdCh8V8OO+Z6cKT03NWwnhwPvA3wsooNrsIWIrfkn5ys5B356BKaGxWvM/WWV4Eh
	 LSjiCsFBzsfm9OTiiaCQu7/+SG2SxphumGW6rI0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG3A6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgG3A6M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:58:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274EC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:58:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so27038430ljg.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NznbcYXOSp01EyGosbSRn8yWy++TN0gw+icVZ32E2Y=;
        b=Vx6QqqKhDWX/jkkXuVZvyK5cWcvAKS1WUUrFKTLMI+X+wV9IDkF6+B6aljC0WmD7SJ
         drRIwXxVKMrIVmbot1DlfH0dJmmpG4n0T+1H+5OwjkZDPqyFvgvHj0qDPi9btxCBLEhj
         WBLCxelhXqMAyrte8RwPX6tkynStFrabSp7Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NznbcYXOSp01EyGosbSRn8yWy++TN0gw+icVZ32E2Y=;
        b=TkvflqMfU9z0iC87wUmnpiIHWyT69aDpmyQeGt3rAFqpfwV8gfMjKMjytTgDvsmDpe
         uncUuYLmkB7nnt145qZSKtj4LrDfTNpEnu+dgE7nspD1iBkH54g3hgxzqpcR/s1RU48L
         rlt53qbnb9WLFG7/bAomq18CRDfg/u5eKSSQxi+sTv15dEZ+PZ2CreHz5VE7GFVAO0SB
         8zu7Y+e2X835NHZF959MpXQG/1uqbpi8hMIUwfOquAiIimCupehf3MFWk+3DPXypdVh4
         DyyQ8vUdO5MhTowoKBM86yPy7G77RJQ60RZhX3CJ4070TF9Mx6V7e4DK1ASNyQs1jwC3
         ccvQ==
X-Gm-Message-State: AOAM532FQE4EoM9PppCxGWgX0D18KyJ6a7owpDXctoh+V9PqnCHudv50
        ebs9QE3F7uj2Nlso7rXSsPxg6SvZj44=
X-Google-Smtp-Source: ABdhPJzjGXpcVGRDlUMA/qU52FyJ2nWpqrN++nV77UhQHoNxy/6ha3ciwhe2ubLcY2je4+/vRmk+jw==
X-Received: by 2002:a2e:3c03:: with SMTP id j3mr251225lja.12.1596070690078;
        Wed, 29 Jul 2020 17:58:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id d2sm695379ljg.6.2020.07.29.17.58.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:58:09 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c3so6878317lfb.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:58:09 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr291069lfo.31.1596070688397;
 Wed, 29 Jul 2020 17:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net> <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
 <20200730002944.GB2996059@coredump.intra.peff.net> <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
 <20200730005243.GD2996059@coredump.intra.peff.net>
In-Reply-To: <20200730005243.GD2996059@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 17:57:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzL9AUsQrF=ncq_frWOmstHjXx=-em0QuGc76KXdeOMQ@mail.gmail.com>
Message-ID: <CAHk-=whzL9AUsQrF=ncq_frWOmstHjXx=-em0QuGc76KXdeOMQ@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 5:52 PM Jeff King <peff@peff.net> wrote:
>
> There might be room for an easy feature there, too. If we're given url A
> on the command line and then we convert it to B with insteadOf, it's not
> clear to me which one is the thing we should write into the merge
> message.

You're right, and I actually considered doing that originally.

The reason I ended up with my hook is that a number of people send me
their pull requests using the ssh address anyway, because they as
maintainers end up having kernel.org accounts, and that's how they
interact with it.

So I actually end up wanting to rewrite it to use the public address
even if the insteadOf logic didn't trigger, because those ssh
addresses just don't make sense in the public history, and there's an
easy 1:1 translation to the public mirrors.

> And while it's definitely a special case, I suspect it may be one that
> other folks have, too (e.g., mentioning https:// URLs is probably more
> friendly than ssh for most people).

Now there I agree - I suspect a lot of developers inside various
companies have "this is the internal mirror I use, because
firewalls/bandwidth/whatever", but they might not necessarily want
that internal choice be reflected in their log messages.

That said, I'm just _imagining_ that to be true. I might be reading
too much into my own habits.

            Linus
