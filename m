Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC72C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691606147D
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELDov (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:44:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6FC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:43:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9241254otg.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=En+w0PvS4KhsQVEJ+NsH9xUTZX21Df66JywO41wUH6I=;
        b=ML6P+j+try83lIEj5n9ldsbEzLttP04w46lnCmmWvDlHDuCGE64nC7blD3D1ghtZ81
         2bA619wimHcpDySKFDE9JGGG+9rsoi/ZPfn5FdOgTiWm73z5co4rIqE4/7dE+JULpZex
         8YPiUOmWdIl8Y79Z1IBhYj5wQQW+VGA8zRD2Fx4Lryq6AUHB6yYUofXiB42vc3cTU1G/
         iLBxQdaNC5pHWHOfKojFGnTW/vdG1+/kR6njVF7DMvPM1p+LCWl/9MIAugABMA9zBWnh
         xx2VB9NWZs1Yz6MFRg8RaSYxKaSknbYqLXx2meGurZ31knIVLUt4Rz7TKBp71RJqOi7z
         F6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=En+w0PvS4KhsQVEJ+NsH9xUTZX21Df66JywO41wUH6I=;
        b=R/foiiOPIHdeyHFyqfVhrnKBCMfMcDE1RMx3MVq86XG22OvO0lMjApPQkTLKnpj0e6
         ZjG2YeIR+KOgAfCSNNpNzh5dpO6L8BW1uzYmp6Nzdj5vXjOux+3HoMD0lyQYEAIWzB/R
         1XDJ0TmhqjL4le+EV3Thfl3yYrJZiFqercNxwVhcMR4sMYAfN6U6nd9Cx7fruwOPNZ8A
         cNc3zJDGrtmB4Ry8JPa7MiaooLjcG3WZWCSjThW6AkbWI7UtugzbIIgIqF/ke5w3U6gQ
         NXlpEM5FCU+pK9Kd8r48i8dS5gilG0Y2hnKJhrg074Q85JR1Iuz4apIkdG2bnBgn+FWC
         OSlw==
X-Gm-Message-State: AOAM533WwQmL3z0dwgf9mSpmgJ0USpIV6U7EZsF4E0xXi4JIVg3SAw4U
        ugggL9irc+UQ/stQqZhkVjL9CXKxZLEtNA==
X-Google-Smtp-Source: ABdhPJxmW45b7AcrGlzIEx4VIQjrYG7NBNMyQ8A/SY/SZJtbaour2IdpRMipaAYbn91ZDf1KsxnkTw==
X-Received: by 2002:a9d:6e0d:: with SMTP id e13mr30019080otr.83.1620791022764;
        Tue, 11 May 2021 20:43:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c19sm3552080oiw.7.2021.05.11.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:43:42 -0700 (PDT)
Date:   Tue, 11 May 2021 22:43:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Varun Varada <varuncvarada@gmail.com>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <609b4eea1088a_678ff208ba@natae.notmuch>
In-Reply-To: <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Varada wrote:

> Re: your point about me not pointing out specific examples: the
> command output for detached HEAD state reads "you can discard any
> commits you make in this state without impacting any branches by
> switching back to a branch". I'm incredibly passionate about this
> example. Here, the user is left to think, "wait...so this will not
> impact (significantly affect) any branches, but will it affect them?
> As in, are there side effects that I should be aware of? Where do I go
> to find out what they are?" All of this mental energy is completely
> unnecessary. Mind you, this is regarding discarding commits, which is
> a destructive action.

Completely agree.

I'm not a native speaker of English, but nowadays I use English more
than any other language, and when I read *impact* I read alarm bells.

First I'm reminded of "brace for impact", which something nobody should
take lightly (native speaker or not), and when I search for "impact" on
IMDB the first result I find is Deep Impact [1]. Not something bland.
Maybe my understanding of the word has been tainted by my experience,
sure...

But I'm still waiting for anybody to explain what's wrong with "affect".

> > > But why bother? The word "affect" is a much superior choice.
> >
> > Why bother with a chenge at all?
> 
> It seems like you already previously agreed with the premise that the
> word means "a significant effect" or "to significantly affect". I
> understand and appreciate your thoroughness to scrutinize changes to
> the repo, but I'm frankly surprised that such a small change is
> attracting such fierce debate. This is meant to be a change that is
> probably one of the easiest ones to decide on: it only consists of
> one-word changes that don't change functionality, yet undeniably
> reduce confusion.

When I started contributing to the git project more than 10 years ago I
noticed precisely the same thing.

It is a paradox called "the bikeshedding effect". When you contribute a
complex and convoluted change it's easier to get it in because few people
can object (as few people can understand it). But when you contribute a
change as simple as changing the color of something, then *everyone* can
opine (literally).

That's why the simplest changes tend to be the most difficult.

Additionally in my opinion the git project has a language problem, but
that's a separate subject.

> Re: your previous point about linguistic authorities: yes, there is no
> authority on usage, but therein lies my point. This doesn't even need
> to rise to the domain of usage, because it is squarely within the
> realm of semantics. Words mean something, and we all use dictionaries
> to learn about / confirm those meanings. Insofar as all the major
> dictionaries cite the word as "a significant effect" / "to affect
> significantly", that semantic concept doesn't belong in the cases
> where I've made changes. And if it does, then those need to be
> clarified (because that's where the real confusion/ambiguity is).
> I.e., it's not "why is not every case a significant effect?", but "why
> are some cases a significant effect?"

I often find it's easier to flip the problem around (from Karl Popper's
falsification principle).

It should not be your duty to prove that all swans are white (which is
impossible), it's the duty of the skeptics to prove that a single swan
is black.

I haven't seen a single person in this thread pointing out what's wrong
with "affect".

Cheers.

[1] https://www.imdb.com/title/tt0120647/

-- 
Felipe Contreras
