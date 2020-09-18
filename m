Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3FC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2684321741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OyGGbciZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRSAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIRSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:00:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CCAC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:00:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so7183921qka.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIoZcmrbC5dMUH8+C9k/K/XIIxQuy/hqj624cS2s2D4=;
        b=OyGGbciZ2weishMUsu2yeBIKZNOBWPvMlcAVHmWeYZUpywZRJz4cO7uGiojH09OK4p
         R4N2D+FS4qE/D5Ac67OLCCznCInOmLIAGhKTwWWpwzFH34rKqeCbMjpIuR/scKyZB6o/
         rmeQG/qf5CUwy+1NlfADkpuFWWGpY0PH15h2wAjaZx+G3NzfagQ9pCOPaDQaEhwdX2OY
         ihkLZ38qjJ90bOu8uyKwziFszlTfgmMIocxv+T0yi1m2mDWSlukNWyVhq/MIpQH3jBLs
         /7HSkrVOJnOwVoT0FkJ8f+7UVZ+8dq2uM7eJfsf1X0bZ4jifGM1696FybglHW/tT/igc
         mYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIoZcmrbC5dMUH8+C9k/K/XIIxQuy/hqj624cS2s2D4=;
        b=OzLZmI2V2PqrdxcHvvNhuKQrP7HHOMLPB9tbMMP/TPNyO3PwZJ5Qow/Lvs7yd6PrH3
         /ee+OBcJ0ek4BvZ5iOmOPrwoE4J9cTWQEZ6KJesZJLTwl+cCIDEOccpMh1GDS9zQ/4/q
         OfaWF1FDjKdwiLRIKj+OZ3DnnnmbESImsfh68RimVZkWXvC6HlXDZIEKUn69DZiQejTO
         yUubmNhnIIwQ0mLe7PXKDH5Sxs4flq3Ov74knHWBZ+xRV96LG7oNnvpMeTazCwosYw6g
         307Z2f/sdm8Z2Nq6j+yKiCkr9vvDhduV4jlH9+4MyqDH3AxFz9eX+SdpnkQe8GA1PgzC
         aUfA==
X-Gm-Message-State: AOAM532yAca2xj+SiiFHS77Ctqb+L5EFcmCtmt0qI0ndSqTKmKR2GazO
        tXcNBAGV3Ul43MdE2XYiG4ochQ==
X-Google-Smtp-Source: ABdhPJwWxvYHhTIlX3Jkw6PP16cHRL8XJAdodONtWe+jF97gfiAohCHT0SrC11EBw7OWaWPVROJ4eQ==
X-Received: by 2002:ae9:e602:: with SMTP id z2mr35219678qkf.259.1600452046049;
        Fri, 18 Sep 2020 11:00:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bcd8:3baa:a5e5:d0e6])
        by smtp.gmail.com with ESMTPSA id e90sm2637644qtd.4.2020.09.18.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 11:00:45 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:00:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918180043.GB149847@nand.local>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <20200918172044.GB183026@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918172044.GB183026@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 01:20:44PM -0400, Jeff King wrote:
> On Fri, Sep 18, 2020 at 10:36:47AM -0400, Taylor Blau wrote:
>
> >   - The cat pipe is unnecessary, and is also violating a rule that we
> >     don't place 'git' on the right-hand side of a pipe (can you redirect
> >     the file at the end instead?).
>
> What's wrong with git on the right-hand side of a pipe?

Ack, ignore me. The problem would be on the left-hand side only, without
set -o pipefail, which we don't do.

> On the left-hand side we lose its exit code, which is bad. But on the
> right hand side, we are only losing the exit code of "cat", which we
> don't care about.
>
> (Though I agree that "cat" is pointless here; we could just be
> redirecting from a file).

Yep, but an easy mistake to make nonetheless.

> -Peff

Thanks,
Taylor
