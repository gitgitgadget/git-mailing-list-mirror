Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A5C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE30C60FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhJZVdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhJZVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:33:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472CC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:30:48 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h20so753321ila.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MnmPT+CcLr9cA3oRG/uStODklaOMMlQSUoojNpmo8CA=;
        b=TohY2itpOT99bM5Ae/5gf3utW/PW3auc2QVokHO13HzX7Zhsi6UPu7hwTIqCeqghf1
         dNrQbwqGpHl5gC1DEI40j3HgF8HqWF0FamT2y/cnHWYJb6mi6m2Z8Z0cgXJz/V93eA5g
         TK9exv2GsbK7Vm+gqNZ2+DEcjytvp0X0/JhaEaShRBFSAuTEeozUPGHpK+BcjjZTtXAi
         daZhw8dyiKx20IYf55G11k5XSblVWXDIS003P8h71v9T7QptvHO6Q7Jn3oEeYWqNloVL
         1vIBrc1WUXu0I8KOVL70BsZW7B7IB1HGZBWwRfURKKY91lUOOQLeIZyXb2OW+e4xn3dd
         EKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MnmPT+CcLr9cA3oRG/uStODklaOMMlQSUoojNpmo8CA=;
        b=XZOF9OnVKtvu/NuYjIvbhV4WpskC3vYFMheeItShfPmyQa7Tc4/2NBxrl9qn+A3EPF
         d4Fx0+ZGn0LtKMErZlsOTzRsHHdopZaX42QR2h3wCy+oDAc+5HHtUavPFOLGvCN1M8Ue
         +702SeYhQkAkOoXTL6pS+iS+JSNyYEdUOsnizjhtu0oog0DtowcnLsLwDbOT2hgx8DkZ
         NFKgaA9aWvGrLGCVSkyguYkqWSL8W3Df7Db1QRAB3u80O6IFzwjqVbuersIXiNqFO7ne
         N0fTn6XANKdZtx1ql3UAX+RDpp+ClSiF+GOC57YjneSSqMxZkzfd5qTbCT/RhElMH5y1
         gQIw==
X-Gm-Message-State: AOAM53072whlVO4amVgbbeU+qm+Bj5XX5ASlWfNiLQ1NhiKtO7xtSTCB
        BUPcjrOrE8txIJxHnvZl+VZgMg==
X-Google-Smtp-Source: ABdhPJz5IsJ3VQBNfK63VMbsz9U8x79k03JpIp9fCtifcTZHuGFLIPDxglVBeIkuxKSrSMBXvl6jfA==
X-Received: by 2002:a92:c541:: with SMTP id a1mr16021173ilj.61.1635283847956;
        Tue, 26 Oct 2021 14:30:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z11sm10265370ilb.11.2021.10.26.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:30:47 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:30:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXhzh+pW5KvU7MEA@nand.local>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
 <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 05:11:29PM -0400, Jeff King wrote:
> On Tue, Oct 26, 2021 at 04:23:14PM -0400, Taylor Blau wrote:
>
> > So this all feels like a bug in ASan to me. I'm curious if it works on
> > your system, but in the meantime I think the best path forward is to
> > drop the last patch of my original series (the one with the three
> > UNLEAK() calls) and to avoid relying on this patch for the time being.
>
> Bugs aside, I'd much rather see UNLEAK() annotations than external ones,
> for all the reasons we introduced UNLEAK() in the first place:
>
>   - it keeps the annotations near the code. Yes, that creates conflicts
>     when the code is changed (or the leak is actually fixed), but that's
>     a feature. It keeps them from going stale.

I agree completely. I noted as much in my message here:

    https://lore.kernel.org/git/YXJAfICQN8s5Gm7s@nand.local/

but Ævar made it sound like his work would be made much easier without
the conflict. Since I'm not in any kind of rush to make t5319 leak-free,
I figured that queueing the parts of that series that wouldn't conflict
with Ævar's ongoing work would be a net-positive.

>   - leak-checkers only know where things are allocated, not who is
>     supposed to own them. So you're often annotating the wrong thing;
>     it's not a strdup() call which is buggy and leaking, but the
>     function five layers up the stack which was supposed to take
>     ownership and didn't.

TBH, I find this much more compelling. Either way, I don't feel strongly
enough to deviate from v2 much, and I don't want to create more work for
Ævar along the way.

Thanks,
Taylor
