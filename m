Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D9C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCDF64ECE
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhBYC1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBYC1f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:27:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386DC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 18:26:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k13so6257185ejs.10
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 18:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mZXtLRJ1sLRLotstAKroy3npU/6GDRFP6XheBXzm2RA=;
        b=JadkCLEndlP0MaECJ3e47j1ni7O09dzet3yKvZfSeJ9Ye1UGfWD0RSgXP3ZMYnUVF2
         oA5ZnXEToS99jxvbYFTwShh+8vAi7qnS1HLrFIcMHOEXS//DILKSzy8Xr3bNZpZk9iyH
         vp0z75spGkfHlKtMxi0i7toFXIpPQHI9MZHIV7OR/45DFiuK2c7smyuOhuOmCcfOMKTQ
         F9R2d8c9NbEIjiiy77zBwHpvU4QeeGrxEL43P2+DaJJ/uLr9DOpxIktNpjMp6EJZTCkV
         g0M6domHpcmfrO/01kGN2DbMSWmOO/43pX+u58zX1jEg8+/zQfrdCTSwh9QSkRkBlZKY
         sWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mZXtLRJ1sLRLotstAKroy3npU/6GDRFP6XheBXzm2RA=;
        b=BpjkdgB0N0K7Ujo8CkrirWzKDfvL7c4xqmf7n5gMh47zLxqeYiB1l8eVcMWe0vysK7
         DpClb6f6tMUC3h4OOWWAgC/p/puyQJK6IWoq1j33eZxL8y0v6b9OCwFO7ZgFvpibbyH9
         LJniwtabqTOH7aFwt3aKffOcz1/m9KcnpTt8JTmAsznnsYfbhofZr7ClxqXwO7mH4qrx
         EvML+xwJwcI1wGM5QNS3UZSK4vLvNup9VvzzSGnuuFIPLkBg/c4meXpF4/cG/cfeb9LM
         dBkhEnXQC/VR1P1ivE7Z/hfGsHQDDOkewKBV0bE5eFVWdtvVbcZvj8g83RABCSV9DHoU
         I2XA==
X-Gm-Message-State: AOAM532v1dOfhYTU7utLo6zQGWWcYtaWX2jx23VnVAGl/TTapd3vW6BB
        rZGVegssTctq4M9m5rcFhyuXvL7nW6KU0g==
X-Google-Smtp-Source: ABdhPJwoX0oeieGjxOJOWGbuUTxdxeuNokXz1I1NAFUUJ2WW5ZSfKHYH24PKy4Jov7qhC8PZ4tKaBA==
X-Received: by 2002:a17:906:1457:: with SMTP id q23mr551566ejc.43.1614220014077;
        Wed, 24 Feb 2021 18:26:54 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lj13sm2165889ejb.123.2021.02.24.18.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 18:26:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/10] diffcore-rename: extend cleanup_dir_rename_info()
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
 <87v9ag7uyx.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <87v9ag7uyx.fsf@evledraar.gmail.com>
Date:   Thu, 25 Feb 2021 03:26:52 +0100
Message-ID: <87sg5k7uhf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 25 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>     -		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
>     -		if (!reinitialize)
>     -			strmap_clear(&renames->dir_rename_count[i], 1);
>     +		partial_clear_dir_rename_count(&renames->dir_rename_count[i],
>     +					       !reinitialize);
>     +		free(&renames->dir_rename_count[i]);
>=20=20=20=20=20=20
>      		strmap_func(&renames->dir_renames[i], 0);
>      	}

That free() wasn't supposed to be in there, I was still experimenting
with whether partial_clear_dir_rename_count() should also free() this
itself.

But now that I notice I left that in there and in the meantime ran all
the tests, they all passed. So maybe this & the if/else in
diffcore_rename_extended() can lose its braces by just calling either
cleanup_dir_rename_info() or partial_clear_dir_rename_count(). I didn't
look in any detail, and if the free() v.s. FREE_AND_NULL() distinction
mattered here.
