Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955DC636D7
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBHShr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjBHShh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 13:37:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3C40BC1
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 10:37:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so887043pjd.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEEuahPiv5xr0p8lF8hVG2YqVtIxBEigSS6G/6U9jcE=;
        b=PdPfS7VT2/d6j3Eoes/4OUgHFcV2zgnUVhnwiLN+Af3gkgLaPnFIOcO5M8rZ9Fgk0E
         sZ7la3tdDn4YAmGaWZ7iXEfE9fhwJpP31xD+DSZuJyGG4HMsJ621oi/Qx75Js2pUomYo
         KmcUDoh9Kyr5A9veZAm2IiKK5h+O1e9W0EJ8exYxvUURsMIL7WgoBfdhK5dJdC5aE0Yd
         6wxAiGc7RiCTKLPPqC60K/g35ceG05v5Z8V2GRAulwum/xp6lY9VTOOkrBv0XvMkRlza
         SUaqjdc+KNYbiSjld87EKGsyWSl6HKOt3IKfa4c34QSeRNZuJPX2wEkcNThCpmD1FY33
         kXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEEuahPiv5xr0p8lF8hVG2YqVtIxBEigSS6G/6U9jcE=;
        b=zDZF5cfei+9KeexTQAu1KG8NpPu/1g42ySHum61c5TDl2CgytuHPaOjP5XnHfdTThg
         coBMQ9oIjSkN+NuYFORW5REn4m2sdPf+KfS948Uamq4ZBMWp40M2tBiNLleBruPifE44
         zXZd4fq/QXLBNLrVYERmU7xCGBosNrD5wX6RcVpzcQ9xVoGYPpq2vDxErfmN5sFPMMul
         8Qv86n5w1l4TrI3FQf8cM24eaoBHp2V6SnPbuRnndCTRj2BtTlyZacSsbyNK3iOFn/fT
         GFZBbetIfvLHXjDrnNMvKwozcN4DbBDONVLCvn7d8qW5Xma+0PyyyANzz50QdkNeyhZg
         wruw==
X-Gm-Message-State: AO0yUKWg5YJDFBJz1NxI0RyMQcIKBhN1seA9DEd06bOs5301o6p6MyaB
        CsqW5nmbZosusfQ4Ol6Fh3KpHQCfbtw=
X-Google-Smtp-Source: AK7set8IcCpOcu8/h+yy4bCKOTlBegi/G9/q5xs9U7qF5s3R+uCfi/FigvdJLWidhqOeWOZFRqZ8Gg==
X-Received: by 2002:a05:6a20:441a:b0:c0:c3de:bb82 with SMTP id ce26-20020a056a20441a00b000c0c3debb82mr7557919pzb.48.1675881432686;
        Wed, 08 Feb 2023 10:37:12 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a639c11000000b00478c48cf73csm10059695pge.82.2023.02.08.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:37:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] branch: operations on orphan branches
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
        <230207.86cz6l501v.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Feb 2023 10:37:11 -0800
In-Reply-To: <230207.86cz6l501v.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Feb 2023 09:33:39 +0100")
Message-ID: <xmqqa61oroko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>  - Renamed "ishead_and_reject_rebase_or_bisect_branch()" to
>>    "die_if_branch_is_being_rebased_or_bisected()"
>
> Looking this over holistically, I think this is a great example of where
> factoring something out into a function is just making readbility
> worse. This function is only used in copy_or_rename_branch(), and the
> overloaded name & semantics are making things quite confusing.
>
> Whereas if we just start by pulling it into its only caller I think this
> gets much better,...

Hmph, I hadn't considered it, but with only a single caller that
becomes a viable alternative.

> Another thing that I think could be improved in this series is if you
> skip the refactoring-while-at-it of changing the existing
> "if/if/die/die" into a "if/die/?:".
> ...
> I.e. your refactoring of this in 2/3 turns out to in the end have just
> been inflating the code change, for no functional benefit.
>
> I wouldn't mind if this were in some pre-cleanup, or if it actually made
> the code easier to read, but IMO this pattern of using a ternary to
> select the format to "error" or "die" makes things worse for
> readability. It's a few bytes less code, but makes things harder to follow overall.

Good.

Thanks for carefully reading.
