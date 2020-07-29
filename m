Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E67C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D714E2075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQoP2ms/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG2Sxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Sxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:53:52 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0FC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:53:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id x37so16391066qvf.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mHeevWGwqHzsrfaeH+vLJ9t7JzzCAFOO9loRYL9G6ZM=;
        b=LQoP2ms/H1d1OgBPbq0OmEMXdCvZ0TelQcSaI2kwDAeU0ufHqpkGu1btgaoxG1k1ZI
         tmysSZGHk+TZYO8UIwReh+l//doXasFnVPluKedB7IjKLeA1VsVKG9VjA4LskdC67hqS
         8QzhyG13NZB5WVMZ+k3OnQ19+H+lPtY6H/vHiz8Xdx3lCjzXIhVfgyfGRpqvuL65fUO7
         zcI2H1v6WBl5v0m7wDH0ATsiDeXONHHPJUqHHW+DKLxIX9qr7JjHJejQn3GWyjSOrFKT
         M+sFgMTbkM+RK1JWTT2227JG2f+AzgfWI4wdafpIIkGL/+gfD6q5qt3Ie5trTc12ov/j
         JgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mHeevWGwqHzsrfaeH+vLJ9t7JzzCAFOO9loRYL9G6ZM=;
        b=pjB0aGR0mmzRM7rLOk1Zpz7aRB58hgAsb7Em5NRi8HTGN69VMSxmVWnePVNSFS/tGs
         Q83jNs1vrWPI9XS6jAHSnl1bdjZzQ+3SSeds0cYBFTXU8LKo8K0BVCv9KlQ4tkAwp2cY
         YmzADIiC61z9xoUTFKzWCofmFGPD6nH2zqAuSLeQ9C82vHoCvuIGH7vBq5o6/kc7hijC
         cfwwBpHNyQwqKAFGkodX1HYaZ4wwRuIhQiVRSX/dkIFNf0I6qHN313gLlTLSi7aR5fRE
         Wq6CND/tj77HeyHkB05KWHJGQ2p71YrnktQ+OFftwFJWhjwLGGlozA51Ndy2OQAGrXFY
         /hWA==
X-Gm-Message-State: AOAM530gFcS4E8t+ucrb9t1otAk/zro1nlgnmu0K6WyV4xyCmlVbhMo6
        xNkymOzYChOXn0kClBPdgsKtVDtaFKmuNOFJyj3w
X-Google-Smtp-Source: ABdhPJy6Ia84aRzi/YEk8jYlHqWykvObtMuLuIZFcSDycl23R0FhQk1Hd6VRTapPCMBQocIGnCPYPa28XxGqosym2D93
X-Received: by 2002:ad4:5189:: with SMTP id b9mr19984631qvp.242.1596048831426;
 Wed, 29 Jul 2020 11:53:51 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:53:47 -0700
In-Reply-To: <20200728200847.GA1019822@coredump.intra.peff.net>
Message-Id: <20200729185347.653706-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728200847.GA1019822@coredump.intra.peff.net>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jul 28, 2020 at 12:23:50PM -0700, Jonathan Tan wrote:
> 
> > > For this particular case, with the performance and all, I agree that
> > > the stupid and robust approach would be the best.
> > 
> > I'm concerned that we will be painting ourselves into a corner here - I
> > have been appreciating the richer interface that a C call provides us,
> > compared to sub-processes where we have to communicate through a single
> > input stream and a single output stream. For example, "wanted-refs" and
> > [...]
> 
> Yeah, that's a compelling reason. I'd have thought for this use case you
> could just say "hey, make sure these objects exist", which doesn't
> require a lot of communication. But often when I think things like that
> and start coding, it turns out to be much more complicated. So I am
> perfectly willing to believe you that it doesn't apply here. And even
> if it did, you're right that we may run into other spots that do need to
> pass back more information, but benefit from more lib-ified code that
> doesn't die().

Thanks. Just to be clear, I can't think of any hard stops to
implementing lazy fetch in a sub-process right now, but (as you said)
while programming I could discover something, or we could need something
in the future.

> Just to play devil's advocate for a moment...
> 
> > (Also, I think that debugging within a process is easier than debugging
> > across processes, but that might not be a concern that other people
> > share.)
> 
> This is definitely true sometimes, but I think is sometimes the
> opposite. When we push things out to a sub-process, then the interface
> between the two processes has to be well-defined (e.g., writing results
> to a file with a particular format). And that can make debugging easier,
> because you can pick up from that intermediate state (munging it in the
> middle, or even generating it from scratch for testing).

Well, unless there is some sort of interactivity like in remote helpers
:-)

> Likewise, that can result in a more flexible and robust system from the
> perspective of users. If we had invented "git log" first, we probably
> wouldn't have "git rev-list | git diff-tree --stdin" at all. But having
> that as two separate tools is sometimes useful for people doing things
> _besides_ log, since it gives different entry points to the code.

That's true. And the lazy fetch might be one of them - after looking at
the code, I think that I can get to where I want just by implementing a
null negotiator, which will be useful for end users. (In particular,
simulating a lazy fetch might be useful sometimes, and re-fetching a
packfile could be a crude way of repairing object corruption.)

> That said, I think I could buy the argument that "fetch" works pretty
> well as a basic building block for users. It's pretty rare to actually
> use fetch-pack as a distinct operation. This is all a monolith vs module
> tradeoff question, and the tradeoff around modularity for fetch isn't
> that compelling.

If we are going the sub-process route, I was planning to use "fetch" as
the sub-process, actually, not "fetch-pack" - among other things,
"fetch" allows us to specify a fetch negotiator. So it seems like you
are saying that if we had to use "fetch-pack", you have no problem with
libifying it and calling it in the same process, but if we can use
"fetch", we should use it as a sub-process?

In any case, I'll look into using "fetch" as a sub-process and see if it
works.
