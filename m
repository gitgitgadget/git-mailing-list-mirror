Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31428C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D682610F9
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhJNXk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhJNXk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:40:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD3C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:38:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e3so22955498wrc.11
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3ydWDH9RoC7A7VMY2mR4jq5yV9QdscdKWQTDXRvVqCA=;
        b=ASiWRRGJ6S6gZHovygG1+rJC3B9845l8wtD9kfyWmVaYEnMZNHPqxCxd/moZFuip3/
         +GMSCN+XMZoIlMfWFXJnxwVLMnLBrnEsNIw43LPHH5weMab9kyJOqtwamf4PMYQei3b5
         xImVVK357SabSXDSB5/ZXvpTgPhPZVVk2jWQECHNcK5RkrpbKtIgi1W8+dIfQEC5KRfQ
         C/PIb0068QfJZJQMzO/L+xU3obvrXEvjpgJGu012n2DTeAvkYW7xv28qsCa5N9CCPC+M
         IC4VR9egH83+/VMeXHAT3ibM1gfz/FIRUQgByTnJlsexWuVfdXTYPQe2h8pZsV2O1ZVL
         zJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3ydWDH9RoC7A7VMY2mR4jq5yV9QdscdKWQTDXRvVqCA=;
        b=bOfbY8e619WndRRvRT92r5+C0rfWwzNhL9e8LKXP7iCFvAvLtY/Tr6RvCb6Ce4vF3c
         kDxgyYg5HSqHJ0oghBDq0GBOSS9WiytZMx5l/z+M2HjBhvRkRGuGaZt1A08k96DGBiBS
         pQMVW7s9lY3uX0qXvphIS9/hcsxrjGBMLbsDEJCH2Ao46cvWMSsh6grfRKhB/Qjl8msw
         2264zEHyvry0qByXeMylpRdMW1sqYrRLDnMqJPLS0o7xLnGF/i6x8FeW5IttKA5FP+lm
         ykf9AYeiCO3QiVTDpRLTcjX0/yKov5ykJL+zYYd/poq3DI1MFaMWHapZRWmZWg9xsyMw
         yyaA==
X-Gm-Message-State: AOAM531sPe0ovgsSCJJSmCRB0yBUEasHZkcLK3Z9FvSUKOYMz+/3zqfd
        dAOxdUP51Gq/ZvP4OxtZEsc=
X-Google-Smtp-Source: ABdhPJxGZxYnmN7NDZ+uReRyTAkAJFBH4PVDqRixHoUsshru0SjbHeJAhrFiqycfkt6Hy7EhJGE5XA==
X-Received: by 2002:adf:aad0:: with SMTP id i16mr10497357wrc.128.1634254729113;
        Thu, 14 Oct 2021 16:38:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i13sm2934848wmq.41.2021.10.14.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:38:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Date:   Fri, 15 Oct 2021 01:38:02 +0200
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
 <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
 <87pms8hq4s.fsf@evledraar.gmail.com>
 <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com>
 <kl6l7def1c4h.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <kl6l7def1c4h.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <87ilxzfa7s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Glen Choo wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
>>>> The commit-graph should be disabled if replace-objects are enabled. If
>>>> there is a bug being introduced here it is because the commit-graph is
>>>> being checked during fsck even though it would never be read when the
>>>> replace-objects exist.
>>>>
>>>> Thanks,
>>>> -Stolee
>>> 
>>> Thanks, isn't the obvious fix for this to extend your d6538246d3d
>>> (commit-graph: not compatible with replace objects, 2018-08-20) to do
>>> "read_replace_refs = 0;" in graph_verify()? That works for me on this
>>> case.
>>
>> Ignoring the replace refs while verifying will allow you to verify the
>> on-disk commit-graph file without issue.
>
> It seems like we've converged on doing read_replace_refs = 0 \o/
>
> If we are going to do this twice in graph_verify() and graph_write(), is
> there any reason why I shouldn't just do "read_replace_refs = 0" once in
> cmd_commit_graph()? IOW any time we do anything with commit-graphs, we
> should just ignore replace refs because they're incompatible.

No reason, I think that's the best way to do this.

I've submitted a series to fix that verify issue, as noted in the CL
these patches on top of it without that disabling of the mktag tests
will pass with GIT_TEST_COMMIT_GRAPH=true):
https://lore.kernel.org/git/cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com
