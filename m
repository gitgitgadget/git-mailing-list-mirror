Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A47DC47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F93613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCCf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:35:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F368C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 19:33:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 76so4542397qkn.13
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49G0rWpxQ6tStJqjGrR0cGX+5N95n6Fstzkt2WUln0U=;
        b=Z6Mg2cXNK69QZXoS0Fi8QE8e02GDFZCtEDlTQlvjfV6n+KBlZw25SIHhdFCnuTPn++
         +4PEXYYRb+tcDVLbSA/lUST30+gaxWwdehJXktrRjoVKugq6DTB3zq7Ig+1YsefcVJ9n
         lX+I/aqsgB7QjeeRqSsx10ypxMQPzK84UgPdQturShOGGsItKtxosMjrKzkUaoln5K2I
         7UmDAKpUB5hsawRJaFf3QiL+4HUFildwauzE4DC5Vk697BrqOPOyPwyMzhZ/ltVqOmTQ
         x1VXNuOvPuSZnRSyYOqWHcztWUQYJ+E+2uhl9w4gozjPi/MAEVrdfzeDvvweh2+prPRO
         pWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49G0rWpxQ6tStJqjGrR0cGX+5N95n6Fstzkt2WUln0U=;
        b=OC0z/InVclrGMzsbokDppteBiCfmwJ5luloE4bHm/8WKLGXrp0zpdi5einyM2dvmfc
         ZvW31gCs2m08tdm30y63vlKQuKR5+rm7iGsL3qLaG0du4LersAZcaUiJ8h0mEQKJApi9
         a2pZmrGRgR1iMPMgpnS8kpnBbpAWc74HuucUYxApGmmDLRHEVoKVJebWBgd/+Tsnbjg4
         U2dPTXbe9G2Kbve8FzK4oNRqugLA62W3JOe4hyhYLHgaitxsFB+dQqeHtllSHvVajmxA
         M2u66l30qxVtr4b14+tQPwmCWvDPF1Jh3Vk4e7xB6RJpIinN8KAQCg0wKE9QvFSS6dU1
         +7jw==
X-Gm-Message-State: AOAM531piYUrEwhLXIp38RSLnOScAO63GIxvs82MgELDeu3Woh7/Fe3s
        MpwFSuWMpU/TFhzmcgmQW7BPlQ==
X-Google-Smtp-Source: ABdhPJz0SeAUL3JZYJEXEbiKGVZUoepNQWtYttMa3CVCKRWpkn/PjWmjmo2tsW7spE58nmC+Vt1UVQ==
X-Received: by 2002:a05:620a:787:: with SMTP id 7mr30358799qka.397.1622687611185;
        Wed, 02 Jun 2021 19:33:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id 144sm1108467qkk.103.2021.06.02.19.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:33:30 -0700 (PDT)
Date:   Wed, 2 Jun 2021 22:33:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?B?4oCTbm8t?= =?utf-8?Q?submodule?=
Message-ID: <YLg/dLqYFEqHZJUn@nand.local>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
 <YLfqiLbpPXWXHlBi@nand.local>
 <xmqq8s3r7oma.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s3r7oma.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 09:55:57AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In all honesty, though this seems like a niche request for ls-files to
> > fulfill, ls-files already has quite the collection of options, so I
> > wouldn't be sad to see it learn how to do this, too.
>
> I would be somewhat sad for two reasons.

Mmm, that's a convincing set of reasons to think that this is a bad
idea. (And I was sort of on the fence about it anyway by posting the
whole thing as a short diff instead of a polished patch).

> I wonder if the "attr" magic of the pathspec, that allows you to
> choose paths based on the attributes you set on them, is what the
> original requestor missed.

Maybe... but relying on the attr magic for this particular case would
force the requester to set that attribute on all submodules in their
project, and constantly keep that in-sync with their .gitmodules. So, it
certainly make it easier to handle a request like "I don't care about
ls-files telling me about any submodule(s) except these ones", but
perhaps at the expense of some extra bookkeeping.

I might be missing something, though.

Thanks,
Taylor
