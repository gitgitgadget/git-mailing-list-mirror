Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518CC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F825206BE
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oj4plyHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgKIWWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730716AbgKIWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:22:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9996C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:22:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so12766384ybj.14
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8kptbg5gg9licE1SQrpMC8sTzGnRtkkrvw2mP3xte4U=;
        b=Oj4plyHByyp/AtyYVbXyZ2mFCCDrnmV0AyE6EMhrm/MTb03264vVqP0yl0C8+2Sa6m
         Yirp6aAiOlpgjizO6coAQARTYIybQgJl+hNOibtmK5r3TKSNG1c/EO6tWvI6xGNarIcc
         83zJKM+7oumkS4QsjZjYOLrPwhROGyFq5o4cPIGjYpfAtyD4ICdCp+urAS7cu2MqXf2s
         w+wPr9oQdRj/2iR8SDdwQBPKDFb5F7c1KNZPC9dFLQoKF+lSZ/bOgffs7YeekFnoxKnI
         ceGkQczUaRjMECQEAK4YKEYwymlRDsYxnNxm6KW33rIGEry0T4hCKXT6u/CuTreu5f1I
         PHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kptbg5gg9licE1SQrpMC8sTzGnRtkkrvw2mP3xte4U=;
        b=tOexhg+KDb/J+kK77zrMdeJ2M9PMcM0sPBPauERHJVt9XUkmkeeDOmQ8v/I6j41dwA
         8dXW+801cZFhbbkgKFB5ZbGBXteHkC2O0MasZY1MfjD/zgLAWvnAEeH8yp8sO83CDr9L
         aA5s4vEtKQexSolS/SKWUMjpE+3lFG2eUHiubs3nnYHe5R/FURNgVEJTLmL/AP0m3XAJ
         gpy8ETfNB6ugMC6iWZ8xhnvGldCF/j9YPNboj9y2Mb/M9DN+6R1+KMhBYI8FeTcIv+kC
         rGBsIyniSLXX4mDTmTURbvmeyQlgCqpiEiQxntNl3VaUpxxQ0s/lDfe5Mdvwuvf6hRCl
         76tQ==
X-Gm-Message-State: AOAM533Yz5RgOMnaGTNGjr2fgidlTPlMbYyNb9SGNudcNiJml87RzANh
        sZPD56NE7h7k2P2CPiftSrqEWPy5u0UEoh6X2Usm
X-Google-Smtp-Source: ABdhPJxOqogTu2dWKpiU0fZGXZWODiN30uy7gYsNHFHYndLUnj/rfQor+2tOHJttsHWek1OIiZK9rI/N5IYvM0sFs3JR
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:8c8:: with SMTP id
 w8mr9375451ybq.356.1604960534957; Mon, 09 Nov 2020 14:22:14 -0800 (PST)
Date:   Mon,  9 Nov 2020 14:22:12 -0800
In-Reply-To: <d72de441-e7f4-347d-e37a-e8e530855821@gmail.com>
Message-Id: <20201109222212.2544841-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d72de441-e7f4-347d-e37a-e8e530855821@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH 4/4] Doc: push with --base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 11/9/20 2:56 PM, Jonathan Tan wrote:
> >> People expect that a single repository at their hosting sites can be
> >> used as the central meeting point for the project, just like CVS/SVN
> >> servers were in older world.  "git push" would need to accept that
> >> reality and start common ancestor discovery eventually.
> > 
> > Thanks for your reply (and everyone else's). I was thinking that a more
> > rudimentary form of the feature would suffice, since I wasn't expecting
> > much more need in the future, but looks like this isn't the case. I'll
> > be thinking of a more comprehensive idea.
> 
> I think this "half round negotiation" idea you have has merit, and can
> get us 95% of the benefit that a multi-round negotiation would bring
> without those extra steps.

Thanks.

> My concerns with the current series is that it isn't fully ready for
> even that case. In my mind, a protocol change like this would need:
> 
> 1. A top-to-bottom implementation that allows a user to opt-in to
>    this new behavior with a config setting.

Makes sense. The client already needs to opt-in by specifying the base,
but yes, an option needs to be added for the server.

> 2. A demonstration of situations where this algorithm out-performs
>    the existing algorithm (i.e. client is far behind server, but
>    topic is a small change based on something in server's history)

Noted.

> 3. A clear way to handle odd cases, such as multiple merge-bases.
>    This leads to a change in how you are sending the data.
> 
> Perhaps this "send multiple OIDs in a payload" is already half-way to
> implementing a full negotiation, and we might as well go all the way
> in the writing. I expect that sending all maximal merge-bases will be
> sufficient for the vast majority of cases, and so any multi-round
> negotiation process will almost always end after the client sends that
> data.

I think the ability to send multiple bases would work in this scenario,
but this might run into concerns that other reviewers have brought up
(specifically, the fact that we're using environment variables and HTTP
headers to pass this information - and among other things, line length
limits). So a more comprehensive solution might be needed, even if only
for this reason.

> Looking forward to your next version.

Thanks.
