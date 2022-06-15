Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEBC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbiFOUpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiFOUpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:45:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640AC2FFE0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:45:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fu3so25501592ejc.7
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+KCXRxs8nvbu1Wf6vlhmHNFQa0A3sQcY0hBgZNkg/Ik=;
        b=MmKAKp4Ntykxz31u3ObAIZvgzhvPA++0Jq0JzDK3ngVd/MZm36Mgj9K6eYAqZecCGf
         GLK2n/kbWiFdzKtSEWWGvB0WdcjZk2byitgTK41a3h+hv7wDTAJ/R9ECfPqEMH4gJM+Z
         YCD//PXL3oWCJxmN0S8hgRmk5azyFwwngvzMtBmRkCUVjw5Pz+QQCZ0cTRxCJiBpmTnd
         wJ4WFPORiumRzpD63K8X8ND5kWE7+0TUAF+exbg1/Ch0H6JxdLEHom3ueA4e2xbsXd7u
         Hi5N9QAouMQ63ejFlsLnbpT8OprMgUcfOmIiCCFgmK8jzKq3ErUBlR2ay4rGoyr0Jyyz
         4cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+KCXRxs8nvbu1Wf6vlhmHNFQa0A3sQcY0hBgZNkg/Ik=;
        b=Xhzhenu82WZKU5nqGTpSFcEWIB3XbhnNXjz3aW72Lj/EkR4iNr0zy+3mG1PhB4uokd
         fMEZgi1Hbopzod9XqJMdCS7iLc9eIADmDzqc6SlWBkHYsSFpeev9a0nvLFVa3Ic0G3XS
         YVW8E22CAWl7CiDRuNIn9nWo04uLEw2u0aSU57kYUc2ZVPTzC2JcmarH8kmskxzJmUuv
         Wj2DPtmdTwsfO3/DEGokd0KYw/vKm4p344SteLcizFkplntoJquUVDPhY+jSbunkgLrQ
         pH1TWqOP6Dh28zf3thiO6J42vfat7o5hKW9r/H09D3p9yACIcDQXE1rrePPKSIupcltL
         6moQ==
X-Gm-Message-State: AJIora9NplXpMtM/z6JVBC536C5pAOtmFpjiZE/uKC15eQuiS5l3h6+5
        XwWERTAg1U3qMUFfRahjIS8=
X-Google-Smtp-Source: AGRyM1uP/aSp+xsmWVts8NKCXZcMcYLFTKeSxWS+HIF5iGi1tKvu5C0QwyUzg4caBgc/kPPeGdUh2Q==
X-Received: by 2002:a17:906:5352:b0:712:3916:e92 with SMTP id j18-20020a170906535200b0071239160e92mr1484920ejo.756.1655325922863;
        Wed, 15 Jun 2022 13:45:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b16-20020a056402351000b0042de8155fa1sm210435edd.0.2022.06.15.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:45:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1ZtB-000u54-KT;
        Wed, 15 Jun 2022 22:45:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 4/6] archive-tar: add internal gzip implementation
Date:   Wed, 15 Jun 2022 22:32:04 +0200
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
 <1328fe72-1a27-b214-c226-d239099be673@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1328fe72-1a27-b214-c226-d239099be673@web.de>
Message-ID: <220615.86wndhwt9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, Ren=C3=A9 Scharfe wrote:

> Git uses zlib for its own object store, but calls gzip when creating tgz
> archives.  Add an option to perform the gzip compression for the latter
> using zlib, without depending on the external gzip binary.
>
> Plug it in by making write_block a function pointer and switching to a
> compressing variant if the filter command has the magic value "git
> archive gzip".  Does that indirection slow down tar creation?  Not
> really, at least not in this test:
>
> $ hyperfine -w3 -L rev HEAD,origin/main -p 'git checkout {rev} && make' \
> './git -C ../linux archive --format=3Dtar HEAD # {rev}'

Shameless plug: https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledra=
ar.gmail.com/

I.e. a "hyperfine" wrapper I wrote to make exactly this sort of thing
easier.

You'll find that you need less or no --warmup with it, since the
checkout flip-flopping and re-making (and resulting FS and other cache
eviction) will go away, as we'll use different "git worktree"'s for the
two "rev".

(Also, putting those on a ramdisk really helps)

> Benchmark #1: ./git -C ../linux archive --format=3Dtar HEAD # HEAD
>   Time (mean =C2=B1 =CF=83):      4.044 s =C2=B1  0.007 s    [User: 3.901=
 s, System: 0.137 s]
>   Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.059 s    10 runs
>
> Benchmark #2: ./git -C ../linux archive --format=3Dtar HEAD # origin/main
>   Time (mean =C2=B1 =CF=83):      4.047 s =C2=B1  0.009 s    [User: 3.903=
 s, System: 0.138 s]
>   Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.066 s    10 runs
>
> How does tgz creation perform?
>
> $ hyperfine -w3 -L command 'gzip -cn','git archive gzip' \
> './git -c tar.tgz.command=3D"{command}" -C ../linux archive --format=3Dtg=
z HEAD'
> Benchmark #1: ./git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive -=
-format=3Dtgz HEAD
>   Time (mean =C2=B1 =CF=83):     20.404 s =C2=B1  0.006 s    [User: 23.94=
3 s, System: 0.401 s]
>   Range (min =E2=80=A6 max):   20.395 s =E2=80=A6 20.414 s    10 runs
>
> Benchmark #2: ./git -c tar.tgz.command=3D"git archive gzip" -C ../linux a=
rchive --format=3Dtgz HEAD
>   Time (mean =C2=B1 =CF=83):     23.807 s =C2=B1  0.023 s    [User: 23.65=
5 s, System: 0.145 s]
>   Range (min =E2=80=A6 max):   23.782 s =E2=80=A6 23.857 s    10 runs
>
> Summary
>   './git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive --format=3Dt=
gz HEAD' ran
>     1.17 =C2=B1 0.00 times faster than './git -c tar.tgz.command=3D"git a=
rchive gzip" -C ../linux archive --format=3Dtgz HEAD'
>
> So the internal implementation takes 17% longer on the Linux repo, but
> uses 2% less CPU time.  That's because the external gzip can run in
> parallel on its own processor, while the internal one works sequentially
> and avoids the inter-process communication overhead.
>
> What are the benefits?  Only an internal sequential implementation can
> offer this eco mode, and it allows avoiding the gzip(1) requirement.

I had been keeping one eye on this series, but didn't look at it in any
detail.

I found this after reading 6/6, which I think in any case could really
use some "why" summary, which seems to mostly be covered here.

I.e. it's unclear if the "drop the dependency on gzip(1)" in 6/6 is a
reference to the GZIP test dependency, or that our users are unlikely to
have "gzip(1)" on their systems.

If it's the latter I'd much rather (as a user) take a 17% wallclock
improvement over a 2% cost of CPU. I mostly care about my own time, not
that of the CPU.

Can't we have our 6/6 cake much easier and eat it too by learning a
"fallback" mode, i.e. we try to invoke gzip, and if that doesn't work
use the "internal" one?

Re the "eco mode": I also wonder how much of the overhead you're seeing
for both that 17% and 2% would go away if you pin both processes to the
same CPU, I can't recall the command offhand, but IIRC taskset or
numactl can do that. I.e. is this really measuring IPC overhead, or
I-CPU overhead on your system?
