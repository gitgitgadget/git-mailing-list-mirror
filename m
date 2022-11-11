Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9220CC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiKKVKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 16:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKKVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 16:10:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62B83B9D
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:10:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so9222310edb.9
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfSTPPZ2YEkO/VwQ4loTh/CBX8Yos9gLmtW3uKkEyDk=;
        b=oZKnr49ycvqHRHDkPvtJYMH14ccRZJTp0IvWQeLQav+BYvB7T74eo9rIeLgPIqxPcN
         CJkyRQPdWT0I5qRe9PkaVen8rttiP6Md0h08V5QTyaDcARUpY4gGht3bACJoEuqbyvrh
         52OUW+bNljE3nEXKPmxMJcwkT2zlumOLQJvJdS4dgehcFIh6KNVONhNrEGxLy7CCEooC
         392t80AHwgVIau85eV50WQMH9n532EZeyCwJukHFeZliNVsryd4oqXxayDnn7waDNXI9
         j0+NqcgNb3666dme4RNFh1gF0FrHoeEMc/iXOK4OJ+TXHh0zVLAtUFN6hwM8EjuOsh5M
         uTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfSTPPZ2YEkO/VwQ4loTh/CBX8Yos9gLmtW3uKkEyDk=;
        b=mVRA2oxfgLClRDVhDq1CVtRAHsxkHiC74qOStsslXL3Vk9cU6UeU2mMg0DpoorUprq
         ju2AVrh13ZhFf06aW+MxbaIcmZ3t6dmYGbti37frcUsFzDHMz14ND/iR0PA0idsWLt+5
         MOlB362+oIOTzhbSX4FEz18PJQ7kofickkPUEKCsoe3NY0gyzLa82N7a4BIRIeaG4NKH
         WCRZIJLGlizItToSSMw1Dfc7X1pfIcR8nRhPSpv6g3LRxufcYLETm08bBR1voHPShTEc
         USlXmWLYYYCSnG2D3pzf6g+rbM3/F6vm3cSHHSdEb0rnFB4AF7+xYENE8fnBs3vYJ352
         3IWQ==
X-Gm-Message-State: ANoB5pnuH671uGyeRNN5mbU3ph41z+8JIRxbpx/+MgS/tBatoOF9NdCn
        6N2HyFxj6MrgZZLv9MM7Tjw=
X-Google-Smtp-Source: AA0mqf5YwYJvA2PGa6+gh+WG510xgYVVpBrupo9/0NBJAzWW/MRARCK7nBZcCBHqaetHao8/up+czQ==
X-Received: by 2002:aa7:cb0d:0:b0:463:ba10:9e2d with SMTP id s13-20020aa7cb0d000000b00463ba109e2dmr3108850edt.43.1668201029455;
        Fri, 11 Nov 2022 13:10:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hd16-20020a170907969000b007ab1b4cab9bsm1232126ejc.224.2022.11.11.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:10:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otbIC-00273J-1A;
        Fri, 11 Nov 2022 22:10:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/11] Turn `git bisect` into a full built-in
Date:   Fri, 11 Nov 2022 22:09:59 +0100
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <dadca7adbe3e7984f60fd6de6c8d63edb6a1ad8f.1668097966.git.congdanhqx@gmail.com>
 <221111.86edu9oa9d.gmgdl@evledraar.gmail.com>
 <Y25sVYUAVvsfRiPK@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y25sVYUAVvsfRiPK@coredump.intra.peff.net>
Message-ID: <221111.86o7tdmc3f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Jeff King wrote:

> On Fri, Nov 11, 2022 at 02:53:19PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Do we have a test for at least the exit code of "git bisect -h"? I think
>> not, because before this it would have been (from skimming
>> git-sh-setup.sh) 1, but 129 after.
>>=20
>> The new exit code is better, but let's test that. For some exitsing test=
s:
>>=20
>> 	git grep 'test_expect_code 129 .*-h'
>
> It should be covered by t0012 automatically once it becomes a builtin
> (and checking out the tip of dd/git-bisect-builtin, that seems to be the
> case).

Yes, you're right. I forgot about those. So, there's nothing to do here
then...
