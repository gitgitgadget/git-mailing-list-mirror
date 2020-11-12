Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16730C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B152100A
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOgNDevI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgKLQ1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgKLQ1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 11:27:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC4C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 08:27:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p93so6958465edd.7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EwMOJap9/bttx01AKP/fx+EFMC97+Pby+rB286LhibY=;
        b=OOgNDevIJQL88gXnJVGzGM057Tv8je+SGrGeKS9pxTArD6PzMUnXcsc468TWvnpuXn
         5oi3jqdDX8Hqx1mesy8vFxI7835ddwPy4hEcfA7926X5KN27Zdju7aI8aZp0RkJ/rsZ8
         aA9EloGYMgYH5sC8EmqCfWFAIhH2il1z2eNTysbQu94AXHM+3z2TUO3UNJT9jgjSf5ei
         HaIxRKOUj0dNRhdDakXWJ2za3nrnW42f+bIiIy5xRTUszeccJ6WdtB8FVzIgrgX+SnLS
         Fsp2FwCRjxqCmlfyeAJhgXwFYnT9SqDDjyZyrnrad8nLhuh3/w9yGc4yVFloo4mBQ4h0
         pE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EwMOJap9/bttx01AKP/fx+EFMC97+Pby+rB286LhibY=;
        b=YVzF4zyuSTWTltzw1wE4sTDFbPmPM1jib/Ho0jY+zfbBYY3JWIfPXy2o/MXzjURFM3
         FHODvGGkW5G0QE0sVg3KsQG+AQ9d7+rD/XZQtzOUGm8z5tsF2nnQpre0MY/ae/QdKdSR
         0ISI8+2KIDEKygOZi6LgGXpUhXopReyXwcL521BkHhVFqn/Yo/JvJtd1XurBZi0UbbTN
         j4NigxhkniIeq9yxPzCHZ56NP5E47YW0CXKFqPD5t+XTUsH5l1NSkGVOazeMIQZSrwTf
         uS3akUyZlZiHS1tfTbtY6ADLyvm7R8JcK7AQ5AUtHm9z57HQoQAt1aIEmJL0uaHbxYVm
         okNg==
X-Gm-Message-State: AOAM531/7TDWv37Kukaa+z+RrEHKU4LkAJ0AyrDmQEF+9evx1n6wHfRH
        g3hQBW2EIpIadSA7gpSfJoQ=
X-Google-Smtp-Source: ABdhPJzuNTvmzLZVPcrX4+apCvvNwRHxnlzR7effelrNGetXpvme70wOGgfCLVlAsY3APY1kxv5dkg==
X-Received: by 2002:a50:f68f:: with SMTP id d15mr647081edn.4.1605198423331;
        Thu, 12 Nov 2020 08:27:03 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id h23sm2321009ejf.120.2020.11.12.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:27:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "herr.kaste" <herr.kaste@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: BUG: commit-graph.c:1068 when doing `git pull`
References: <CAFzd1+7xQHgaOYKW7WZaWCPdp85Pfk8k_M-gVtBq6Wf7bbJTzg@mail.gmail.com> <CAFzd1+7VxaGGMVKicuy8KnWdZoBxEHY8xS9kK1VF0Tgai=Kcxg@mail.gmail.com> <X61J7bWDXO/r7Ob5@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <X61J7bWDXO/r7Ob5@nand.local>
Date:   Thu, 12 Nov 2020 17:27:02 +0100
Message-ID: <871rgyh76x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, Taylor Blau wrote:

> Hi Caspar,
>
> On Mon, Nov 02, 2020 at 08:12:07PM +0100, herr.kaste wrote:
>> A
>>
>>     $ git commit-graph write
>>
>> did the trick.
>>
>> Let me know if you think there could be something useful to reproduce,
>> somewhere.
>
> I think this is worth trying to reproduce. The first message you're
> seeing about the commit-graph-chain.lock already existing is a
> red-herring: it's likely that the last time you tried to generate a
> commit-graph, that it hit that same BUG() and left the stale lock laying
> around. (I can't remember off the top of my head whether we still run
> the atexit handlers upon a BUG(), but even still, I could believe that
> some other stray process left it laying around, too).
>
> So, what's interesting is why your commit graph ended up in a state that
> it got some commit without all of its parents. If you could reproduce
> that state, that would be interesting.

No matter how it got to that point we shouldn't be dying on a "git pull"
just because the commit-graph code had a hickup. I thought I'd addressed
this in 43d3561805 ("commit-graph write: don't die if the existing graph
is corrupt", 2019-03-25) and related commits, but I see that's not the
case.

That code really needs to learn how to operate in two different
modes. One in the write/verify codepath where we're the primary command
being called, and one where we're just being called on
fetch/pull/status/whatever when we shouldn't hard die just because we
can't access the commit-graph side data.
