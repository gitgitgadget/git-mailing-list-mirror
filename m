Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D6CC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKHTVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKHTVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:21:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99D73749
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:21:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x2so24039393edd.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T++zuGfLUcfwoLLf+TVSjedwzSVO578RXtHB6daD/2o=;
        b=nA5cWTCHoPLMuI7oZz5FL1kBpq093Q9fFQkjR0bZYO818Dd6AQuHlgI3DmbQ2HfnbL
         KrjwXe3gwX8YgxhD31i7/Gbcme2hRF6z0R6F+f7i72MisZv5Wvj80AGRoHOG7HaHS3KH
         K1zhHms8KSWSaHnsJ4ph53H/HRUbPg993tA0OmgcrySMM/7kyk/1V/9fvG4VTbEqWTRk
         eAIYsLuMzBJSLij07pA48pUb9A0lCmXMkYPZP9iYU6OjF+MEARkveW1O8rrD6OotKhlD
         wf78kaQBFGpjQkyTpguOJRz/GJkFHRuuX68E6hDKU/7XPHNtKjzFrq8EvMU72vblJS8H
         V5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T++zuGfLUcfwoLLf+TVSjedwzSVO578RXtHB6daD/2o=;
        b=3XXLsm96NkaaEbT7hYm4vLa/6rBXSpkqiBXMhNYapsytkDzN3gtkFKkydkqRO9MhOg
         qwC0+tRBcQt0hzPkMUqqC87M/CsI45dNj8R/Er0ZLCyJzbTyXv2a1Jx+mcL0HIS+6mc2
         jAFi0FOgiCnWyJgnK6l15KTy0kUZIVbdX9sU34QNRUWR45MQL5+ITAvUHcwssAJyc5SZ
         Z9yd2CW4mooDm3wTLuqExSSs8EHsoJyl/N9lD6Tb6f7RI7rQALq5bS41HXyLtoJIxRbE
         4TUqMjOjD+fv4MwCcQqogda2tAHaKERoUUbhxVQj4Jsl24hdfk000W0aht4pmrzKBEpj
         4Fow==
X-Gm-Message-State: ANoB5plFXTitcIPmNiQEKnzKzNAE6bCPD5RAFHGCIJywBBX7v9EEw6wf
        PAxvyHT/G68wC08rN7yJ1sRrv3GFhWgBRQ==
X-Google-Smtp-Source: AA0mqf4fNFai8fM0RufdJ0d8l7DwX2x6AVmtznvd65Z2O6uUb3CQ3T/Gp1gu/ZZkAvl+C1qi/KWN4g==
X-Received: by 2002:a50:8e45:0:b0:466:70e8:6f59 with SMTP id 5-20020a508e45000000b0046670e86f59mr10641121edx.187.1667935286837;
        Tue, 08 Nov 2022 11:21:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5043943eje.61.2022.11.08.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:21:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osUA1-000iZ0-2a;
        Tue, 08 Nov 2022 20:21:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 06/12] docs: move commit-graph format docs to man
 section 5
Date:   Tue, 08 Nov 2022 20:16:49 +0100
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
 <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
 <20221108180417.GB1731@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221108180417.GB1731@szeder.dev>
Message-ID: <221108.86mt91qmkq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, SZEDER G=C3=A1bor wrote:

> On Thu, Aug 04, 2022 at 06:28:35PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Continue the move of existing Documentation/technical/* protocol and
>> file-format documentation into our main documentation space.
>>=20
>> By moving the documentation for the commit-graph format into man
>> section 5 and the new "developerinterfaces" category. This change is
>> split from subsequent commits due to the relatively large amount of
>> ASCIIDOC formatting changes that are required.
>
> So after this series I got a couple of gitformat-* manpages, but,
> alas, most of them render improperly: a lot of paragraphs are for some
> reason fixed width even in a fullscreen terminal window, and their
> width is more than 80 chars, so they are rather awkward in a
> standard-width terminal.  This also affects the html version, where
> those paragraphs are rendered with a fixed-width font.

Do you have examples of that, and are these cases where the formatting
was different before the move from Documentation/technical/*

I'm aware of e.g. gitformat-commit-graph(5) being somewhat funny, and
may have missed some cases, but I think that was also the case before...
