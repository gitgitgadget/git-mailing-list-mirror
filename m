Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B02C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 08:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiHEIfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbiHEIfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 04:35:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92290C4
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 01:35:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b96so2570066edf.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=a2sZxgZXl//lwHYNtQOc1/xMrDBE5KNYl2aNuKZVWYo=;
        b=SbSjq/Vkn9fL8CVPjlUIeg4C2RFdPqx6zg3tNzSK+0xGzrvzoS71gRE20bK6ymgUBs
         /8YXaM5k+z8zaifoBJbAb69qvfHLfvhGOuOGP6pP5R7OQkbY++vbRyuHrIBAEYwYTZkd
         2Yc8iC4DttUISjdY7jIfpic5D7s4YDnbHjo7pnjU1AC3PDGXPTuYQjHP059HiUli5G1+
         nmlsoRinr/g5SOFaAK74OYHI2ylMBvOuVzGPuM7T78l2nNWuYhgdmx3It4rbyn6ug8SH
         CzCps08YCa8tHTwwF3p2o+GcKtKDvSJECtJSsgM96gMpB7dQ5ZPegsdUh3dPBdjhecKQ
         fqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=a2sZxgZXl//lwHYNtQOc1/xMrDBE5KNYl2aNuKZVWYo=;
        b=5k4IuLfMPmjUDI2M2Ns7uU/cqa/0JeW8lWUHm1Ja+XhI1dW4U1UQtfirI5BqVVmTZI
         WHwdrKwIODO3i35oSLvRtw79XzNIZlZFKDZajyCn4jsAiWuG0X4fa+yEprMClXufevQH
         zQQ6562gcCtVViqZLkLV1i1NohK6i1e+gIbER3n2bziZpRrWIy/Zz1BqDR+CiM76dXtO
         H36JjsmEZtVJwW91LaoStzsCZAh39AOQ4PyBzkDs7Uq3oqLddZItzkblsCfCuRCOJaYX
         HgwUp6Bagl9uZRqOeNCiWOPbeFTO9RT0DDeYv1seGMeyBMLOXx7Q/EEZW2lHz0OxJ4mO
         iubA==
X-Gm-Message-State: ACgBeo2v8ZFoXcRs7bNvABShnIR0asJ+APPru5e7qNpLAL1+fnn9233Q
        ylZvPPbxzYCHMUbvd+ssDrg=
X-Google-Smtp-Source: AA6agR4A8UXTvFyBO49PMSo1VlxVgKR571FliLz6Kv8xUNT6gYnoSVD8dR6WdNbtM+OgW6bqcf2qdw==
X-Received: by 2002:a05:6402:44d:b0:43b:e6e2:c98 with SMTP id p13-20020a056402044d00b0043be6e20c98mr5636626edw.323.1659688508408;
        Fri, 05 Aug 2022 01:35:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bj26-20020a170906b05a00b00730fd9ccf84sm471140ejb.90.2022.08.05.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:35:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJsnT-000S2d-0D;
        Fri, 05 Aug 2022 10:35:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 11/12] docs: move cruft pack docs to gitformat-pack
Date:   Fri, 05 Aug 2022 10:29:08 +0200
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
 <patch-v8-11.12-b9dde9788d4-20220804T162138Z-avarab@gmail.com>
 <xmqq5yj73d6l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5yj73d6l.fsf@gitster.g>
Message-ID: <220805.86h72rrsuc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Integrate the cruft packs documentation initially added in
>> 3d89a8c1180 (Documentation/technical: add cruft-packs.txt, 2022-05-20)
>> to the newly created "gitformat-pack" documentation.
>>
>> Like the "bitmap-format" added before it in
>> 0d4455a3ab0 (documentation: add documentation for the bitmap format,
>> 2013-11-14) the "cruft-packs" were documented in their own file.
>>
>> As the diff move detection will show there is no change to
>> "Documentation/technical/cruft-packs.txt" here except to move it, and
>> to "indent" the existing sections by adding an extra "=3D" to them.
>>
>> We could similarly convert the "bitmap-format.txt", but let's leave it
>> for now due to a conflict with the in-flight ac/bitmap-lookup-table
>> series.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>
> OK, so this round we roll the "cruft packs" into the main "pack file
> format" documentation, because the former is merely a minor deviation
> at file format level (i.e. comes with an extra .mtimes file) and the
> philosophy behind how they are meant to be used is what makes them,
> that is mostly the same as the normal packs, different.

Yes, perhaps we should split all of these out, but it's a smaller
logical change to just bundle the ones that were split out into the main
documentation.

> That makes sense to me, and I agree that in the longer term we may
> want to treat the pack bitmap format documentation the same way.

I have that patch locally already, and figured I'd send it in shortly
after this lands. I just didn't want to burden you with the merge
conflict with c7e7f5dd814 (Documentation/technical: describe bitmap
lookup table extension, 2022-07-20).

The merge conflict is relatively easy to deal with, I included a
resolution in the v3 of this series (but ejected the change out of v4):
https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-avara=
b@gmail.com/

I can still re-roll with it if you'd like it sooner than later, or
ac/bitmap-lookup-table could be re-rolled on top of this topic
eventually (it seems it needs an eventual re-roll anyway due to SHA-256
flakyness).

Or we could just go with the status quo here and leave it until the dust
eventually settles, which is what I went with so far.
