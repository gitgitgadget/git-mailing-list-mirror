Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7BC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BF523E26
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437817AbgLKPWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393039AbgLKPW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 10:22:27 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9563C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 07:21:46 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so12844199ejj.5
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vTnj+WxhmhVc3n+eorpKLCcWtuH5WjNbiqGb1ynhDEc=;
        b=lm1XGAz0HXg9dc8NvohTeKUaEp3iZ7MkWRObLHG3ssvUbtTgHR4zdEFC8893EMnieN
         9RZmxFud+cLPNlfvbBjQZ8k+LVngu7l4x9VpI/4T0dQQ3WHIjMa72KX4x2cKTvHgMhua
         EIMlok+D5su1oImF8WBqjxCvT32NJVT4Qk22e1UBgH/lvJI1TfLClhOrz9j34vPUKWwl
         1YjRFv/Bfj5TWvk8GS7AGxn6i3TesW0vvCfrL3ewCRCBkC4AaCPdRTaewclfQ7Xlf91q
         oFahO6DAnz4U1HUGX+R8+RqE/ko4AeaQAjWDByemPQANSUvSYkyndH9/quuPeFRgdEWk
         BCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vTnj+WxhmhVc3n+eorpKLCcWtuH5WjNbiqGb1ynhDEc=;
        b=UJBwh3KhaupWiFxL3s4xIXicYZrsRz9sCEhwIaDhtj577cHnZ7957IJk2LHghe/+Pw
         GLjHQqcN0mY9iePDR/KDwD8HNnRaaQElnMvxGx25CJMpuFob5wHljC+72iTqsugRXLQe
         vJDoFAEdP6I3v7bx3oErE6zM/LOi5/T4UWG6YDR1i336wSdPYBOpv3NMvx2SRL3lKBbN
         BC9y6IAdrXd+g1teWfAZfb+j0E+pbOflFNQrBJfc9Q8XuOE4wPkp0sBr44QLMs2wM88L
         IhbrJonGPftb/3NNu95kCSLRm8T+gTdCe7FiyndDvZ5MVQBeVezyZTMnTjkynAhl8y3X
         maXw==
X-Gm-Message-State: AOAM530IbmbUTf/hKsV+pnCAIYRZWr0EBRyC7zW6/GBLRTPCcjm0b9RK
        UVu6i2tCThwslVuHUBUsfXI=
X-Google-Smtp-Source: ABdhPJw21x68LusdCLfeU3BobQx0etQ2lWQFEMRliCyQFmHU+WULC/F699zmBx0kI17ULiC2nBqdog==
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr2470990ejx.389.1607700105517;
        Fri, 11 Dec 2020 07:21:45 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id s26sm7633344edc.33.2020.12.11.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:21:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im> <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase> <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
 <X9OGiuUUcVw83obp@ncase>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <X9OGiuUUcVw83obp@ncase>
Date:   Fri, 11 Dec 2020 16:21:44 +0100
Message-ID: <87h7oswepj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 11 2020, Patrick Steinhardt wrote:

> On Fri, Dec 11, 2020 at 09:27:57AM -0500, Jeff King wrote:
>> On Fri, Dec 11, 2020 at 02:35:01PM +0100, Patrick Steinhardt wrote:
>>=20
>> > > E.g. IIRC this whole series is because it's a hassle to invoke
>> > > core.askpass in some stateful program where you'd like to just provi=
de a
>> > > transitory password. I think some brief cross-linking or explanation
>> > > somewhere of these various ways to pass sensitive values around woul=
d be
>> > > relly helpful.
>> >=20
>> > It had been the original intention, yes. And it still is, but in fact
>> > the usecase has broadened to also use it to get rid of our global git
>> > config in Gitaly. Which is a little bit awkward to do with
>> > `--config-env` or `-c`, as now a ps(1) would first show a dozen of
>> > configuration values only to have the real command buried somewhere at
>> > the back. It would have been easy to implement though with the
>> > GIT_CONFIG_ envvars.
>>=20
>> I don't know what kinds of variables you want to set exactly, but
>> another possible option here is some mechanism to point Git to an extra
>> config file. This would work if you are setting a bunch of options in
>> some static way, but not if you're setting them to custom values for
>> each command invocation (because then you'd be dealing with a temp file,
>> which is annoying and error-prone).
>>=20
>> I'm thinking something like a $GIT_CONFIG_ENV_FILE that is parsed after
>> repo config but before $GIT_CONFIG_PARAMETERS.
>>=20
>> Or alternatively, add an includeIf directive that lets you do something
>> like:
>>=20
>>   [includeIf "env:FOO"]
>>   path =3D foo.gitconfig
>>=20
>> which triggers if $FOO is set. But again, that's only useful if you have
>> certain "profiles" of config you're trying to set, and not custom
>> values.
>>=20
>> -Peff
>
> The issue we have is that the config file isn't necessarily under our
> control. It is in most cases, like e.g. when Gitaly gets deployed via
> Omnibus. But we also allow for source-based installations, where the
> user configures most things manually. And in that case, we have to ask
> the user to "Please set config variables A, B and C". Naturally, this is
> easy to forget, will drift apart in future releases and so on.
>
> To fix this, the plan is to move all required configuration items into
> Gitaly itself, which GIT_CONFIG_COUNT would've allowd to do quite
> nicely. Something like =C3=86var's proposal to allow reading the config f=
rom
> a file descriptor would also work, and just putting the whole
> configuration into an environment variable (similar to your
> GIT_CONFIG_ENV_FILE, but containing contents instead of a path). And
> finally, using `-c` would also work, with the downside of making it
> harder to see what's going on with all the git processes.

Aside from other stuff mentioned in this thread a trick I've used for a
while to make things "git-y" is:

    [alias]
    sh =3D !sh

Then you can just:

    git -c foo.bar=3Dbaz sh -c 'git config --get foo.bar'

Or, with a symlink from "git-aly" to "gitaly" in $PATH:

    git -c foo.bar=3Dbaz aly [...]

Although that's more a hack, and may go away depending on what happens
to dashed builtins (I don't know what Johannes was planning there).

Of course this only works for global config and "I want to run this
script doing a bunch of git stuff, and using this config", not
e.g. dynamically setting a password for one request.

> With regards to what we require from the config, you can have a look
> e.g. at [1]. It doesn't contain much, but we expect the following ones
> to be set:
>
>     - core.autocrlf=3Dinput
>     - gc.auto=3D0
>     - repack.writeBitmaps=3Dtrue
>     - receive.advertisePushOptions=3Dtrue
>     - core.fsyncObjectFiles=3Dtrue
>
> Anyway, this is all rather specific to Gitaly and may thus not be too
> interesting for other. So in the end, we'll just live with the tradeoffs
> of whatever solution we end up with.
>
> Patrick
>
> [1]: https://docs.gitlab.com/ee/install/installation.html#configure-it

