Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04857C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 12:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiCRMnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 08:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiCRMnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 08:43:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7922E518F
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 05:42:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so16792806ejc.7
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Xk3hwy1QpVsPBGNdubY1Ed9jj1X9W/N4WhH4pGCnY3E=;
        b=bnrvtbIrSkx6zV3WTdyYqnqTn/vBgrR812V9doBd1kvbuf5r+UbzOR++HhkmGC0TNe
         zMByr0xW47++zx6H+hxbb9u7w2LzPbArjqWd/qR4OOQ9+PeB2qNglVbyPhmSss/JyEWD
         cwjezzBFb1c0IhBpWv4AUAmUcJ+EcV8e+5uv8hqUueHsanU1fAeWXrmqm3wDa6ISEEMC
         +mzPybq2xbKxjqrsB9te2dwbj4aaq7xxB/uHpTARE7C+FBw9Qod2LKaAsUXjQqa3O1ma
         +0ukyRL+tBHjKMItl5iGZjC75K2hRay3REVNAUMRj2Wr02GQuZjTWR6f1zSYr+n1B1jT
         WRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Xk3hwy1QpVsPBGNdubY1Ed9jj1X9W/N4WhH4pGCnY3E=;
        b=5BvkWUow1u45P3jWRBrg44EVN1+Fjqvwrp5MB0wpoQg3G5dbid7MqiIK0bHS72WyUy
         rekVQJjM0HFg2MEYPEE19zVa2KaN3c78yDy4dTHQggZAUP0enLGNQdhTPDQO1Q1yXUYf
         Bd/RyofjGuTir/vUPlecFDngkpDfOl1BcLhdj6FnaZmJfcHhSlNVIcbTun3RoiXSVujF
         da8sPuD0uhyQmaMm+42oVK4WKA9EkZCRdSCUqi2Fso0B/8D/DCa1KvhPketxEoym0OMQ
         MQ8XtMJ/AJ0vo1TEgo0N3/Pb+y+Z+TDl19ZWqKd/qiNENS2xA4/OFAcWcyMoi76azGgx
         OxAg==
X-Gm-Message-State: AOAM533Y+ILVwpKsq/p1KmMUq0QWeVGcQ7uSATfJZDudggYrGGIEJDqD
        aCqHT+bjjqnNU4JbrvKrT08=
X-Google-Smtp-Source: ABdhPJwtKBNgowTR9KRhBKYt0EUbyh5syNDal+EMs8Gf/6VvE6QrJOf9p+1FZLcVa+Zf+Ts3GmyPVw==
X-Received: by 2002:a17:907:3f12:b0:6d8:bf7c:7672 with SMTP id hq18-20020a1709073f1200b006d8bf7c7672mr9080147ejc.686.1647607349028;
        Fri, 18 Mar 2022 05:42:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n19-20020a1709067b5300b006ce36e2f6fdsm3660899ejo.159.2022.03.18.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 05:42:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nVBw3-002jTV-RP;
        Fri, 18 Mar 2022 13:42:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] refs: designated init & missing debug in
 ps/fetch-mirror-optim
Date:   Fri, 18 Mar 2022 13:40:56 +0100
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
 <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
Message-ID: <220318.86fsnfctzg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 17 2022, Han-Wen Nienhuys wrote:

> On Thu, Mar 17, 2022 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Aside: It seems that the GIT_TRACE_REFS facility has been broken since
>> it was added, i.e. running the test site with e.g.:
>>
>>     GIT_TRACE_REFS=3D/tmp/log.txt make test
>
> I wasn't aware that this is even possible. I've only used it with
> GIT_TRACE_REFS=3D1

Yes, it's possible with all the GIT_TRACE* variables. To clarify the
failure has nothing to do with the "log to file" feature of it, the same
happens e.g. with this on master:

    GIT_TRACE_REFS=3D1 ./t1400-update-ref.sh -vx --run=3D1-46,55-169

I.e. here I skipped some tests that would fail because we emitted the
output on stderr, but this one fails due to the debug tracing and
transactions (I think, but not 100% sure) tripping over one another
somehow.

> I looked over your patches and they LGTM.

Thanks!
