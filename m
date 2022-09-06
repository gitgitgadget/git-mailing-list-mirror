Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F1C38145
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 21:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIFVUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIFVUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 17:20:46 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E2B4420
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 14:20:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m5so9201747qkk.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aBsPpc3EXaHTcipfx3Q2Ym3UkZCt6DK//TYMzbAAeNI=;
        b=QhQ8ATVT7N6I2I3BL+6P3lUUB4nL3FRsWG2cEV7zlpkcgI6TQ9Bwn0EvPoElJlO8FY
         yeCGwSsnrAHLxmqv3iwdfcbAt+PnmQQB5BDXTIU+TyRMdoF0eNrfW+xsIwmRDJZxcgxP
         6/XM2w14qTTEPNm802aiu66zYBKK8ddr+1TxQ4jZLAVe1vrDRe6v1+1n5gndkYia4jzd
         MJi0uFAotNCiRuLmzpPszk+gKpYhuXwbb/u8x5hK+qm0OHDXlNndEfvQoipgZCM08Pz0
         4nwT5rdPZIc6amfhHLcjNpCtmnvDwvf83uZQZJ01YarMN/ztiWha9ZKE4FKguqzAMpA6
         PfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aBsPpc3EXaHTcipfx3Q2Ym3UkZCt6DK//TYMzbAAeNI=;
        b=3BRMEMk26TDrdrkRTQHMgtbtzh4NthBpPh6EUyMw7cXVDTCdQMKk5bFPLN2bTG8m3j
         c8F2u6q0zXRMaINs62KixcHtZNq1adV+u1usSyfVy00j3BvHqMe6SSnUd3q7wUbR0hFG
         Z/utKMIVjAECOpSPmWGyuXC0BeYKBupI/w5om0D6gHDo0HB41lt7uAoMIl5CBpHQmPsL
         XQbdmMtBnjquW+l6aAUQgqVMGkPoFcdHb/XWp2wKW0R4HG/wdNbI4RjF7Ww6OGpTV0I/
         Aebu8cMQSYPGGDZlV2AzeqcLm3ggY570k/pbuBnL5aveLfFNxV4UfcYw5oxShJdPJklj
         8tag==
X-Gm-Message-State: ACgBeo0ResYnI63CvkXwMjww0rgZcN5yZvGRppcovdVPWQRV98dCwNIo
        95Ei0CxDK5IS8mSD7ANYGd0RSA==
X-Google-Smtp-Source: AA6agR7wM67ncuTBKDl1dX+/mD4poPozIahzx+VjTJ14t8uGSnyY/6FJ3PGmixF5ETQ/nDrvy7yJNw==
X-Received: by 2002:a05:620a:2681:b0:6b5:b547:40d with SMTP id c1-20020a05620a268100b006b5b547040dmr536055qkp.34.1662499244445;
        Tue, 06 Sep 2022 14:20:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a450b00b006b8e8c657ccsm12423074qkp.117.2022.09.06.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:20:44 -0700 (PDT)
Date:   Tue, 6 Sep 2022 17:20:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-list: disable commit graph with --verify-objects
Message-ID: <Yxe5qwO/GzsEXMjb@nand.local>
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
 <Yxe1422xPYoMNlkG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxe1422xPYoMNlkG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2022 at 05:04:35PM -0400, Jeff King wrote:
> So it seems like the safest thing is to just disable the commit graph
> for the whole process when we see the --verify-objects option. We can do
> that either in builtin/rev-list.c, where we use the option, or in
> revision.c, where we parse it. There are some subtleties:

Agreed that putting it in the rev-list code makes sense.

I was wondering whether disabling the commit graph would survive
a `raw_object_store_clear()` or `close_commit_graph()`. But it does,
since we're not actually touching the `commit_graph` pointer itself, but
a second variable `commit_graph_disabled`, which isn't ever set back to
0.

Thanks,
Taylor
