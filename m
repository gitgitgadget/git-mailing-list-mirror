Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA7ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 10:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiH2KgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2KgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 06:36:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1457207
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:36:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b44so9515675edf.9
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=WeoP6lbUbX85E/jAoezyqzqrDjqRIiARhDxNslx3BMg=;
        b=nqtrA5bp3u+IKinaj5JhhvTXo6tahlkyhuUWfWtBsN82UinBMbayl00szkuLXsaU1p
         lD1LqHIAxJ+4Klc2yHjIsweBswafYM31Nl7kwndEPsq3nHFiAfWGIkXEBDXiMFU+q5Dl
         lg+/GOkUrxlN54TLuYaZKEhu6DNh9ca+RCMl3yLMZ2Yo6CG3c5ftMREHH60KWtlsg3Vn
         kCUY51L6vuwITFM6r/oziN/bxsXN/WH8O9H2PLzJmwp5vrTPZoiytSArRKx+ESsCk2Ee
         AUX4Yi1XHJQTdB+s79yfr7VVyhobyBLq6nMuuRCOOUd+kvEDIoJj0ZOSdHvNsbVLEMzS
         0wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WeoP6lbUbX85E/jAoezyqzqrDjqRIiARhDxNslx3BMg=;
        b=WoNtplpb7GWb6142VuiRxiO0xm2WwfNxMZ9OhEBVlqlH1HfTdSZIvfMz8fu5VYgRrF
         6aU8mD7Qw/HRON+DY48WJt5sEhe0ywPDjmYD/Fz4+UQQXkoOomFVp3KUuHn6HGAwYivP
         SgaHJ4saV1Z8MXDiOaWLaRsPt77HFwUS9HDVxFOa8ETL1C3TH1uWuN7wy94nVmN67SMJ
         FkrfkSoUHd4ioo64fWGawdY6G35/fFgJ0Kz1IbrEoL1H0M+JYzPu6ZN6KAPFjSiCP118
         T16iHULs+ppRxVZcmm8Sy9aoRljq05f2c7DC47zd0Zp2fP6LIeKcS9D1GADMaHqFQJSE
         63zw==
X-Gm-Message-State: ACgBeo2S/Tue4XUbPM1V+/L+XjQczZ2dXguzE/TvkH6Op7qZHZLR1kU8
        EjJCL4xPdNritxyaOBsgFNQ=
X-Google-Smtp-Source: AA6agR77+EiEVX9Qd3qt2nAW+4vXqT6pVMYB21ke6Mou59oTcS3uv2E+QfT4QqAhwOBUcfzJJ53miw==
X-Received: by 2002:aa7:c98f:0:b0:448:439:fbce with SMTP id c15-20020aa7c98f000000b004480439fbcemr9912281edt.246.1661769366588;
        Mon, 29 Aug 2022 03:36:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y5-20020a50e605000000b0044402ac02f7sm5534584edm.67.2022.08.29.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 03:36:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oSc7g-001fET-2n;
        Mon, 29 Aug 2022 12:36:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Date:   Mon, 29 Aug 2022 12:29:09 +0200
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g> <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net> <xmqqczcnymtd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqczcnymtd.fsf@gitster.g>
Message-ID: <220829.86k06r2v6z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 26 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>>> But the fix here isn't to delete unused.cocci, but to hold off on the
>>> UNUSEwork D() patches until we figure out how to make coccinelle jive with
>>> them.
>>
>> Yeah, my general skepticism and disappointment above notwithstanding,
>> this seems like the best path forward from here. I tried a few other
>> tricks (like --macro-file and --iso-file), but if its parser chokes, I
>> don't think there's much we can do about it. Even if we wrote a patch to
>> coccinelle itself (and I have no interest in doing that myself), it
>> would take a while to become available.
>
> If it is just a single unused.cocci, I would actually think removing
> it would be a much better path forward.  UNUSED() that renames to
> help folks without checking compilers would help noticing bad code
> much earlier than unused.cocci many contributors are not running
> themselves anyway.

I think Jeff King's reply covers what I would have said, except one
thing I'd like to add:

My reading of this is that you're misimpression that unused.cocci and
Jeff's UNUSED macro are two ways to the same end-goal, and that if we
keep the macro we could lose the coccinelle rule.

But they're doing completely orthogonal checks, the unused.cocci is
finding code that's *actually used* accordingn to the compiler, but which
we know results in code that's functionally unused.

E.g. doing nothing with a "struct strbuf" except to initialize it, and
call strbuf_release() on it.

Whereas the UNUSED macro is finding parameters that are truly unused,
and which we could have expected compilers to optimize out already. It's
just helping us maintain our own code hygene.

I suspect that we'll also find "functionally unused" code with the
UNUSED macro, but only indirectly. I.e. we might find that all users of
an interface don't need the Nth parameter, and so we don't need to
prepare it for them.
