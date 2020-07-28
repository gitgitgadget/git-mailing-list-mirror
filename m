Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDCC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDCF2065C
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/yGLRh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbgG1TX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgG1TX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 15:23:56 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D8AC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 12:23:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id i5so14501147qtw.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5sclk86DXbXtMJgZTMxGw1su1WpIrijJ1mSxjVTVjfw=;
        b=F/yGLRh1WarcSvnobBBCoRcl93LnWZugAqf7H0jPtpne0mmvA6zcpl5KNmyqusJ6ON
         CPfHWeiKbyG+t/50RHpdog+3MXGqWMnpJ0OLr3FgKi7DXPwcWrQ9ajBmJnbYqgWNmv2Y
         69kdn/93FEEd9XiqNUHaz4jThfHAD5SgjlJ5qLMR9iLzyjsvIaWfQlrl9Be2O76zBrbU
         wSR6T4W8CDE8Lp/1Uwi1d/NTJIPz2Lx3cnMI5IKIjLzW14MCzlpVXf+SIyEH0YUVr8JI
         tsn4YH2gr15KGqX1N3VkVSWXg8buXnosh1mjU22D3I68FU9qZ0e8Whnx78fGn/R0OgvI
         8Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5sclk86DXbXtMJgZTMxGw1su1WpIrijJ1mSxjVTVjfw=;
        b=CBSJA/r+WODbLgMnarG7/V1css3Nw7DBMSW2vZtjPdQAuHKtnq6nwqyaWm1fikZJqP
         kb/lvnKfTOFS2gU9dTBF5mcQD/lwPLYs9k6MYV6cQvLlZrvUwK843bV9MiXjzSrvym+t
         sCVLoEz/g28G6U0kYyWM8mRbN3q0lKPDU05TzxUf+2PGiSldMYUg1aNdpUGzMT8RWtCO
         unRnYFo2UIbqxnplk8wgrSLLI5rD+4DSyMkm5G8ahGH3I3plCvmmupCjX2cXChlF/WIx
         BNC8YdMqhySt8H2Qt04nBFDQvdhuwFac00U8+qeWBNlncGNggQPp0uwc136kC46BNNWZ
         eyEg==
X-Gm-Message-State: AOAM530TykxY2zGz80XMzMQXYrr8f1822XnryofEa0zrM9Q6H5KMmRp9
        kBQzyCZNXpkpYqMow7bHaZoTtXMuiyLrCMG7czSA
X-Google-Smtp-Source: ABdhPJzQX1tc0Uof4WHi5/ou/4tht6850EYBKYmDNB/qHKkjLKGLqzDnzTYjZef5T8WhNn1CQilmlXMcIENR20JQ7MXk
X-Received: by 2002:a0c:fa84:: with SMTP id o4mr28884435qvn.186.1595964235659;
 Tue, 28 Jul 2020 12:23:55 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:23:50 -0700
In-Reply-To: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
Message-Id: <20200728192350.352978-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
> 
> > I think it was this one:
> >
> >   https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net/
> >
> > I still think it's a good idea, but the hard part is lib-ifying all of
> > the functions that call die() to instead return an error up the stack
> > (and handle cleanup, etc). Which is why I never really pushed it
> > further. But if we're going to be lib-ifying such calls anyway, I think
> > it's nice to do this flexible thing (from their perspective it's no more
> > work to trigger the callback than it is to call error() and return).
> 
> Yeah, I almost 80%+ agree.

Thanks Peff for the pointer. That looks like a good idea, and more
comprehensive than my suggested approach.

> The remainder of 20% is that I am not so convinced that (fmt_string
> + va_list) that isn't pretty much usable for anything but generating
> human readable error messages is enough.  It is certainly a good
> enough replacement for (and much better than) the approach to
> prepare an error string in a "struct strbuf err" that was passeed by
> the caller, but I am not sure if that is a good bar to aim to pass
> to begin with ;-).

I think that functions that inform their callers about different errors
already do so through return values, but in any case I think that Peff's
idea can be extended once we need it (e.g. by adding error reporting
functions that can fallback to the string function if the special
function is not present).

> > That said, I do think for this particular case, your "just run it in a
> > sub-process" suggestion may be simpler and more robust.
> 
> For this particular case, with the performance and all, I agree that
> the stupid and robust approach would be the best.

I'm concerned that we will be painting ourselves into a corner here - I
have been appreciating the richer interface that a C call provides us,
compared to sub-processes where we have to communicate through a single
input stream and a single output stream. For example, "wanted-refs" and
packfile URIs (a.k.a. CDN offloading) were made much simpler because it
was quite easy to communicate back the updated hashes for refs (for
"wanted-refs") and more than one lockfile (for packfile URIs). If we
were doing it with "fetch" in remote helpers (like in HTTP protocol v0),
we would have to augment the textual protocol to communicate back the
updated hashes and the list of lockfiles - doable, but more cumbersome.
(That is also why I only implemented those for protocol v2, because
protocol v2 had "stateless-connect" for HTTP.)

Being limited to sub-processes also stopped me from implementing an
improvement to how fetch-pack calls index-pack - when I added debugging
information (list of refs and hashes) when writing the .promisor file,
what I wanted to do was to pass a callback (function pointer + data
pointer) to index-pack to tell it what to write to .promisor, but I
couldn't do that. I also couldn't write the list to the stdin of
index-pack, because the stdin was already used to communicate the
packfile. I could write the list to a temporary file and pass that name
to index-pack, but by that stage I thought it would be simpler to just
have fetch-pack write the .promisor file itself, even though I think
that this should be an index-pack concern, not a fetch-pack one.

(Also, I think that debugging within a process is easier than debugging
across processes, but that might not be a concern that other people
share.)

In this particular case, when doing the lazy fetch, we pass a special
flag that skips some steps - among other things, negotiation. Admittedly
we could add this flag to "fetch" (or whatever command we're going to
invoke to implement this sub-process part), or add the equivalent
general-purpose flags/configs (e.g. fetch.negotiationAlgorithm=null)
(but I haven't looked thoroughly at what flags would be needed). These
seem surmountable and I can't think of anything unsurmountable, but I'm
still worried that we're painting ourselves into a corner.
