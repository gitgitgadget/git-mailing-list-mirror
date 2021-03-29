Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D81CC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BBA61988
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC2VhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhC2VhE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:37:04 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FAAC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:37:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y2so10429927qtw.13
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZtOXVl36W5qKJRXdcpeD5mD0t55xnz9WC9dCiTXnl0=;
        b=UwxdL8Peww81MFlWSxxHFfrpSwG0ggc2CM9aPAQnD2X8ysPpYeifGJg6EDLfk4XkkT
         F93fUgIPf+ll/v8H2B5Y9W3SOrsm2SWmWS1M7BbXf4lYyEd0tQQu6n18ADBWW+M7Zeeu
         q8KU/d4IyTZsn+TRgI9+zfe1D3Mu0mHEZNc5rVLPd/BdmMBQKUXoOIbwi0YbP87OslnV
         IN8lZ+FfJHYSLShvbXyK9kKPuNquIa7HxFVn+7E1BwTHTKwpHEYg9ErvCtntkNZzMEHW
         qLHt7rFUK4u1PL4vm06g1CdfLlEzkcclfonj3v9M8LqWDkNQPAbvDR55uGuKQ4Iek2aA
         YS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZtOXVl36W5qKJRXdcpeD5mD0t55xnz9WC9dCiTXnl0=;
        b=BC3FHezrLsY95VBeApN6YXdVtyZlkCW1CWDQ0eSWG7fUMKG91Ec8frYPuM4a+78Mgb
         P4P6gfQckNU+yBcX7PWB4tMeB/TAJgk+URvsqxCq5qIOE4GXxJtG7O7kF2R0eyBL84G+
         umR2qPV2GeSB/9Jkxlu8BkAmPqlTGOOCBLxcIL3jgvrqaXeh3WhO22dUmbwPCP5Gpi8a
         I9WC4Dkfflr66uueL0oxu/7xCcAV+OFhtvwpWn4orfL9Xr8S50NpVRz/DUteDG68H48R
         SZS2LlFReuReVGY7kZ9dKK35O5bsgeK/cZRHvDe1YK5CPeb/gTRDDGJg+1qGnyuC+Pi8
         +R4Q==
X-Gm-Message-State: AOAM532M8Snaow8rSXa49VAMh9gb5zpxkHSc1+blRAkQLWApzB19/CXC
        FWBMStthYKK/muF75D9phOzzHg==
X-Google-Smtp-Source: ABdhPJyArE53KqzgSRE2rbFHgxN+/E5PabGCcweoTbBuT/6AZBb6/xJk77VEa3xtMQUMizi8iWVZEQ==
X-Received: by 2002:ac8:6690:: with SMTP id d16mr24835081qtp.312.1617053823058;
        Mon, 29 Mar 2021 14:37:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id d68sm14417169qkf.93.2021.03.29.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:37:02 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:37:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGJIfdyghSUrq/0I@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 09:05:33AM -0400, Jeff King wrote:
> On Thu, Mar 11, 2021 at 12:04:31PM -0500, Taylor Blau wrote:
>
> > Here is another reroll of my series to implement a reverse index in
> > preparation for multi-pack reachability bitmaps. The previous version
> > was based on 'ds/chunked-file-api', but that topic has since been merged
> > to 'master'. This series is now built directly on top of 'master'.
>
> I gave the whole thing another careful read. Most of what I found were
> small nits, but enough that I think one more re-roll is worth it.

Thanks. I agree that another re-roll is worth it. I have one prepared
locally, and I just had one outstanding question in:

    https://lore.kernel.org/git/YGI6ySogGoYZi66A@nand.local/

that I'll wait on your reply to before sending a reroll.

> The biggest question is what we want to happen next. As you note, the
> concept of a midx .rev file is useless until we have the matching
> .bitmap file. So we _could_ let this sit in next while the dependent
> bitmap topic is reviewed, and then merge them down together. But I'm
> inclined to treat this as an independent topic that can get merged to
> master on its own, since the early cleanups are valuable on their own,
> and the .rev parts at the end, even if dead, won't hurt anything.

That matches what I was hoping for. I think the clean-ups are worth it
on their own, but I also think it's a good idea to take the whole
series, since it means there's one less long-running branch in flight
while we review the MIDX bitmaps topic.

(FWIW, I can also see an argument in the other direction along the lines
of "we may discover something later on that requires us to change the
way multi-pack .rev files work". I think that such an outcome is fairly
unlikely, but worth considering anyway).

Thanks,
Taylor
