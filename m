Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD1C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiGZPEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGZPEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 11:04:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131AD2E6B8
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:03:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so26728823ejb.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o6H9frLA4U2/Fkiob/RR2m9004DcHjMKWFdQyTraUWI=;
        b=OTI3fm3wt8JyoOX+Sp2jEURB0UKZNSJ0JmxeMm4Ay3/s1zSc6zdC0YU3KXIZBJuqbk
         2VUHaT27v9+CZndqR+ujMYJFXRPLrWwyBdpZxfx5oSYANeoMf+Oi2wG3Y8ujgfFeF7xr
         A7pRmJewS3u3jjBBtDExvPKLx3MT8hEb8b+agErI5Lb+V4xV/0SYF2oj5H5rZ03D9TSM
         7n8SSi0JgOEm+1SisKOX32QNcjW/LyUx1jaJNgnKAakl52p+sCb4nBL5XyIgh1DnPlIU
         Fox0irchj0NdNJWOtuX3qlIegR++qVA6PPGx46CLp4mdwk1LGkRKtnSCBxHIdupIlKFb
         ZnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o6H9frLA4U2/Fkiob/RR2m9004DcHjMKWFdQyTraUWI=;
        b=WHL86I0cReYJl066D+RX7+gvGXa+yj+DZmP5bZlgUEv5bm4rvgrM3qzGSCufTSxkhe
         ZBhKHayAiseNQLoAv7Y+l5Rh+2QbpRGYRuqso4H9uW4ag+rCB8ccOm3kz20/wTZFbjSL
         P1rQBnRaAJle7OT9x7GuF0QBStZhhE2gzMx36vhjvqq6GcnDwIeO8NDMN98z9ANTQ15K
         BCdpo99aeK4mrRzxb/E8CAkq3WZm2jlD89QXPMUilPiVOchGTS+8AAASdUsJ/FU9vIHP
         3r/G4IZ82r/CcdVY0GwskEEPyyn1vH0m/QoZDXzeB48QmzSkmUBs8GBHxno6g3QoO7rE
         qUAw==
X-Gm-Message-State: AJIora+vF490LtAOYtt1cobk1fw0n2x9hgdVctS97eKeybHGHbw33f9l
        +0xw+wjlsb+ZrExVZ7OWt4s=
X-Google-Smtp-Source: AGRyM1uZ6vZnHHneDpR9FZKdo8dPigIWP6bTmD2OvZ5fniYjpAUXMCAdUlisv1sVAeaHc0cK5R/lug==
X-Received: by 2002:a17:907:72ce:b0:72f:7b3:b9c8 with SMTP id du14-20020a17090772ce00b0072f07b3b9c8mr14016694ejc.248.1658847837364;
        Tue, 26 Jul 2022 08:03:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gn36-20020a1709070d2400b007262b9f7120sm6535989ejc.167.2022.07.26.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:03:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGM6F-006Akm-Un;
        Tue, 26 Jul 2022 17:03:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] log: create tighter default decoration filter
Date:   Tue, 26 Jul 2022 16:44:58 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
Message-ID: <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:

> This was previously reduced by adding the log.excludeDecoration config
> option and modifying that config in git maintenance's prefetch task (to hide
> refs/prefetch/*). I then followed that pattern again for the bundle URI
> feature [1], but this caught some reviewers by surprise as an unfortunate
> side-effect. This series is a way to roll back the previous decision to use
> log.excludeDecoration and instead use tighter filters by default.
>
> As noted in the last patch, the current design ignores the new filters if
> there are any previously-specified filters. This includes the
> log.excludeDecorations=refs/prefetch/ set by the git maintenance command.
> This means that users who ran that command in their repo will not get the
> benefits of the more strict filters. While we stop writing
> log.excludeDecorations, we don't remove existing instances of it.

Leaving aside the question of these magic refs, and if we need new ones
(e.g. refs/bundle/*) I have sometimes made use of out-of-standard
refspace refs.

E.g. when I build git I create refs/built-tags/* tag object refs
(i.e. not in refs/tags/*), which is a neat way to get "git tag -l" and
the like to ignore it.

But to still have it show decorated in logs (e.g. I'll see what my
"private" branch is at), and "for-each-ref --contains" still knows about
it.

Now, that's a rather obscure use-case, and I suspect other "special
refs" are similarly obscure (e.g. GitLab's refs/keep-around/* comes to
mind).

But I think this change is going about it the wrong way, let's have a
list of refs that Git knows about as magical, instead of assuming that
we can ignore everything that's not on a small list of things we're
including.

Wouldn't that give you what you want, and not exclude these sorts of
custom refs unexpectedly for users?

> I'm interested if anyone has another way around this issue, or if we
> consider adding the default filter as long as no --decorate=refs options are
> specified.

I think the resulting UX here is bad, in that we ship hardcoded list of
these if you don't specify the config in 2/3. So I can do:

      -c log.excludeDecoration=this-will-never-match

To "clear" the list, but not this:

      -c log.excludeDecoration=

Which we usually have as a synonym for "false", is it just adding a
prefix of "" that matches everything to my exclusion list (but HEAD
still shows up...).

Speaking of funny refnames isn't your:

	git -c log.excludeDecoration=HEAD log

Going to exclude refs like "HEAD/foo/bar" too? I.e. it's always a
prefix.

I suspect a much better way out of this, which I think fixes the problem
you're raising here is:

	log.useBuiltinDecorationExclusions=[bool]

Or whatever, i.e. we ship a hardcoded list of exclusions.

Leaving aside whether that's a blacklist or whitelist, or whether we
turn that to "true" or "false" by default it wouldn't have the behavior
of "flushing out" the built-in config.

Another way of doing that if you really want to use one variable would
be to have:

      -c log.excludeDecoration=foo

Add to the built-in list, but:

      -c log.excludeDecoration=
      -c log.excludeDecoration=foo

clear it, we have a couple of other list config variables that work that
way.
