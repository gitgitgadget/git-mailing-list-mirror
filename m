Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146CC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C920660E93
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbhICC0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhICC0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 22:26:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E2C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 19:25:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id m11so5062354ioo.6
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K1GrDVTLiKDPFAk1K41EENmZh2iyA8DGWO35Gzbm7LM=;
        b=UCtiHqbfVu7elUrxEKlSoQtOv/6x/VEqDMeSaF5JMtdcY05a6UpmSDONpvDsVLx1M2
         xxmCPRl1C9398yWDUstpEl9uYTEdK2zmtu/iz2gNz6uFB7SHZ/2VsDDlLepULG4CZs9T
         Fu602VUktxrOLrPkV8PDjiR2zhUWTANYbNgYljbb/V+FPYH6ZWRBBjQXKzSuHGryN9Sd
         N0wDkqPqokXid5boZAgJeOhQeGpFjV8opA5NqT7hj9ssyJqWL9kn8Cg7W+rURLILFHxQ
         fBoXcQlH9R3SxL11gYxczFWnxBIgH9ow3pCEfqvGYRtAi5AnjimBy3dZa1djaQc0zLwa
         9P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K1GrDVTLiKDPFAk1K41EENmZh2iyA8DGWO35Gzbm7LM=;
        b=qyq7s4Hjk9BJn5g4Sc49nV32BiMrdu0W9no2X2PurGTvXGZBwpoa2HL5YnqES6uqvC
         O/EjlTRlQ7soEe6DvWkbJlnKbG+ey0kghTa+3oV4XdPyed9bou7aIhEt+YUXAURSefQ4
         CZzR4SU0dX0NFzbiU5caCCpuhOsddKH4Qy60i/sixfQJ6hnNHyoRl2yCkycvlcOHUtIH
         vWMaS4rxP34qIuaiLOAuYXIUcGuIVTVDoE1jL88rY0d/teg0viMwVzozo6P8JQSDkpvn
         uC/byKJxLwKeYVdoFKsWyNcejr+IsmQouIHzy65ozw8AH8TwLZzpm/1bNomqtg12/fsa
         rQLA==
X-Gm-Message-State: AOAM530Qo4Yt+P0Man6E0dh0QyRa1RSIVM/E+2Xugr1pHgkquay7D+Gd
        j6eDiJBKyPMNm6XccwhYYhzxcyd52Ds6M+nn
X-Google-Smtp-Source: ABdhPJwTZvBC9NrJh0i17T6dhRXA6KaTTTUJSSkcs8UTZy03hs+8BTPHZKltPJc7SweDFTCZhFKPug==
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr743797jak.8.1630635917984;
        Thu, 02 Sep 2021 19:25:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b18sm1924320iln.8.2021.09.02.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 19:25:17 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:25:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
Message-ID: <YTGHjGAm1I8GuUy/@nand.local>
References: <xmqq35qmiofp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35qmiofp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 03:48:42PM -0700, Junio C Hamano wrote:
> * tb/multi-pack-bitmaps (2021-09-01) 27 commits
> [...]
>
>  Will merge to 'next'?

I think so. Your integration looks good to me, since you replaced the
original patch 11 with the replacement that uses find_odb().

Peff gave v5 (with the replacement patch) a positive review in:

    https://lore.kernel.org/git/YTCdHHRW%2Fi3HVN0h@coredump.intra.peff.net/

so I think that this is ready.

Thanks,
Taylor
