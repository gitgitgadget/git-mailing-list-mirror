Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA964C001B0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 00:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbjHPAjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbjHPAjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 20:39:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D6BF
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 17:39:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58cd9d9dbf5so83067b3.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692146341; x=1692751141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nu1btfnkZoBT9lD/u3z4WJKx2DeRsHt5k93Gb9KPrAw=;
        b=Tc42Nez8hw2mo1EaCbqJUuYT038TZ5097LCheGsyaNNtHa9QvVlRgkD6jql2UlJNKX
         d6qvx5SqEeHuQ9bQA2FvRbHuF1vR+UOA9662xf6XlCufsqH5Tu7nCPFDplpft1BK/L4f
         ND8coLKMvdEsDhaFi/SXMCataKzX1QCg5w/CIf7f4wC5i4jz6WE88qqgxaDLgGu3G6L8
         dF+nzGkOVsuDymU2vUuiA74akUvI+coaks81hNpr8uO+Bv8eoelkuLXumgftyDc9G332
         0L8sfWr9zHCA59pGnvBWeCypmeYdS3+6TlO2sw868kbi+OP2k9BxCKTVnFuABLorHj+2
         kerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692146341; x=1692751141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu1btfnkZoBT9lD/u3z4WJKx2DeRsHt5k93Gb9KPrAw=;
        b=BTjXb+0oH/8AxgEkeRkiVjfKWSGk8GgirO0kONmaw7OJLxaqymFqbHlATHfhlFPzrt
         vqTfk4D7BvGHARGn4ZcgzhVMtcWKUzdlIRKmGBWfrnTJR1Z6j0BWJAYXrSsliXUNWUTz
         +AFmeeBb9Vzc5R8FWUJmiHnxy85Sa0wxRCrsy9WnEgztKy86SrZ4yU246mNqMCSX9qwo
         YTENne9jsHROtBj0Trdl4YobUbHhG5TxvIlYdFBlKchbVpJCKYnnc71MipCYDpCTnKZ2
         pITBvdGk48Yfji/YtwwR4HWYem5FTYjyKJ5b8zyXB7bDuxXLCkXdVrkcPfKIFkCYN+a8
         0i+w==
X-Gm-Message-State: AOJu0YwEFW1kNDwUJ25Y7GWc+NU4UTu0T3Kg4K6EhHWlZQJq0qXKddeO
        JEwFajO6WfveBu7BRQHbtSZzbbNxDrp4nGrMN8Qpdw==
X-Google-Smtp-Source: AGHT+IEjX8K/1IFPa1p3jsu1NXRlyoD2Q6c9FC6Bchxw1bgrLfZtgPcNLOVBbNe+hPUZxSBc/IJSjQ==
X-Received: by 2002:a81:4886:0:b0:579:dfc5:20cc with SMTP id v128-20020a814886000000b00579dfc520ccmr4153868ywa.17.1692146340802;
        Tue, 15 Aug 2023 17:39:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h129-20020a0dde87000000b0056d31a089e9sm3726442ywe.126.2023.08.15.17.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 17:39:00 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:38:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZNwaoGBNrpdzlPUq@nand.local>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
 <xmqqv8dhjfgm.fsf@gitster.g>
 <ZNvxg7BVJ+C5XFY4@nand.local>
 <xmqqjztwgcnc.fsf@gitster.g>
 <ZNwFlcS3SOS9h77N@nand.local>
 <xmqqfs4jhp3p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs4jhp3p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 04:18:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But why is that tree marked in the first place? It's because we attempt
> > to rebuild the bitmap from the existing .bitmap file, but fail part of
> > the way through (when we look up the first blob object in the reposition
> > table). But that happens *after* we see the tree object, so its bit
> > position is marked, even though we didn't rebuild a complete bitmap.
>
> So, there is another bug lurking, other than the lack of "combining
> filtered repack and bitmaps are explicitly forbidden" logic?

I think that there is a bug lurking in the sense of trying to reuse
bitmaps when covering a pack that doesn't have reachability closure in
this particular scenario.

But there are no "blessed" use-cases for doing this. So I think that we
should indeed fix this, but I am not immediately concerned here.

> We see the tree object, we immediately mark it as "done" even we are
> not, then we finish in failure and the "done" mark is left behind?  Do
> we need two bits, "under review" and "done", or something then?

No; we can either reuse a complete bitmap or not. So it's fine to OR
all of the (permuted) bits into ent->bitmap, but it's not OK to fill in
just part of them.

Thanks,
Taylor
