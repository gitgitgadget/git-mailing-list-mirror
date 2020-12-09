Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B96BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0170023B98
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbgLIXDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbgLIXDh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 18:03:37 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3615C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 15:02:56 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id o25so3605889oie.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+Jnns6lfJhz8kCrvgZSlMlq+bFBloAf8U2jSg6iwbg=;
        b=ySfXzrzo4nY74nnsh64XZ8esDS6pyR8b0he+xap6z/dS3YjXTyrfhXVjlQeI/BMBUS
         0mi+kSEevsnQHdSHqXBYMwR1y9lpjeSr0EGOaCpubaMoTj16oFomPGV71osbMOnHaRpa
         1k3LxUJFvA0jS76MzefVli7gPI4VydEm4rqDmEynqNe/H1siERanxGJtX/1rQfECQKyX
         3C/o6j2Lfs7cbYzbWuEKPV7bU0pH+j1If0Nca4wdFTxKtR45tDir99ewus0ZYD+J34cF
         gEiwSWRI+Bs77b4TH3tyUVOWys96r5MWZZqnMPf/WJDv34oaH3ki+bqMF9lrI7JQqXD4
         BHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+Jnns6lfJhz8kCrvgZSlMlq+bFBloAf8U2jSg6iwbg=;
        b=NtrBxdPYcNK44unlrIWSbQKZ8uzA/XC6rtThxL6zYu68fPVjrs/i3L1E83yx47YKQU
         Xx6d0tgvIQDcUqqSZfYTeZ4GabvZWp/DJ/TJgZlEehHoqwls8ueE9FLooLhtMpbZaQZ5
         NB2oedLGAvXF8KGzKK6EQW88v5XSr2gmmBf1cmHcxtlo8/RRjAsQWgF9ZEPsy4rwJ/ze
         eGQwISJ7gwOitMyzmPCNhICHtPOJuWeV2lyXUpZ6rP90FFQdl6xiCaMUKTmi0euNmVGB
         QgnN89lI1N2VYkFoOP9ETr6luiAcMySkJZSDB3wgLuP9NvyuCzMmLbF2ZLjV/14OSRwH
         ihHg==
X-Gm-Message-State: AOAM531yPlyM/6CwAi4j1CwalRHOtUUqqYhjWTJe5pEtrrFgaK9Hzntq
        X6nzYl9btcYt6EoE+fK3kkmk9g==
X-Google-Smtp-Source: ABdhPJwKVafMVrfAiTkA8Qbd0W6OIVCU+xTPOdkQPKMkLNqQ0V/2KYohzPgQk+dqu2zXaTKUCTlW/w==
X-Received: by 2002:aca:a9c8:: with SMTP id s191mr3607149oie.11.1607554976116;
        Wed, 09 Dec 2020 15:02:56 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t203sm600104oib.34.2020.12.09.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:02:55 -0800 (PST)
Date:   Wed, 9 Dec 2020 18:02:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
Message-ID: <X9FXnWLFT/2v8acE@nand.local>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
 <CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com>
 <xmqqy2i738x1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2i738x1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 08:22:50PM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Dec 8, 2020 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> * en/diffcore-rename (2020-12-07) 5 commits
> >>  - diffcore-rename: simplify and accelerate register_rename_src()
> >>  - diffcore-rename: reduce jumpiness in progress counters
> >>  - diffcore-rename: rename num_create to num_targets
> >>  - diffcore-rename: remove unnecessary if-clause
> >>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
> >
> > Curious.  I submitted 7 patches for this series.
>
> Yeah, I wanted to leave the "hard-to-digest" one out, and queued the
> "relatively easy to review" ones.  Even then, I ran out of time to
> read these early 6 (and nobody else seems to have done so, either).

I reviewed all seven, and would be happy to see these merged up. The
first five were all pretty trivial to review, and the last two
definitely required more attention, but I couldn't spot any correctness
issues with them.

It might not hurt to get another set of eyes on 6/7 and 7/7, so if you
just want to take the first 1-5/7 for now, that'd be fine with me, too.

Thanks,
Taylor
