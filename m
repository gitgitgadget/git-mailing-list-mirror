Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D37C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKDNIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDNIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:08:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF3A2E9E4
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:08:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so13088415ejd.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dP1lHAq4TaahkS3ww/srL7mnqWbueMOZeW4dLOfAe0o=;
        b=I0N1av8FACYQKjqES5AZN3yhc4s0yb4BeHZSEemIODVZgwrz4KtJiN5SlhDnY0ysJ1
         OZMPL/zxDimZZKkYMBvEfR7G8dEdZ/x3YokvKjDPU2sscBntoyuqSxWcnxGqia9Nv6jK
         e7vUL+SP/MfNC8toJrJ+cC3suojAjJMYOnv88XGJw4oImDI+DyQ9Cn+/qUKm7RlGEqM2
         2czqP6MabU2k2XoBDCBY52fCg1X7vLrf/1R6wcRoEAiQcomLMhH1iNwRZpetIidHmrgf
         dB3ZSJQ9uW4mTdigSzr0xCx7esvBEDbKja41BGTiJOYZrNySBPtqbb092AqIQmq4md0j
         mLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dP1lHAq4TaahkS3ww/srL7mnqWbueMOZeW4dLOfAe0o=;
        b=oU5stgsb9+tKTzSaaqYvm4yWCrnmedcLrb09ysC3C3uD8V5BrAknTnW1TG1QpgltxU
         F6Amq2CYtCYZSSI0BqYgmfBi4q5qP+7UQkwnqNTxGdgAevMT5JBzfWnd7g/Uo2QLC/+X
         WISE4tynn5wkKl4F4YZugqsf476NuoYX7GzHHsNXCTCZaLx4wYZuLymg1a+HwG4JWZ7r
         FxCD7Q4aRstdpf1YJgbHzB2K8/BbKIV5mWn9IR9RDZJb5EB4rrSKBjuOmOrT2m2b/Rgp
         DojmGjKFLQY09CKvAkm8rVYNcndg1R99SnzvPZ191Z+8t2Qq90v89zOGe4Q84kWkNbXw
         10qA==
X-Gm-Message-State: ACrzQf26CIewc2C+qevc7U235ikMduAVvc1mxW0copoFuSCwA2io7ibZ
        7fsZw62fBQV6a3klkSmn6to=
X-Google-Smtp-Source: AMsMyM45Q5LrAhpssRd7elc2/o7nSOeIJXBpjgZBF1FZ1Fdxfnp3FRLX0qD3aYb7G8mRIRO01Jiwaw==
X-Received: by 2002:a17:906:846d:b0:7ad:90dd:4b6 with SMTP id hx13-20020a170906846d00b007ad90dd04b6mr33591598ejc.492.1667567307859;
        Fri, 04 Nov 2022 06:08:27 -0700 (PDT)
Received: from gmgdl (j99119.upc-j.chello.nl. [24.132.99.119])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b0073de0506745sm1762831ejn.197.2022.11.04.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:08:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqwQs-000DYT-1v;
        Fri, 04 Nov 2022 14:08:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Date:   Fri, 04 Nov 2022 14:07:48 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
 <221104.86zgd7x85r.gmgdl@evledraar.gmail.com>
 <Y2UJaRdiciKMFpHU@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2UJaRdiciKMFpHU@coredump.intra.peff.net>
Message-ID: <221104.86v8nuyiid.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Jeff King wrote:

> On Fri, Nov 04, 2022 at 12:36:12PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > It feels like the invocation of bisect--helper ought to be passing "--"
>> > itself to indicate the end of options, like:
>>=20
>> Normally you'd be righ, but there's a much easier way to do it in this
>> case: cherry-pick
>> https://lore.kernel.org/git/05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.166=
1885419.git.gitgitgadget@gmail.com/
>>=20
>> I.e. we're eating "--log" in particular, but could just stop
>> understanding that option.
>
> We're not eating "--log" in particular, though. We're eating anything
> that parse_options() understands. It would eat "--bisect-start", too.
> That's less likely than "--log", but the fundamental problem would still
> remain.

Right, I mean the regression's anyone's likely to care
about. I.e. that's an easy fix, I think run scripts using --bisect-*
options are probably unlikely to exist.

But yes, the ultimate fix is to use OPT_SUBCOMMAND(), but getting there
takes more time...
