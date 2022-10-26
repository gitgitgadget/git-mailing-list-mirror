Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464E9FA3742
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiJZTnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiJZTmq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C6F6C0E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:42:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z3so2260342iof.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+LrwhBDQ0hRjcCVSdgAPm27sY9aFsCAJFVd6hHAi60=;
        b=JEi0hVMv/i959UJY5GwoYeaCuotCr5M3wtYX7HmmDahRyRTbo22PqNEmOMzTD1B1eG
         2/AS1SoUsvCWPtDegOp0udAxNH8RppczheC/2FZE6N2n1VoIgeF42yu30CA6o75OuXbU
         iXGw+nCU521hDOO3k2yysVENfLH4ePRxm8LqkfBFw3p1kPAvMSbbbpKTXSW68kmFTPL2
         1MS14lp7SZsTjw0YbG/lnSFfO308m2k7caJLpODMdZn2WUNmpIPx0L+mxgVJj53YpvJV
         Is1+vWGrc0j8LbEYkgSyoA0X5wKMGwUHSf17bL3cx3pU9TkmPcyOFK9ymyHSlxej4h2q
         5+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+LrwhBDQ0hRjcCVSdgAPm27sY9aFsCAJFVd6hHAi60=;
        b=w+gQR9gHAoxHDAlt7sd/UlwoUBLR4bENVNtLnAmJeGyKmIIYXlySCWTDguP33eX3y8
         T96Oq4Zu2g6s83w9iPjmG4VHebZ0VTIm8EpycOdawPxuZu3YpqsSFHYU1jU6ctt/4aIa
         j8n5K0gjEae4tKOHMcYT/KO0Hw9rBT0GmCpxmTlFVhCbV5jucZzfRg+ZAJewWjSPR2IT
         mi/o8ATGgCAfpiMe/m+jbOq1ryr4GivCwzzEc0hzY78vLPAeLnfdYc346dBSV6/Suw21
         u6637ofiy9adeawChhrQrM5VvWrS91yhaICpk4SUN261O91Rn9EO+6JsXAjVRqTxVJ31
         e6gg==
X-Gm-Message-State: ACrzQf2RLeDm4UPPeFHb6lQOGhEkV8ieYTXmO3Wu9qCJDnxkMWApiHG1
        gzEYZHvT5VBgKu1GwuBosmpfzew/jCZ5w+7I
X-Google-Smtp-Source: AMsMyM4AG9OESMSJtUFikeXz1/Oj0/2vSr+0BO+XZdwksgIfgsTri/L4iMN1D7bJvdLxQPxhKb6ylw==
X-Received: by 2002:a05:6638:32a2:b0:364:de6:cdbe with SMTP id f34-20020a05663832a200b003640de6cdbemr27083967jav.73.1666813352746;
        Wed, 26 Oct 2022 12:42:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18-20020a056638005200b0036371872137sm2345692jap.11.2022.10.26.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:42:32 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:42:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/repack-expire-to (was: Re: What's cooking in git.git (Oct 2022,
 #07; Wed, 26))
Message-ID: <Y1mNp99PUPJAq4yc@nand.local>
References: <xmqqwn8mh1di.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn8mh1di.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 11:43:21AM -0700, Junio C Hamano wrote:
> * tb/repack-expire-to (2022-10-24) 4 commits
>  - builtin/repack.c: implement `--expire-to` for storing pruned objects
>  - builtin/repack.c: write cruft packs to arbitrary locations
>  - builtin/repack.c: pass "cruft_expiration" to `write_cruft_pack`
>  - builtin/repack.c: pass "out" to `prepare_pack_objects`
>
>  "git repack" learns to send cruft objects out of the way into
>  packfiles outside the repository.
>
>  Will merge to 'next'?
>  source: <cover.1666636974.git.me@ttaylorr.com>

That would be great. There hasn't been a ton of review on this round,
but there was a good set of eyes on it during the RFC phase where nobody
seemed to complain loudly ;-).

So I'd be happy to see it get picked up, especially given its
simplicity. But if you want to wait for more reviewers to look it over,
that's fine too.

Thanks,
Taylor
