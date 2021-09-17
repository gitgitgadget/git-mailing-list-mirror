Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A7C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466016056B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbhIQEJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbhIQEJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 00:09:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD8BC061756
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:08:05 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s20so1973699ioa.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pr1A3WBvdmSfXm17/lZlZMaIlM85VkX1k7/5+/pxP8s=;
        b=qewtkbOknboeIDYMvGbdi3JtEymDBu9pvpy/rpc+em9Ofp0qEvaYtdSYMA+Cbo4WVI
         lso4a0CGunK43H9K5uwBTv5AhKeJCwy4bz9P3HfjFoTI8H3yYOazB7YcLHu6BDUlrevF
         SP/I3AR9FU4N8/bWJ1PUOen99/KdJQBUEtYL4Zp5aUN4FqocyKxyDRrTl8vYVijdXkC0
         /dmrG3rseRBbxqvB9n/Xgd+Yxs3y6i0xmRJtIEonfRDO02D8vKrGHsxVC1J4v6Q4GIes
         lqd5UD/IILlsKFeHc2Gng81Tm+Tkv8pWlIggC/2JIXkLea0rBH/SYFRGFP2uS16A6t+U
         unPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pr1A3WBvdmSfXm17/lZlZMaIlM85VkX1k7/5+/pxP8s=;
        b=FXhUm+Q1YkTdF1eAqpvwBD4nG6I8sCjoGqflIgV3HL8gUgBQZWJYGspaxKY/Di6TQE
         KxQfRxWLuA62pX4JZtmm7u+khpERHmnYdPOs4UXCJY7/2ehEurCfKedGqQCMgKkbkQrc
         VHAjgBW+7Slor5cI4n+aPVKm6wthAz2363jH1k0dp+5wZtbcjbpSgIlEO2Henl1dNuTb
         tF9/77YXPOoQnZMM/LlgdBpvAmvZNopn+RRQmrf3OmUKmaimdxVm6uQrwnwYc+cyTUSj
         oXsqeIaJtX/gw+E+AOzzltPjHb5JStTAm0Y7tSus7RjOo0FJ1omLOkniV7/X/tWA/++m
         ZrXA==
X-Gm-Message-State: AOAM532k/+ICJaMttHUBwbpYcphiyQkrkw0ZtZQJLh/kCdUNtePjeSiA
        ngRSd15X5kYZcZQsdrRWt0H2rg==
X-Google-Smtp-Source: ABdhPJyKPdZd2NTyPcCN1rG3cIUjjCnwI1GXrpjvyOTtCPEgN5jLsBJj8tb8hZrDDk0SzbXbLKEytw==
X-Received: by 2002:a05:6638:41a2:: with SMTP id az34mr6987545jab.4.1631851685165;
        Thu, 16 Sep 2021 21:08:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1sm2934215iot.44.2021.09.16.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:08:04 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:08:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 00/22] fsck: lib-ify object-file.c & better fsck
 "invalid object" error reporting
Message-ID: <YUQUpCeFmQ1eSn7R@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:57:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
> This improves fsck error reporting, see the examples in the commit
> messages of 19/22, 21/22 and 22/22. To get there I've lib-ified more
> thigs in object-file.c and the general object APIs, i.e. now we'll
> return error codes instead of calling die() in these cases.
>
> This series has been in "needs review" state for a while. This re-roll
> is mainly to bump it for the list's attention, but while I was at it I
> addressed point from Jonathan Tan raised in a previous round: use an
> enum instead of int for the unpack_loose_header() return value.

I took a thorough look through this series, and left a handful of minor
comments. I didn't spot any glaring issues, and think that this series
is in pretty good shape.

I do admit there were quite a large number of patches to get to the
couple of changes at the end. I left some thoughts throughout for places
that I would have combined things / presented them in a different order
or similar.

I don't think you should spend much time changing the structure now that
it's been looked at with close eyes, but just some idle thoughts for
other large series you might send in the future.

Thanks,
Taylor
