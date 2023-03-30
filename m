Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DCC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjC3SpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjC3SpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:45:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC9AD14
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:45:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso20683398pjb.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680201914;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sn0xIrGaozElt8nhJYzXOE47rMonhgY2fAKC3uynbRc=;
        b=F0meX/cm2Bma8n8iAe5kawZrWjmXFbRjTMnsE+nhYh7rQreZAhrTylaiiZ7U3SxSHr
         OuJlwLj0OW2Y/uov5irDLxutgPW/Og3ppWsgFtBZxPbdUoxDYLX3dsYJfydjlWhDaier
         rvWEvlyRTWoBh/6xcMugsPEwN9CXV91no+NVu449dL54krR7mkXBWOn6cGxhMpWemqVL
         pPgkqyggzoRzrIvPSkMdPoTl9caIwfnDemxEuAJAyRtrp3CvzK0ZswmIkhAWyFsSSkWN
         XRoLsGj5dRzjnCn4VGrAbyfIfcL7N//z3tfYkFlHDWAjd4ITNN7KhZ1IPhNV8NqDuAFT
         dzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201914;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sn0xIrGaozElt8nhJYzXOE47rMonhgY2fAKC3uynbRc=;
        b=t8AdwyeUVlTXe4gREVglkkLWQbbK7HfCD2bAtT9zBcF7ht+RQGnirp+XG12EEFJwgK
         vl/6wy/CDDsiSaGWxboJAavnLgG2npO1eoNXlQzH6K7YTehSS2csNcvtL8zg939biicK
         hpokZmT2yaSQ0PdDMVwaD4I0ZQce5la/TalFqzQKLi58ENFq/RUVmuMbaY9oVe6ZQxhH
         yF90y0LVgdHYyjato2rRioimJ0+835i4004+2FcUJry4XjrkT1e3bfAi1hhVTsuqAksP
         05LQ68KGMgbcYfwu7hrwR0zYXeJotyAk2ok+5RNvqhMBoUiDiAQwX44b1JfbciMnvsyA
         QjQw==
X-Gm-Message-State: AAQBX9c9G7GcDH1hhhyPH0UCZOZKldbVIch0h86nqKfRzKAx3JlDSmBt
        CxMisEo6cqmuz1raqAz+tqQ=
X-Google-Smtp-Source: AKy350bcnyQWibF9vn25qHnmXCvd48mj7908xI1hE3VYuo8Bjm7Nv3OfT0cMVkw+HlxsNDr/SButGA==
X-Received: by 2002:a17:903:28ce:b0:1a0:6e4:4931 with SMTP id kv14-20020a17090328ce00b001a006e44931mr20683010plb.31.1680201913564;
        Thu, 30 Mar 2023 11:45:13 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902d71500b0019abd4ddbf2sm54476ply.179.2023.03.30.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:45:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 1/4] tests: run internal chain-linter under "make test"
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230328202207.GA1241631@coredump.intra.peff.net>
        <230329.86wn2zvo9u.gmgdl@evledraar.gmail.com>
        <xmqq7cuzd0cs.fsf@gitster.g>
        <20230329232804.GC2314218@coredump.intra.peff.net>
Date:   Thu, 30 Mar 2023 11:45:12 -0700
In-Reply-To: <20230329232804.GC2314218@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Mar 2023 19:28:04 -0400")
Message-ID: <xmqq8rfejcxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had hoped that "chainlint" in that comment would remain sufficient, as
> the context implies that we're disabling the script. But it's easy
> enough to expand. I squashed this in:
>
> diff --git a/t/Makefile b/t/Makefile
> index 10881affdd0..3e00cdd801d 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -44,7 +44,7 @@ CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
>  
>  # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
>  # checks all tests in all scripts via a single invocation, so tell individual
> -# scripts not to "chainlint" themselves
> +# scripts not to run the external "chainlint.pl" script themselves

OK.  I've taken it and did "rebase -i" on this end.

Thanks.
