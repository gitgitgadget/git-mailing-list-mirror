Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D15C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiEIVqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 17:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiEIVqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 17:46:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47818FF38
        for <git@vger.kernel.org>; Mon,  9 May 2022 14:42:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id js14so11428119qvb.12
        for <git@vger.kernel.org>; Mon, 09 May 2022 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dvCVYG4uKSNhF4KaNMTeu3RJd6E9ivhTODSa/qJYkTQ=;
        b=ziwUVLCxMMlbaIrdh7g5rdIN6RqvPG4JSMKxv5lRb3i6cSaJhMZN4RGrCNoKJeQuaR
         6Yg+0Cc81aW1Qtdir0/bL2u8Gn+BUC+k9tAkTjcn+BG9qlPfyb6ZsnNeIgdUGfivAMCy
         MAc9DofLyIOjq8++DH2gETHQDdY8LMZ6M+UkS7bDiOqa/PoLRL5U2gOYHjGJRf6fAFfj
         h4+7ucX0lwXW5RjPGcvra4ckckBcyzKQ23plDnB9BdpxjkVXjnAQ/JRsd1GR0B6l3Nwk
         7wfQx+iPWjo45PFHyaToAhw5JsWPRamvSUkU5CTJA2WT8EljK0rvoXxSRotGfKqiSmgX
         KoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvCVYG4uKSNhF4KaNMTeu3RJd6E9ivhTODSa/qJYkTQ=;
        b=dFzY/eWomjE5lAH7BN4xoBW8zjZN5CBp2PBY6k6panMsBPVoZzaMH6sRbOedOh28Re
         Q64frMrUi4OkEe79DAOs7oYMoboxlIH300wo74k8CiGoY60xvWRardrFJm4jdjRusaQd
         y0e+WGJH6W6mCIayRMoGfdygd6Hi3v4caq55J74dP7QBhK8NiiCXQY1EAmo5SWn+zQzt
         HG0DEgDDWxMRrpHB/9cUBMFd6yhrbwyT+WSuLiq7h0eVkfAp6DQKrHLzf522AxnQb8rK
         7Yf3YXBP4oIXHvyty7aYhgM8dOSKrwNe3l5fxxWsIjXqV18iTRfMv78vCXugERJW111i
         nYFw==
X-Gm-Message-State: AOAM530agXa+wjmsrarEOUcnzJ5ibzI94zG854vG4eX8i5+EG4SbK1Nt
        RFNzc/YaH255jFOcLUaFI0B0HZueQl+lQne9
X-Google-Smtp-Source: ABdhPJwT01tfbszi/0A1DgU2ucArLmUtEOfblANAXBigTQGQ/DUhpBe4bF4dWLCf585PCmvWsZg8vw==
X-Received: by 2002:a0c:8e8c:0:b0:45a:b0e2:fe40 with SMTP id x12-20020a0c8e8c000000b0045ab0e2fe40mr15199334qvb.101.1652132545863;
        Mon, 09 May 2022 14:42:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84a8e000000b002f39b99f68dsm8167857qtq.39.2022.05.09.14.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:42:25 -0700 (PDT)
Date:   Mon, 9 May 2022 17:42:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
Message-ID: <YnmKwLoQCorBnMe2@nand.local>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

On Fri, May 06, 2022 at 06:30:10PM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
>
> Add a config variable, `safe.barerepository`, that tells Git whether or
> not to recognize bare repositories when it is trying to discover the
> repository. This only affects repository discovery, thus it has no
> effect if discovery was not done (e.g. `--git-dir` was passed).

Thanks for working on this! I'm excited to see some patches here, though
I'm not totally convinced of this direction. More below.

To summarize, this proposal attempts to work around the problem of
embedding bare repositories in non-bare checkouts by providing a way to
opt-out of bare repository discovery (which is to only discover things
that are listed in the safe.bareRepository configuration).

I agree that this would prevent the problem you're trying to solve, but
I have significant concerns that this patch is going too far (at the
risk of future damage to unrelated workflows) in order to accomplish
that goal.

My concern is that if we ever flipped the default (i.e. that
"safe.bareRepository" might someday be ""), that many legitimate cases
of using bare repositories would be broken. I think there are many such
legitimate use cases that _do_ rely on discovering bare repositories
(i.e., Git invocations that do not have a `--git-dir` in their
command-line). One such example would be forges, but I imagine that
there are many other uses we don't even know about, and I would like to
avoid breaking those if we ended up changing the default.

