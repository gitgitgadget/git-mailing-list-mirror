Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D3C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiDVS7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiDVS6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 14:58:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E26113A4DC
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:54:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc2so18015595ejb.12
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+XNcUgD5y3ZWWzONuZ8qG1mWuqM4pAAXMEZLbVkJr24=;
        b=StRypA77nteh0Kj/B9f8PB7djos1K3o4zpzXGwaqs3O4Pb8k/zOpObPEMgFm1uzUa/
         d0UNpfptUtbRLfNpkvgjtSM+atmokhjFPYUS2ykcS7LVmoPZq84z/gj+fGZ5iUNpM7v8
         0VyBT2MARsbpJvGaQ+GuoTVyoihUDGD5ACa4g92li3/0RaUwco4x9B2blggEYOOLBJZ7
         lqyaChnqbfRHep/RFWDi3miy6rB4/xTgsUPxangMJRErMWZuVKSs07PkAYFK+q4SvnXD
         Z73ar/rxD2nZL6AMSeaCUEIbNWQy/22L89t34bXiiOYypLZ9XTJFt6Bqm9dgjv4+Q8Ff
         OWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+XNcUgD5y3ZWWzONuZ8qG1mWuqM4pAAXMEZLbVkJr24=;
        b=v4NrisrVn9eOAFghfUbbSNQApj9mBEooPrzOE+BpfZr//bysDPjYcdfs3m5Q3isQKZ
         sNZda0ES/w99OkO3HQjXefaGSH9RMzA7GfQmf0Eq6/XActw3cQlAHy7CDwBibD7Wm08O
         bKKHssjZj7mfyQ67svaLxNpTsslrWovjEnKpdT82R8bvrONNZYwhcOmCR+SQW0J2VzOx
         Nw1MyUJRIiAsPBH0d3qyE7e8OBfR+69z39MoWxB/eFtZnxJTXu4cLcze7nZuDOuzm2W9
         G/Ail29HZ2MlX5ejzQdR3pgzCmB43p2aqNOxwQ3VlwfbyMnAj6v+rT58uo0hauAZxL02
         mxwA==
X-Gm-Message-State: AOAM5321bhe2mX3rEj7kLmfwgbc0YN8RQqMW1OlkC/daywO+9UDBlEwv
        QBW2FuVFZFRcx48/qkJpnyt9fhtuET4BEA==
X-Google-Smtp-Source: ABdhPJwlse4xeMptw/ybWxcA2+UQPWez2keNUVTUMfFTZ+vWcFXV51/xnjgLCqmeH5n6defLog04cA==
X-Received: by 2002:a17:906:6a27:b0:6ef:f278:8424 with SMTP id qw39-20020a1709066a2700b006eff2788424mr5562322ejc.490.1650653431332;
        Fri, 22 Apr 2022 11:50:31 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090681cb00b006e86b594e1fsm982015ejx.207.2022.04.22.11.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:50:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhyMQ-0009m0-72;
        Fri, 22 Apr 2022 20:50:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] CI: run "brew install perforce" without past
 workarounds
Date:   Fri, 22 Apr 2022 20:46:14 +0200
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
 <patch-v2-1.3-dcedf03c2d7-20220422T085958Z-avarab@gmail.com>
 <CAPUEspiuV4XjQH_r+uRMnstRfR4apB0Z83SoVbJTe7xrncyP-g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPUEspiuV4XjQH_r+uRMnstRfR4apB0Z83SoVbJTe7xrncyP-g@mail.gmail.com>
Message-ID: <220422.86o80tq7ex.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Carlo Arenas wrote:

> On Fri, Apr 22, 2022 at 2:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> index dbcebad2fb2..82fa87f97af 100755
>> --- a/ci/install-dependencies.sh
>> +++ b/ci/install-dependencies.sh
>> @@ -37,13 +37,7 @@ macos-latest)
>>         test -z "$BREW_INSTALL_PACKAGES" ||
>>         brew install $BREW_INSTALL_PACKAGES
>>         brew link --force gettext
>> -       brew install --cask --no-quarantine perforce || {
>> -               # Update the definitions and try again
>> -               cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew=
/homebrew-cask &&
>> -               git -C "$cask_repo" pull --no-stat --ff-only &&
>> -               brew install --cask --no-quarantine perforce
>> -       } ||
>> -       brew install homebrew/cask/perforce
>> +       brew install perforce
>
> While this might work under the current VM configuration used by
> github actions, is definitely not the usual configuration in macOS
> installations and therefore likely to break if run locally (as some
> other on the fly changes attempt to suggest)
>
> keeping the "--no-quarantine" makes for a less likely to fail option
> (since SIP is enabled by default), and therefore I am also concerned
> that by removing all these other (learned the hard way) workarounds we
> might be making this more fragile for the future as well.

It works with the current CI, and keeping those fallbacks would have
meant turning this into some for-loop where we track which command
variant failed exactly, then retrying that with the SHA-256 munging.

> instead of this rewrite of the brew interface logic, removing brew as
> you suggested would be probably better.

I won't have time to pursue that in the near future, sorry. Especially
as I've got no OSX box, so any changes to this series mean long painful
bouncing around against the GitHub CI.

Anyway. I'd be happy for you to pick this up, whether that means
re-rolling my series with your suggested changes or taking yours over
mine I really don't care, I just want to not see those OSX CI errors
anymore.

As noted I have a mild preference out of general principle of having the
CI at least somewhat deterministic, i.e. to do this series where if we
can't get p4 at all we'll fail.

But I'd be fine either way, i.e. your series is also fine by
me. Whatever stops these errors from happening whenever perforce.com
updates the packages & the brew recipes haven't been bumped yet...

Thanks!
