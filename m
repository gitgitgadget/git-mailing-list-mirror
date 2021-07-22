Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880FC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A446128C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhGVNgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhGVNgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 09:36:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC3C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:16:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id w22so6511477ioc.6
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k89HgtamXhQtwvS9Fe1StJyKaV6946DfKt4nArgByJA=;
        b=Pti0d8JL16oDOAyF+4B0X4EoEuvprFNSsMDFsu56xTfRJmZXAtmGwFFYQTAdXIiZ+E
         Y9aZZOsX8kTxGaobSxa02QuEuCyDcBl+orhWTuKBSOmy85ZbIx6t4IsKLnuSjf7LU4dM
         xFr5GuIfth9TauSOQ/BLLhm6TY48Lq7rzqLp23npAXLxDbjzplcya2xJ8JzUs6W5zeE6
         lq53hsL5hx5cTF+n6+pdh2k2/0HokHf32z/BRzLCLgapcsiYMAqYyi7oFtuFmshjmu7Q
         G5npm/lQPiQ1UckoV8dyk2FnmTRYNN7hZano0gHJAW6kUB+Zb9FQ3f5zU9EQWA3309kn
         zWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k89HgtamXhQtwvS9Fe1StJyKaV6946DfKt4nArgByJA=;
        b=BE7sl0+xpbPDbKesjPqVhZf7bVoIGxWRFq7w4ITTQgbwCcp9AfGUyaklU/2tiD0nTV
         EQ5oxJVdSboG8RGAA6yuHjhMRuU+7XnLa52rv9a/iDBNmY8KxsjF8H9XbCuPhMrMzy9H
         tljHJxm7NMdKBG9HEQS4ym/4mXDVyA/cWp4NAYvlTfT7hHIzt1M2ApnXgbt+vatQy3Pb
         XCsxgTr156OwEwSQg6Et0Say05yzAAVGGWYy+t7ntGXtNZN27OTk6hN1PB+4EvfUhYqc
         fYZioCv3JqGTs8KhaDNUswojGRHIufjSCB2xTeeCwGn2ZUYB1lcn0wGUIVEM7u+2M07n
         G3EQ==
X-Gm-Message-State: AOAM531pupiG+QB9ZQ3E0Bp5sZfEqFjF2lGeLkkYVGUPoslQ7qFmCD/D
        AXN6G8AqlOtMbgKwBG71mPND2Q==
X-Google-Smtp-Source: ABdhPJx/eWU7bRzzIk9RfhpG25hkTkE3bGKwmWzHhXU4/gI6Fqf7NEk41Sks1J7cJPRqK3OVC2nqhQ==
X-Received: by 2002:a5d:85c1:: with SMTP id e1mr33673ios.18.1626963412609;
        Thu, 22 Jul 2021 07:16:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h24sm15095486ioj.32.2021.07.22.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:16:52 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:16:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jul 2021, #05; Wed, 21)
Message-ID: <YPl90eSyuovU3CvT@nand.local>
References: <xmqqo8av9j7f.fsf@gitster.g>
 <87a6mevkrx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6mevkrx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 09:33:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
> >  - pack-objects: fix segfault in --stdin-packs option
> >  - pack-objects tests: cover blindspots in stdin handling
> >
> >  Input validation of "git pack-objects --stdin-packs" has been
> >  corrected.
> >
> >  Ack?
> >  cf. <YND3h2l10PlnSNGJ@nand.local>
>
> Have re-rolled & addressed that, I think
> https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/ can be read as
> "sure, let's take Ævar's v2 as-is", but let's have Taylor Ack that :)

Like I said in the thread, I don't mind what you wrote (so you can take
that as an ACK from me that I wouldn't be sad to see it get picked up),
but I do think what I suggested makes the test easier to write.

I don't care enough to worry too much about it, so if you're not
interested in polishing it further, then what you have is fine by me.

Thanks,
Taylor
