Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68288C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 02:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKPCDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKPCDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 21:03:01 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1882B271
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:03:01 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 63so12190876iov.8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbpBMyYZnNBgWql6W5bHXnIPoSPNeqNnUBYtoXlRxpg=;
        b=WXlbwUNXtrZg4GFrlZBn5J5K1hgGetjNVir9281EMvnPHmI3hCQqhmb9/fywMovCIe
         TQSFIsv4qpaxMwXKk1mu5XCJ6f/goW9d7FKUWkOoyNIZtGATEMhXAtzp6cjMeoRDgwJC
         hip9bxYkKKWYX59bIEki/QAb2qe9y8IWK6O61FwMHlvD7WGz/rWo1F07n7ukw7pf+yts
         tyTc2irdhk4Gi8oKP4bRZPRayTILUWbeL3HcDML+4WtvD+o2UzTp6p6rgqjYW1rdo53n
         QkToYSilNT4xvTtJqsIJ1/K0vdLSrdPRHzIgw71b2yGwqM8cIy1dcLhEA0FTMa5mF+Ua
         tqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbpBMyYZnNBgWql6W5bHXnIPoSPNeqNnUBYtoXlRxpg=;
        b=KLv2NhJM4zVqz3pKJZ3+8Rt4fSrJPtMcbfF2eo2XdyV5t603kl1vd/aAa3WU3h4tfg
         GWVgQ9vtBZhdVj9/vwAJqfife6PXNd8e9ThG19fqI/y7JnJs7VBqNFjuQsYNBKU7tqFx
         1hLiWZW2nen6HfVk/MfbXw5GJzuu/yCgLgQ4maBJkPGo1gFcwhziUhFCu7V3cyLDZdsY
         nJe/UhEhPzv2VDA8AJruzVwtEH4JiS0TDb0+ayHFH6oSK/P5cMMU/c7jWk3x58JgAwTr
         tA5tGIE//iA8RzEaPrJa1duNlt5qcsFiL7Yet17jXPBUcD/dyuxVn52J2eNYXSiV81bw
         O8Og==
X-Gm-Message-State: ANoB5pnRk4oznXW1ahWO+RQOhXXRauv2FMA8uEcJI17G1tR8soN0Xd6b
        yW3doPKDahVDAAbGxF33dyw65yAJwdPKAw==
X-Google-Smtp-Source: AA0mqf5Yf9UHJQN1cKC0gKgEJRbCRiNZFTNlBcSZ754H5goHbrzXGwpK+lmp4P7RXjcYmiDvRkOJ4A==
X-Received: by 2002:a05:6638:4415:b0:363:8849:44f7 with SMTP id bp21-20020a056638441500b00363884944f7mr9265703jab.24.1668564180386;
        Tue, 15 Nov 2022 18:03:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18-20020a0566381c1200b003740de9fb65sm5365873jab.46.2022.11.15.18.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:02:59 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:02:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: ps/receive-use-only-advertised
Message-ID: <Y3RE0bq91a0XFKRW@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <Y3MxmzestKm9iMTU@ncase>
 <Y3M2Fq7pZk4lNY9G@nand.local>
 <Y3PMLFuvR6hlIzbq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PMLFuvR6hlIzbq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 12:28:12PM -0500, Jeff King wrote:
> > > I think this is stale, right? There was no further feedback until now,
> > > and in your [1] you say that things look good to you, but that you
> > > intend to wait a few days for further feedback.
> > >
> > > Thanks!
> >
> > Yes, that is indeed stale, thanks for catching. I'm just waiting for a
> > review from somebody that isn't you or me ;-).
>
> I just left a review. It looks good to me to hit 'next'.

Thanks, let's start merging this one down.

Thanks,
Taylor
