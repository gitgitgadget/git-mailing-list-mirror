Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E0C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828CD2154A
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/StCFlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK1BbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:31:16 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:35092 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK1BbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:31:16 -0500
Received: by mail-pf1-f179.google.com with SMTP id q13so12246551pff.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygeHyuOIUFJ33DLLuLBBpcn0aserpQMJqSzrKPRG3z4=;
        b=O/StCFlGzr4QbGiv6Agm342UHjXLl3MlXgYpT4Urrum0WjKNFyJfXhKdI2OahWLP50
         vuQtb0fXtfZBmphlzC+kHeHynlvMHXXtVoM4opWT2mdHvaz9LIi/Wnehg++PZTiDhrsJ
         Br1qVJaePs40TMZZHZ/5U6Hl1QJcpkzPNiFuUQZV9a2C0mmqZhPowyJCe3oruGrjnntc
         1m507kDwskLui4+YweGFIUvA9tFke7Gvf6meZWlU/CbalA8IM4HMbtys64O/J+t/TTXn
         ee/XDNq5UarmaTGp7ywwu5Dl8i/kP0MMifvVvucKKeTzRlMKKJ60hJtmonJ9gB2cd4LR
         8DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygeHyuOIUFJ33DLLuLBBpcn0aserpQMJqSzrKPRG3z4=;
        b=Rs7N2a6lxToXq7JubJllPvERDVrImqXiBwjOL+5PNUDE9QKdsT/qu09MWJfXFD9/AS
         RrLHKwiK5nYOW3OTMPo8AdIPfGSaQKYQk2dcFcYPiC8u2cN52HIcNLx754Rh4wq2B2nf
         Rd4XI6KVqb6O2FYRwOtXJB4JW7NGvFeOnAEW+7Vo+IpojK9+Psvd+kbBCpXkkyWRcwv6
         65NVzOnKnbkTFHM0AF8jviqmZijthBd6tGrW4rsWtsEqdYP97gHLOMi5fCx64KumXYFr
         uqO2h4/56iGQCD3WG10o+T0fZsG5uY8o2wOjB45zMji/Brk8rgbflZVOYB4QSNWX/mm3
         w9OQ==
X-Gm-Message-State: APjAAAU/DnGicpeQ+zz38i9BLQstD7f+3zKfHiOpSoar7WBJgwQWARJt
        ze/CT4PV9/2kcQM4ylsPrNs=
X-Google-Smtp-Source: APXvYqzVADbu5Iuwj7EDmd3+dKvwRb8P/h0C9GyNtg7FE1ias2NSjohveXSKw2F10kY9s0ju1fccdA==
X-Received: by 2002:a63:2b51:: with SMTP id r78mr8418169pgr.4.1574904673848;
        Wed, 27 Nov 2019 17:31:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 206sm20514958pfu.45.2019.11.27.17.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:31:13 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:31:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ruud van Asseldonk <dev@veniogames.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191128013111.GA76989@google.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
 <20191127112150.GA22221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127112150.GA22221@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Hmm. I don't think that technique gives complete coverage. There are
> other scripts (e.g., filter-branch) that call a bare "perl" (not
> PERL_PATH), which presumably pass the tests even though they'd break in
> a real-world system without perl. In fact, many scripts used to do this
> before fcb06a8d54 (use @@PERL@@ in built scripts, 2013-10-28). I don't
> think the effects on NO_PERL were really considered there; it was more
> about finding the right perl.

Oh!  Thanks for looking deeper.

> I think NO_PERL has historically mostly meant "do not build or install
> perl scripts", and not "everything ought to run fine without perl".
> We've generally assumed you can run vanilla perl snippets from the
> command line the same way you'd run awk or sed (and the tests use this
> extensively, which is why you have to set PERL_PATH again to run them).

Right.  PERL_PATH and NO_PERL are more orthogonal than I had thought.
So this is

  Not-Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

--- the patch shouldn't be applied as is.

> That said, most of those casual uses of perl in actual built scripts
> have gone away because the shell scripts have gone away. It looks like
> filter-branch, request-pull, and instaweb are the last holdouts. So
> maybe we should be treating NO_PERL as disabling those scripts, too.
>
> But then, should we be doing more to make it clear that those scripts
> are broken in a NO_PERL build? Who knows what happens if you run
> filter-branch without any perl available?

Agreed: if we want to follow this approach, we should install stubs in
place of those scripts when NO_PERL=YesPlease.  Will say more about
this in a separate reply.

Thanks for catching it,
Jonathan
