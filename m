Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1273C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9577613AD
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhFAQn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhFAQnz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 12:43:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27638C06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 09:42:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so14697669oth.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2rgqozFQa15vLftyXDo2h9Xq1vClSefgin89tnw7/Y0=;
        b=TvEHi9VFxYq37CkW6lqG8PWF5enQSZ8/ru8mvABnyB973Np2qD2iYEymUelsgiZfmx
         FDenjxEJkMm91b6PB5Oa47kG3M7RhhxGIcgijG8qWWOEMx4W5d/nd1cA7zEYvlPqhKQO
         1ixpTM7HAZxXnZohZhP7wMZymW0hWsTAqlSDaKQcTKBLBwiuXQj0ZZ8WJxIdEGS45fXs
         SobwCdj40fr/SArE29iyt8worIHcFy5+ywyEE+mtDdCtxoPA6trop5pnHaQ4A6r2deZH
         Y+snYYq3Tt/69etavTEnOE9iIfwNMeQF64BhNR7TFQEGKAdzyjYSWP6Tu/brLy5qed/+
         q/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2rgqozFQa15vLftyXDo2h9Xq1vClSefgin89tnw7/Y0=;
        b=aM1ylDyjP1DHynkqcNkobk9hmiTVU9WVHTDeH0RimiU6lXA4EqSLAPtQ4gbPYJjQKL
         tZvXwP+eOuTrTyJVEUEPqtA20+uz0LwU8nDDsd01HuX2KHGP8VwYoaLqrsuBreOnzxqn
         ith8SyH5wkZfSZHwR9mMo/eY6NJ1M1800jO43xuLZBjRfHYZfzU3KtFyynh5rr/lYmQk
         HNZ5aWLyT75osIdgiVI5Vp0it2tN8RKzhw3RpTvzMGEQOZMHG0EvAXitVP/gN/0tw5tl
         ABoqaCHFBSI1Opv3w/QEif4Nsr2J/tF8xERSGQqWPnEDjyQYeALtyzCIqjJrQ38G/DtB
         sUog==
X-Gm-Message-State: AOAM533p8nRtpxhxMRh4KQvQVXUPEZF8VfGprG4zhdf5/lcuRaYIds4B
        1W8hzMRSzhpzmfZGzIme6wA=
X-Google-Smtp-Source: ABdhPJwNPDWS7ikIsKRvEHV59BHzB5SYC8debu2QRsG2hufFSPSnWpLya4EhFWcriAkIsHeS/h0nJw==
X-Received: by 2002:a9d:73d8:: with SMTP id m24mr22150577otk.269.1622565733483;
        Tue, 01 Jun 2021 09:42:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n127sm3462609oif.55.2021.06.01.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:42:13 -0700 (PDT)
Date:   Tue, 01 Jun 2021 11:42:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Message-ID: <60b66363cc293_3f42088c@natae.notmuch>
In-Reply-To: <YLZTmzvuRpgY935A@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
 <60b509be97423_24d2820856@natae.notmuch>
 <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
 <60b5d4f87f30c_e359f2085e@natae.notmuch>
 <YLZTmzvuRpgY935A@coredump.intra.peff.net>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Jun 01, 2021 at 01:34:32AM -0500, Felipe Contreras wrote:
> 
> > > > I use ruby to parse binary data from git all the time:
> > > > 
> > > >         git log --format='%b%x00' |
> > > >                 ruby -e 'ARGF.each("\0", chomp: true) { |chunk| p chunk }'
> > > 
> > > I doubt we'd want to add a ruby dependency to our test suite, but sure,
> > > we could do the same thing with perl.
> > 
> > I don't mean in the final patches, I mean while the patches are
> > being developed.
> > 
> > Once it's clear what the code should do, and how to verify it's doing
> > what it's supposed to be doing, we can decide how the test suite should
> > verify it.
> > 
> > Ruby is great for prototyping.
> 
> If we are not worried about the test suite, then I would think viewing
> the output in "less" would be the simplest way to see that it's doing
> the right thing.

No, I meant you write the test case with ruby and once everything works
you decide how to replicate the same with something more widely
available.

Sometimes I decide to delete the test cases I used for prototyping
because they are too convoluted, test something very esoteric, or it's
not easy to do the same in CI infraestructure.

But they helped me write the code.

Cheers.

-- 
Felipe Contreras
