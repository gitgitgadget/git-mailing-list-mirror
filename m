Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1BC35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DF72137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NQPnJjen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgEAUYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEAUYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:24:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103BC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 13:24:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so2022435pfw.13
        for <git@vger.kernel.org>; Fri, 01 May 2020 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d4tzwUGx4hrV4ywFtV2rEDjdHcErsCxSY1lHXOsQnqE=;
        b=NQPnJjeny9dcfKVPzUfmCtpXKm6CtL5nxBAo3SscAzV/pcq3q8AnFehqKyXPFr+Vo8
         qzfTF4T/00jS9XZDUcGqph3JwQJOjk/X5sVCrnWaNQqfg4X6Bz9ZKpVws00iLMx+EPgI
         WGStoZx95sJl59JGyGrMTK+pKDusIYY+EZg4fIisBWIzU7Vmif7r/UtBed+l9tzt+IKO
         yIgIPwy/+dTld2WJJe50zJDkKogva6dGuEsZ/Lo/xYfsMSmkp0+qyrAG+v1z0sElj1ib
         8z217QoaAFfnlOtEBRWAZ851itnLcpTWoVs0ayoOdibB/xTC6trj2pvawMUVwKxOZAiQ
         OeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d4tzwUGx4hrV4ywFtV2rEDjdHcErsCxSY1lHXOsQnqE=;
        b=YXVVyWOnxLzCwBwauLHkeNGTe+5GfwaZlKkKSXEn4EYzudVst6p4OfSIper6uThFDk
         qmWUPvfLBFk2De8TsfQHaRIICcDxjahbtVGgNqCbr9WQUfz7jhj0XBU+WSrrzAgcyXMf
         LAY63KhGtX7Y80jR/ohX44VwatpyKPaAMzBlAmdDwSLScnvdkNHoSf6flkv4ZDWuYxgJ
         wDyxq7Ij5LVEtgMEMXVBqZn48J1cuHeYVEJWNRjA3Licgyur1ZTbB6pLHkMEtitfHOqK
         VyhBs4qROEbjNti7X8tulS14FV/0L42tRnxHFzy0bNMddPY7F2/Qc7iYvzrB1yF3KmI0
         FQ/g==
X-Gm-Message-State: AGi0PuZLNPnb1lczLMCQ1cmvx7kbN8M8Wi06UjCIdFgGusP/cQmhSgUx
        0Aq3pI+X76MutioLvU8eiel4fVG6UmYcbA==
X-Google-Smtp-Source: APiQypLrP10nSLZHDONRdkl2tsYo/IxapuxJqN7OUsv0D98OPWl2IH9WHz8qqU22HM5bZfReA2hmLg==
X-Received: by 2002:a62:2544:: with SMTP id l65mr5881116pfl.288.1588364653568;
        Fri, 01 May 2020 13:24:13 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i190sm2954274pfe.114.2020.05.01.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:24:12 -0700 (PDT)
Date:   Fri, 1 May 2020 14:24:11 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #04; Thu, 30)
Message-ID: <20200501202411.GA41612@syl.local>
References: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 30, 2020 at 04:04:25PM -0700, Junio C Hamano wrote:

Thanks for an update. Here are some new topics that I have been tracking
as well:

> [New Topics]

The only topics that I've been tracking that aren't here are still going
through some review. Those are:

  * Sibi's patches to start building with CMake [1].

  * The fifth part of Denton's patches to replace 'test_must_fail'
    usage with another approach [2].

  * Dogulas Fuller's patches to update a quoting issue in documentation
    [3].

One thing that may have been passed over is my series to teach the
bitmap machinery how to quickly interpret '--filter=tree:0' by
discarding non-named trees from the result set. That is here:

  https://lore.kernel.org/git/cover.1587597151.git.me@ttaylorr.com/

This didn't get much review outside of from Peff, who wrote some of the
patches, so I'd be happy to re-send it or wait longer for others to have
a look, too. For what it's worth, these changes are fairly
straightforward and we have been running them at GitHub (and allowing
partial clones with `--filter=tree:0`!) for some time now.


Thanks,
Taylor

[1]: https://lore.kernel.org/git/pull.614.git.1587700897.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/cover.1588162842.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com/
