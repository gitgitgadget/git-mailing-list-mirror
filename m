Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF81C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 06:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0092065C
	for <git@archiver.kernel.org>; Sat, 16 May 2020 06:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob5bfdwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgEPGiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 02:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbgEPGiD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 02:38:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DAC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 23:38:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n18so506823wmj.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4XPp5KPX4A/pdQGTPaBkzUShM1i2OLVeHkMjqi6iC4=;
        b=Ob5bfdwa6d0qnqrp8o/H5b+oGCDduVcONRrinpexbF3d1dl5x1Sa5j4hFu6noxy4Gl
         wQXSDMSgrqpJiBsZDHbGXUnHWY/cg0CBy02aCQIV/7HwEag4jh6HL1zIXGMstUetff1K
         LCHkqxe0ixxjSyNgiss2wK75d35dB7sfmNAzd2gHlROPmtSotxW7JtfasX2a+JlJA4XV
         76YryR+AEmghKbM2GTpyFaYqbRDr/oeVVTEwtQAcfETXsrtRyzWomQlZvrnbHgGxKkxJ
         SyaLECZxl07q+KvzkI8ZR3H9Y4zifmzvYblqv1OXxlYYJYuYIgttBV6v2TudB8I4Bw8A
         lCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4XPp5KPX4A/pdQGTPaBkzUShM1i2OLVeHkMjqi6iC4=;
        b=hFmbhaz7odILhkXQAw0fPqyzg8J9S+zn1XyMt7V+sTJxMhLiZVv3nyGMpD+fk8iRD0
         Okbd2KFKpp1jISn+noxMEEKYk6sO/dgqCDKNDksZKPKHpFDA9VHaAUQ12uAC3cRQzw4o
         4lgdqkPuSWtpRbyAIfq7bf7hLWn43c8/pMy1K7hJJr8QcBQyL8RsdVfl1kmHTRobbDii
         fEILGD1Ks2XQ0lSpFmnlp1VTC98cCti14K6APxiSMm970rp1gv3UwRc2x93ZIISLwT6+
         68z+RRyC8CnXDjo5foQ+80vvl+U97GPXgNxGzIhwAlytF2Ru2Ww/YZdBnMXxwodmkNbU
         3x1A==
X-Gm-Message-State: AOAM531Urgg8CZv9ymD3DBJAkGYXNFQ7q8SjJliyJHeDIZDfTCa4xKC9
        PZkoCRK5ek8o+gdwwg/dHac=
X-Google-Smtp-Source: ABdhPJzSYzeU7VQ4ykkJfD/H3M//AvucCMAafRjnWLQ2vHjBlKDuCwUWJ45AEk3eGHMXRxhU2VtmLg==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr7597864wmg.87.1589611081175;
        Fri, 15 May 2020 23:38:01 -0700 (PDT)
Received: from szeder.dev (94-21-23-52.pool.digikabel.hu. [94.21.23.52])
        by smtp.gmail.com with ESMTPSA id o205sm6505085wmo.32.2020.05.15.23.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 23:38:00 -0700 (PDT)
Date:   Sat, 16 May 2020 08:37:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git push over HTTP; long delay with no progress, then hang?
Message-ID: <20200516063758.GC5925@szeder.dev>
References: <CAGyf7-GQSPcdheKKiZPBpfGxAj_xu4oWdwRq_esSbuqLu5P08g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-GQSPcdheKKiZPBpfGxAj_xu4oWdwRq_esSbuqLu5P08g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 09:09:27PM -0700, Bryan Turner wrote:
> When running a huge "git push" via protocol v0/v1 over HTTP

By huge push you mean a lot of refs?

> (repository is ~10GB, with ~104,000 refs), I observe that:
> * Git makes an initial connection for a ref advertisement. This
> completes almost instantly because the repository is empty
> * "git push" then sits in absolute silence for ~10 minutes

I've run into this a few years ago, remember waiting for 57 minutes ;)

> The process chain looks like:
> git push <URL>
>     git-remote-http <URL> <URL>
>         git send-pack --stateless-rpc --helper-status --thin
> --progress <URL> --stdin
> 
> The "git send-pack" process runs at 100% usage for a single CPU core
> for this entire duration. Does anyone have any insight into what Git
> might be doing during this long delay?

Pathspec matching is, if I recall correctly,

  O(nr of refspecs * (nr of local refs + nr of remote refs))

with remote.c:count_refspec_match() responsible the "nr of remote +
local refs" part and remote.c:match_explicit_refs() for the "nr of
refspecs" part.

This is particularly bad for http/https protocols, because 'git push'
expands your refspecs to fully qualified refspecs, passes them to 'git
send-pack', which then performs pathspec matching _again_.  So if you
have a single pathspec with globbing, then 'git push' can do the
pathspec matching still fairly quickly, even if there are a lot of
local and remote refs and if that single globbing pathspec happens to
match a lot of refs, but then the refspec matching in 'git send-pack'
has a whole lot to do, spins the CPU like crazy, and there you are
writing a bug report on Friday evening.

This is less of an issue with other protocols, because they perform
pathspec matching only once, but of course all protocols suffer if you
pass a lot of refspecs to 'git push' or 'git send-pack'.

> Whatever it is, is it perhaps
> something Git should actually print some sort of status for? (I've
> reproduced this long silence with both Git 2.20.1 and the new Git
> 2.27.0-rc0.)

An immediate band-aid might be to teach 'git push' to pass on the
original refspecs to 'git send-pack', as this would reduce the
complexity of that second pathspec matching.  This, of course,
wouldn't help if someone scripted around 'git push' and invoked it
with a lot of refspecs or fed lot of refspecs directly to 'git
send-pack's stdin.

Alternatively, teach 'git send-pack' a new option e.g.
'--only-fully-qualified-refspecs', and teach 'git push' to use it, so
'git send-pack' doesn't have to perform that second pathspec matching,
it would only have to verify that the refspecs it got are indeed all
fully qualified.

Or build the remote refs index earlier and sort refspecs and local
refs, so we could match the lhs of fully qualified refspecs to local
refs in one go while looking up their rhs in the remote ref index,
resulting in O((nr of refspecs + nr of local refs) * log(nr of remote
refs) complexity.  Dunno, it was a long time ago when I last thought
about this.

All this assumes that if there are a lot of refspecs, then they are
fully qualified.  I'd assume that if there are so many refspecs to
cause trouble, then they were generated programmatically, and I'd
(naively? :) assume that if something generates refspecs, then it's
careful and generates fully qualified refspecs.  Anyway, all bets are
off if there are a lot of non-fully-qualified refspecs...
