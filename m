Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134E7C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C664E64E86
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhB1Mtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 07:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1Mtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 07:49:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA2C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:48:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lr13so23030198ejb.8
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UPAE8Lqz7W8JfeQ0cs6vlUbY/CYRZnQmjgkbJW8muHU=;
        b=UqLdQJnfhGIxTWpjwPfm+zhH/mKY7Cog5vUg9MqgIC504d0H/uDsfmKclS3pOS/dkU
         YgOQyTnMrz6xKHbyYdlcmT6tMucsjcv8M9cx4BLPPvUmUE60V6VlUNWdLwzijeBqmdOR
         +czFMDVz7rp59+oFS5khYoCs2UQfQEIVNsStgNouQt1710u9culFabdx+HyjCV0ZyAck
         uF+Pc7C7ZkdYNIhHxJhg/XfgsZr7SynGBXVqx/cUnMjtkI6EJlWUhSjfzcYt3rtsmkYz
         U7hzzQ1h3ZguMgDD6LzEusPjtpietxd07hXhvr3xsb4SOn5ypDXHrh2/RLHUUqNzIL0k
         YCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UPAE8Lqz7W8JfeQ0cs6vlUbY/CYRZnQmjgkbJW8muHU=;
        b=GpTMToe9Fs3Nrhjxl/36w5V/edNPN5xe0L5yI5B9QCup/9ELotelYKql4SArkUYpLw
         cmr/uO4cM8eXXCI5TKyB26ZY1e+PGYe4avREyODI4MAHr6xouxSPyeOvHDYug5Mx0mpv
         S3wcgxDSuuHQspkE+X1iT8BtCxcAEEz9taoOGRx2mx6WOl8F0o2BSPhIyrxs+AzA1xfB
         JuviO7BgkaK/nh+mqkUBuM0MXhQqOpLvXs/jXmnlGdMXyfmnv9cj27lC5Y8c5uITIJju
         nx1yNwI426Fl+jiKKvlPwPH6jKK1YI4Cdkja3oPtdPe7tBdG0vVnb6xL0AZtbegxeDrq
         mTGg==
X-Gm-Message-State: AOAM532wfrJh73DZsVAvmXfXC8pj9/sVYXvnQErbaLP/jwMEYClxC48R
        zMTqGBP8JjlWHdsd0clPmrpzGcxSrHU=
X-Google-Smtp-Source: ABdhPJxfLa1jCKSyexSO5jlWPu+DmfYh0dX3sPQEjHVG7I9eG+GeMWUd2IJUUbhZv+4ICr+i57PxCw==
X-Received: by 2002:a17:906:444d:: with SMTP id i13mr11312139ejp.170.1614516537980;
        Sun, 28 Feb 2021 04:48:57 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a3sm9754811ejv.40.2021.02.28.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 04:48:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210227191813.96148-5-sandals@crustytoothpaste.net>
Date:   Sun, 28 Feb 2021 13:48:56 +0100
Message-ID: <87h7lwl5mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 27 2021, brian m. carlson wrote:

> We have in the past told users on the list that git archive does not
> necessarily produce stable archives, but we've never explicitly
> documented this.  Unfortunately, we've had people in the past who have
> relied on the relative stability of our archives to their detriment and
> then had breakage occur.
>
> Let's tell people that we don't guarantee stable archives so that they
> can make good choices about how they structure their tooling and don't
> end up with problems if we need to change archives later.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-archive.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 9f8172828d..1f126cbdcc 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -30,6 +30,9 @@ extended pax header if the tar format is used; it can be extracted
>  using 'git get-tar-commit-id'. In ZIP files it is stored as a file
>  comment.
>  
> +The output of 'git archive' is not guaranteed to be stable and may change
> +between versions.

Is "stable archive" a well-known term people would understand, or is
someone going to read this thinking they might extract different content
today than tomorrow ? :) I wonder how much if anything this means to
someone not privy to the recent thread[1] that prompted this patch.

Perhaps something like this instead:

    The output of 'git archive' is guaranteed to be the same across
    versions of git, but the archive itself is not guaranteed to be
    bit-for-bit identical.

    In practice the output of 'git archive' is relatively stable across
    git versions, but has changed in the past, and most likely will in
    the future.

    Since the tar format provides multiple ways to encode the same
    output (ordering, headers, padding etc.) you should not rely on
    output being bit-for-bit identical across versions of git for
    e.g. GPG signing a SHA-256 hash of an archive generated with one
    version of git, and then expecting to be able to validate that GPG
    signature with a freshly generated archive made with same arguments
    on another version of git.

1. https://lore.kernel.org/git/20210122213954.7dlnnpngjoay3oia@chatter.i7.local/
