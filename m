Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DE9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442207AbiDUVvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442176AbiDUVvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:51:23 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225E4B41B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:48:31 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id bo5so6187440pfb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgnwR2bgrzNuEcxpD0HOQUAc1ck9OcV/bCjHq5QIBwM=;
        b=L+1yTo6O43RIlJx47bn3BRfCYaznlhwHo0j8/kBY+dpm21ltxe+Ds9W5DEkU6xZD5C
         cIRj00FTS4j/hgFQUkNXCcufuusTUx3FbNG1PTHVlQnt/BiTidGmccu/ceor39FS8gtf
         d7cGP+lwzC6iIv68znIXk05/N6LZvppuJxFLjdt9V13vqahYF8eaBvklmJwo3lz7Hj6N
         50/alsMto/NP7koHhm7gTheVR1rE9f++cjyAxd+ltfWvqPgMk3FjBKY241jMjhHENAyk
         p7idpj9x7x/u2nYyw7s7A6f5qsKK6mUJS8aBAlh/t1EaYhH9vOJW/pi2EYImnpKJhfbQ
         iz9g==
X-Gm-Message-State: AOAM533d9thGG/XxJuD1B3ssSa9j9l4iJ/PovbRuSIJRay3Ulr1Wo8/C
        D3UYTkxS6Im7XeZdB7bOwiH+/nYAgNwt6vZtmMM=
X-Google-Smtp-Source: ABdhPJysm2rdf18tY8Dlp2+9gZ2cWUkJ4JVcdeWGZuySfN1J2kcP0WFjijOnp73z+J0iEmw4o2qfmLM0/Kd0RY16H2w=
X-Received: by 2002:a05:6a00:1824:b0:50c:e939:118a with SMTP id
 y36-20020a056a00182400b0050ce939118amr904128pfa.15.1650577711080; Thu, 21 Apr
 2022 14:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
 <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com> <xmqqo80uf9jn.fsf@gitster.g>
 <220421.86pmla5eja.gmgdl@evledraar.gmail.com> <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
 <xmqq7d7if76u.fsf@gitster.g>
In-Reply-To: <xmqq7d7if76u.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Apr 2022 17:48:20 -0400
Message-ID: <CAPig+cSMJJem_1t0rVwjbU9SsQfBpmbE2Yn6wZeNsY=h-1MAkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 5:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Any of
> > the following would likely be less confusing (in no particular order
> > of preference):
> >
> >     * sed -i .bak -e '...' "$path"
> >     * rename dance
> >     * perl -pi -e ...
>
> That order happens to match my preference, but if the first one
> comes with a comment to dissuade readers to copy-and-paste the
> construct to other places in our code, that would be even better.

Bikeshedding: I think I would prefer the rename-dance over a lengthy
comment meant to dissuade people from copying this non-portable usage,
especially since people often fail to read comments. The rename-dance
idiom, on the other hand, can be cargo-culted without harm.
