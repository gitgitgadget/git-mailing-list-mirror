Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63111FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 03:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKADEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKADEj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 23:04:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B41115E
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:04:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f7so14377677edc.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SFraRQsULFIrRGwYyXXckFf42eGU01PrSDI5OkGZk88=;
        b=RimZmT9k1QqBSUczH+QupNzXG6kMsViTcdl4mo1tIdJen7Jv0hK++bpA7yfxIPYkNd
         brk2osXWCHCUjzqlVU+uge5dyZCpaDpgMHKS69ukQ6Fiw1yCe8exqs4eweEkbtAaCwMB
         JVgcruv4pSn950OqTM7LSakfVc746LNGrgNGIOxt1GJMpPxaXFCkylzh8DQYd7ohjtSr
         2Lk9Z5hcUwidiWEhYqnAp+XP5WSS5Ym/6/6kMymz109NNcbsMTLYn0gsRRocqnpoYXdL
         ENCWk1tt0ymz1rYajyUUTXrtQne6zhjKCohbVDOMpNF0KLS3CfsWfLwAnmeAdfX53vPb
         ugyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFraRQsULFIrRGwYyXXckFf42eGU01PrSDI5OkGZk88=;
        b=WM5ykrufZpXtslgRXET04wtx0d7SwSYiy0q23tf4SNUYCSovocwDvKDHEoiHZApHpc
         JNUeOTpsLPyUwUAK4Jt2I0WlsTMNUKFnGP1rIy6eipSMaiNNMiXESV5+2eGIpYj6hy4+
         0bgidU1ieK1v1wLWkTrooZkabUMM2ijuWj8aZCh05pDl8BrQlRe+umeeVTM543pJ62Dm
         mYuyijqZgAyoR+vZj/RambBrhEd64z2IPSqmB9g4NK/AnGAuk6zJ5YqYNS828HQIGZwg
         t5Ey9hHQE5lNaBqmobtN2u3ZdmFjeK+H9xgHl3uS97s7bjDa4cldhpvJX9IIXJQl51Ub
         bioA==
X-Gm-Message-State: ACrzQf06DBk+cSEAQKp3Q8DbINTVW5YqQahpDsiwHNHY0eGk8zlxeYLF
        VJQ0KlnWIwcAwQ5ZTqXtP6Q=
X-Google-Smtp-Source: AMsMyM64XMW+e1phHJj1n006YS5jtyJRIrbzkyce5c/XStCkXXb/KiAuHne2o9kp14M+Q89JHKnWUQ==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr17328271edb.305.1667271874737;
        Mon, 31 Oct 2022 20:04:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0078a543e9301sm3551693eje.200.2022.10.31.20.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 20:04:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ophZp-00B14I-2P;
        Tue, 01 Nov 2022 04:04:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Date:   Tue, 01 Nov 2022 04:01:18 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
Message-ID: <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Jeff King wrote:

> On Mon, Oct 31, 2022 at 09:47:08PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>> That being said your change is obviously smaller, so if we'd prefer
>> that in first as a band-aid I'm fine with that.
>>=20
>> But I'd really like to object to the "it is not actually important how
>> many...", it's crappy UX to spew duplicate output at the user, and we
>> should avoid it.
>>=20
>> So it does matter, and we get it wrong not just in this but also some
>> other cases.
>
> Yeah, I think it is crappy UX, too. It's just that I think the tests
> should not _asserting_ the bad behavior. At most, they should tolerate
> the bad behavior as a band-aid. So I think Dscho's patch is doing the
> right thing (and I do agree that we should fix the immediate CI pain by
> adjusting the tests, and letting the user-visible fix proceed
> independently).

The tests aren't just asserting the bad behavior, they're also ensuring
that it doesn't get worse. 1 warning is ideal, 2-3 is bad, but
tolerable, but if we start emitting 500 of these it would be nice to
know.

I've found a couple of regressions like that in other areas, i.e. where
our tests didn't spot some output change because we were selectively
grepping things, but where it would have been nice to spot it at the
time.

