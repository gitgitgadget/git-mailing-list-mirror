Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29ACC32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 07:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIUHCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIUHCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 03:02:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C932B7E02B
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 00:02:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc7so11604280ejb.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=BwPNQOrhXKnQEXtOPhXmINUORhP6BMCWyc5MrN+QGeU=;
        b=IVYmLqJ1S5wJ4K1mhH1kI6pUMS0Qo7MwXWnDPrTy+hmJxUXGH9MQlfmcDR1Kr68pbq
         cUeWXlwfrXdkqJLUreBb4rKMPgTOh/+rmGwuh9vKuH3V7/ttIR5bGxEjX4V4ueZOE+RE
         59Ztob/Vc57xQ9AQHoqhOtwQTKHhU4qx50Z5kmXCX/ZWWI4VMNH3typwgUiUv4ZaurHr
         GgtVs2GrE4gmVA98sYU0fqVep5/oS34FahOF10FbWrfp4/VMcU6grSzm8uOiS2NzQqwK
         nqDjYTi24cSlGPPaBsy4QFVuAPryJgHk3JBIjZrtcoQJrXR8NS1ycVLLIx7C3RAbazwZ
         Hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BwPNQOrhXKnQEXtOPhXmINUORhP6BMCWyc5MrN+QGeU=;
        b=28TEWMYE9I/LW4x3339oszb9FWh2plXjfIUg0X7oXcqssJ5LQFAVEh7tOyK7L8hfEZ
         330Cejnh+zcsxT8uZ1GL4THGoJgm0jSQeRjhNV6PEXPt+i0qtn6kxlijEB76p4NweOGn
         rvHkEcM9BDGIgCAIg9zXVnFVEqw1RQpBELp0AobgS4AGWJV+pID8+Mnn98TMVHJWVYvK
         bR9YK4mc8DsauH0sOtWAKBMo2ZJB53zk6a6z2gLQ5UyEWSI1hNxoFdosi+mQ0rQ+Rbiv
         ObJ8jAFG53FD2zEQiRe1Gz/uAg8mjM4RPnIYrO/T9/Xi7+oqU5BcMBYJZC0auNii9gl2
         dtwQ==
X-Gm-Message-State: ACrzQf3k3CMYQ1oQUHKmgfcpdv1oKg84VSbcZUQ4ROXFkTIgHT7a7FLF
        xv1wU3Nl/G7MxtNHlYpJekzyZICzmlY=
X-Google-Smtp-Source: AMsMyM4LTuKcTiYdLcth0nBI77+SeA8+HXa9zr4sbvnltPZLxL8dZkT6N+so73GiqxBuaMBKlz8qtw==
X-Received: by 2002:a17:907:1b1a:b0:74a:18f7:7f63 with SMTP id mp26-20020a1709071b1a00b0074a18f77f63mr21137016ejc.28.1663743757231;
        Wed, 21 Sep 2022 00:02:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e18-20020a1709061e9200b0076f0a723f6bsm899185ejj.58.2022.09.21.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 00:02:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oatkh-001nWx-21;
        Wed, 21 Sep 2022 09:02:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
Date:   Wed, 21 Sep 2022 08:59:54 +0200
References: <20220920105407.4700-1-szeder.dev@gmail.com>
 <20220920201619.40972-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220920201619.40972-1-szeder.dev@gmail.com>
Message-ID: <220921.865yhh5hx0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 20 2022, SZEDER G=C3=A1bor wrote:

> The 't/test-results' directory and its contents are by-products of the
> test process, so 'make clean' should remove them, but, alas, this has
> been broken since fee65b194d (t/Makefile: don't remove test-results in
> "clean-except-prove-cache", 2022-07-28).
>
> The 'clean' target in 't/Makefile' was not directly responsible for
> removing the 'test-results' directory, but relied on its dependency
> 'clean-except-prove-cache' to do that [1].  ee65b194d broke this,
> because it only removed the 'rm -r test-results' command from the
> 'clean-except-prove-cache' target instead of moving it to the 'clean'
> target, resulting in stray 't/test-results' directories.
>
> Add that missing cleanup command to 't/Makefile', and to all
> sub-Makefiles touched by that commit as well.
>
> [1] 60f26f6348 (t/Makefile: retain cache t/.prove across prove runs,
>                 2012-05-02)
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---

Thanks, and sorry about the breakage. I've looked this over carefully &
it fixes the edge-case you noted without making anything else that I
could spot worse.

In case it helps:

	Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

It's still a bit odd to have a "clean" that cleans up a thing it *might
have* generated, i.e. sometimes we create & use these via a Makefile
target, and sometimes by manually invoking test scripts.

But any such issues far pre-date this fix (or my commit).
