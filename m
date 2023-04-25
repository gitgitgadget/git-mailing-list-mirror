Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B694C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjDYVDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjDYVDL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:03:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D417DD6
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:03:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b99e0ffbabbso2710645276.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682456590; x=1685048590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5yb4gODjeJ7kU9xzfP1353l1zapJ2bz9DpwBG4wS+Y=;
        b=3ghhj0C/3T9rTKHCtjQutNf6txvQB0qiFXa/ZhEuEhbaAWd+vOj72NxKSZKyppwLwk
         VTgZ20M110vUvtSz+aT9Vdg3LMSWLdVGpPij5nfeQLw7sGkxQvLwSkH27D8leU+nlQ5I
         iEUlaKzETwFBAKUFZu5a2NbgXoN7qQYr1WJ9//w3h1jJDJkYq1ehBAGKzedLR1YaKg6D
         9b/suGcKxTuAD+UXpaRM1fff3MJI1UabpD8uatlrA9WnjDuT/YByIbDnkMoH0iJTtGPq
         28MMdzxeGuS8j6Nk50/EGn+Jzr5pGf/3Y/TGdWyk8Ths9hJ5lfzayOkGm/mwcUmwbj+e
         DyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456590; x=1685048590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5yb4gODjeJ7kU9xzfP1353l1zapJ2bz9DpwBG4wS+Y=;
        b=UL7fWAcsMydgdbtgTr0US/f61iFjtMuPLgZvV69fLB68mRd+fu1eoDZOn7+6wurSZs
         VwfOE0CXR6otdXVqqpuvtlyrCpThwm/Bt8GCYKFBHPcVvIwD6MOuVm9+0ekthrQ+u1+Z
         lAKf9LkrHqvCrqFnpYktlOHmNVcz08l0hvDJF+0Y33GmFvRLMf4BtgI0fav9PHsAKK2e
         U/ypmvRn3PlXPvYJ/GnR9JgVo0hPEJ+QzRVoxV+d3IUTehPfCLWLxgZUfWBexBWjL4rg
         IvcZj+gC072UwDEhtlAMCrH1xWO45n4xCV2hbinNhhN2Me9kMQ9SlHxh/f4cV4C6HGyw
         yYfQ==
X-Gm-Message-State: AAQBX9clap62tPKde0tKBWs1nvCIprvg092yKTizKdJyRIp5jRvk5XhJ
        UUchOF5PfwitBs9eNOSF8jVNZA==
X-Google-Smtp-Source: AKy350bs45P4Ahjjal16TxPpRjYJlhZZETkMx+tO0qbKissIfEMDkDsR4rKYFWWZmEkQDc5IBhPAkA==
X-Received: by 2002:a25:6905:0:b0:b92:3993:d34f with SMTP id e5-20020a256905000000b00b923993d34fmr12671360ybc.48.1682456590045;
        Tue, 25 Apr 2023 14:03:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a258b81000000b00b923b9e0a82sm3628235ybl.45.2023.04.25.14.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:03:09 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:03:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/6] banned: mark `strok()`, `strtok_r()` as banned
Message-ID: <ZEhADEFE9cq/fjSV@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <20230425062708.GC4061254@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425062708.GC4061254@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:27:08AM -0400, Jeff King wrote:
> On Mon, Apr 24, 2023 at 06:20:07PM -0400, Taylor Blau wrote:
>
> > Here is another medium-sized reroll of my series to add `strtok()` (and
> > `strtok_r()`!) to the list of banned functions.
> >
> > Notable changes include:
> >
> >   - Dropped `string_list_split_in_place_multi()` in favor of a
> >     combination of `string_list_split_in_place()` and
> >     `string_list_remove_empty_items()`.
> >
> >   - `strtok_r()` is back on the banned list, with a more realistic sales
> >     pitch.
>
> This all looks good to me. I left two comments which are on the border
> between "minor" and "philosophizing", so I'd be happy to see the series
> go in as-is.

Thanks, I agree that this version is ready to go, absent any other
show-stopping reviews.

Thanks,
Taylor
