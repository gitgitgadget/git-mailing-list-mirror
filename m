Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB16C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1D22583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLDGPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:15:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A96BC061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:15:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s8so4149431wrw.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iCTYe3HgUkMvf+lBnQu7MNHtpsWRZwGlowTRrncSdE=;
        b=ZnK+MY/YcPTbTOZoA4uc0E22THSujGy11G8LO9oCM0fqN0U3VRcyEwtILEFRnAbEUS
         mZokQauFCiZSZrQE+iKAS9jbanaCBgI9SE5GXG+98XKCNLkx5mzbFW8ZZ0yG0QXTR+8D
         P/NcuKLDSrxfHh6OaOiUXZQiVD5AOdqZaPHMFKI690W0+Q5hm3z31PXGnKFn95L51lhV
         a+PV9vsC8VqH8rL2UGFK+/A8O5/6bmn0A3xPdAHLj2pxpWqlABIT3uvN6mS7vIy4PYkG
         +zcAjABa/LzNB2IbiW4bXoUkpigWojKJJHS8Hl2k+0LD5Zv8j4UWEtypdMtCkw8wJ7IF
         jfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iCTYe3HgUkMvf+lBnQu7MNHtpsWRZwGlowTRrncSdE=;
        b=NMgDr403w+6cDXQ/YNEQzOW7ymcYTx0oQUUK15Rrco2pyd13pWx9X2FTCEmU5KRAZ1
         czYJ65qFclOZzqYFhImqOGAbPLyC8vaV/AZowEcU2/u1lNy5NWGrT072FucmM1x7ZEGr
         ygTJN8E/KZsMJg7P86YY5cev9PKF9TYLDwQFwpKinJNYrcdG1+EqbzJfpJE5MRlIbkwP
         +JC0KKS/YE268fWZqkCw5Qtf6NAW5uJj2Uyp4FY8W65X50XGy5AvG6tWWUA9HW8DQLX2
         jhDTUfsO8a9+hsPSUlvIpc+fM2kkG5G/5P4xZoczK3PbtdG9Ve+EQoOsl7/In1RopF2Q
         07Tg==
X-Gm-Message-State: AOAM532o2EZkJ2Va8ePQVOWvlit88DSO6tMlvYDDOcqry8b747mdkyUI
        rdES0GhlPcAif6RFFXCP1G5weW5FPO9a2h3Tikvt+bvprFk=
X-Google-Smtp-Source: ABdhPJyTfZJ8DVVtMJiMn3swhrVHsmtYnlsfTmciNXJzaZmUyUonNgPyaeaQ65y3K359Y1KD9Sk2XaHFkTagf0PjTCM=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr2972110wrv.255.1607062502120;
 Thu, 03 Dec 2020 22:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20201204055727.1165204-1-felipe.contreras@gmail.com> <CAMP44s35yk=0jCzd92s0Y5KEnmrJAKxnDDWsW3M8rT8wXEVEZA@mail.gmail.com>
In-Reply-To: <CAMP44s35yk=0jCzd92s0Y5KEnmrJAKxnDDWsW3M8rT8wXEVEZA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 00:14:51 -0600
Message-ID: <CAMP44s1pAmFzwpUzR6fzqAw3UFqz=o0WA-gYwbHuMDc=Sy3u9g@mail.gmail.com>
Subject: Re: [PATCH 00/14] pull: default warning improvements
To:     Git <git@vger.kernel.org>
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 12:02 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> And of course the addresses of Elijah Newren and John Keeping were
> formatted wrong.
>
> Please reply to this message, and not the original.

Nevermind. Apparently the mailing list software dropped the entire
series, so please disregard it.

I'm resending.

-- 
Felipe Contreras
