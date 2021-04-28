Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4CC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53D861448
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhD2AJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhD2AJL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:09:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF4C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:08:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so76312025edu.10
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UoInKQh70TSWe8xX+mCa33zY8wufo9JOGy4EN4jQ1uQ=;
        b=u1KvXWD0DDiE+5TzLqfXAyD+a5wDfNQIZsb2dbLqG/AdoOKLk0G1CyVHr4rV8gZb5m
         6AF2qQ2NKvd28wYvRcGX9+XOz5iBUELNNrNd2WDs0MZGkvZHQX6Vkb/uJ+l907LlA/Ut
         oVxgZ9nToNmMxvrdkCTPEOY3sI6/am6AK/lTVZiobYY3XxAvRddeYcE119kYNNbUcg0m
         ISymGZhJtEn2+PyERxSNIDoG7ziS7WNR4YJtJLQU5Bla7HLgHr4gPKVe7XPTsLoe7TR+
         GNlMtsQDbpEll+n1PmQErViVKLb5W+XtCk2bkDOeTKkcAraKVeD6BJoaHxCemcKULvyo
         7kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UoInKQh70TSWe8xX+mCa33zY8wufo9JOGy4EN4jQ1uQ=;
        b=RE43xR+bu9qfVxwclSjx3hnO3IW2+HOiNWeLCyXwYOy1pRX+WPzRHeMcxBG4EbLSxY
         O1/fbeyBuOyubKBI8fWiBB2OorfHJLPh1YaXzGeXdNNylAixyU8I0XdqQkhBGsB61jJN
         AISC70CUJ4DtpSkr/bK9ZUd65nw10dO3vQ9NxjH3nDfU8qdLnsntfug+yoPMss53MHmd
         AEYgMDVlIYbh3rlgD3vJiuTKEISGn1tv/33BKM+SMmtDbibQrRNMK0XLwIU9dGsAJ6Lz
         q6eW0XUbbHdUpCF7WYDUFN9HvzrTtWBQX6lO8jvwl01nemN21LVdG2I1pL5OSRcaPYa8
         c2PA==
X-Gm-Message-State: AOAM5308ytfpJvIAbxobOPBHPZ41Gvz6sQlpzuedODu5TEN70grAnNUR
        SS712XOUsKVRpfoFELTFhbQ=
X-Google-Smtp-Source: ABdhPJyP0LjepU2WBwSv1TXW/XOjG2GRcVcZTfqUXLLp20rvzDm18mGGB/L4UPLJsmCDkCQ7Tgzxlw==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr14852316ede.271.1619654904054;
        Wed, 28 Apr 2021 17:08:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n17sm999157eds.72.2021.04.28.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:08:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Nesting topics within other threads (was: [PATCH]
 repo-settings.c: simplify the setup)
Date:   Thu, 29 Apr 2021 01:01:28 +0200
References: <87k0omzv3h.fsf@evledraar.gmail.com>
 <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
 <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
Message-ID: <87eeeuymtl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 28 2021, Derrick Stolee wrote:

> On 4/28/2021 12:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Simplify the setup code in repo-settings.c in various ways, making the
>> code shorter, easier to read, and requiring fewer hacks to do the same
>> thing as it did before:
>
> This patch is interesting, and I'll review it when I have some more
> time. Probably tomorrow.
>
> But I thought that I would point out that this pattern of adding a
> patch within the thread of a larger series makes it very difficult
> to separate the two. I use an email client that groups messages by
> thread in order to help parse meaningful discussion from the list
> which otherwise looks like a fire hose of noise. Now, this patch is
> linked to the FS Monitor thread and feedback to either will trigger
> the thread as having unread messages.
>
> I find it very difficult to track multiple patch series that are
> being juggled in the same thread. It is mentally taxing enough that
> I have avoided reviewing code presented this way to save myself the
> effort of tracking which patches go with what topic in what order.
>
> Since I've committed to reviewing the FS Monitor code, I'd prefer if
> this patch (or maybe its v2, since this is here already) be sent as
> a top-level message so it can be discussed independently.

As a practical matter I think any effort I make to accommodate your
request will be dwarfed by your own starting of a sub-thread on
E-Mail/MUA nuances :)

When [1] was brought up the other day (showing that I'm probably not the
best person to ask about on-list In-Reply-To semantics) I was surprised
to find that we don't have much (if any) explicit documentation about
In-Reply-To best practices. There's a passing mention in
Documentation/MyFirstContribution.txt, but as far as I can tell from a
cursory glance that's it.

Personally I draw the line at "this random unrelated thing occurred to
me while reading X" v.s. "this is directly in reply to X".

Reading the upthread I don't really see a good point at which to start
breaking the reply chain and not make things harder for others reading
along with clients that aren't yours (which, looking at your headers
seems to be Thunderbird 78).

I.e. the one feedback on the patch idea is your upthread "waiting until
such a change". With threading you can see the context, but without
you'd need to get it via some not-MUA side-channel (presumably
lore.kernel.org link). Sending a v2 (if any) without threading would
break the chain again.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103191540330.57@tvgsbejva=
qbjf.bet/
