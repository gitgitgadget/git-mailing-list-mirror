Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF26C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B0060C3D
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhA0XAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhA0W5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 17:57:40 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F365C061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:57:24 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id ew18so1951046qvb.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=auSZb4mKbFVJ4YN2xIGwUN7feg7kgBveIDwdxiDIJIQ=;
        b=YLKF77DN4uZKsE3xOXz011hHf6JRVrMpiH44rXB6JQT9z2gH06myIRp9dlepEdrpcG
         xrQSwhY26GJIocPWAF8tn9eEPj/iTsigByd1TMYZphDewKCE7O9n1Aq1ZVN2NzJEWrzH
         fNfVch8JkjPpWEPquJbAIJUlovHPvw+91yVe+Qu9g5cH1z6Ugoo0VicifWlSJ0Yij9kz
         15wTND9zkUnOQyuC7XtOytMD646N7B/ksON4gVzEEVna+Wj7rf+xr1ORfAIDz5e5uDAd
         YGpj4xoaIm9TXovn4STqH51WHreopCEIDuzhIzYrYgiZp0IIZfkLBVVofAfvGG0Df3bO
         WpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auSZb4mKbFVJ4YN2xIGwUN7feg7kgBveIDwdxiDIJIQ=;
        b=iv3jHEG3KHNGN3BJta0m+yuuf7FooULeBFbXkZTkE4qEvFTaX+O9HYyGjnXxIAdeqy
         gTJlzloLW7a59RQ8g9DQ8raVzT3BQelskJav+CsTnyJwWgeZU146e6C39bUFGZNaJWOB
         Qu7CNo6CCnlRQcveUTEhBf2ggO57Fb8pYHFAUE4/JozoRFLVb7GAuu8ao9uHKJbaAv2s
         EmT9tYC+utW9ubOFOvsQsMTD1/fXSB0B4VBc247XnvQAvcKxX5sMIWuhBL8bdvK+W1hZ
         i1VH1L1ESvLH9uJ5DXuGQF684mG3p5uoXHS1dBvFS0+AOp4K3RO5GgsC7cPWpYTsS9Jt
         XMlA==
X-Gm-Message-State: AOAM531FxLEpbsfG8dMT7mgndZwK4BiGtnre1AtkHt2Ls447/af2X4qm
        wg5uuvuLaaGXJZAHMBw1kq5Zog==
X-Google-Smtp-Source: ABdhPJyLa2twXxc09KaJI6HrY4a+iO9yo9CdkCcZljw7p5A9JMbzyG4AzcxeBiIKF4vXVAD366QjIQ==
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr12506881qve.26.1611788243799;
        Wed, 27 Jan 2021 14:57:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8b08:17f3:5149:2ab0])
        by smtp.gmail.com with ESMTPSA id 5sm2280146qth.12.2021.01.27.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 14:57:23 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:57:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
Message-ID: <YBHv0ZHZD4VMHLYR@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 05:17:07PM -0500, Jeff King wrote:
> It can sometimes be useful to see which refs are contributing to the
> overall repository size (e.g., does some branch have a bunch of objects
> not found elsewhere in history, which indicates that deleting it would
> shrink the size of a clone).
>
> You can find that out by generating a list of objects, getting their
> sizes from cat-file, and then summing them, like:
>
>     git rev-list --objects main..branch
>     cut -d' ' -f1 |

I suspect that this is from the original commit message that you wrote a
half-decade ago. Not that it really means much, but you could shave one
process off of this example by passing '--no-object-names' to 'git
rev-list'.

The whole point is that we can avoid having to do this, so I don't think
it really matters, anyway.

> [...]
> then we're faster to generate the list of objects, but we still spend a
> lot of time piping and looking things up. But if we do both together:
>
>   [internal, bitmaps]
>   $ time git rev-list --disk-usage --all --use-bitmap-index
>   1455691059
>   real	0m0.235s
>   user	0m0.186s
>   sys	0m0.049s
>
> then we get the same answer much faster.

Very nice.

> This _could_ be made more flexible, but I didn't think it was worth the
> complexity. Some obvious things one might want are:
>
>   - not counting up all reachable objects (i.e., requiring --objects for
>     this output, and omitting it just counts up commits). This could be
>     handled in the bitmap case with some extra code (OR-ing with the
>     type bitmaps).
>
>     But after 5 years of this patch, I've never wanted that once. The
>     disk usage of just some of the objects isn't really that useful (and
>     of course you can still get it by piping to cat-file).

Yeah. I think it's trivial to support it, but I'm in favor of a simpler
interface.

That said, I worry about painting ourselves into a corner if the default
implies --objects. If we wanted to change that, I'm pretty sure you'd
have to write a rule that says "imply objects, unless --tags, --blobs or
etc. are specified, and then only do that".

Maybe we'll never have to address that, but it's worth thinking about
before committing to implying '--objects'.

>   - an option to output the sizes of specific objects along with their
>     oids. But if you want to get to this level of flexibility, I think
>     you're better off just using cat-file (and if we are concerned about
>     the pipe costs, we should teach rev-list to understand cat-file's
>     custom formats).

This I agree with completely. Any caller who wants that level of
flexibility shouldn't mind the piping.

I have no comments on the patch itself, which looks fine to me (and I
have seen over and over again as it seems to regularly cause conflicts
when merging new releases into GitHub's fork :-)).

Thanks,
Taylor
