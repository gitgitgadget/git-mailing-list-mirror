Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D13C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439726113E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhIIKYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIKYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:24:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD7C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 03:23:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x11so2619324ejv.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5J4FhOYb4udJ6PXal4gWl7+ajlXWhLMVc3tpq1bPCzk=;
        b=iZY3fxskF4qbFP+AY9uV5BWR8lJ2NbVEi5TW4EaK36n+npuSophsj19mLM8cFz0yJ/
         9MRJgsXnOW+3rja9XD2rH7OOWcV3aAt716oK4/fGoXCewNbWrPW1CsG23D3rFsnLQARd
         wljGkGEkb+c8WBbBOb2hNRbTGebkHGGfkERq7AwOmwOtv+QQzGnehAvT5h5LMzNTHdjN
         TCKkexR+R9pl3Ydf/1/lDhpxW3A3JbVky+IWASVJEozxAR18PZbyaVdE3KIuWVGfszHB
         V6dGi2xlSsO8yRQzigAph/wXtlRV69ztrgTVAIY1GKLBIQ6YlzkUplDRs6bWOQrtW485
         X8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5J4FhOYb4udJ6PXal4gWl7+ajlXWhLMVc3tpq1bPCzk=;
        b=mnWHk8+y6MAUtKxvlGqRz75bkcgM6eDvEJTkX2levSxEhUH7on5pBk0rowr5aCQkXL
         rn1hWkIyfR6yFcwG9+pHVS0xwXoDz2RIoftHmit4hzUzFxg7jm3jQ+TVoNybAc/Pvkel
         plWYLLwljUWWt2D5dUyLaKGua2e+r0X3w8wmoQzm5H2heka8wS5MLjRcWOuryyWBjM5t
         ZTKJj4r1/jr0DTuyHLSNtt8VHA5S6Cp9I33UAJ7OpA8wqNpM0klx0U3XGLnzOo3xR841
         eB4Qk0UZBpLqie7ZVTK1XH5vdPWPsvSX+zdo+YV5bYZwCBOjkPcDWaIk/7fxvw9xPcsX
         8m4g==
X-Gm-Message-State: AOAM533byGDvhQYFV30A5PfqbzGS2LY4qrk1JdHOYTy2PZ0aBSFsiKvw
        4rHcGqi7gWwFPAeQF3nGNNxZGaGnPiwovw==
X-Google-Smtp-Source: ABdhPJw2132dIRY3mUSvWcX0C4bscjPpXWbmTkC7oQAnlkokNynJ8vV6nut/31UIp2HWjZ+UwjmZJg==
X-Received: by 2002:a17:906:7b54:: with SMTP id n20mr2498652ejo.525.1631182987473;
        Thu, 09 Sep 2021 03:23:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm700371ejv.64.2021.09.09.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:23:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/15] [RFC] Upstreaming the Scalar command
Date:   Thu, 09 Sep 2021 12:14:57 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
Message-ID: <87r1dydp4m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Johannes Schindelin via GitGitGadget wrote:

> Changes since v2:
>
>  * Adjusted the description of the list command in the manual page , as
>    suggested by Bagas.
>  * Addressed two style nits in cmd_run().
>  * The documentation of git reconfigure -a was improved.
>
> Changes since v1:
>
>  * A couple typos were fixed
>  * The code parsing the output of ls-remote was made more readable
>  * The indentation used in scalar.txt now consistently uses tabs
>  * We no longer hard-code core.bare = false when registering with Scalar

In the summary I had on v1->v2 points 1-3 are for v2->v3, respectively,
outstanding, addressed, outstanding:

    https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/

In addition the discussion ending here:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgsbejvaqbjf.bet/

For that point: I think it's fair enough not to properly handle the
cleanup case in "scalar clone", but perhaps add a note in the commit
message that unlike "git clone" this is known not to clean after itself
properly on ctrl+c?
