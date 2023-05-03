Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83EC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjECV2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECV2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:28:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ACC30EF
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:28:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-559e317eef1so72812897b3.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683149326; x=1685741326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svlP0dXa3waQBHrIit+MyK77FxACB3dUOcHYiCCI9Qg=;
        b=FC4DoM++1/jzv6z6lSJu31tbYDFpfDhFvwSy3nrOH4nwfCzUPuAL66gcb2DxiAeay8
         t49AfmEtyN1tyM47MrYqwRJFDj0p0+g5OfwWY2N+LQmXMAtpCNf23F2OdcGYNS/4fTZi
         KFYWXex6xHvcIdCknMOFYRETL5SG1Xgy7YUk91qLbEYkrbPGieQ4MdwF+V1yKgQ9h1ew
         +YN33lXumRis0pWcUAx8R272r1x95L2PXtmXN6WN4gG/MfP7krJ5NmO27AwxLcUFpcbA
         sJWeNR+zseyvEXGxFyu70gaYcy7rGzwkw8+4+SOQ8e8eWyC9QQvr9jqG2tkHR1Ku6Tt7
         H9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149326; x=1685741326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svlP0dXa3waQBHrIit+MyK77FxACB3dUOcHYiCCI9Qg=;
        b=RGje0ulSkgQJcrw9I+mg60K5CwoPjfyG5IrzkvhMzOwx9v6Mx0AYDO0HuUTVD2N/yV
         BN33OfQA2ku+PfEtpjyelr7A7Fp/5tsQM8mzr+5CnSxYJyvtyzdqWxBL0Ay4iYWLauRD
         KwCbcEg+EPjUgkGc+VEgZZLdgoWt6y5XmQ+hi66bcHxD7UM+tHwTARGIKxt7+Mf/hcx/
         +Zzxkdy+aK5pobilHKWRTE8JgKP2hc6kmBMZvfe+rWvFnrVBOkI30y56ThG80uCupMco
         CM4AOgkYJ0kJ8y4L7zJI4vYJutzKbTXaA/hRuTuptJw34c+46AVfgWDDvFUCNj5Nuzdk
         GiUw==
X-Gm-Message-State: AC+VfDxzyoItZvk5QUFp+RVTWNCZJaVhruTY5t91UE3pcQybeqhuRWWj
        6JfS91KqzdAe+k/3qQ95Hx4HAw==
X-Google-Smtp-Source: ACHHUZ78sjHkvtVUapGn8cjKUUWzJTW0zTh0KP4Hv6gnnioRBubsQ7g9WXgDwbjh8RLF52TXnaeZdg==
X-Received: by 2002:a0d:c347:0:b0:556:dd1b:3bb7 with SMTP id f68-20020a0dc347000000b00556dd1b3bb7mr21638568ywd.43.1683149326548;
        Wed, 03 May 2023 14:28:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n64-20020a817243000000b005569567aac1sm6942702ywc.106.2023.05.03.14.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:28:46 -0700 (PDT)
Date:   Wed, 3 May 2023 17:28:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFLSDS89y8P2+g/2@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503195906.GA1796816@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 03:59:06PM -0400, Jeff King wrote:
> On Tue, May 02, 2023 at 08:09:47PM -0400, Taylor Blau wrote:
>
> > However, there is no option to be able to keep around certain objects
> > that have otherwise aged out of the grace period. The only way to retain
> > those objects is:
> >
> >   - to point a reference at them, which may be undesirable or
> >     infeasible,
> >   - to track them via the reflog, which may be undesirable since the
> >     reflog's lifetime is limited to that of the reference it's tracking
> >     (and callers may want to keep those unreachable objects around for
> >     longer)
> >   - to extend the grace period, which may keep around other objects that
> >     the caller *does* want to discard,
> >   - or, to force the caller to construct the pack of objects they want
> >     to keep themselves, and then mark the pack as kept by adding a
> >     ".keep" file.
>
> OK, I understand the use case you're trying to support, and your
> approach mostly makes sense. But there are two things I was surprised by
> in the implementation:
>
>   1. Does this need to be tied to cruft packs? The same logic would
>      apply to "repack -A" which turns objects loose (of course you
>      probably don't want to do that in the long term for performance
>      reasons, but it's conceptually the same thing; see below).

I agree that you wouldn't want to do it for performance reasons, but I'm
comfortable with the asymmetry here, since this is `pack.extraCruftTips`
(emphasis on "cruft"), so it's not clear that it has to be related to
"repack -A".

Happy to change things up if you feel strongly, though.

Thanks,
Taylor
