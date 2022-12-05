Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C3C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLEXjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiLEXjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:39:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3218B35
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:39:09 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vp12so2212123ejc.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pik9r9M6tW2aSYpWtLpNYy5X9pAOwwLcwLQarnax9JI=;
        b=qqe7qPotLFdIt8o43mlM6unxRoALtdrXjx8gdo3e3uLe+dHaEDYLvrirPa9TOjlUOo
         bdR2vhFmr+Pqu4StbXh4mUwHiyCSEtdss6ty036rmMpba+5Qj6i3wPTRP1k53vlJl5L8
         AiMHllfCo9pSDoicNVGDQGjgk+q1QMTfsU2MTKbfN9yqp7xiQSydz28FigpUkHq3nVt8
         staMUumHSb5tH05ml/psxtDJRdzjRiqiW+9tKBpr17eQEFNndN7Q/QiCMsBSWXZuUr1V
         GwdKd+3DuV3cwu/TA0NBAtO5s3wpkLjBcqUI5ECzpgDZS5eRl5vSYIsaD8YvGs22YLcs
         BtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pik9r9M6tW2aSYpWtLpNYy5X9pAOwwLcwLQarnax9JI=;
        b=jK81xPdv31EmyKO4kt6sD1zTcr131ySsc4hozEB+yf2YwEz0fgN7SiaSFzv71JET8l
         xlRJQ0ivSC5c8k8LBpzVcW0dtfDuOGaIvSr9n+f01t0Kj3Gy03UApSWcUTj2PfiYC3EV
         7GSgQkPWU8+dLXLINMeZlzNQ7R2Jf2sJDJLjqqUZsFXgwQ/S0ku3ada3QKOp+X5C9GIQ
         W09iMAgGU9Ib+Rq/EKSr3S1BpUXx8LqU9AiXOLM94yYLKztUEBcO4FI5k7vEv+QGwR7q
         EgVKXcICOdRrxm9E417Ck5P5oYmZYFM3p0PGeV4sqHO2MyPSNJ/QCVt/tTmvXmKn1jis
         3Lig==
X-Gm-Message-State: ANoB5pnnJX03b4Om0gTir/GTqWZ26KQTSeEyVJYRmLAuA8fgvc4rFvyV
        mMkkIFKSHim+Ldy+lnmjnVW/F9RVIeU=
X-Google-Smtp-Source: AA0mqf6XDke94/P5dkPT6EXYDcRUR9jU7HFqYPKzwhZNehbfWznjCh1Kyw8PTdXcErrLnTOJrCEfKA==
X-Received: by 2002:a17:907:a801:b0:7c0:e060:e819 with SMTP id vo1-20020a170907a80100b007c0e060e819mr8562865ejc.763.1670283547634;
        Mon, 05 Dec 2022 15:39:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm6685183ejc.211.2022.12.05.15.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:39:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2L3B-003Kav-3A;
        Tue, 06 Dec 2022 00:39:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Date:   Tue, 06 Dec 2022 00:12:32 +0100
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y45yaYV3xFB/xR2G@nand.local>
Message-ID: <221206.868rjle7za.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Taylor Blau wrote:

> On Mon, Dec 05, 2022 at 10:01:11PM +0100, Ren=C3=A9 Scharfe wrote:
>> This rule would turn this code:
>>
>> 	struct foo *bar =3D xcalloc(1, sizeof(*bar));
>> 	int i;
>>
>> ... into:
>>
>> 	struct foo *bar;
>> 	CALLOC(bar);
>> 	int i;
>>
>> ... which violates the coding guideline to not mix declarations and
>> statements (-Wdeclaration-after-statement).
>
> Yeah, I was wondering about this myself when I wrote this part of the
> Coccinelle patch.
>
> Is there an intelligent way to tell it to put the first statement after
> all declarations? I couldn't find anything after a quick scan of the
> documentation nor our own patches.

We can get that working, but I think it's good to establish some ground
rules first:

First, when you add *.pending.cocci rules they shouldn't be pseudocode,
but things that are too large to apply right now. I think my recent
041df69edd3 (Merge branch 'ab/fewer-the-index-macros', 2022-11-28) is a
good example.

In this case if I apply the proposed patch and do:

	make contrib/coccinelle/xcalloc.pending.cocci.patch &&
	patch -p1 <contrib/coccinelle/xcalloc.pending.cocci.patch &&
	make

We have a deluge of syntax errors, not just the warnings Ren=C3=A9
notes. This needs to be fixed, the *.pending.cocci must actually work on
our code.

(We should probably modify the "static-analysis" to actually apply the
result of these *.pending patches and compile with those, but until then
we can manually test them).

Second, we have test support for rules now, see
contrib/coccinelle/tests/. You just need to create a
contrib/coccinelle/tests/xcalloc.pending.c, and have the expected
post-image in contrib/coccinelle/tests/xcalloc.pending.res. Please add
one of those. We don't have them for existing rules, but it really helps
to assert & review new rules.

The various edge cases that your current *.cocci doesn't compile on
etc. should go into that test file.

Third, the resulting patch is currently ~2k lines. Can we really not
make it non-pending with some whitelisting/gblacklisting. E.g. see this
out-of-tree patch for an example of opting out certain functions:
https://github.com/avar/git/commit/bedd0323e9b

I think that's preferable to having some *.pending.cocci we may or may
not get to. I think you can also probably write a working rule for this
to incrementally target certain subsets of these, and we could just
mass-convert some stuff already (if it doesn't conflict with in-flight
etc.).

Fourth, I must say I'm kind of negative on the proposed change. I.e. the
foot-gun is definitely worth solving, but why not just create a
coccinelle rule to narrowly address that? In that case we can presumably
start with it non-pending, as we don't have that many of them.

On the notion that we need to special-case:

	- CALLOC_ARRAY(ptr, 1)
	+ CALLOC(ptr)

Because an array of one is "not an array" I don't really buy it. The
calloc() interface itself exposes that, so I don't see why we'd consider
those separate on the API level for these wrapper macros.

I.e. I think the point of the macro should be to provide the appropiate
sizeof() for you, not to be opinionated that nmemb=3D1 should be
special-cased.I think it's probably not worth the churn to make that
transformation.

But if we *are* doing that then surely we should provide the full set of
functions. I.e. ALLOC() and ALLOC_ARRAY(), CALLOC() and CALLOC_ARRAY(),
and REALLOC() and REALLOC_ARRAY()?
