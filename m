Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F90C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF252072A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgAGNOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:14:53 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36278 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 08:14:52 -0500
Received: by mail-wr1-f50.google.com with SMTP id z3so53891871wru.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 05:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oe2vfjDpagvIcWw5WprhvG8H6eQHmdLech4JLLYc3A=;
        b=afDPvvwO9OnUSxVHvDVf1lyrdQJ29bb68AIW7AoA8j7Pzcg4ECNky+SKTf0Jn1b8Af
         0atKD1LE8oqSAHFj1rOQCUp6TC9k52z9SAcgfjMhVdugcti6Xw4e3KX3wEvbd+iwYzcR
         Fw4FEz7LgXFJ39s1OzE6gjK+h+91k1AGLmk5J6AKad8jeEOmp8tlGrfXexXbFvAik2bw
         YA4KyYKmYraWRztXOZWNukSylwNOsZWMsV7nvsyYTieH5jNVUb7Tgef9FvVfiQb/+hEc
         wEzL+Tt8STH5GdXkbXcy/DgZZa/CT3Vho8JVMZ/LhoJ8DYo2ZCyJm6EIZVQxyUdFUhIi
         pBXQ==
X-Gm-Message-State: APjAAAXxakRVjP0FMjtxqJMexed/3JzIKGra0GTtGMXYT6/VVwOw9/ke
        VnJR+FW8wQY+fl3sazedRpip4raNrYshHlIss0k=
X-Google-Smtp-Source: APXvYqyRHtnbZjfkZFi9/Zm72LdoyO5HA1AHwYw4MSXX0ToImE+WJ86QApgTP3pFBbMwsv8Zzd/TUtdOiXDrSjpNfTo=
X-Received: by 2002:adf:f382:: with SMTP id m2mr109453776wro.163.1578402890986;
 Tue, 07 Jan 2020 05:14:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net> <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
 <fe1cd838-d390-96ab-d3b4-72df5aa61947@gmail.com> <CAPig+cRH-yeHmeikf=cbTTMDom+7SLtT2dmya=WP7fsy8tTY3g@mail.gmail.com>
 <3fd8d52c-622e-29a6-442c-66797a3ae1f9@gmail.com>
In-Reply-To: <3fd8d52c-622e-29a6-442c-66797a3ae1f9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Jan 2020 08:14:39 -0500
Message-ID: <CAPig+cTJKgXp1Pmp+muq-psHNrFhMBdZgfbMySozQ_dknpy-tw@mail.gmail.com>
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 7:56 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 1/7/2020 7:50 AM, Eric Sunshine wrote:
> > On Tue, Jan 7, 2020 at 7:42 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> Here is a a patch that reproduces the test failure. It hits the
> >> assert, so it definitely fails.
> >
> > What happens if someone builds the project with NDEBUG? Then the test
> > won't fail as expected. Perhaps this patch ought to also change those
> > asserts() to `if (...) BUG(...)` to ensure consistent behavior.
>
> A final version of the patch would probably fix the bug and not use
> test_expect_failure.

Indeed, I understood that when I made the suggestion, but you still
want to be able to catch the problem if the code ever regresses and
reintroduces the bug. And, to do so, you'd want to ensure consistent
behavior which you get with BUG() but not with assert().
