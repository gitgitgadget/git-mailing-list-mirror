Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A37DC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2034E6128A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhHXWxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhHXWxm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:53:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79DC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:52:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e21so31610915ejz.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5wDqCEGMN6r6gan6OMjYflilQTL78hX8jOrX1ZT0uJ4=;
        b=tGd+C7UMm/dJY5zyn1az0qvHcFare3SRNHu+HRHyxT/aI0jbHHcGy06dwxg8KGI2p3
         715+hzhOcBAk2w4JXn9vTgEkQAe+xoBT1ZVsU6LKf5unSXGd904gvxXv2eJ8gOsVo+4E
         rQhzpBhiLd9jw1x9YDkO7spfDQnCWOs4IQj4UM/zRXg0OG4vfNpFQgm1U3rR17lrhVRY
         LGR9XaWzNKl8XZyqNqu38YCnKUKQs5Fb5cr0jIXY8NWrQHRYz8oe0y7oqzHgXGoSwEWg
         azFW6WHWrRTUuv1vCTKpWSC3v5/h9FR3Vhj0QSuHPnNP5LM7eT4AnB0HcNSHeatuN1aZ
         BRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5wDqCEGMN6r6gan6OMjYflilQTL78hX8jOrX1ZT0uJ4=;
        b=KZ171D6H7wQDAJE8MOMNw/nQ4ABueDxKsxuLdqVga+y3X8t8W8tjUIcei1zyLdsT8X
         Yq2F6LNhX1sRnoWhfiNU9/Wc3RZ8jSEQxDcI27ss3hI//936IVOEsjqYtDBNzvFzncOh
         odQODRcgAsjxos4fWI+RlDgKmRRtl876KV89n/c1u394g+40J98AhGGlx2t+T88coWOP
         Arm0bfKVFOXpszYdPYV6p60Dba1l1GaJEqnldMdpXVexnFF+XcmCQ36tcrpVT7dgMA0D
         OdsKeSlb+qXC7NgaIL/UFpme8f/j0eseKu8S5KqdrT2Bf6AwQYGoo+Np7kjqEoxYFa/U
         6WlQ==
X-Gm-Message-State: AOAM532RkDhp4RYgENmDbiw3Tgt1yRYw7PKmr7TAYVaJlz712Ddeuxwj
        lnRbuhA8zzUdCSG+OX5TCDKSIEUM3Ipqbg==
X-Google-Smtp-Source: ABdhPJzn8Vg07TFhuHQ6HTxerWUpD1s8Q8CorzrXXR52ijjsa18sxv3ApBx6Or+d8JcBB7zf32xJNg==
X-Received: by 2002:a17:906:6cc:: with SMTP id v12mr16036655ejb.153.1629845576004;
        Tue, 24 Aug 2021 15:52:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm10436133ejy.20.2021.08.24.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:52:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Emily Shaffer' <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] hook: allow out-of-repo 'git hook' invocations
Date:   Wed, 25 Aug 2021 00:45:57 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-7-emilyshaffer@google.com>
 <87ilzueh1g.fsf@evledraar.gmail.com>
 <033201d79927$f5bfa1f0$e13ee5d0$@nexbridge.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <033201d79927$f5bfa1f0$e13ee5d0$@nexbridge.com>
Message-ID: <87v93ucv5k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Randall S. Becker wrote:

> On August 24, 2021 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>On Wed, Aug 18 2021, Emily Shaffer wrote:
>>
>>> Since hooks can now be supplied via the config, and a config can be
>>> present without a gitdir via the global and system configs, we can
>>> start to allow 'git hook run' to occur without a gitdir. This enables
>>> us to do things like run sendemail-validate hooks when running 'git sen=
d-email'
>>> from a nongit directory.
>>
>>Sensible goal. Perhaps we should note in an earlier commit when config-ba=
sed hooks are introduced something like:
>
> To clarify the requirements here, if running without a gitdir (and
> thus without a repository?) how will front-ends know what to supply?
> Will this just be "some shell script" that runs?

Emily's also aiming to have "git hook run" running "some shell script",
but in this case we're talking about any git program that runs hooks,
but doesn't require a repo. I think the only one is git-send-email's
sendemail-validate hook.

>>
>>    Even though we've added config-based hooks, they currently only work
>>    if we can find a .git directory, even though certain commands such
>>    as "git send-email" (or only that command?) can be run outside of a
>>    git directory. A subsequent commit will address that edge-case.
>
> So we cannot assume anything about the repository, correct? Similar to ru=
nning git version but not git status?

Right, with RUN_SETUP_GENTLY we may not have a repo at all, so like
commands such as "git bundle", "git config", "git ls-remote" etc.

>>> [...]
>>> Notes:
>>>     For hookdir hooks, do we want to run them in nongit dir when core.h=
ooksPath
>>>     is set? For example, if someone set core.hooksPath in their global =
config and
>>>     then ran 'git hook run sendemail-validate' in a nongit dir?
>
> So this is complete consent to run outside of git? I wonder whether
> there needs to be an attribute associated with the hook that enables
> this edge capability. That way we can validate whether the hook should
> be run or not (from front-end scripts).

If I understand you correctly you're pointing out that anyone with a
sendemail-validate script could previously have assumed a repo, but not
anymore. So e.g. someone who always has other config the hook requires
when they run it in repository might unexpectedly have that hook fail if
they na=C3=AFvely set the config for that sendemail-validate hook via "git
config --global".

I think that's a good point, and one I hadn't really considered. I think
it's probably best to just document this edge case for the one (or few?)
hooks that have this caveat than to not support it. I.e. it seems useful
to have a sendemail-validate without a repo (just to parse/validate the
about-to-be-sent-email), that we needed a repo before was really only an
emergent effect.

Also, I think it's not new with this config-based hook mechanism, but
something that I introduced in back when I added core.hooksPath (but I
don't think I realized I was adding this edge case at the time).
