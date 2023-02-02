Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044EC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 11:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBBLYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 06:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBLYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 06:24:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B5719AF
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 03:24:41 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so5030191ejc.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71JZdL53BNT2unpvjurK1qyYDhHckzzwpvc+zi6rJKY=;
        b=lFv0YtUxvfC0GgIZsUbuDunqyGZvXYPPLvdJsfxxkY0putVMuZK80w/505FXIRq3zu
         w3SHEA2zHVK+RdoZWUtRMZ/vaXuwW/TZ9selesnINxwVWY2DdsCssJ4FoHSZpoE6xn4T
         vxVQP/lUwdC/vS3krkZpQDEshR9vlA6n+jRl/POd4yP71vQx94z3UL5p3jzA+t8VUeYa
         TeB73tb3O40Yw+omxl6v0KxlCoVNgIHyby/3VII8cAztQsAWn3uIKexY1ptX0KJRvhee
         da0oHAXRWYsHoqG0mabzrnaUUwYB3TuhDzTL/X8sNFvlI5ySyX/urVHsvNmMPI2vaEpd
         Yifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71JZdL53BNT2unpvjurK1qyYDhHckzzwpvc+zi6rJKY=;
        b=SS9JasvSYjuNeKBDJLMgiZoOs6pUgrSTAMPRX61qJt6+x6yeiufHiArNJKBeFg6AX0
         jRqhxKiwaHFu4azdcC5izsYmA2qHa2KSFVPWvAzfXGqRupI0Ry3fdJmsProzpamDBg+O
         OxWOuPXfoo7pE80CG29W9Wq2grZuuu8qfH6d3BPpksvyT5/0PJNLsgCCXINXavqRncUb
         XtKO41QdIufiFgXMRx5RottXi5KKL188DLV3uFypyeNAY3qtUhghbjZW7LbzPOTAdy0L
         XwOOiWVeUerYm6xs8Uth3Yz/TmN774Xhz+ZGL9fGd2FFTSynuZhpjSeXGdkYgc45DECV
         kLQg==
X-Gm-Message-State: AO0yUKUg74zSo8hn72jwemmWDVP1YfrgeKISc+AmvNwHkIfJ59N1bKuu
        zRl+ysdiov9bO6noYkhLXk0=
X-Google-Smtp-Source: AK7set+cdtPz0o+lXLgsRaLyHyO8ufPQABdjcgIU43OiJIIydoXVsSN9mSeFMtW3aU+x92dYMFEj3g==
X-Received: by 2002:a17:906:31cf:b0:878:4dd1:5161 with SMTP id f15-20020a17090631cf00b008784dd15161mr6122797ejf.11.1675337080331;
        Thu, 02 Feb 2023 03:24:40 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906081000b0088cf92eb0e2sm3445525ejd.178.2023.02.02.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 03:24:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNXhn-002hq7-01;
        Thu, 02 Feb 2023 12:24:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Date:   Thu, 02 Feb 2023 12:04:48 +0100
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
        <xmqqwn5bg695.fsf@gitster.g>
        <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
        <xmqqfsbxcmdd.fsf@gitster.g>
        <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
Message-ID: <230202.86edr8pax5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Johannes Schindelin wrote:

> Hi Junio & Peff,
>
> On Thu, 26 Jan 2023, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> >> Thanks, both.  Let's merge it down.
>> >
>> > Sorry, I'm a bit late to the party, but I left some comments just now
>> > (this topic had been on my review backlog for ages, but I never quite
>> > got to it).
>> >
>> > Many of my comments were small bits that could be fixed on top (tiny
>> > leaks, etc). But some of my comments were of the form "no, do it totally
>> > differently". It may simply be too late for those ones, but let's see if
>> > Matthew finds anything compelling in them.
>>
>> I do not mind reverting the merge to 'next' to have an improved
>> version.  Your "do we really want to add a custom server based on
>> questionable codebase whose quality as a test-bed for real world
>> usage is dubious?" is a valid concern.
>
> Except.
>
> Except that this code base would have made for a fine base to potentially
> implement an HTTPS-based replacement for the aging and insecure
> git-daemon.
>
> That code base (which is hardly as questionable codebase as you make it
> sound because it has been in use for years in a slightly different form)
> would have had the opportunity to mature in a relatively safe environment:
> our test suite. And eventually, once robust enough, it could have been
> extended to allow for easy and painless yet secure ad-hoc serving of Git
> repositories, addressing the security concerns around git-daemon.
>
> And now that we're throwing out that code we don't have that opportunity,
> making the goal to deprecate the git-daemon and replace it by something
> that is as easy to set up but talks HTTPS instead much, much harder to
> reach.

There's many reasons for why you almost never see a git:// URL in the
wild anymore.

But if "easy and painless" was synonymous with "built with git" or
"ships with git" as you seem to be using it, surely it would be more
common than doing the same with http or https, which requires an
external server?

So, easy for whom? Just us and our own test suite?

Having read both your reply & Jeff's[1] I don't think you're addressing
the thrust of his argument.

You can share all those goals without the method of getting there
requiring us to start maintaining our own webserver.

> In addition, it causes a loss of test coverage because Apache is not
> available in all the setups where the "questionable" code would have had
> no problem being built and validating the credential code.
>
> Windows, for example, will now go completely uncovered in CI regarding the
> new code.

I have not set up Apache on Windows, but binaries seem to be available
for it[2]. We don't use those now, but is downloading, setting up &
running them in CI really harder than emarking on a project of
maintaining our own webserver, especially we've got an eye towards
non-test suite use?

Even if we think that we'd like to have a webserver built when you "make
git" I don't see why we'd go the NIH route of writing our own. Unlike
the git:// protocol there's a *lot* of implementations of http(s)://
servers.

If we think apache is too heavyweight for whatever reason, can't we add
one of the many light http servers out there to contrib/ use it it from
there?

1. https://lore.kernel.org/git/Y9JA0UCRh7qUqKQI@coredump.intra.peff.net/
2. https://httpd.apache.org/docs/2.4/platform/windows.html
