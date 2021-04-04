Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6776BC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3094761368
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhDDEb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhDDEb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 00:31:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC81C061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 21:31:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so168860wrs.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZUq1VZINunEA+YEUH2l+WVo44o/iWDwY5fbWguSv1H0=;
        b=kHY4N0BJFpfDEas84dZi0APOfNyty8VY1S2yD7mxK2nV6mhyc4kWxvzPh+cmDUbvQq
         kynAO8MeHWawHQH1vZqUgNI71p4SSiLPf7It1+BD3oSQHmpUQNFuRTWd0ru1etXJFO0R
         ncMmlgAgbqixoajQjmk7u1J4z8jJDIORyVu6CCZ8D8gDdjchkB3junPtg3D3gjMHCls+
         RzgY1XKCyno8Z7VTI3E/TdicHNUdmKUMKW5mQmMNcr9v9WusgkvZUcTEEICW6wvrxOyW
         LGLKcavRNRVBQl+gX7ofUmVbgO6UC4N3Z5Ja3uA7Wr1WbKXyhkE1260FO8zkSpMmvnc8
         6sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZUq1VZINunEA+YEUH2l+WVo44o/iWDwY5fbWguSv1H0=;
        b=EyDIMc8CWgLFGtBSCW30kTiSJYeIuy2SiQ0FdZpfMXt+TIXV/7yxrg8hq95b3U61TX
         ea/eI2c36iRrxdxsqeqADEXPr7TGmkEfd4oWvRB9j5X10QfC3bER2Fq/CABHwhSVKNXD
         EQtYN7HrLVs0FjxOPwp2bF/KnM+GBLCl2v6EjCqsAGM9KyFX8yTGTVmMXFCPdr4rPIh4
         KCCzoY0udArZafAin5IwEc0QFhxPeXHWxLzaPUBSTepfXDBTxFHtEzgNfYy+i2NrUFE3
         q5tRsHstO2TvRP+H6AJSQrY5tvjICnBSrp/Q7Y3Yl+kwt3xhpJmxJyxW9Eu7yBjP9tlU
         cQEQ==
X-Gm-Message-State: AOAM533jJUzoMB8ykwZIioP+an1xTl/CI0vXA6FHcvYjHDlhashoCqcX
        +dPaaOhgmqW2lNvbkwaIVX4=
X-Google-Smtp-Source: ABdhPJxnVtYQFC3XhFaDtVk1ZUI2WPLrRUqM93Inntsrx0kUQtXViyXeBcObQjHs6q2G8I5pE9D4Aw==
X-Received: by 2002:adf:f005:: with SMTP id j5mr22358217wro.423.1617510681889;
        Sat, 03 Apr 2021 21:31:21 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200d5df61eebbad8b22.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:d5df:61ee:bbad:8b22])
        by smtp.gmail.com with ESMTPSA id 61sm10814984wrn.25.2021.04.03.21.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 21:31:21 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/1] user-manual.txt: assign preface an id and a title
In-Reply-To: <20210404040739.2671960-1-firminmartin24@gmail.com>
References: <20210402121303.344914-1-firminmartin24@gmail.com>
 <20210404040739.2671960-1-firminmartin24@gmail.com>
Date:   Sun, 04 Apr 2021 06:31:14 +0200
Message-ID: <875z12isbx.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first line of the cover-letter has been eaten because I forgot to
leave an empty line... I wanted to thank Junio and Bagas for their
reviews. I hope I didn't miss anything important.

Thanks,

Firmin

Firmin Martin <firminmartin24@gmail.com> writes:

> I found a more satisfying way to keep the change minimal: it turns out that
> [preface] does exactly what we want. It just adds the missing id and the title.
> No renumbering, etc.
>
> See https://docs.asciidoctor.org/asciidoc/latest/sections/preface/
>
> I attached the diff of user-manual.xml, user-manual.texi, git.info,
> user-manual.html (using html2markdown) and user-manual.pdf (using
> pdftotext) in the commit message which I also reworded and shortened.
>
> Firmin Martin (1):
>   user-manual.txt: assign preface an id and a title
>
>  Documentation/user-manual.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> -- 
> 2.31.1.133.g84d06cdc06
