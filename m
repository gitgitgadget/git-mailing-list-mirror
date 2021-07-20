Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EBC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D4361029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhGTUUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhGTUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:08:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AADC0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:49:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s3-20020a17090a5d03b02901762367797bso342706pji.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+UcyPoHbrcZQcDlH0vLw2T6P6VkCt/vWYxVj1Djv/JA=;
        b=WMd86eIdad8ZUTHyMVAvFYRkK7F0/vunECTp/h2c6GTxQcaG+nlwepHeUY1jmpJwoJ
         XAOXpYVPkG3KjxdRI8GoYg+taTe8Aky34b2WDSv6ahoxWLh8Apti3EPIqQwpCWCeol9h
         d+6L/2ssLV8+I2QnukL+uX1+OQwD2LNFGwirpfraF+cbNXvqVB2jTmJ1Jm3oVvyNuHSm
         8w6GyvTZgNExiasuLPRlBeeovIEA4hSi3Vg1paUxTCcUknn5OdbTREI9PMpF8CaPPezm
         8wvWJ2s93DRIPcrI5ajbb+3N7mDGctMiIBgxDA1f9WMbvDFiDC7cqLNwbZkd8GlunT77
         HjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UcyPoHbrcZQcDlH0vLw2T6P6VkCt/vWYxVj1Djv/JA=;
        b=WU8ZGuGZ/OfBduYkfottHbuCSWhkK1fUHsxTAJaoR8TwXrJNMWF09l81EtKdFL3DuA
         Guj7epwv5Mn2C9xSBXiRSju1bOYrSHIEN34HFHr1rqNVZEZofBmak7+UyiXNBVLwEQqr
         Oi1ie8fkhx2msUi8rBSdx2waWh6zCxM9pNtkR1zZSwoiFc3xp0esN8jWA1OwudBs8GLz
         zIAWS8x4R9v8HOS/4xw9g64AsmvaBE5gj3Qgw9z/QS0+CnL7gtMewhTPbwCYvXaXcMzy
         gm9i79SK10wT2YG9cUWIl5Asogx6bAJZWmQ9jAxV+xvchDCsf4qGsq/Y5vkCv6VcwAfR
         IA1A==
X-Gm-Message-State: AOAM532/AbNchAu0wvv2ql9ivzv+8FYpA8Fv7PTaSMdW7Eu9WNnpUa8t
        Dc5ouHSI9/bbogPYbSxOBIZEDC310USJZZmoIKUn
X-Google-Smtp-Source: ABdhPJzE8Q0do9LN8iVudY/E8eV/H1xI1TfJExyMpZUvB/FZTW2vCQQw2npBIVeTMf1v/yu7npB6BUtMhweghtcs8/+i
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a798:: with SMTP id
 f24mr31942827pjq.8.1626814150215; Tue, 20 Jul 2021 13:49:10 -0700 (PDT)
Date:   Tue, 20 Jul 2021 13:49:03 -0700
In-Reply-To: <xmqq8s22ko8k.fsf@gitster.g>
Message-Id: <20210720204903.3586550-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8s22ko8k.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: Re: [RFC PATCH v2 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Here's an updated version of the remote-suggested hooks RFC, hopefully
> > addressing some of the concerns people have brought up (e.g.
> > auto-updating without letting the user verify, or prompting about hooks
> > by default). It consists of two main parts:
> >
> >  - Non-interactive prompts during certain Git commands about the
> >    existence of hooks. These prompts are turned *off* by default.
> >
> >  - New "git hook" subcommands that can install these hooks (so that the
> >    aforementioned Git prompts or out-of-band installation instructions
> >    can tell users to install these hooks in a platform-independent way).
> >    These subcommands work whether or not prompts are enabled.
> >
> > You can see how they work in patch 2's t1361.
> 
> I really wanted to try this out, but which commit was this based on?

Ah, good question. Like v1, it's based on the old es/config-based-hooks
(f2e1003b62 ("docs: link githooks and git-hook manpages", 2021-05-27)).
In v3, I'll rebase this on ab/config-based-hooks-base instead,
especially since that one has a programmatically generated list of hooks
(instead of a hardcoded one).
