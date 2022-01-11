Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1BC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiAKTle (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiAKTlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:41:32 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFFC061748
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:41:32 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i82so311345ioa.8
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x+ncPBK9sHFrQpcB+lOGrKWn0LAb88yl0QkfQ/99qz0=;
        b=rh8+G9+WQu2ekipUyozYkpzsP781oMFDErQjAgaCaA92YdBlnGUwGcPv6qyAN22Lrq
         vOO/9bQ9KL3vrPaeyr0HTXILD7dzENajcmyeQ4ESwMMSHqmt1RwWfvNwrwjsiY/USzYc
         qDv6hQZmbq5se/8dQ49uOIXsGeYFZwhbjA3t1edaJr45p+Z2EiaMprWSnNngBvdk+I+b
         /O1IJnE4dVIeZah3ufNe48NzBo2X3wD3ZDcgK5G3RKqXjvlDKSYhL1dONxXjsDoBr3R/
         gogyy2lRdcWKGH16cZshwaOWPZyMOirGM3n39qpEroiF5ZbwrwK/x3hjZyhsoPzBfQxx
         UHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x+ncPBK9sHFrQpcB+lOGrKWn0LAb88yl0QkfQ/99qz0=;
        b=S5mtyjUYbzjsqBKiGTHwViJZb+vIFO89ot5lme8ulTqvtyrmxpcgzFbJSguts/wtxG
         Wk6Rjx4QoeRAT/AsoA0DYcnPPjgLh7PNG3DLw+xGvpIqhZ7X2naowYMKKdu4yiRXYcN/
         gf7mfUDSq3AKSzxYOMNqAad6inPDhicwDdl9URmTRYzVcdcIMCTCWBnf+wS+uEbFaeUx
         c9iZj900jtrhwHIDx3f07/HgKBLRhPTkrPQgBoBlX+4nR4gSlvZboS+o00deifEwjzYc
         zQlFa3rciSyiC/1k1scXfCmE8WXStbOcYDC5DkMqpscbIPJ2bxLOTk2HrGZ1Dl18z4pi
         6nrA==
X-Gm-Message-State: AOAM532tpLcK8d2jdpn2jJaaAsWO3BQuX2WVVPbKl6I80ayFfRSztHBM
        psKDpiBMbsbucqCZIQ+L37mjh6W5qMwI/A==
X-Google-Smtp-Source: ABdhPJzrnUirjMgdry0n/BWvm8K6J9TvMLQjp73V03UsTDAv6zh6fU16PxSs0Nt6/y9JZak49k0VfQ==
X-Received: by 2002:a5d:93d5:: with SMTP id j21mr3004242ioo.71.1641930091465;
        Tue, 11 Jan 2022 11:41:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z8sm242310ill.35.2022.01.11.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:41:31 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:41:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Message-ID: <Yd3dao5Qh5yl/cBs@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> > In any case, you're only setting the lower half of `min` high. Maybe:
> >
> >     uint64_t min = ~0ul;
>
> yeah, that works.

I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
somebody more confident than I in this area would be welcome :).

Thanks,
Taylor
