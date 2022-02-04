Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A5CC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 01:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353649AbiBDBsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiBDBsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 20:48:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD08C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 17:48:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c24so10168823edy.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rYw5ssmBwURfT4Ya3J8KJ8SkCO9pPcllw2eQ0ud22/w=;
        b=Br4VBnIuywgkMty8z5z9yy0/exiN2NnOoDRxulqo8zRwV3hKzk8vOtQImGuYGPnKcc
         0ZSgH1o4e8FDw7wATLMTeN+X6G20Y8JstTVVDqHcgPbY1pJPzTWc72H3JeGJi/XNsQtk
         MBNm5ieUHUKEOLw7Hdsuaasx3d2IUvYpIetEfC4Gjv+q0G0Hc0CokfkMWivUdOVUudIN
         FAybXWpNSckgpnIXyLGFW2VmEdsBIa6YoBEq4W275jXIHgVEguBn1Dq5piNNRdBRv81U
         7EYqJ7czAw2nwX3E9XA8xtiywY0FbmieRjc2JPDWe5YzvXm8t2aBen3q9m7MdFZoijcS
         A/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rYw5ssmBwURfT4Ya3J8KJ8SkCO9pPcllw2eQ0ud22/w=;
        b=HhraFHu2vRjlZ3s6NJUtvOto8GhONVpc2h4Pyd1+lL16UTAusr0yyTsuVxgUaoeRHE
         zRECTleY31dmDNFWZz6oflXKbMjsGuseL9DHeimLC+kR5HCBj32HyZL7izQo8qzHryio
         WkU9Kw0k5mNp2xkubK+djt2XFFUQAfKzAj17fMXM3vSc4bxViELhMu7c18U4KwwLvZNN
         QkMi6zz76Tdl2djw3fqPjTrSqUKYThlEjJbI5Pkj5Xxh9wzjDahnFCl0UCoHtpMcBRKA
         aLTZw8pjBGlg/82PSjpfBxPMxZ7OKrekgFYIjCTb14aJixeStX2OGjYDhRdoPO+7GWNp
         Vxjw==
X-Gm-Message-State: AOAM5306H/k7srxc80YCOVGmIx6u8ijvU8PezVfCdPeMWKS+iFe9li/U
        7XIk/jjK/rdWWVVAZPHI30Fzs0YveUGoLA==
X-Google-Smtp-Source: ABdhPJz93+pHavWHT9X73mB0CEtz3mlBFhxHrXkSEQfvHn9LrBAsdAdAF4e7yUWMVZO02pWm80Fkpg==
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr876531edd.401.1643939283566;
        Thu, 03 Feb 2022 17:48:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lf16sm158719ejc.25.2022.02.03.17.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 17:48:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFnhh-005Loe-Qv;
        Fri, 04 Feb 2022 02:48:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Date:   Fri, 04 Feb 2022 02:15:27 +0100
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20220203215914.683922-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220203215914.683922-1-emilyshaffer@google.com>
Message-ID: <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Emily Shaffer wrote:

> Since v6:

Thanks for the re-roll!

> I've dropped the fifth commit to use this new config for `git rev-parse
> --show-superproject-working-tree`. I think it did more harm than good -
> that tool uses an odd way to determine whether the superproject is
> actually the superproject, anyways.
>
> I poked a little bit at trying to find some benchmark to demonstrate
> that "submodule.superprojectGitDir" is actually faster - but I didn't
> end up able to write one without writing a ton of new code to traverse
> the filesystem.

I'm assuming that's tested against some variant of the submodule-in-C[1]
conversion. I.e. at least when I tested it [2][3] it seemed easy to come
up with (probably overly artificial) benchmarks where it would matter
for the shell-out in this series.

The question performance-wise was rather whether we'd just be
introducing the config mechanism as a transitory performance workaround,
and the need for it would evaporate once that C migration happened (re
original CL quoted in [3]).

> To be honest, I'm not all that interested in performance
> - I want the config added for correctness, instead.

And I'm honestly still at the point of not even being against this whole
thing, although it probably sounds like that. I'm really not.

I just genuinely don't get where this is headed. I.e. for the last
iteration I did a demo patch on top that showed that there was no case
added by the series where the on-the-fly discovery wasn't equivalent to
the set-in-config value[4].

That change showed that after this series in a state where the config
*is* redundant to on the fly discovery (or maybe not, and we're just
missing test coverage).

But since you're citing correctness do you have some repo->sub
relationship in mind that would be ambiguous in a way where the
configuration would resolve the ambiguity?

I can imagine how such a thing might work, e.g. if we gave submodules
some git-worktree-like method of being completely detached from the
parent. I.e. being able to place a /usr/me/repo.git whose submodule
entry for a "test" dir lives in /opt/tests or something. So when you "cd
/opt/tests" you wouldn't be able to detect you're within a submodule.

(I'm assuming the case where the submodule has its own "in-tree" .git,
is that even supported anymore...?)

But I can't think of one where such an ambiguity would arise within our
current featureset.

What I really can't see is how if the need for such "config [...] for
correctness" would arise how that doesn't also invalidate the
assumptions you're making in 3/4 and 4/4.

I.e. surely if we need the config for correctness it's also true that we
can't after-the-fact add the config on the fly to (such) existing
submodules without user intervention. Or maybe the ambiguity would only
arise from the POV of the submodule, but not for commands executed
within the parent?

1. https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com/
2. https://lore.kernel.org/git/RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com/
3. https://lore.kernel.org/git/211124.86a6hue2wk.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/RFC-patch-2.2-b49d4c8db7d-20211117T113134Z-avarab@gmail.com/
