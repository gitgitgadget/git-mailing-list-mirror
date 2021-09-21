Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BA604AC
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhIUEcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhIUEcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 00:32:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57107C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:30:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y197so11514979iof.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faDQWuAmEPKPJpp21H3rftOWfRd1YOrLH4EM3wgyvPg=;
        b=SS3DgIoRsYOBvGZ45HM6xQftODAN2P2k50DIgUIM7UnWXlaKrMQwDxTA17UBXOKRdc
         oK5fxkCZkgqOw2hvZnMCixLJ/ECSE5Fkj3R6h0F1G7mr7yrOq85t+rThvndden4xu/5J
         LH6wfmnTbeKxmprr6EIFkSZSBR7GB08WlIHxntmny/47+6eUUaTlkcgdTbHuNBvGS75v
         wqCuBtwB3gpOnFt7uJV5UvTIXMn4w+cHuENty6XirgsCf0UlshkndL065NeP3gExx4W4
         jMNS7tYMdbLbyuc6bgBtZZS9nZYSVMYr5ml/IXNF++/7hm++1gXfaQYN4em/l6O+0Nmq
         /npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faDQWuAmEPKPJpp21H3rftOWfRd1YOrLH4EM3wgyvPg=;
        b=1buEllIqfrkn4dzx1YkV59mRHKn9wNrw1K0GxIaKpjo4OWgHjH4W22OCevauvfXqMT
         o2JC2PfiVF3gfJtSjCan0R2cP1DHQij3nkqEIiYbSfwJ/lfgMG/zhAfNGLivS5Pc1mWD
         suCs7cbv24mvCsQzKJS8pb05hNJy46ZFSvBSIji3aK12FWcEK5jY+6FBsz1JfUwBypRq
         WV1WfZGDqZUw4ZQ8jCIlEAyKMfJ9VgyO6BvuvLj1fEC7P90VAum/nw0WsSxWNm70VDZm
         WwU1tpx9Z2ywoZgqJ9d8q70/sGqI7QEZfjpIWK5vpsHS7V0YhGBReP11RbZVvOKPTRxc
         AVtg==
X-Gm-Message-State: AOAM531Pd47DKU8eOBJ2R5nmKu6XV3ShY9F4fj42fgqsaYM+sql1MYVc
        N+bgiYOV3GzuucoHEvTZALtwQBxZFGdKGg==
X-Google-Smtp-Source: ABdhPJyfyalK0sJ0LD7LeQtp7U58yczmo44tlgY/J89fCqX0f0oE3NiXNd42WYuH3mMltLCiz6mXmQ==
X-Received: by 2002:a6b:ef10:: with SMTP id k16mr17543847ioh.210.1632198641745;
        Mon, 20 Sep 2021 21:30:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm9674098ili.35.2021.09.20.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:30:41 -0700 (PDT)
Date:   Tue, 21 Sep 2021 00:30:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 0/5] const-correctness in grep.c
Message-ID: <YUlf8HyBWC7aDF8n@nand.local>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 11:45:42PM -0400, Jeff King wrote:
> While discussing [1], I noticed that the grep code mostly takes
> non-const buffers, even though it is conceptually a read-only operation
> to search in them. The culprit is a handful of spots that temporarily
> tie off NUL-terminated strings by overwriting a byte of the buffer and
> then restoring it. But I think we no longer need to do so these days,
> now that we have a regexec_buf() that can take a ptr/size pair.

This all looks very reasonable to me. I appreciated the way you broke up
each spot that unnecessarily modified a buffer into its own patch with
its own explanation.

I looked through each of the three spots you mentioned with a close eye
and concurred with your reasoning. (To the extent it was possible, I
tried to ignore most of your commentary until I had generated my own
understanding while searching through my copy of grep.c).

Thanks for an enjoyable set of patches to read.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

> [1] https://lore.kernel.org/git/YUk3zwuse56v76ze@coredump.intra.peff.net/

Thanks,
Taylor
