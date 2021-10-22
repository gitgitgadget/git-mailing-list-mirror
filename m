Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4126C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3E7604DB
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhJVEln (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhJVElm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:41:42 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7DC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:39:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h196so3788144iof.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gikce3NPlR1NeFK9iPdwndqEthCYORWX4yS2UeB3Ct0=;
        b=IjphJrsDlYiG37u1lhrhTyxDk9JpAtv3CtkvW5IHoVFJi9gHiTlBmxlrJ2mex+b1HX
         JcFhEFfuhe7kHHZQx2XdNVuUSyJl69/irCNgdTTjLK/2paRe1MkWjLNoAFLR1Ed/m3Hn
         jckF7MtAOjb354FYb5RbO3CdlrgY5/pnXRA50Dliz9+TDpeW2Ah0mtxrcE9p3CUm5J1z
         o01we9AXBg+zFnhDB9QUJLbgtYXs8U2eb4v+QrY8vNvS4hHkhgYqcGTf9uUs27GfmjQ2
         1vNQSyoUWMxY2/SjoLui6ZaV+Unq5x9xthWQ6Rvr4COZsR5pEk2tbaBYjjYLGTmX4QeD
         4bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gikce3NPlR1NeFK9iPdwndqEthCYORWX4yS2UeB3Ct0=;
        b=FVoflT2xp0aRGnqQoEP9iP0UuPZzQ901rMONTYRUIyhzG9/WqS0GL+xaV9D7aAqzN5
         zQZUBrbvC8c1vBK/zpS0JDPtZmhq6IdxpqfWzTH7HHitcdVHpcjP6ovdwPxawy1psgxR
         hekeXxPJJQPxGaHIAjtU+YeJHyDWjBaOxdx6UiH30i986qO//cWCzu7GhNVuJQFhqU9C
         I9uN/UDSUrUhxs+Khrz5H2NHL2Z4ltm5IfGl25/QEqQ/AAYHukp2EO37nPadG6+Nae6X
         h9a+ggtQfzklgVNtYRBrzeEB95lOHju9jIeRhu+pcGUUGI05BZpKeb/Dq/K1MCfwTsuj
         j3aQ==
X-Gm-Message-State: AOAM530zPickQddW3qOZqnQpU93NW53S2D0FLqJjh6j/Gwe9ZsNtl0tf
        9P/Xji8aGs31okKmwZfBO1n1Nw==
X-Google-Smtp-Source: ABdhPJwYZeGpYtHycaxuy+jyAM8XoznhpecmckjemLgHPmTeYv7vNtd3PQXjaVWA7uIqzI5Na1WfYg==
X-Received: by 2002:a02:270c:: with SMTP id g12mr6736102jaa.75.1634877565072;
        Thu, 21 Oct 2021 21:39:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j22sm3391276ila.6.2021.10.21.21.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:39:24 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:39:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 00/11] midx: clean up t5319 under 'SANITIZE=leak'
Message-ID: <YXJAfICQN8s5Gm7s@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <211021.861r4emv7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211021.861r4emv7b.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 01:50:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Oct 20 2021, Taylor Blau wrote:
>
> > I tried to separate these out based on their respective areas. The last 10% are
> > all from leaking memory in the rev_info structure, which I punted on for now by
> > just UNLEAK()-ing it. That's all done in the last patch. If we choose to take
> > that last patch, then t5319 passes even under SANITIZE=leak builds. But it's a
> > little gross, so I'm happy to leave it out if others would prefer.
>
> I'll defer to you, but I've got a mild preference for keeping it out. An
> upcoming series of patches I'm submitting (I'm waiting on the current
> leak fixes to land) will fix most of those rev_info leaks. So not having
> UNLEAK() markings in-flight makes things a bit easier to manage.

If you don't mind, I think keeping this in (as a way to verify that we
really did make t5319 leak-free) may be good for reviewers. When you
clean these areas up, you'll have to remember to remove those UNLEAK()s,
but hopefully they produce conflicts with your in-flight work that serve
as not-too-annoying reminders.

I would certainly rather not have to UNLEAK() those at all, so I am very
excited to see a series from you which handles freeing these resources
appropriately. It was just too big a bite for me to chew off when
preparing this quick series.

Thanks,
Taylor
