Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9482C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiGMUCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGMUCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:02:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C910FC2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:02:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so15723500ejc.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BXBu+5JWAMx+VNesiPCKLK6ZTLcujhnVu1xdcOkxJlE=;
        b=QT25MpYwsF3bcfq4nRUdh1aKzEkecKyQn/LiDlqXoOdPIeQQdvTb1f4OyK2/HqIkDE
         gnqorE7/TX7tD8KIlNSUro+U/pp7G+V3qVIHJDBXvGNLGmyEEUPJvhzM2LXnLBqry23Y
         tafnw8B26kUB6uZt9yV5NKsFrfbwWLKtYGFsyRanCcOH7BWhLfaY8dTS/E7C9JFp9gTu
         +ATr5HGjFlP98GAWeI+Qr0r6mxXk5Ie1QbZCgCISBLuGAlkRaP4ogw1S1qDyb4wX8arw
         A4pa0JuRFBzMa7kHr3loJjTLicuUQBVHh/rIJHW5/YZMa5iP0ZJ/eC3l3gEVxMAiXAq3
         jNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BXBu+5JWAMx+VNesiPCKLK6ZTLcujhnVu1xdcOkxJlE=;
        b=duZCEwGv/5hsaY07jgKlPqwiPsrExJJYESPluuxlYaujN/ohikj2jSlibgJ10a/tAg
         /b/BoSVqj2Pgfhj/mfmqem4zDtf3/rp2KkPGGiSAdMMvQfDuRKNVSnR6ApNXZs+XcWji
         +M5yD7Q/0YQMYWvXCsXrWCZUla9hxF/ZH1KgyCMVavXk/KqHFwYeuZxXDQ5E7R+6MiUH
         t8rxu15/Rui8l5EfAVHs4mHf26xHBM0+tElmyDF/zSIx97umDM/Gd0BQv+un62ZLmhKs
         7EU8gqe9ffTgQiDRQIacV56YmaDY3qb94+QLrsUtp/1b5zFNjMQpcf5Dq7faQhyeOP3h
         FNXA==
X-Gm-Message-State: AJIora/8dZjStx5x7VCnl/1cTSlpWoskAap5gDvJKgLIuHKjMKhWc6AB
        XGFO7lPuCslAK5sV3iMsFkea0arbkwpV8A==
X-Google-Smtp-Source: AGRyM1uXs2l8FUZA4V8yKeIDV2YI1D/aKyrRcC1Lx39FiLql0lAJt5TLwvBNIrQ9m+EcYfnJy3WlPg==
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id sg15-20020a170907a40f00b0072b64ee5b2fmr5371968ejc.268.1657742562384;
        Wed, 13 Jul 2022 13:02:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0043ab1ad0b6bsm8565128edq.37.2022.07.13.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:02:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBiZE-001vy3-M2;
        Wed, 13 Jul 2022 22:02:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
Date:   Wed, 13 Jul 2022 21:42:44 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
Message-ID: <220713.86wncg3hnj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Derrick Stolee via GitGitGadget wrote:

> The terms "allowlist" and "denylist" are self-defining. One "allows" things
> while the other "denies" things.

I've got a preference for things that can be found in widely available
dictionaries, these words seem to be tech neologisms.

The resulting wording also seems a bit ackward to me, e.g. we now say
that some tests are "allowlisted [...] as passing with no memory
leaks". Are we denying or allowing them to pass? No, they're going to
either pass or not.

So to me "whitelist" or "blacklist" is more natural when used in the
descriptive sense, whereas "allow" and "deny" are verbs, so that seems
to impart a sense of actively allowing or denying something.

> These are better terms over "whitelist" and "blacklist" which require prior
> knowledge of the terms or cultural expectations around what each color
> "means".

Apparently whitelist is defined in terms of blacklist, which per
Wikipedia originates in some 17th century play:
https://en.wikipedia.org/wiki/Blacklisting#Origins_of_the_term

> [...]
> Some recommend using "blocklist", but I personally prefer "denylist". To me,
> "blocking" something seems permanent. "Denying" something seems ephemeral
> and related to a specific request being denied due to some (possibly
> mutable) state. I'm open to suggestions here. There are many fewer
> replacements needed in this case.

I suspect the actual motivation is closer to that summarized in :
https://en.wikipedia.org/wiki/Whitelist#Controversy

Personally I'd really prefer if we didn't take these sort of changes,
and took the view that if something was readily understood that it was
good enough.

The CodingGuidelines note that we use a mix of US & UK english, so
forbidding certain words & basically requiring some of us to keep
abreast of the latest political trends in America is a bit too much. I'd
just like to write code, please...

> I did not make any change to our CodingGuidelines. Hopefully having clear
> usage throughout the codebase will be enough to promote using consistent
> terminology.

...particularly since I think what's being implied here is that we can
expect interested parties to be setting up the relevant E-Mail filters,
and asking patch submitters to change wording in the same way as this
series does.

We also have 30-40 uses of both terms in-tree, so it seems implausible
that people are mainly copying existing wording.

A few of the hunks here are changing docs I added, and I just added
those "naturally", i.e. I happened to think of those words to describe
what I was trying to get across).
