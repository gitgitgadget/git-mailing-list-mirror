Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CCDC433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0E12070C
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhA0D66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392357AbhA0Bl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:41:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B206C061788
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:41:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d2so442034edz.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9STc3VLrLVIYF/i/d0plZ1dxoBkc9qtZmwUYED6VaX8=;
        b=keSISbbseBu1AdSxNa8j/4AfJ9orFS4lO8I30RTmdZCeus3BPUtFcuSmIDL/yHgodm
         PqyM9XTvXRuhxCrsF+eUYLxhGVyzk0LoIrXzSpiuZhQ3EkM9M+Pd9d0yYke1+CeqzOF9
         NMz+t2/xT9kaJ3jCbsyUwRfW+r53X+nr2bY/tTZdWRynbl12jtUQmUNgEFUR0GBQYTd8
         BET1YGMIRx5d74pAyzZcQYzOuzG2tuprwllyD2pDoCIwr4m3wA/tE+wo6JtkvBlhM0ZE
         4SfOZb2a4NSmMLlzjBP+XFoOPoBPT9dzy1NZ2mljDOeiwGQjie+5XUQbntLauVm5E48f
         aNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9STc3VLrLVIYF/i/d0plZ1dxoBkc9qtZmwUYED6VaX8=;
        b=G1SSczNLM+5GhuIRdhpHUmCXLL39jkZnZs5VzKZlPf01S/d6wDbNcVYX+5gzGp5r1O
         3bKlAb9ypIVfdy9vOk83Nd50flN2qn/XNk1JSSj5ed/10rGyhqHdyfPi6wDdAqKJ8Lb9
         fFYHYqFeb0cVHNBeBbOnMPv2zdWUE+fl0K6jfBspfd7CDmfjjRPwPJEQoEAduXIQX60v
         akCEy9TdxnXUwh5TSMcv6rIq7OVo24LxVvbgZZM6KXwNwhWmQE0rqyd05pordIoIpCxC
         ExkWsi8VhBS260/eJn+tWLw7v/DR1LD8vH5MoNJo0krd30SNRhGfFmcCp+k/Prabbwcd
         PeXw==
X-Gm-Message-State: AOAM530SPKDBu0SChFY03iG85KZtHhie5k29ZuJZYGyEt9yMMjZkZGyR
        jtm6FTx0cQq9fQeDusrtIjI=
X-Google-Smtp-Source: ABdhPJxRWsTcb3U25wO/jzRGFzp7vAQ3N0tzDldFxQVk3P/2ay5RU7EWq7VEiD1i3G6e9oMmI0Jk/A==
X-Received: by 2002:a05:6402:1682:: with SMTP id a2mr6971365edv.30.1611711670050;
        Tue, 26 Jan 2021 17:41:10 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id lh26sm131555ejb.119.2021.01.26.17.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 17:41:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1611686656.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <cover.1611686656.git.jonathantanmy@google.com>
Date:   Wed, 27 Jan 2021 02:41:08 +0100
Message-ID: <87h7n3p363.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 26 2021, Jonathan Tan wrote:

[For some reason the patches didn't reach my mailbox, but I see them in
the list archive, so I'm replying to the cover-letter]

>  Documentation/config.txt                |  2 +
>  Documentation/config/init.txt           |  2 +-

Good, now we have init.defaultBranch docs, but they say:
    
     init.defaultBranch::
            Allows overriding the default branch name e.g. when initializing
    -       a new repository or when cloning an empty repository.
    +       a new repository.

So this still only applies to file:// and other "protocol" clones, but
not "git clone /some/path"?

Re my reply to v1, do we consider that a bug, feature, something just
left unimplemented?

I really don't care much, but this really needs a corresponding
documentation update. I.e. something like:

    init.defaultBranch::
        Allows overriding the default branch name e.g. when initializing a
        new repository or when cloning an empty repository.
    
        When cloning a repository over protocol v2 (i.e. ssh://, https://,
        file://, but not a /some/path), and if that repository has
        init.defaultBranch configured, the server will advertise its
        preferred default branch name, and we'll take its configuration over
        ours.

Which, just in terms of implementation makes me think it would make more
sense if the server just had:

    uploadPack.sendConfig = "init.defaultBranch=xyz"

The client:

    receivePack.acceptConfig = "init.defaultBranch"

And in terms of things on the wire we'd say:

    "set-config init.defaultBranch=main"

You could have many such lines, but we'd just harcode only accepting
"init.defaultBranch" by default for now.

I.e. we set "init.defaultBranch" on the server, and the client ends up
interpreting things as if though "init.defaultBranch" was set to exactly
that value. So why not just ... send a line saying "you should set your
init.defaultBranch config to this".

Makes it future-extensible pretty much for free, and I think also much
easier to explain to users. I.e. instead of init.defaultBranch somehow
being magical when talking with a remote server we can talk about a
remote server being one source of config per git-config's documented
config order, for a very narrow whitelist of config keys.

Or (not clear to me, should have waited with my other E-Mail) are we
ever expecting to send more than one of:

    "unborn <refname> symref-target:<target>"

Or is the reason closer to us being able to shoehorn this into the
existing ls-refs response, as opposed to some general "here's config for
you" response we don't have?
