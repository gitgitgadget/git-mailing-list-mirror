Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E0A1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDHXSi (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:18:38 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38707 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDHXSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:18:38 -0400
Received: by mail-wr0-f180.google.com with SMTP id m13so7004252wrj.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=WKQkOip+QybE0EZffprspA0mdxgftey9zVgWFiwqnIc=;
        b=lNAxozIQQVuwx6hl3EiDW6OTYQd/CrmEJGlJpbExjG0qt8inCVIJaQHz0LH9jaeLGb
         Cc7tHEZYfjGEQ9tZGulUHI5R8oxXkeCApzrkrgGp6rhzrIQilhFWNd0CKSIKesMk1PH8
         FtiQNL9EX10O7uBaMA3xLqcF30MFZP89UR5MgZcjbudhnbXRh+B/sxq7NggdWD/aQeKY
         9MioSoudJveKqkcRJrBXej7c6+781XzmF+NK39ZcZu9ppLI3rtI2PWrDGW9h/dmYPSg1
         fx/71gzpqOdBTPBHucH2j83kjB7+foDG8jMGiCQyCyvl9J8wO2Bz7rB//rhwNrdUqQHQ
         jI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=WKQkOip+QybE0EZffprspA0mdxgftey9zVgWFiwqnIc=;
        b=G3phJ/2cGqgwfz8b9BCqRVF7238WFBH5hKYHsXk7N60XaRcDqwxcAX1tIALQ0FHE2+
         jrXIXO1zBcHfu1seqfH/uKkyCSC540ZpYNu/v7Rpn0YmZ9b+97G+mD1E2an1Zk0Rtuci
         iREPSTDqAa41xUQ2WALYh4iAAGQNOpDb6LkcC2Jl6MZT+NLYtiwKcYZDxJewoBVdQwnv
         y6RRKfFYG0iPrI4gm0mwI9N2jhftftzKXfnULkWCDmrPBZfVIv4Ghdvkt0U2QasUHewt
         gOJioT6yYWfP5V+rpLPAgeiuSwRmxLdpQ9AAfOkqUw6C5RqxNo7RP1IACQ94zpjNindc
         irZQ==
X-Gm-Message-State: AElRT7El0cirDH/TSBHbj88zEp8I4pyhu0AkLo+rRgV1yvmnkrL4qnHO
        U99StweShR6C7hcz5GqZpdk=
X-Google-Smtp-Source: AIpwx4+4VzQrCqnrXNrboWoOHD/RAzXEdrVATRnyDQGsILKXAzl7sjnQx3dtwJO6Z7szSDjn0lUO8g==
X-Received: by 10.223.191.11 with SMTP id p11mr25940250wrh.160.1523229516680;
        Sun, 08 Apr 2018 16:18:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b38sm16211297wrg.81.2018.04.08.16.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:18:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] ref-filter: factor ref_array pushing into its own function
References: <20180406185801.GA921@sigill.intra.peff.net>
        <20180406185945.GC11108@sigill.intra.peff.net>
Date:   Mon, 09 Apr 2018 08:18:35 +0900
Message-ID: <xmqqy3hx70dw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In preparation for callers constructing their own ref_array
> structs, let's move our own internal push operation into its
> own function.
>
> While we're at it, we can replace REALLOC_ARRAY() with
> ALLOC_GROW(), which should give the growth operation
> amortized linear complexity (as opposed to growing by one,
> which is potentially quadratic, though in-place realloc
> growth often makes this faster in practice).

Sorry, but I do not quite get the last part this paragraph.  Up to
but not including ", though in-place..." I would understand as:

     - With ALLOC_GROW(), we are explicit in that we are amortizing
       the allocation cost by growing in exponential batches.

     - With REALLOC_ARRAY(), we are telling the underlying
       realloc(3) that it is OK to pretend that we grow by one, but
       if that permission is literally followed, it could end up
       quadratic.

    So if you have really a bad realloc(3) implementation, switching
    to use ALLOC_GROW() is an improvement.

But after that I am not sure what you are getting at.  Do you mean
"In practice, a well-done realloc(3) does the amortizing internally
anyway, which makes it faster than the grow-by-one quadratic, so
this change may not make that much of a difference"?  Or do you mean
"In practice, a well-done realloc(3) internally amortizes better
than we do manually, so this change may hurt performance"?

In either case, I think this splitting into a helper is obviously a
good move, and using ALLOC_GROW() is conceptually cleaner, as we use
it everywhere and tend to avoid realloc(3) just to add one item.

Other than that small confusion (not even a nit), three patches were
pleasant read.  Thanks.
