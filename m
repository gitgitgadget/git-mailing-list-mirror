Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881FC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 00:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJUAaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUAaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 20:30:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCD3D01B1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 17:30:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r17so3415408eja.7
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1k2k0TjhvYowdpiZw04jljOIfR6ovPmqZNOUbLa7Gc=;
        b=CENKtyDJyZhYIrmz3jfy+UtUHX6my/ZzHkNAVMQOobtcUh6kn6Ti2o1GSvXeXOVtMJ
         K+AQNOxaSrXUPsxXYASN47s6knrnCGYA4m1SWhJMEJxID1CCmKcjges2XW3RtGtCzx/8
         hV+BotkgA3VO8p2dPqENv3JHplNgEQftSU//4LHUUSldki2hZDqDhCw6TRyZ45Hr1h3R
         7oZQA/Wzq5qGKVO1yJfYYogqgn5q66UjqRA0P6Snjcu+B9igoeU+okgl4cQnnNCECnUU
         Zh8mRU87AyCcp7VZoSpjupeWpScHfxjGkjnpFNQv6R0Kse7Pkfan2+21Gp+rw2QKx46H
         BPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1k2k0TjhvYowdpiZw04jljOIfR6ovPmqZNOUbLa7Gc=;
        b=7W3qXbxZsd4OYOdw6qj5avtm1FKGdCBHYzeUB/cUz2iY5/ca+QEKG/oONnll/JJXPe
         ldP0P8EksWHUn8mPbPSBI+w07oTwsDmhW3O8H0yU61/KNaDQD9QxPGNhwzsfwayDLIft
         PRTUjUBEoi27NUS3IaJ1HFAhMNzx8n2+p66kfKyrKc2rCGF8vvEkVT5xc13y+KCgiGfZ
         1Jc7ZMWDvPZAbfNAus2zYRBpVhXVBVl41Ke0oxRUBBq80/KCbtlsJVeH4K1SS2uEc3ex
         qiHSnF3ZSUD3xd7bOIcCotN9VFaY0VFU/9cQ34cRU5BVkw2g5Y7EPGcvlsGtXkio38I5
         0BlQ==
X-Gm-Message-State: ACrzQf1ugZiSJyFPOt3AomAq11s5oDhK4JbV6yscBq2qPng7VmntKwEL
        aGsdANa/tm5pxTTgWzWetWI=
X-Google-Smtp-Source: AMsMyM5h9OULyV8mpn5KcgHfV77iAmVs7L0aK3x2UztaNJzB2dpB1zlbBTe88Ut2SLr8C/EpF6i95Q==
X-Received: by 2002:a17:907:7215:b0:791:a61f:56b3 with SMTP id dr21-20020a170907721500b00791a61f56b3mr10070671ejc.331.1666312214098;
        Thu, 20 Oct 2022 17:30:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b0045c76120e61sm12741892edy.54.2022.10.20.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:30:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olfvP-006g1b-2v;
        Fri, 21 Oct 2022 02:30:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] Makefile: use sha1collisiondetection by default on OSX
 and Darwin
Date:   Fri, 21 Oct 2022 01:52:39 +0200
References: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
 <xmqq4jvyqdof.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq4jvyqdof.fsf@gitster.g>
Message-ID: <221021.86tu3yf27g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 20 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Junio: I see in the meantime you've queued your own
>> https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-av=
arab@gmail.com/;
>> which is currently in "seen".

[B.t.w. that link is wrong, I meant
https://lore.kernel.org/git/xmqq35bitooc.fsf@gitster.g/]

> Yes, as I said, I intend to merge it to 'next' in tomorrow's
> pushout, and then fast track all three topics (Peff's "-O0",
> Eric/=C3=86var's "use git_SHA_CTX abstraction", and "osx-clan uses
> sha1dc") down to 'master'.  As you chose to make this topic hostage
> to the other multi-part topic, which is likely to be slowed down and
> require rerolls for typofixes and possible bikeshedding, by the time
> this topic becomes ready, it is likely that it would already be in
> 'master' and you'd have to rebase on that.
>
> Isn't this step of much higher importance than the other multi-part
> topic?  I do not see why you chose to take it a hostage to the other
> one.  Let's all learn to give priorities to produce sufficiently
> focused fixes that also sufficiently cover important issues.  Frills
> and niceties can come on top later.

I don't see why we're in any rush to get this change down to "master"
(either this [1], or the base [2]), nor your jc/ci-osx-with-sha1dc[3].

Your list in [4] has two fixes for issues on "master" which we should
get there sooner than later.

But the 3rd is just addressing a CI blind spot that we've had for at
least 2 years, and since 2017 if we're talking about the default SHA-1
backend on OSX.

Yes, we had some unportable code sneak in recently, but there's no
reason I can see for why we'd expect that to happen tomorrow. It's been
one such issue from 2017 until now, so at this rate we should expect the
next one in 2027, not next week :)

In any case, I figured you might want to fast-track it anyway, or
whatever, which is why I crafted this series to give you easy options
given your [4]. Namely (and in no particular order):

A. You can queue the base topic[2] and this [1] on top of "seen" and
   your jc/ci-osx-with-sha1dc and they won't conflict.

B. This applies directly on "master" if you peel off the first hunk. If
   you wanted this faster than the "doc" change it could be queued like
   that, and we could fix the docs later.

C. You could eject your [3] and we could let this simmer at the normal
   rate, but that's assuming the "no rush" outlined above.

D. You could proceed with your [3], and I can eventually rebase on top
   of it (we'll probably want to undo the nothing-to-do-with-SHA-1
   change, presumably?)

E. You don't need to pick this up at all at this time. Nothing's broken
   now that hasn't been broken for the years by us not using DC_SHA1 on
   OSX by default.

1. https://lore.kernel.org/git/patch-1.1-1f4e39be97b-20221020T225305Z-avara=
b@gmail.com/
2. https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-av=
arab@gmail.com/
3. https://lore.kernel.org/git/xmqq35bitooc.fsf@gitster.g/
4. https://lore.kernel.org/git/xmqqtu3yqhm2.fsf@gitster.g/
