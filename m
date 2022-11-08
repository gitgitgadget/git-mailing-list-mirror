Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34889C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKHVws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKHVwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:52:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93561BA7
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:52:46 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d123so12565303iof.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+P/ef6JxeH5LYzHpzMRzDOUEVxLhIzryRKs9kdVRhis=;
        b=K4rnN3X21AUWZCDHvk3dUAwxK1A7RnUBkMn/42KnpEEvDinvBC2ldkYOeR1Np66hBS
         skJQSn4t1HrIciXvDtxm40JmhHSgVAfXtQ0in4oaLbkA0HfxeFiNMKl5EKZizV/c/0nq
         5NZ+g7aOcMUEI/HQ8bzSTB3TJi5pgIp5C33TG7DSeosBUVKGZVDW2xf3HB3jWvWEzZZF
         vdzoNGAzmzIFzSr9CdumfViJfmW2K6KZN+waVUX0pME5WZ1DP/R8G4+94/Nn5eOORYVA
         0FEqmMsjMQWnDlVNs+dkmu4IAJlT9GlqHQJSaXlfk7ipQinIsNg3mjAPZ/t9hriCrH5a
         ZL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P/ef6JxeH5LYzHpzMRzDOUEVxLhIzryRKs9kdVRhis=;
        b=0l9BHUCU/0RGiLxARm/rc5C42cOVMU6r9E32IkCjJvNNx7TMrNNJLV7PQkzT4Gc89e
         75oj476tVJE5njcsAAOyeOu2u0dtOeBrDs1CbCDfbZqS4yPuT3PhRL3xsjtGMo3W51K5
         b0v0xqeHIhilH8PTrAKUsXPFGhC2yvoBAa454QxnR88hFDwz8DSCUHCD6jXr/E2tf1qd
         nFhc31VDwKWA/ze2BvLYzH00R0RRzzOx48EdjJqVH3ozMS5sPPqynTJ1IA3HDie5xolh
         tG69Xm7Kbnim7zIq40zG4llRIdFYKcd7N9Gal0rsDGU15KvjHlUryM1+n+yi743k8lt7
         pURg==
X-Gm-Message-State: ACrzQf3cXDs9sc0euNcfBexbhLoozxM3rOUBwgjlqOuDGi8iPE+xoobu
        0Qcbgo6Hw+2WMhXj+zdc9y1gxcKqWp0SxOA7
X-Google-Smtp-Source: AMsMyM6OHQX81TRP3NXeUcuy/hzHMHMtlag0ZhECY5wB3TXE+9ARvWbHdtn2LJpxNwO+rb+bHTX0Lg==
X-Received: by 2002:a5e:aa03:0:b0:6cd:6e75:69fd with SMTP id s3-20020a5eaa03000000b006cd6e7569fdmr1096777ioe.49.1667944365899;
        Tue, 08 Nov 2022 13:52:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f36-20020a0284a7000000b00370decbbff3sm4091737jai.148.2022.11.08.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:52:45 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:52:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: ab/make-bin-wrappers (was: What's cooking in git.git (Nov 2022,
 #01; Thu, 3))
Message-ID: <Y2rPrNz6BD6DlRcO@nand.local>
References: <Y2RldUHTwNzmez73@nand.local>
 <221107.86h6zax26k.gmgdl@evledraar.gmail.com>
 <Y2pnZic1mi205/MQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2pnZic1mi205/MQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 09:27:50AM -0500, Jeff King wrote:
> On Mon, Nov 07, 2022 at 03:33:40PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> >
> > On Thu, Nov 03 2022, Taylor Blau wrote:
> >
> > > * ab/make-bin-wrappers (2022-10-31) 4 commits
> > >  - Makefile: simplify $(test_bindir_programs) rule by splitting it up
> > >  - Makefile: rename "test_bindir_programs" variable, pre-declare
> > >  - Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
> > >  - Makefile: factor sed-powered '#!/bin/sh' munging into a variable
> > >
> > >  Resolve issues with the bin-wrappers/% rules where "make
> > >  bin-wrappers/git" would generate the script but not "git" itself.
> > >
> > >  Waiting for review.
> > >  source: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
> >
> > On my end I'm waiting to see what you and/or Jeff think about:
> > https://lore.kernel.org/git/221101.86edun5tgn.gmgdl@evledraar.gmail.com/
>
> I don't have any strong opinion on that. I read the v2 cover letter, was
> skeptical/confused of the motivation, and didn't go much further.
>
> Your explanation in the linked email is that there are _other_ reasons
> to do this refactoring, but I don't have any knowledge there that would
> add to the review. My gut is still that building bin-wrappers/foo
> doesn't need to depend on foo, but if it's one line, I don't care that
> much either way. If it was 50 lines of complicated Makefile refactoring,
> then would probably not be worth it.

Isn't this topic exactly the latter? IOW:

    $ git diff --stat master...ab/make-bin-wrappers
     Makefile | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
     1 file changed, 52 insertions(+), 20 deletions(-)

...maybe that was exactly your point ;-).

TBH, I am not sold whatsoever on the premise of that series, and agree
that plodding through 50+ lines of complicated Makefile diff is
difficult to justify when the premise is hazy to me.

Ævar, any strong objections against dropping this one? If there is a
simpler way forward, I'm all ears, but in the meantime I find it
difficult to justify the review time as-is.

Thanks,
Taylor
