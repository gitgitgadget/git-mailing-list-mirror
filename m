Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2EC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3106E21D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="adQBDieh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIWnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIIWm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 18:42:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA73C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 15:42:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 8so3183260pfx.6
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DK56Cawx01L9mpyY6nbpwokC3teUE7DrEPOc28+KbPk=;
        b=adQBDiehN9Y2rLNGmEM5sQSDKoOAqJagBf4AHptQHlkK7nvZ84KCMHyf3JSsd6ut25
         V+jRz3Ty7tdEMlot92MAKxgOxWOMguhjayK38xLQJQNs1lJlHlucGGFPnzEOJVyGBPXn
         DgK1pzYWURLz0tB1lPHjOD/txp48rhVsMneTXOlVt3gH9DdMsDIkpT/TfqLwjZqroYet
         j8CNa6eBreNVZkbNVAA4llz8lXM/Edeyz+zle4ip9ZAsLRFwNPWVbzoUjN7QCM1f3l7h
         KQEtPT1i2HzvjqWhsksR8R5z9Zqvhl0bnvlMHSH6L8/6qMOcLZm+G8IziwMfiYM0nVK/
         uVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DK56Cawx01L9mpyY6nbpwokC3teUE7DrEPOc28+KbPk=;
        b=pjMa5QUKuDChZI0XDhO5ZmU8885SREIp7MzKQPP8lB0d/3D4gLCjmINV2VA5+5/lXG
         TJ7i9L2Q4E/zYA7jWW7ED4QFawumWYjzE4yWoN6ZrsxJVW43JsZkL5kjlCnYnbSQV05Q
         1H9FgVAPlIy44LbudKauiJoDBJvgHxfwAkyMoHI0G28yQg6WivHcoJ819aXvELnKQVH9
         1w6bjexkCOcBbQOlS+Q3uEs8eYTxbocvW53LZ//lpOAADoi54Fq0lMjZyvRVx5twjW5C
         SrQ+RRKRhxrKAiZSmXv9IMMxILkcq9r8PDDufp5sbMjAzeTmjOP8ojAZvoGL4RvstHHA
         Eemw==
X-Gm-Message-State: AOAM532ohK164v328645Kqbf5bOIjo1s90sEyQe2OxTJDZ52/GJFbd7+
        W+EamHYpNIVnHx9j8HaMrp+tSlyO5Hpv7xRaUYWk
X-Google-Smtp-Source: ABdhPJySul83MS632gl3AwVpZs8d4UU5ljABg6bskxV60vj4zJR5qZg2oMEkn08owtNWuByfHeUJXxKUAqX6OHBIIWhq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr235654pjb.0.1599691375963; Wed, 09 Sep 2020 15:42:55 -0700 (PDT)
Date:   Wed,  9 Sep 2020 15:42:53 -0700
In-Reply-To: <xmqqh7t0zy43.fsf@gitster.c.googlers.com>
Message-Id: <20200909224253.866718-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh7t0zy43.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     emilyshaffer@google.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> >> The main concern I saw here was "we are doing a lot of work that isn't
> >> used if the user doesn't want to log traces" - should I approach a
> >> reroll of this topic by trying to be smarter about whether to set
> >> 'quiet' or 'print' or 'verbose' or whatever it is renamed to, based on
> >> whether there is a trace destination? Then for systems which are logging
> >> traces the extra work is worth it, but for everyone else it can function
> >> as before.
> >>
> >> I don't love it from a design perspective - it feels a little like
> >> progress module is looking a little too closely at trace module
> >> internals.
> >
> > Isn't that primarily due to the decision to tie progress and trace
> > too closely?  If so, perhaps that needs to be revisited?
> 
> Or the "too close coupling" needs to be accepted as the cost of
> doing so (as "progress is often a good cue for an event worth
> tracing" was a convenient way to cheat by programmers not to spend
> too many braincycles to decide adding trace points---they
> automatically got them when they decided to show progress output).

I wouldn't describe it as "cheat", but I agree with the general
sentiment - in general, I would think that if something is lengthy
enough to need to indicate progress to the user, we should trace its
performance.
