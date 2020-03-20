Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A6C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291AD20739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZkmG6Jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCTA5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:57:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44257 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCTA5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 20:57:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so2341677pfb.11
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tp9FYLE4Rwe0Lgg+IO9D3ZgO1L3F4ywYTLOmIBFePbQ=;
        b=qZkmG6JnI2rcYV4NyPYYlJ7Y7wuCAJLV/PNLIgP8IAwpxDHU7nnxtXibKdlAvISSAA
         OZzkHiqr0X15XrhNRjdUDVJAM9xJJZBSMpXVd6NovBaeloTskh/ff/IsrtHK7a/EZ62d
         pnM2KeFUMg2vQqXIEFEea5ml9AvSopUkDvSNzWsOCX+dVGEECSTjATTVTdSLIkHhg5fj
         b1Q50YQZpuGK4GU3GJQG9KFT936u6BbvLZySDbNR/uOuuPX8ncOPJju8vgVnLyku9vPL
         cz8DyQODHS36Aii4EndifXCuSiCBGtKwfSoXIXwET5qx+bWwc2tyCHSY8O4h9K/gxVWG
         53vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tp9FYLE4Rwe0Lgg+IO9D3ZgO1L3F4ywYTLOmIBFePbQ=;
        b=umzvZVqSLzuafSWLGMQZYYLH9OFFcEKlewlqvksL2ZXp7u52an2oGpha02Rb4VjuAh
         ggfX716Qqa9XAjRfUJtr8N+y+TSjjqJaw3PvFi4OKeZBK7RO98y5kODDO08xH+kdjx0Y
         nMA8jo8ZoGZpRD/WnImhKqowtqmmd0HOvyoZaWUil3HhpRzvvtrKnmaYaWNwnjL0jOG4
         xTWvd67lw1SziSTZzY2g4uPsxWDjZ44QqtjVCWAu3vY0B65xnhHpJGH1ngf5VlgfAqpV
         A2OTVGGYVtxIGoG4VFFuajCWLQXRZjsS6bfk+D7Z2OKtkMEctFTl6WJzujvUu4p43leH
         I89g==
X-Gm-Message-State: ANhLgQ0Gdn8m9e7j16TETkHkDQRQbrN7LcHeSR6sN0s8r9IRJ2+i1A8C
        7w1iyNes6A8MFMwQXPTxqSk=
X-Google-Smtp-Source: ADFU+vuEdg+iCYZZuGQiwr2RoLubGxXAEMhPvKYqqsqGOFAmz/uZgwhHP63qE68WjnwXMyjfFe9KPQ==
X-Received: by 2002:a63:f113:: with SMTP id f19mr6399201pgi.168.1584665873849;
        Thu, 19 Mar 2020 17:57:53 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id f127sm3408953pfa.112.2020.03.19.17.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:57:53 -0700 (PDT)
Date:   Fri, 20 Mar 2020 07:57:51 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] t5616: use rev-parse instead to get HEAD's object_id
Message-ID: <20200320005751.GC1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <b9beadcc510301ba385f1b01b653024c8f369b49.1584625896.git.congdanhqx@gmail.com>
 <20200319160707.GE3513282@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319160707.GE3513282@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 12:07:07-0400, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:05PM +0700, Đoàn Trần Công Danh wrote:
> 
> > Only HEAD's object_id is necessary, rev-list is an overkill.
> > 
> > Despite POSIX requires grep(1) treat single pattern with <newline>
> > as multiple patterns.
> > busybox's grep(1) (as of v1.31.1) haven't implemented it yet.
> > 
> > Use rev-parse to simplify the test and avoid busybox unimplemented
> > features.
> 
> That makes sense. It would also future-proof us against the test
> changing the graph such that HEAD actually has ancestors.
> 
> > diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> > index 77bb91e976..135187c5b5 100755
> > --- a/t/t5616-partial-clone.sh
> > +++ b/t/t5616-partial-clone.sh
> > @@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
> >  test_expect_success 'verify that .promisor file contains refs fetched' '
> >  	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
> >  	test_line_count = 1 promisorlist &&
> > -	git -C srv.bare rev-list HEAD >headhash &&
> > +	git -C srv.bare rev-parse HEAD >headhash &&
> 
> Maybe worth using "rev-parse --verify" which would double check that we
> produced a useful hash (it seems like an unlikely failure mode, but it's
> easy enough to cover).

Yeah, I also thought it wasn't expected to be a failure in this case.
Using `--verify` doesn't cost anything in this case, though.
I will add it in the reroll.

-- 
Danh
