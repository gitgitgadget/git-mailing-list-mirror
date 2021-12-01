Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA8C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 13:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhLAN4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 08:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349764AbhLANya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 08:54:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB646C0613FC
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 05:50:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so102020400edb.8
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kKiXdtK3RXAcSRfFr2c0em7PtRfjWK27GYwxz++i7uk=;
        b=VYzW6tqVw86wgkUECc9X5EQPMX9E+gVQv+0QcVxuXG2aWRtUCMNVjsYp3HDdtu+IHo
         rhqYh1u5JgDPzDEu+DZz76Fvom9rvhQN3kHVNqjjc43xuUQkk/RD1FHozuys3k/x4IZ7
         pdlHFlFipm++1To/4j75KsULTF480olnQlXXmqkeMiGsEwVQeP9qL7OZ/VDLfBhNNa2s
         PBgEz8jYMbJ0vUt5Sp5iedlZOtk5E3F+dpNu0x1IbGNRUJ/iuB7cg5oQWFXDAOXvQ/EE
         LAUimuX2tcJ4tfNaQyshvV3HXbZ5JRG8cPrvKlL7TpsUwZ90iOBmnD0q9j0ufw/Mv+EH
         Huqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kKiXdtK3RXAcSRfFr2c0em7PtRfjWK27GYwxz++i7uk=;
        b=M+OPXRQrJM9LKgwHWcZ+1zkF+pEiytMunTqdWFIORcnbnwOtjdgFQ40QD0q37JQQD6
         twDO8kpl8t9YZXiJvzpCQ7VXpDJyMXCHybx4FdCKwyNuhDQVUfawpzYMlWSO4hwKcplw
         /0c/WgXTRjXFMG/ss55uvjt0bN+2QhD2nI4GA0BD8DCgIbVmiKowCZ24Ut1QPl3lUIYe
         1u5o9FP2vqoMWWxbnWHgFYjw+dZMGfpgrcIqpL5Q2/PK10/tVW4JfH7LXA8FkzW9KVWW
         wMaIeC9QulROBECYJO2t/BbSOH0D7PSPxjjYjh/mJesQQ0/jdTN9zB4LjQg8UOphnZnC
         tpAg==
X-Gm-Message-State: AOAM530OzsWWcOQmUzQWpFFEmtQBERtmJRpBJrYC5SI1xYDt3HkiI+XO
        G44TJt9p/osHR5fDrTWLDXiIobfOMYBMOg==
X-Google-Smtp-Source: ABdhPJwJV5rvvSf21CQ5Z65ctTLeFito1XAwom2d+nA7oXmu+HCf24PGEgiHeGYAjkVu37KOtipUsQ==
X-Received: by 2002:a17:907:9612:: with SMTP id gb18mr7397575ejc.205.1638366656702;
        Wed, 01 Dec 2021 05:50:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hx21sm10831437ejc.85.2021.12.01.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 05:50:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msQ0d-001Fin-PG;
        Wed, 01 Dec 2021 14:50:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
Date:   Wed, 01 Dec 2021 14:43:37 +0100
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
Message-ID: <211201.86lf14bfi8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Johannes Schindelin via GitGitGadget wrote:

> Over two years ago, Slavica =C4=90uki=C4=87 participated in the Outreachy=
 project,
> starting to implement a built-in version of the interactive git add comma=
nd.
> A little over a year ago, Git turned on that mode whenever users were
> running with feature.experimental =3D true.
>
> It is time to declare this implementation robust, to use it by default, a=
nd
> to start deprecating the scripted implementation.
>
> Johannes Schindelin (2):
>   t2016: require the PERL prereq only when necessary
>   add -i: default to the built-in implementation

I'm very happy to see this. I left some minor nits on 2/2[1], but
with/without those suggested changes this LGTM.

I was a tad surprised that feature.experimental=3Dfalse doesn't disable
this anymore, but after looking into it a bit that's how we should be
doing this. I.e. the life cycle for these has been

    opt in setting [&& experimental] -> opt-out setting [&& !experimental] =
-> remove opt-out

If you're intending to re-roll anyway I think a brief mention of that
being intended & correct would be nice.

I.e. I went looking down that rabbit hole since there was no mention of
it in the commit message, and wondered if it was intentional & correct,
which I then found it is (well, correct, but I'm assuming also
intentional).

Thanks!

1. https://lore.kernel.org/git/211201.86pmqgbful.gmgdl@evledraar.gmail.com/
