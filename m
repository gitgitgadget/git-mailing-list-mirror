Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B544C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJUXlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJUXlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:41:45 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27582ADD24
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:41:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z10so20141iln.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb30nqNeb1d9kgG9L36R3w7CReTJFfo+p97ruTR95zc=;
        b=qCJm6wGEkEGLEoNcccySWAC5GfkIOidImpE/jxySsaui236Zz6oPGOYk82MWz1ejBp
         rx9niRyE/m55FBJWJ893f5JqZbkbo5kHhmhC6MwJcA25qPiNPtvHw/P8yAUnALmiF3cV
         MGprm7IsS/mRb3Z5ZEVGe4KlYQ/rDdrLxfU2xD8+Gk3F5wvSjZQ+GATUAVX1o+snwMss
         5y4WxEQ9otqOJBbVzzNMv3zSOOOVOXSq645HoibDX2JoEmhxyLzDlV+1l1tOdmR1rfUz
         zwNG0DobiLJ3DlQC6gDELUfzIiqDP5NiGavxmXDQbuQ2qu2HhvovmcHIWDXpwLoEJnr3
         d6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb30nqNeb1d9kgG9L36R3w7CReTJFfo+p97ruTR95zc=;
        b=CJZVKVwDctwZ083kt2qpgLy6L+Q0EiqGjQLA/InXNp3VBUP6zb6zEiediDB4I9IECr
         ftVEKT53p4O3q1TN59QYZnvLPwhWOv4GOw4MG3ztg6JISVFaLjD/FoEA0XngC8RYvX6f
         N+X4ftpIqoTuL3jm44qZmS86FJpVPw994R4QHGrV2IKMsEPStPVZ7VkvdF0GL0NEMS0K
         BzTsHJYYdhytgqAX/EGXJuLfX+xiz7M102CFn2zpXwNURwNfg7t41S17e7W2nyJnHPXI
         BQWZqUdqTOQqAx+YQ6lDUBE8iEYjzXVrjngVJ9fw7S+FSfVQhoLnNBVaseA3uxEbw2jC
         UWMQ==
X-Gm-Message-State: ACrzQf155aACGMQDhO3G2isNCCq0SYN8NeGJCGggph4BWyHscDJQAzav
        u9CwrHX7TWyWltHqQ/pR3XQJwS3AJEs5Sprh
X-Google-Smtp-Source: AMsMyM7C67UwiW1kgsROkTkPD7FB5bbkOLc5//Sw+BKq778CVPGOVubIoQjRnomIq9rDYeDiuOr0Dw==
X-Received: by 2002:a92:d70e:0:b0:2ff:8bb3:2712 with SMTP id m14-20020a92d70e000000b002ff8bb32712mr3217282iln.316.1666395703257;
        Fri, 21 Oct 2022 16:41:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u185-20020a0223c2000000b003638d00b759sm4647982jau.54.2022.10.21.16.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:41:42 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:41:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 2/4] repack: populate extension bits incrementally
Message-ID: <Y1MuMJT0ntvoTeUZ@nand.local>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSkubbDBh0Ma1G@coredump.intra.peff.net>
 <Y1MpUHBQtq8uP5Uy@nand.local>
 <Y1MsdAgL8fdIRtxH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MsdAgL8fdIRtxH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:34:12PM -0400, Jeff King wrote:
> > which still lets you eagerly keep track of the generated pack extensions
> > while also protecting against forgetful callers. Obviously we're relying
> > on a runtime check which is going to be somewhat weaker. But I think
>
> I don't think we need that. The renaming loop a few lines below will
> happily segfault if anybody forgot to populate it. With a less nice
> message, obviously, but if the point is to notice a bug, it will get the
> job done.

That's reasonable, I think. I'm happy to abandon that suggestion :-).

Thanks,
Taylor
