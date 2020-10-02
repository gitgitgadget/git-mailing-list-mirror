Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA3C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A08420754
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyCCDVBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJBU6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgJBU6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:58:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B3C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 13:58:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g9so1090501pgh.8
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jHTZ/NlKlfAVCOW/gsxFkeKWGARDtGUnN4ug+JGXPT8=;
        b=eyCCDVBOwwgTlblWITwCS6RoeUV7iMLfOuiER29GUfrkSmW4QeREHk1kxB+PySdWm/
         M+rNBnOOJSogEAEeU7Heen+A8P9sMeNk6qLiLOGBCr6u6k9YID36k1Z6m2omWLRveC+H
         SieC+O4YqiM9/CD85y85VsB7Nh5vSvSqQvjuZ7l2wAjKAWv0d+lfgDCBZGaEitAI0FIA
         1E0/M4vbhuORLqXCYR7unK2a5Vj1+zsJ11bCFXRESIMCtYj07SflEP17UHf8+6C6rAgN
         P3/CRtYI+5nm1JFB3HzOlQLfiS4oPylZl5y5E7AVaAm5rStGIKcVzzAyVA2MM5DzotS5
         2YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHTZ/NlKlfAVCOW/gsxFkeKWGARDtGUnN4ug+JGXPT8=;
        b=embZcKldtSgYylVFrHdn7xYI5rKGOPWSSVHzYCOmFPaJWGp+goTIM2DuinxWEcJBOP
         WWn0zM3trgekAdRtJduQ9eux8CpZFFg+LSPZPslBSC6PQY2kFzdNoQ9xVg7qLhLxvth8
         StCbCeH5CNOBcttwlCaLIWdzd2gKz2PNJ2DaZb7nntSqbdxv/pAA2RYT7gYvFLg+4FZA
         zWkyettGXXNZx6bIjQhtWT34sAPc4S11ts3i7xQPaqFfO2B3QS/vpThNfD+D5JoGvyCm
         cGQurqLcW1bxwoPGPWRg7nvy5SYICXQP8WEM2mlOn9eIiWUltKDiHAjJXTAfugFKlFC3
         SyDw==
X-Gm-Message-State: AOAM530hVP+ATdQmNMiGlgMzRaBbR90yqNXHSh5MJEWWzfzR8LO3o1dD
        ixNGezoybPg4OgBU4HaFxJs=
X-Google-Smtp-Source: ABdhPJyIZd+Xc+bCjUYUm2nlbVkGo1bKlJNfK16Y6ypqR9BNE+4zf9LSC7dVYdaQzZN6+b2wvJMYUA==
X-Received: by 2002:a63:3193:: with SMTP id x141mr3736483pgx.254.1601672316462;
        Fri, 02 Oct 2020 13:58:36 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id j26sm2922163pfa.160.2020.10.02.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 13:58:35 -0700 (PDT)
Date:   Sat, 3 Oct 2020 02:28:30 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20201002205830.GD78209@mail.clickyotomy.dev>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
 <20201002150710.GA54370@mail.clickyotomy.dev>
 <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
 <20201002193906.GA78209@mail.clickyotomy.dev>
 <xmqqmu148jxu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmu148jxu.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 10/02/2020 13:14, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> > Noted; even though "get_reachable_subset()" and "in_merge_bases_many()"
> > (after the commit-graph fix) return the same result, I suppose the
> > latter was designed for this specific use-case.
> 
> Yes, in_merge_bases_many() was invented first in 4c4b27e8 (commit.c:
> add in_merge_bases_many(), 2013-03-04) for this exact use case.  For
> use cases where callers have multiple "these may be ancestors"
> candidates, instead of having to iterate over them and calling
> in_merge_bases_many() multiple times, get_reachable_subset() was
> added much later at fcb2c076 (commit-reach: implement
> get_reachable_subset, 2018-11-02).

Got it. Thanks for the detailed explanation and reference.
 
> > OK. Shall I update the next set by reverting the "disable commit-graph"
> > change, s/list/array/ and leaving the rest as is -- if we decide to go
> > forward with "in_merge_bases_many()", that is?
> 
> Yes, that would be the ideal endgame.  What I pushed out to 'seen'
> has the removal of "disable" bit as a SQUASH??? commit at the tip,
> but not s/list/array renaming.
> 
> Thanks.

Alright, I will add those changes in the next set. Also, I saw in the
other thread that you tested commit-graph fix on this series and the
tests are passing -- thanks for checking.
-- 
Srinidhi Kaushik