If it's possible to pursue a more targeted fix that leaves non-embedded
bare repositories alone, I'd like to try and focus these efforts on a
more narrow fix that would address just the case of embedded bare
repositories. I think that the direction I outlined in:

    https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/

could be a good place to start (see the paragraph beginning with "Here's
an alternative approach" and below for the details).

One potential problem with that approach (that this patch doesn't suffer
from) is that any discovery which finds a bare repository would have to
continue up to the root of the volume in order to figure out whether or
not that bare repository is embedded in another non-bare one. That is
probably a non-starter due to performance, but I think you could easily
work around with a top-level setting that controls whether or not you
even _care_ about embedded bare repositories.

For example, if I set safe.bareRepository='*' in my top-level
/etc/gitconfig, then we can avoid having to continue discovery for bare
repositories altogether because we know we'll allow it anyway.

To pursue a change that targets just embedded bare repositories, I think
you fundamentally have to do an exhaustive repository discovery in order
to figure out whether the (bare) repository you're dealing with is
embedded or not. So having an opt-out for users that either (a) don't
care or (b) can't accept the performance degradation that Emily
mentioned as a result of doing unbounded filesystem traversal would be
sensible.

Playing devil's advocate for a moment, though, even if we had something
like the proposal I outlined, flipping the top-level default from '*' to
some value that implies we stop working in embedded bare repositories
will break existing workflows. But that breakage would just be limited
to embedded bare repositories, and not non-embedded ones. So I think on
balance that breakage would affect fewer real-world users, while still
being just as easy to recover from.

>     safe.barerepository is presented to users as an allow-list of
>     directories that Git will recognize as a bare repository during the
>     repository discovery process (much like safe.directory), but this patch
>     only implements (and permits) boolean behavior (i.e. on, off and unset).
>     Hopefully, this gives us some room to discuss and experiment with
>     possible formats.
>
>     Thanks to Taylor for suggesting the allow-list idea :)

I did suggest an allow-list, but not this one ;-).

>     I think the core concept of letting users toggle bare repo discovery is
>     solid, but I'm sending this as RFC for the following reasons:
>
>      * I don't love the name safe.barerepository, because it feels like Git
>        is saying that bare repos are unsafe and consequently, that bare repo
>        users are behaving unsafely. On the other hand, this is quite similar
>        to safe.directory in a few respects, so it might make sense for the
>        naming to reflect that.

Yes, the concerns I outlined above are definitely echoing this
sentiment. Another way to say it is that this feels like too big of a
hammer (i.e., it is targeting _all_ bare repositories, not just embedded
ones) for too small of a nail (embedded bare repositories). As you're
probably sick of hearing me say by now, I would strongly prefer a more
targeted solution (perhaps what I outlined, or perhaps something else,
so long as it doesn't break non-embedded bare repositories if/ever we
decided to change the default value of safe.bareRepository).

>      * The *-gcc CI jobs don't pass. I haven't discerned any kind of pattern
>        yet.

Interesting. I wouldn't expect this to be the case (since the default is
to allow everything right now).

>      * In the longer-term, we might identify a usable-enough default that we
>        can give opt-out protection that works for the vast majority of
>        users.

Perhaps, and I think if this were the case then I would feel differently
about this patch. But I don't want us to paint ourselves into a corner,
either. It would be unfortunate to, say, find ourselves in a position
where the only protection against some novel embedded bare repository
attack is to change a default that would break many existing workflows
for _non_-embedded bare repositories.

>     = Other questions/Concerns
>
>      * Maybe it's more informative for the user if we die() (or warn()) when
>        we find a bare repo instead of silently ignoring it?

We should definitely provide more feedback to the user. If I set
`safe.bareRepository` to the empty string via a global config, and then
execute a Git command in a non-embedded bare repository, I get:

    $ git.compile config --get --global --default='*' safe.bareRepository

    $ git.compile rev-parse --absolute-git-dir
    fatal: not a git repository (or any of the parent directories): .git

whereas on the last release of Git, I get instead:

    $ git rev-parse --absolute-git-dir
    /home/ttaylorr/repo.git

I'm still not convinced that just reading repository extensions while
ignoring the rest of config and hooks is too confusing, so I'd be more
in favor of something like:

    $ git.compile rev-parse --absolute-git-dir
    warning: ignoring repository config and hooks
    advice: to permit bare repository discovery (which
    advice: will read config and hooks), consider running:
    advice:
    advice:   $ git config --global --add safe.bareRepository /home/ttaylorr/repo.git
    /home/ttaylorr/repo.git

(though I still feel strongly that we should pursue a more targeted
approach here).

Thanks,
Taylor
