Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E68C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 09:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347170AbiDSJe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiDSJe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 05:34:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46B22BC0
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:32:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lc2so31600126ejb.12
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lRevspjQ5v2iKNBQ9oxLMfd35Bh57Q0vmQUglaK5CQA=;
        b=gGfMQiP7tYhRhaaQRlpNCqmE1D8znOMYHlTrBCsGBUpeCRyExQR1XATvtL5aQHhKRI
         +eDdt5a6AQ10x7AWi1/3QQ0Hk2Y6vkFjobFrexPciuBlsECVniHldEWlHP6RySH+8ctY
         LEIZXYiijvAiqce3ufbMI0oCosJY+Rf6npDZLs9oNhBbBVD1JUAOskw3WqW3tDTnohJk
         8JPHUiZ1Qsbv32OdC7MjVg2jrDaR55FSrdEr+QA57nj3QIe4CN9zJnwFFfXH1VergOyI
         goAm4fnfwPWy3OYwJqeq6Vxo9SalKadRI8tdIRVR7chIeQo+hb4NqZFcQQb4h7C422Iq
         wIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lRevspjQ5v2iKNBQ9oxLMfd35Bh57Q0vmQUglaK5CQA=;
        b=uR3RIORhd66e8g+E/IWcIegSt0t3yeH9b5Apdj6NOhx35hBaVyCXNUiJnRBK4LTQEy
         qvHso9fQYi/5vj7r5WuDsD05VZ4mhBu/lYUA6Hz2rlcOhwvWLieTZQ4hjP5DCT4ciIsq
         ssc6kjIi6nxK6fTFw8WtWol4YeI94BORKa8pdgOrhO1BjYshzM8cqxkxxv82Xi5MEXTi
         teAIN2+fTrVmM82GUf5p7Cc+rvhwEkDDgJE5b303/Hzdzg124taalFcJwwhe2K17bDC/
         EX2jkjmELZiYUxx1e0d1PN74efghULx/IiNYS+H5cBlFqfAhYcEtgW4uKGOfhwyf3Sbs
         fyfA==
X-Gm-Message-State: AOAM532LgHRxdUuVhbWH74dEcuOtA7gysXqWZvUa7lt7CWe6oZIQe5g2
        Dnn3XOmqOUyfuWY9idaxfc0=
X-Google-Smtp-Source: ABdhPJzcGMleVTgvTqQpFNgyv0AxUXrGaMuHSLc9CQO9gqsVPvYRzx7kkvnfkFUpBcqmCw7vw1M2GA==
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id dr2-20020a170907720200b006df83a967d2mr12367664ejc.327.1650360733335;
        Tue, 19 Apr 2022 02:32:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw3-20020a170906c1c300b006e88cdfbc32sm5488183ejb.45.2022.04.19.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 02:32:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ngkDT-006lSv-LY;
        Tue, 19 Apr 2022 11:32:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 31/31] CI: make it easy to use ci/*.sh outside of CI
Date:   Tue, 19 Apr 2022 11:31:35 +0200
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
 <patch-v4-31.31-4fc67e668da-20220418T132809Z-avarab@gmail.com>
 <CAPig+cQi1sRt_fMi13LtFvDL3J3ZcNaOzTugQaN-T41YAgw5Nw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPig+cQi1sRt_fMi13LtFvDL3J3ZcNaOzTugQaN-T41YAgw5Nw@mail.gmail.com>
Message-ID: <220419.86r15t8llw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 18 2022, Eric Sunshine wrote:

> On Mon, Apr 18, 2022 at 12:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> In preceding commits the ci/.sh scripts have lost most of their
>> CI-specific assumptions. Let's go even further and explicitly support
>> running ci/lib.sh outside of CI.
>>
>> This was possible before by faking up enough CI-specific variables,
>> but as shown in the new "help" output being added here using the
>> ci/lib.sh to provide "CI-like" has now become trivial.
>>
>> The ci/print-test-failures.sh scripts can now be used outside of CI as
>> well, the only GitHub CI-specific part is now guarded by a check that
>> we'll pass if outside of GitHub CI.
>>
>> There's also a special-case here to not clobber $MAKEFLAGS in the
>> environment if we're outside of CI, in case the user has e.g. "jN" or
>> other flags to "make" that they'd prefer configured already.
>>
>> Using "ci/lib.sh" as a stand-alone script is much more useful if it
>> doesn't hardcode NPROC=3D10, let's provide a poor shellscript
>> replacement for the online_cpus() we have in thread-utils.c to cover
>> the most common OS's. It was suggested to use "2>&1" to invoke
>> "command -v", but per my reading of [2] and my own testing that
>> doesn't seem to be needed. Perhaps it's only needed for "which(1)"?
>
> Not redirecting stderr makes sense. I almost certainly accidentally
> typed "type foo" reflexively even though I meant to type "command -v
> foo", which explains why I thought redirecting stderr was needed. The
> explanation above probably would have best been done simply as a reply
> to the review thread rather than as part of the commit message, but
> dropping it from the commit message is not worth a reroll.

Thanks. I figured including it was worthwhile, since I'd probably on
another day have looked at it & mixed them up the same way, i.e. you
need the redirection for "which"...

>> 1. https://lore.kernel.org/git/214f8670-91d5-f4b6-efa1-76966c3ab1ee@suns=
hineco.com/
>> 2. https://pubs.opengroup.org/onlinepubs/009604499/utilities/command.html
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/ci/lib-online_cpus.sh b/ci/lib-online_cpus.sh
>> @@ -0,0 +1,26 @@
>> +# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
>> +# that presents a chicken & egg problem. But if we move it to a
>> +# stand-oline command...
>
> Um, what's a "stand-oline"?

Typo for stand-alone, sorry.
