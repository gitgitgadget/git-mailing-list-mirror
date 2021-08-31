Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034DC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CDB60F56
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbhHaUox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbhHaUow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:44:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B3C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:43:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n5so1061045wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+RhegBa7xbvjrINhUnBe8xkndz9ktq7ybS8fCMjWC2w=;
        b=CKkSBsKJaLaA9VF49xLT6GyHjUF7RJ4nheVoC4JwRfPQ61+AE0l2+zniFpupVIpKSa
         OLwJptayZlfInTGpo/HelI0JROja0TEWJ/sHILEm1nHuooeQujSqmDeMqRrm7MDKzzyx
         KJL+RnjnW1bqkF06HGgGj7cYgXxhjzY7KSAouNjGgR8YPIbofW/6/L+2ybNLZO9UY06e
         wNnULVwLjqFUp8z7Zh/5+VxYEZsNTIxekmTHNCyuEPM6rZpdjmxhQ2W5OUWoCyZfyCwY
         rHEcpXi6FFS8B7DjbhoN4lcNJAP+9OqLkmbzZfbSLC2YwaH9TXHm4nZdI4A2Iqf9hoks
         +oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+RhegBa7xbvjrINhUnBe8xkndz9ktq7ybS8fCMjWC2w=;
        b=f3MzTQ+7A3ujvNxTCNXZjvQsxk1ogz3o9H365ZQL8QzHScL/ldoCaItCb4yn4je2du
         2V0Nn52fzKPESXYaJJndCdUD/lyuKeMim0IAomBDXrDE0lfXK8Lci/yEeQWrYPCLRXi5
         vUOt6i4WVE6n+tTG+vaWolFOhvLeqFRZYITcaRhAd/r4k23f0XUzL2H7wEcs3BQoLiOW
         p2tzgi664nNHtF4InyDZInXUB+nkwMmn+IlsozKZOmnCSDAhis4/az11suJ8asT9loNU
         fcXAD3J4y8RRcoontw4GeRnC5hdge8UdoYzWbD2bl49iqQ1E2/GjfsMkJQf+mMPL7V0O
         is5A==
X-Gm-Message-State: AOAM531X+WRovlwg+ZFXk1p8i98ghoePWfodxb6RMtqDM8L8P5C7k0y5
        8HnWuAnPmxp9SwpnZKjtSJKTEfmpQD5rhw==
X-Google-Smtp-Source: ABdhPJzP63rKtZuZ3PuSybyKO9F+PcAtGPT+rhsfQomzk3/w/KMEUa3XD8NqMopEPmbuYEl6Sazcsw==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr34247199wrq.131.1630442635493;
        Tue, 31 Aug 2021 13:43:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f18sm3358213wmc.6.2021.08.31.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:43:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jan Judas <snugar.i@gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
Date:   Tue, 31 Aug 2021 22:36:01 +0200
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
        <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
        <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
        <xmqqpmtttr56.fsf@gitster.g>
        <CAPig+cTaJ=xm=K5Y8yn8RiOFHBH-nzhRztYRz3kYsqsyJUTACg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAPig+cTaJ=xm=K5Y8yn8RiOFHBH-nzhRztYRz3kYsqsyJUTACg@mail.gmail.com>
Message-ID: <87eea9wdit.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Eric Sunshine wrote:

> On Tue, Aug 31, 2021 at 2:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Tue, Aug 31, 2021 at 10:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>                 warning(_("The last gc run reported the following. "
>> >>                                "Please correct the root cause\n"
>> >> -                              "and remove %s.\n"
>> >> +                              "and remove %s\n"
>> >
>> > Even more bikeshedding:
>> >
>> >     Please correct the root cause and remove
>> >     /path/to/repo/.git/gc.log
>> >     to allow automatic cleanup to resume.
>> >
>> > or something.
>>
>> I also found the line break before "and remove" strange, but I think
>> that is because the "Please" is not at the beginning of the
>> paragraph, but is a second sentence.  Perhaps unfolding "and remove"
>> would make the first line overly long?
>
> Yep, you're right, and perhaps my "Even more bikeshedding" didn't
> clearly indicate that I was bikeshedding more about combining the
> "Please correct..." and "Automatic cleanup..." sentences into a single
> sentence, both as a another way to deal with the punctuation issue
> (thus allowing easy double-click) and to make the whole thing read a
> bit better.

I'm aware that it's not in any formal style guide, but for what it's
worth I find that something like say:

    Eric sent me an E-Mail with the Message-Id
    <CAPig+cTaJ=3Dxm=3DK5Y8yn8RiOFHBH-nzhRztYRz3kYsqsyJUTACg@mail.gmail.com>
    My E-Mail client is displaying it right now.

Reads unambiguously as having an implied full-stop after "com>",
especially as the next word starts on its own line, and is capitalized
in a way that it wouldn't be if it weren't the start of a sentence.

In any case, I do think just removing the dot on the basis of that
rationale is an improvement, both for the stated ease of copy/pasting,
and to remove the ambiguity of whether the "." is part of the filename
(yeah *nix filenames can also have \n, but that's a lot less likely).

I don't think sometihng like your "Even more bikeshedding" suggestion is
better, since we're trying to continue a sentence after a potentially
long filename that might on some platforms or OS's contain spaces etc.

In any case, I was hoping to just send a quick fix-as-a-patch to a tiny
UX suggestion, and was hoping to not get into the much more subjective
discussion of how to better reword "git gc"'s error messages in
general. If that's where this thread is headed I'm afraid I'll need to
tap out of it :)
