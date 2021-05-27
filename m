Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F74C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816A060241
	for <git@archiver.kernel.org>; Thu, 27 May 2021 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhE0RBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhE0RBB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:01:01 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235CC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:59:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so268084ooa.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gnn6RWpRG+8xZlZ3zG7pkWt5f0l3f8pQcKKRBBhX+T8=;
        b=IxurHvi0TMyAq4ZkBWXIc+mFPOKu4U67shHIV4NkM3M4CAS0lRB+MIRpPEkFiqEcvv
         tRdqzaOSADQ7buNfNb+T5gCuwvcqchgJdS9/L+4/8/hUK3IdCu16cEvXq1tRbADP0shr
         YYOe06QaRuA2K04TKGNXfMHrSE98rvm0/h7ZONjdEE0vGEsG6pCJWeSTW/zfCzFtYbQ0
         +CzARKclgeD9it+GGdtSNA16EvJAGP9l7D9msPQMgkfO5wxgA+LB0g0nrLrOR7qi0J/n
         PebEZfiL9dK/2WjR2pQRDPNRT33ZyWTTczdfJbmQGvu1LSUl1sQ7Z9VzS2ElKUCmtfP4
         1PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gnn6RWpRG+8xZlZ3zG7pkWt5f0l3f8pQcKKRBBhX+T8=;
        b=PYbOzEbiRge011vyFw20J/gMC69SdLAJwEdu3Mw25r1ecqVNlQl6sswBtZc0u83LjJ
         RohHCIKiR/ITQv1eY6tQkTwse2mt3XHwWGSxTALQn5E2OxuYnRiGnBmNUWa/R4aGZS5I
         voUiu4fL9JdW6XuSUSnFaohES2rAyb5hjCzrdoPmWz50eOswRm6ArQ2xRYv6NKauUW9O
         d+bEeXXr8WnkHPXWW09YU0robRGJDL7WbRmiwjY1PHDMKWo1TizOiWhEHOzXC2AJDMhp
         I4ffMuEZw6aA44TNHH3hHzyQIM++APc4zSpbxmoVmyoIG2/4G086hTd9eBUOjS9mtrJz
         STew==
X-Gm-Message-State: AOAM53348aD+mTNz6iyjsbEMVchvAElQlLASsOvVPqgns+XVOB2P/C4H
        hYoCQaK2NKTOMjR+Gm+PL94=
X-Google-Smtp-Source: ABdhPJyq54JkHt8pzubEIHXC0UJ8YCTmWeJk97UXH4fatXSVC2xPwO26JAvjXXxXhD4K+/63EPl/XQ==
X-Received: by 2002:a4a:d69a:: with SMTP id i26mr3500691oot.27.1622134765816;
        Thu, 27 May 2021 09:59:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w10sm538713oou.35.2021.05.27.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:59:25 -0700 (PDT)
Date:   Thu, 27 May 2021 11:59:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60afcfec2d93c_26530208ae@natae.notmuch>
In-Reply-To: <YK+texFSW6UurDui@coredump.intra.peff.net>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <xmqq7djoj9z9.fsf@gitster.g>
 <YK+texFSW6UurDui@coredump.intra.peff.net>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 25, 2021 at 02:51:54AM +0900, Junio C Hamano wrote:
> 
> > >  Documentation/Makefile | 77 ++++++++++++++++--------------------------
> > >  1 file changed, 29 insertions(+), 48 deletions(-)
> > 
> > Is this satisfactory to everybody (I haven't taken a look beyond
> > comparing the end results)?
> 
> Yes, all five patches look good to me.

So... Acked-by?

> The "comments-by" sub-thread looked unproductive to me, so I mostly
> skipped it. ;) But as the person whose name was in the trailer, I will
> say that I do not care either way if it is included. It did not seem to
> add anything to me. Some trailers are good for pointing later readers to
> folks who may be able to help understand or debug an old commit. Some
> are good for just giving credit to people who helped. "Comments-by"
> didn't really seem to do either to me (and I don't feel like I
> contributed much worthy of credit anyway).

But you did provide comments, and those comments resulted in changes, so
the comments-by line is accurate. And for what it's worth that commit
trailer line has been used 3 times already, which places it in the 3rd
top decile.

Perhaps some people would prefer feedback-by, but that that line has
been used *zero* times. Even brown-paper-bag-fixes-by has been used more.

Cheers.

-- 
Felipe Contreras
