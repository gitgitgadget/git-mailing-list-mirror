Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE5C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 06:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96742082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 06:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMPV7Mhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfLQGR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:17:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:45088 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQGR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 01:17:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id r11so4080312pjp.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 22:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/t/6D+uHUgD3G3xTxuBaU52VQWQjfOP0Ee7YO00l0g=;
        b=fMPV7Mhe5o481SOGFePven+xRmOEFFJ/VpWqpKfSORu07JhdVLAboMYMhbf3/qUKOX
         tHyvOOiHERhMi4/fb/yv7Ooa+QDieWHL/fFAlU2txNcWJzsmf873+xJlCt7PKCgTE7tx
         ILFKspQGH9gJMFi6QWsVw1hhcN9+YqBxKfQSxD5bvIBmboDFB+LuaYObEi+SHcEv/kiJ
         FMj/d7cOgdPaVEfHwfyqvWSy/aj63uVh/ILz/LQi3GSNEtxj2uHxcaJF7Ndc1q9aP1LI
         Cl4ks0L2z7qtjoaEIzr6u7l/UMMNY7AET8rc5zNBCZf62blrl9thOdKbMH8qo9jNhZfo
         ic5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/t/6D+uHUgD3G3xTxuBaU52VQWQjfOP0Ee7YO00l0g=;
        b=S8ui2Y6Rw+T1BGFZwN0WfY4yGyZ4tbg/u6snz6TvvpOZWAVYRgq9lVa+AdlwKo0w0m
         C4OlR8tasmWj9p4hWx4xBW4+4pLjL8jlOr4bcT4txSo8HdDg/bFx/ThLU6gMDfPASOZR
         ybaZaPxP5u+eGt39WzBkEq9jXsnKM9d3IyCU5FZWUvcziZ7DCSakp71E4rKfumw/04r4
         9bnACUmQrK9vDnBU/UFkMxWxe8ldlfDXJUY2K/M/FDSPxSrGTN1WDqzJom745YQGsq51
         JigCW6Z2RhkJFTL7xosLrh1VdRxH9udMmWFZf+Ag0o0snKNAKrDabsCgRhX5bd+zrPKL
         LAxA==
X-Gm-Message-State: APjAAAW4PcUk6eGKli3duLfyTsEvYBLlXgUC3FV7OQXUABi5Vvm0MC6Q
        CXTjrnPYmyLF+IICbO0Xzh0=
X-Google-Smtp-Source: APXvYqzknLw3c4Rkrw2GiN8KYlD6/FK9W602nQ6ogJrarMbJLY+NXoB2Jzi+MnoultZ0YbjL/CT0aQ==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr21379796pla.128.1576563446986;
        Mon, 16 Dec 2019 22:17:26 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id e16sm24610326pgk.77.2019.12.16.22.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 22:17:26 -0800 (PST)
Date:   Mon, 16 Dec 2019 22:17:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 0/2] contrib/credential/netrc: Makefile + script cleanup
Message-ID: <20191217061723.GA507345@generichostname>
References: <cover.1576531851.git.liu.denton@gmail.com>
 <20191217024858.GA2734969@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217024858.GA2734969@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, Dec 16, 2019 at 09:48:58PM -0500, Jeff King wrote:
> On Mon, Dec 16, 2019 at 01:32:32PM -0800, Denton Liu wrote:
> 
> > I recently switched my workflow to use this credential helper and I
> > noticed a couple of problems:
> > 
> > 1. The interpreter path was hardcoded to #!/usr/bin/perl
> > 
> > 2. The script refuses to run outside of a Git repository
> > 
> > This patch series should fix these problems.
> 
> Both of these patches look good to me.

Thanks for reviewing :)

> 
> It does make me wonder if many people are using credential-netrc, given
> these pretty obvious problems. You're certainly welcome to use it if it
> works for you, but I am curious what made you pick it versus one of the
> other more advanced helpers.

I wanted a credential helper that was encrypted and OS-independent.
Since GPG is basically available on everything, it fits my use case.

It also helped that it resulted in a workflow that was very similar to
my old mutt workflow. Before, I had

	source "gpg -dq ~/.mutt/credentials.gpg |"

and I just replaced the gpg with a script that wraps around git-credential.

> 
> I assume you're using a gpg-encrypted netrc (if not, you should probably
> just use credential-store). For "read-only" password access, I find the
> combination of pass[1] with config like this is a bit nicer:

Nice, I never knew heard about pass until now. I only have one password
in my credential store currently but if I need to add more, I'll keep
this in mind!

-Denton

> 
>   [credential "https://github.com"]
>   username = peff
>   helper = "!f() { test $1 = get && echo password=`pass github/oauth`; }; f"
> 
> -Peff
> 
> [1] https://www.passwordstore.org/
