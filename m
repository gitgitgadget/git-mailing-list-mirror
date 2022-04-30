Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DA1C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383087AbiD3Qf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 12:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiD3Qf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 12:35:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1EF18348
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 09:32:35 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a76so469075qkg.12
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4xxPvi0LvwK05ckLhI2MPOpc+tqR5gBkbvJjFvYe0Vo=;
        b=BzL3fx/IFux26UhfOHu/mPMfJJ2MfLYR8epNr05lK8XGQJyomkJXHKpqPB9ku+sfFq
         1B77Nb5J4aDiuIxkrPtm7A+a8ceLmwpOJyHadKB2hLsVDD226UUpaAfQqbrUb6bZwAzB
         Cy9RV2wBlPD022NHXqJ6HZ4eqVVVv/qeZcUX49tt46NVpWf4cuVgPJfeRpZBT+3G61eq
         BQWC3iu+jBgvOwfF5mdht4UAxmxZZa5BPEt0fxO/m/ohQO+oKDyANdPyw4BSnZKeqUFb
         HfItJ+lQg9wq5d2zLM1m9SoKzEZ9YyCHycUZ16IlebFd1d/GDmu99Pj+vqRapZJIQ5Wz
         PlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4xxPvi0LvwK05ckLhI2MPOpc+tqR5gBkbvJjFvYe0Vo=;
        b=hEbXCnR0QwTUatnJYLeKpje6zkI2k3pGVkyrjEdVpQRMs8HTVwwVG/PgCgeak9hDoh
         g2Rawq9IRwsHp+AtdEJas7vwlBOC0IYVfDNjcdrZ94DwsVTJHXUxU9011I2tBVFiB1ZZ
         TQEzX9dLcDy+NXWkPbRz5RHJy4v+9gNDFnjFf3aZm0UMTJxaarpAjYnENHwj8exYWgEC
         Wj9OJlMNhi2yWXPWqY9+UCSUWAW97D/69qNSKDrhsGEzt1W1eTGsjKKw7wmKiYq3Aapg
         9oVrs3xpjeuy4tDDxas1cogBg7ejlbxinncfGj0IH9fKE6OCyMR3lxmhOABaeutWtiE4
         yNxA==
X-Gm-Message-State: AOAM533yNcxmWexi1lBSCknAyjFwrgNRcGPHg/RqK1JtxsfzLquSQHP0
        3jAB/yAANgtLYRi6A5xgk7E=
X-Google-Smtp-Source: ABdhPJwYwpeOMLYeuYuiZpMDSmyEaVfdCPBk7ex9Rd6XlQ7pDzWuVhO1DLX+UXGZq1vxD9J374oTcA==
X-Received: by 2002:a37:54c4:0:b0:67e:9cbf:a984 with SMTP id i187-20020a3754c4000000b0067e9cbfa984mr3412739qkb.215.1651336354194;
        Sat, 30 Apr 2022 09:32:34 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 74-20020a370b4d000000b0069fc13ce22asm1400445qkl.91.2022.04.30.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:32:33 -0700 (PDT)
Date:   Sat, 30 Apr 2022 09:32:32 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Daniel Li <dan@danielyli.com>, git@vger.kernel.org
Subject: Re: [PATCH] 2.36 format-patch regression fix
Message-ID: <20220430163232.ytvwru4fnylow2jk@carlos-mbp.lan>
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
 <xmqqzgk388tt.fsf@gitster.g>
 <xmqqo80j87g0.fsf_-_@gitster.g>
 <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2022 at 12:32:44PM +0200, René Scharfe wrote:
> e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
> way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
> have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
> that mechanism mandatory.
> 
> git format-patch only sets no_free when --output is given, causing it to
> forget pathspecs after the first commit.  Set no_free unconditionally
> instead.

I remember when I saw the first commit long ago, and thought; well that is
very round about way to reintroduce the UNLEAK removal that might have made
it visible.

Haven't looked too closely, but considering that we were warned[1] the
interface was hard to use and might cause problems later and it did.

wouldn't it a better and more secure solution to UNLEAK and remove all this
code, at least until it could be refactored cleanly, of course?

Carlo

[1] https://lore.kernel.org/git/YCUFNVj7qlt9wzlX@coredump.intra.peff.net/
