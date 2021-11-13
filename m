Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9DC433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B450B610A1
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 09:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhKMJ5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 04:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhKMJ5O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 04:57:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F9C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:54:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t18so28463163edd.8
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 01:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1Zc8QS3mzSehpbFpLeAEvAorGM2V+UXEBKF+Q3szIgk=;
        b=WD8XzL3l+0wno79K4NTPfxrV0Fo/4jZtjQ0I0DcgbeYjBH8kGBrXRtxwfmzPbU0Ve9
         hH/uFm/mTqSraIKyM9kUPErPLhcJMHAZ95fhcH1lHjgBjXoF+mRcQ97gmNkKUSWsRzZp
         tLtDAbU8sICW6P8uTZgqn0GkxfzQTX5J6SB0AWs18Gyk2amklK2PNU+jXkk9tGSzgHg+
         QbZnCbIpMSs7C7xYEHe6JxpsUjqrOGLMYTKW6Cqs5mNjAaKaQZ3NlOmPSQnp2gj1h4VH
         Zy3ZqasZL/k82e9odosZNPlIPl9A57oVVQCECoAPyVetkqA6uJ7p5puCUKhoSUWar6q/
         loVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1Zc8QS3mzSehpbFpLeAEvAorGM2V+UXEBKF+Q3szIgk=;
        b=goxnDeJTXmKM0RFHU49ZNJ9d9mvywSnM2UT+UbLTRBy9t5FQFyUFGqKIsm4bswbINC
         FtngicBLGhG1W8sA+4cg8LgvM58/VGZorQfYA9Z3i5bK1EJog8teNNHuX11bELV5x3/j
         RN/4WmA/Bmf/ab5yPUwih4iqkKHH4FTGd22D5kRL0zGQ1He68XECpiWBhrulZSWDo2V2
         cAdKBRndTVTy/UNYO09Zp0evlmE45W5Tbi9JarG+ZKZ5FEiDRUA4vCcf8xU90s+yJ2/N
         bdOs5at7mdvITWmqpiYUI7VNNEJc4IU2kIrID7D2Tt6Zc3q9qnSYbesxx7GkeGia+d/T
         6Oeg==
X-Gm-Message-State: AOAM531UjYeI1FM41dGZCzFaw0lTO5eQxiLOtxkt5SoEz0Iq5R1gyEeJ
        gIRtmjjowE7uSQXMpVUhhsz1DTpFGhT1TQ==
X-Google-Smtp-Source: ABdhPJw2P/mNQ67NpqCLHOQ8u6iqTHCOgJQVhXhlapNzyTWxm0a2PMbwcMfE27MoNqRkuf6k1b+FTw==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr27855757ejc.219.1636797260105;
        Sat, 13 Nov 2021 01:54:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa17sm3692063ejc.123.2021.11.13.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 01:54:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlpjm-000b9S-Iz;
        Sat, 13 Nov 2021 10:54:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] name-rev: prefer shorter names over following merges
Date:   Sat, 13 Nov 2021 10:42:46 +0100
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
Message-ID: <211113.86pmr4tm7p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 13 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> name-rev has a MERGE_TRAVERSAL_WEIGHT to say that traversing a second or
> later parent of a merge should be 65535 times more expensive than a
> first-parent traversal, as per ac076c29ae8d (name-rev: Fix non-shortest
> description, 2007-08-27).  The point of this weight is to prefer names
> like
>
>     v2.32.0~1471^2
>
> over names like
>
>     v2.32.0~43^2~15^2~11^2~20^2~31^2
>
> which are two equally valid names in git.git for the same commit.  Note
> that the first follows 1472 parent traversals compared to a mere 125 for
> the second.  Weighting all traversals equally would clearly prefer the
> second name since it has fewer parent traversals, but humans aren't
> going to be traversing commits and they tend to have an easier time
> digesting names with fewer segments.  The fact that the former only has
> two segments (~1471, ^2) makes it much simpler than the latter which has
> six segments (~43, ^2, ~15, etc.).  Since name-rev is meant to "find
> symbolic names suitable for human digestion", we prefer fewer segments.
>
> However, the particular rule implemented in name-rev would actually
> prefer
>
>     v2.33.0-rc0~11^2~1
>
> over
>
>     v2.33.0-rc0~20^2
>
> because both have precisely one second parent traversal, and it gives
> the tie breaker to shortest number of total parent traversals.  Fewer
> segments is more important for human consumption than number of hops, so
> we'd rather see the latter which has one fewer segment.
>
> Include the generation in is_better_name() and use a new
> effective_distance() calculation so that we prefer fewer segments in
> the printed name over fewer total parent traversals performed to get the
> answer.

So it's the case that if you were to print out the output of "git log
--graph --oneline" for these ranges and draw the path we'd take for
either variant of these examples we'd take different path, i.e. the
first version takes the ^1 parent every time, and the second traverses
various ^2 parents.

I think this change looks good in the context of name-rev, but I wonder
if longer names wouldn't be easier to understand in some cases,
i.e. you'd more clearly get an idea of how this change was tangled up
with other topics.

Does one or the other of these versions provide a better hint for the
"this branch is used by" relationships in What's Cooking?
