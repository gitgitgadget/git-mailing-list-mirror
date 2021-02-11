Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125BC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03E264E44
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBKTjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBKTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:39:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A6C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:38:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id i8so11821191ejc.7
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O71xNa51nrxPPEVn0G6L2A/g8hyQMaOMNqLvG1Cv7zs=;
        b=YO7QazL3KfZfw2ES3wdFyBP691XIdpKtxoT8GLFxuwDkwjV/AjlktZ0p5q7ReNpQFt
         pEeaNPLvNbjzbj8uW91DTMJUPCmjOzwdR4uy1SzySeJBdnv8ANzxta3wLlb5fdc2zAkC
         0JJNGX0K9lv1V0v5M4LI+A7zV6G94NrCzPi+O7nR9VB1NibUWVThelJ1mQQejGL8CHOz
         28wQR0xjjttVo6ZlBBhhO7fq5+c6BvL44l9qtC11B2b8u9Hu9dc6VvKQ1lquVvu8AYmy
         TwgJmjUxsbII/PipcbIvKWgtlaiTHVF64tHZ0nojpXzK7HeVVydqCus7PRMcGQPVA2wA
         XYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O71xNa51nrxPPEVn0G6L2A/g8hyQMaOMNqLvG1Cv7zs=;
        b=QW6+c8D8bRFMPA0OzyxcCes3EgOs/bAwxDtrnxAAGpZo3spUgoksaFo3OLRqg0C7rb
         fc1gwAGMYinmRpMlO/Lbp5xuXZ1sd42IQ3SJEr4FoUz8VxD/kMrrQbhSvZOV4V/Jcqus
         fC4WOhnV/XW0YWFc+PiH7L8BlCV/Z2kERWreh1Ym4W6ooHOEPSldy+tDR0nlSQV7gO8i
         TdcUnn1AHoGnJrs/J75RBqOEh5wqtgTq1TTVGbOAWiY/awVb//wy1om5oAwTTSXmA675
         aISF9a/+VgF6kIRHOA1G+DmK1vQq0D2fFFoYJJsG+yWQxSg6hd346OWdi5wTbnF8XGB0
         i/mQ==
X-Gm-Message-State: AOAM533gxjQmQzRhMfNI4VsrkXXxXlaxSPRnoq/FePOi6v/2pQ7cRK5e
        KWLKzFQ6pj1pmHtGrzUgLpbNLDsQU8M=
X-Google-Smtp-Source: ABdhPJycG4GJvlVNqAyR7VNmBJYdEoHgsjGwN0Now29I6QHN8CjawFVdBLR+XCBL7fsjafcaBhjI4g==
X-Received: by 2002:a17:907:11c7:: with SMTP id va7mr9992733ejb.351.1613072302698;
        Thu, 11 Feb 2021 11:38:22 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id t11sm4695618edd.1.2021.02.11.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:38:22 -0800 (PST)
Date:   Thu, 11 Feb 2021 20:38:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 07/12] test-lib-functions: move function to lib-bitmap.sh
Message-ID: <20210211193820.GH1015009@szeder.dev>
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-8-avarab@gmail.com>
 <20210210205645.GE1015009@szeder.dev>
 <YCRL4lq5eQnPLwK1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCRL4lq5eQnPLwK1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 04:10:58PM -0500, Jeff King wrote:
> On Wed, Feb 10, 2021 at 09:56:45PM +0100, SZEDER Gábor wrote:
> 
> > > +test_bitmap_traversal () {
> > > +	if test "$1" = "--no-confirm-bitmaps"
> > > +	then
> > > +		shift
> > > +	elif cmp "$1" "$2"
> > > +	then
> > > +		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
> > > +		return 1
> > 
> > Since you converted two 'error's to BUG earlier in this series...
> > 
> > This helper function was added in ea047a8eb4 (t5310: factor out bitmap
> > traversal comparison, 2020-02-14), and so I Cc: its author and quote
> > part of its commit message:
> > 
> >     While we're at it, let's also try to confirm that the bitmap output did
> >     indeed use bitmaps. Since the code internally falls back to the
> >     non-bitmap path in some cases, the tests are at risk of becoming trivial
> >     noops.
> >     
> >     This is a bit fragile, as not all outputs will differ (e.g., looking at
> >     only the commits from a fully-bitmapped pack will end up exactly the
> >     same as the normal traversal order, since it also matches the pack
> >     order). So we'll provide an escape hatch by which tests can disable this
> >     check (which should only be used after manually confirming that bitmaps
> >     kicked in).
> > 
> > Shouldn't this be a BUG as well?  I think this should be a BUG.
> 
> I dunno. I guess you are thinking of the case where somebody adds a new
> caller but fails to invoke Git correctly. Which would be a bug in the
> test script.
> 
> But it could also easily be due to Git changing how it behaves in a
> certain circumstance. And maybe the solution is changing the test to
> adapt, or maybe we just found a bug in Git.

Well, I though that if the raw output is the same with and without
pack bitmaps, then the missing '--no-confirm-bitmaps' option is the
bug in the test script.

> TBH, I do not care that much either way. Either way, I think somebody
> would notice the problem.

Me neither, I just don't like test helper functions that simply return
in the middle, becauase that makes suppressing their trace output even
more awkward than it already is :)

