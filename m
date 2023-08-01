Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36300C41513
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjHAReE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHAReC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:34:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4882E65
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:34:01 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-586147e5ad3so29240827b3.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690911241; x=1691516041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hu0lFDZeGDwYv5u5LrCdhihkIv4b9CsPlalNRgFOLio=;
        b=kpxVyo4n9Wb0dQVsgyjBQ7pDT2PxGDyl07vUVeR40iaIPecIy6u6T+M0bHnOBBt1Az
         MycWyoj/QY1H85767zeqmuJUzMp3doEK4iTtfO6MLlGChzKXQM1MGtInJ63KNIWSszb3
         NExEhFT0xhIG0Cxy9btbyPDovyRSxnCE0HWzPgD+o1M6B89HF7Usp05fbZ8EPB3QgS1y
         IQhb3X/jaddHqxF7ROZyI+CTbe4vFPlbA4ed5QKMur/ndhf7ZUl9rBhT73UIUlGv0uLk
         ytUjXbor1QLaTghYzueQi5C3O9u8Tz/V5PaSbQZ64NkxhWY/7rIBaKRxLsyCBWwlsVee
         eR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911241; x=1691516041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu0lFDZeGDwYv5u5LrCdhihkIv4b9CsPlalNRgFOLio=;
        b=Jph/tsKTEzKzwhHSjm227bHjeJuBrzusNbGYNtVVBATUYv4HTLML0mpFiZZ8ZIGF4I
         f391tkiqDir1c/Exq79K3O6XVpDB0e+zgMZyHPJdBw9oDcyzvibxBYTD9Uo0J4klvr13
         vaR8w0KaP4fBfJMGs2uYL+AJ6g2sm+3Xn24rH8BFeJOpTMgZh+lv5Qhg5/tCKwOEul8f
         oHBv2tI1vRosK8v4ESduxwAu2CT6Il/BJll1zOh4UyWLtUwzw1DiImO/ojFS8r8j/buf
         Ryw8mekI52pC5Op8hcLPtmXoOOJS+Mu/7357GZ4qgVpF86jt8j29Q50T90tQE4GxkSRL
         S4MA==
X-Gm-Message-State: ABy/qLZSC0PdsiPxDyZDwMScOn6lafn4O5OygJr05+DZbvuLMPBQPLEE
        2vKQt7PNnAjtFCD6MY8Cy8Rdsg==
X-Google-Smtp-Source: APBJJlGfzz1f/lHAlwje/n3sZybMHE/HLf2NarQ20ec4ZEh/XzFWAy/sijz9gkDrGZVhlSr+kKz6pQ==
X-Received: by 2002:a81:5a89:0:b0:57a:9384:4c13 with SMTP id o131-20020a815a89000000b0057a93844c13mr12102210ywb.49.1690911240943;
        Tue, 01 Aug 2023 10:34:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v186-20020a0dd3c3000000b0055a373a7e5asm3898617ywd.131.2023.08.01.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:34:00 -0700 (PDT)
Date:   Tue, 1 Aug 2023 13:33:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring
 bitmaps?
Message-ID: <ZMlCB/Pkzlb7Wvq5@nand.local>
References: <858rfnb770.fsf@gmail.com>
 <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com>
 <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com>
 <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local>
 <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
 <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2023 at 01:34:32PM +0200, Jakub Narębski wrote:
> Hello,
>
> On Tue, 1 Aug 2023 at 13:26, Han-Wen Nienhuys <hanwen@google.com> wrote:
> > On Mon, Jul 31, 2023 at 10:18 PM Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > I haven't proved conclusively one way or the other where Roaring+Run is
> > > significantly faster than EWAH or vice-versa. There are some cases where
> > > the former is a clear winner, and other cases where it's the latter.
> > >
> > > In any event, my extremely WIP patches to make this mostly work are
> > > available here:
> > >
> > >   https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps
> > >
> >
> > thanks. For anyone reading along, the changes to JGit are here
> >
> > https://git.eclipse.org/r/c/jgit/jgit/+/203448
> >
> > I was looking into this because I was hoping that roaring might
> > decrease peak memory usage.
> >
> > I don't have firm evidence that it's better or worse, but I did
> > observe that runtime and memory usage during GC (which is heavy on
> > bitmap operations due to delta/xor encoding) was unchanged. That makes
> > me pessimistic that there are significant gains to be had.
>
> The major advantage Roaring bitmaps have over EWAH and other
> simple Run Length Encoding based compression algorithms is that
> bitmap operations can be done on compressed bitmaps: there is no
> need to uncompress bitmap to do (want1 OR want2 AND NOT have).

Yeah, this is definitely where the majority of CPU savings seems to
remain. The existing implementation in my branch is much too eager to
uncompress bitmaps when we need to perform a logical/binary operation on
them.

I think with some more surgery we could leave bitmaps in a compressed
state for longer. I am not sure whether or not we should ever uncompress
the bitmaps, though it's possible that doing so is beneficial since
uncompressed bitmaps have better query performance (albeit more costly
memory usage).

Thanks,
Taylor
