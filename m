Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C611C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C4964E4A
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhB1Kfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhB1Kfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 05:35:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C8C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 02:34:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so2581397ejb.5
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hQfoNtPahKi1KIa5x3Y9S5JMq5ks6agjfxynvx7iM+A=;
        b=W+MZidq2lDk+GtU/SLGIZbPiWlHMG2PcoPkuNCmcTXvwa3c6aFuKpdEfyUH/qh9f2e
         G5CMLpFQZRdL4wRtJA7Dx2uKpp81Xthmn224hu3/mvuvvQ3pIDtXLIyB9VHjYWCamUys
         WFiwMWzfc9KgycrDWzF7nKihJkObrFO/JygJMehMyPgW7w29EgcNi6AWiuxW0reN6nEq
         WPZRMTtoi3V8SaCzMUFTolTLHcS6b8bTmPBsGUxDnlgz6juG0pXio2S4XR+l7WIoiYz1
         NLObmbOrpjVdajnz3ZPTde6XQdHbaTCHR2txouPUk/ZvzAoDjoQ5P506NqdAbUauQWTG
         iO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hQfoNtPahKi1KIa5x3Y9S5JMq5ks6agjfxynvx7iM+A=;
        b=mvdwcySDt2m8moJk52zubgURq4Pcsi3UrPo6wnlO2DWhTJDewr6Cw8dHZmF4e7JwQ/
         stGbxFzCtzEhS74WwjDsEbd/tl3IlKUxPNprOZbXC90cXR7aBfdjSMoSs7nI6EIjeMAp
         gnmonZpt/H7fCwuHlGRebMc8mGE5RiAXW050pS8eC/4lpRCiQnzIi5lTT0iEVSFTIQc5
         KGfoNP0EHPhv1AoKt1R+xOFwe65Mj1G1HQxliN6sQTW1JVb+kXCraFqqjF4N0lwNQV/H
         RCBBUVAwNOW5Xz/lNU22/u1XBzi9iDp5RNvEWX/3T9HibNH9haKJcHVI+asYJgCKhLIu
         BWmA==
X-Gm-Message-State: AOAM533zqvQuFyeymoqz6oWyR1J2IBbvw8zZ8XHo41sCb5S2qdfhrTjB
        ukzw2y4614O3guuHT+5JIsw=
X-Google-Smtp-Source: ABdhPJzCiX7p3SPh4MpITh8Rw4OgHnHqJ6r71j9hB9oVSqyV2ywI4S5U0u7inbDsTt9dEdNaWYYtbw==
X-Received: by 2002:a17:906:384e:: with SMTP id w14mr11084187ejc.285.1614508485391;
        Sun, 28 Feb 2021 02:34:45 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r17sm9358595ejz.109.2021.02.28.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 02:34:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Round-tripping fast-export/import changes commit hashes
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
Date:   Sun, 28 Feb 2021 11:34:44 +0100
Message-ID: <87mtvolbuj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 28 2021, anatoly techtonik wrote:

> On Sat, Feb 27, 2021 at 8:49 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> Your second commit is signed.  Fast-export strips any extended headers
>> on commits, such as GPG signatures, because there's no way to keep
>> them in general.
>
> Why is it not possible to encode them with base64 and insert into the
> stream?

I think Elijah means that in the general case people are using fast
export/import to export/import between different systems or in
combination with a utility like git-filter-repo.

In those cases users are also changing the content of the repository, so
the hashes will change, invalidating signatures.

But there's also cases where e.g. you don't modify the history, or only
part of it, and could then preserve these headers. I think there's no
inherent reason not to do so, just that nobody's cared enough to submit
patches etc.

>> There are also other things that will prevent a simple fast-export |
>> fast-import pipeline from preserving your history as-is besides signed
>> commits (most of these are noted in the "Inherited Limitations"
>> section over at
>> https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html):
>
> Is there any way to check what commits will be altered as a result of
> `fast-export` and why? Right now I don't see that it is reported.

I don't think so, but not being very familiar with fast export/import I
don't see why it shouldn't have some option to not munge data like that,
or to report it, if someone cared enough to track those issues & patch
it...

>> Hope that at least explains things for you, even if it doesn't give
>> you a workaround or a solution.
>
> Thanks. That is very helpful to know.
>
> The reason I am asking is because I tried to merge two repos with
> `reposurgeon` which operates on `fast-export` data. It is basically
> merging GitHub wiki into main repo,
>
> After successfully merging them I still can not send a PR, because
> it produces a huge amount of changes, because of the stripped info.
> It can be seen here:
>
> https://github.com/simons-public/protonfixes/compare/master...techtonik:master
>
> I tracked this behaviour in `reposurgeon` in this issue
> https://gitlab.com/esr/reposurgeon/-/issues/344

