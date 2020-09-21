Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B760C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B122151B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toVZEcgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIUIyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIUIyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 04:54:19 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79EC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:54:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so11992364edv.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WToxBQtBZJloVrzBE9O2Tx3+fGLtOoUuC9P8IpeGZEQ=;
        b=toVZEcgQmqmtRnEkHvMZv6Zx/lBB7Z6fkv8FvYZar55p8pUuomGU9zffdXvqok2oKO
         h9c5KFpoldvDDCcb3KPfsQrkZOoDoSDUeRsgta/wYi/l9X1ty1Nn/lwvURfIq84mOakj
         dFg+XpUN81lvO0G3us3KRVzEbOQu7el99uk+4xdrUkMlgibxmPLSeHVmMpieGXKAXuzh
         Cl6v6cCETfb6trdUcJbcJHtrng5WQd9+4M+WHuwLAgXv33bWgWfIMmVi3YASID9DDL72
         hyP2UeINFXn9Bw5eXR9gPZC+DjIrVNvE1hbZiJHWdzg7bpSCemmWTIE7+SPdsVcmFDy+
         di7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WToxBQtBZJloVrzBE9O2Tx3+fGLtOoUuC9P8IpeGZEQ=;
        b=HPUs4AHfb+/78FqPgbIT4P3suoFHFkIUcH6aKSHqAdjX55RG4CmjrCUaEkW3O0wZOl
         gqR24JTX53E7+mBA4cWOtkQPtsjtnqIra2ps1BpghKYPtTt8OSDuYq1+/Q07BF6ZRmcb
         AvFVZmjKECqFywft4ig1MEYqNUEK41uTyucq9GEBCVXs0+DpHiYkJNze0CBUNDRtg8hK
         hVVhobc8Q0L3Gz4a0Bcl6aAdO4BMOJtGhoLc1sG7Lklv5AzPeoKO+xi1SoBs6KDVsMtf
         g0P5JzTCDJ7jG0iFNUF66LB30Cqb6fEuL8SsEsaDozm7Vf6sOpAtH3hgyV8+xJ5BdY+B
         KKog==
X-Gm-Message-State: AOAM532LeOd9mLIKkgdSOaN10rjIwOQzt5rTFAoGtJzWSiq9hifzGJ49
        duSfu/xUjaFf0pi/d136lBs=
X-Google-Smtp-Source: ABdhPJzZo90QCD2ACm+8LoOL8z+oWG0o2iXdNK54t56SIYRLgHrxoQvV0Db+nwpQ+/AGIVWAPq9tzw==
X-Received: by 2002:a50:99d6:: with SMTP id n22mr52021939edb.265.1600678457332;
        Mon, 21 Sep 2020 01:54:17 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id s14sm7717826eju.84.2020.09.21.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:54:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with test_path_is_file
References: <20200916102918.29805-1-avarab@gmail.com> <20200916102918.29805-8-avarab@gmail.com> <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com>
Date:   Mon, 21 Sep 2020 10:54:16 +0200
Message-ID: <87mu1jh5mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 16 2020, Eric Sunshine wrote:

> On Wed, Sep 16, 2020 at 8:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Change a test that used a plain test_cmp to first check the file(s)
>> using test_path_is_file. If some of these file(s) don't exist (as
>> happened to me during debugging), test_cmp will emit a way less useful
>> message about the failure.
>
> An alternative would be to update test_cmp() to present a more helpful
> error message so that all test scripts can benefit rather than just
> this script. By the way, were you testing with a reasonably recent
> version of Git? I ask because test_cmp() was updated not long ago to
> provide better diagnostics when one of the files is missing.
>
> [1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)

Thanks (and also to =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh in a side-th=
read). I've dropped
this patch. It's indeed better to leave this to a more general facility
as in your now-integrated test_cmp patch.

The reason I came up with this now-useless patch is because I originally
started hacking this series on a slightly older version of git, which
didn't have that patch.
