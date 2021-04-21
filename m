Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5CC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2EF61436
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhDUHsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhDUHsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:48:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55460C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:48:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so62137640ejc.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nJFywM9C1DB7Hz36TqvlJ3BAXorRv8aavBzl2yR/2z8=;
        b=HfOd1NMRPe3rnaA1MTqj8hCG8UxM8TkqcGySPCiEZAtmaS0kiIeEtNbmk+X6kIzvdu
         khg5eygfwKjgxX6ArzX+Dx7+0WK/1Lu4bYxW6CHNR/iLDSjON7pbAQie36pc/KuI9IWq
         NWGchaOHMxQXFMDwTVKCCRzrtpsAHd0CdsNKPl2rCymMaGW5cJTL2brQBMUVct/1v8Tv
         IUxnM4LBhapyHHyRo8Xc5IQL7R7hCffAu9n2kah4Y89mPqji158yVYHxfhUDNLZZWi2/
         2kk7r5nwZRwvGrRTj8zmL6prgtQhCJCOgitgqcxv6xqUGYaKv5DvvUaZYZ0fAHlZFOkZ
         G/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nJFywM9C1DB7Hz36TqvlJ3BAXorRv8aavBzl2yR/2z8=;
        b=dpgbQU8KmLHtoyZ7Mdm/fcyX3ZpgOlQgDuYUBXpOd99nk+xN+YKDIP1wRGewPDQrJ2
         UENSul0IvR+DreARrKhIAoiIlGuLxq8D4GGpbLOeWYkB46t3V5Tqm+rJd/OAQMRxS6L4
         fLspSYTuayE+0wQa7Su7TzY3CS6xid1jdVpnMkvBztHd1U9tI3vtD/U8vLiq5kj268GM
         aDDbR4Tz/5R0WPKjbojrQxzUjAQgefdX43FLjIlrQPCtIiQvm2T4CD1xWlbXeBABWg0z
         mzDmUDI0izmUwXCpEydS9s1Ya/gj+ZTcfR0xXBGZUG3p+qM5ptZbgDWHbeC1yu0apfqy
         9KBA==
X-Gm-Message-State: AOAM530dgQvcnCwx/dPCD1Y1WCKjokUNmsinI1QF7QJJxk1BOoDSkhuy
        1dFSrghoBuDSUX5VqWT7VeyUrpyYSyjM+Q==
X-Google-Smtp-Source: ABdhPJxB7var1CxjFAjO9KA474UOTsj1iSsJbHP9Uh7UCKLgme2Lv0YTzg84GZS+XZXvpXB0+NU2BQ==
X-Received: by 2002:a17:906:90d4:: with SMTP id v20mr31537998ejw.275.1618991283790;
        Wed, 21 Apr 2021 00:48:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t17sm2079866edv.3.2021.04.21.00.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:48:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v7 06/28] reftable: add LICENSE
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
 <8a960fb77fa9117009119ce37aaa9885749bd1a5.1618832277.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <8a960fb77fa9117009119ce37aaa9885749bd1a5.1618832277.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:48:02 +0200
Message-ID: <875z0g3wp9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> TODO: relicense?

So, still no resolution to the questions in v6 in [1]?

1. https://lore.kernel.org/git/87o8ei2tfo.fsf@evledraar.gmail.com/
