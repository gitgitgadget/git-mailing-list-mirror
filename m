Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBE3C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5CC61175
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhGTGkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhGTGkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 02:40:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F559C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 00:21:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so20714838otf.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fneTaWvt5LfmlGFd4pWhc7mxNxNb8QeiB7fFByjo/Xc=;
        b=Z/0Gvs1Aa9qxyfHufLaJClUNsledHHyXBdVp5mB4MX9G1umkiK/IKlybfjKK8vtOO4
         YMCv1X69QjVkcf4QzXpu6lFRUoIvtePgFkuOpxcYjDABEu0iNu1ssiJ2bAkFw4fRCclg
         KKge60J+k9b4nTRIfVutaOu1cXCuscmAMieTuP5+Cp4jBb6jqgo0cu+2xvLikriHLZUC
         /XVCbqaCFOAeNnj4cjC0oAjUDpVXQWHthkLpMjr3/qerz9Xuzz59KdfeOWfoCl7wrhQC
         ejocENGh5CSLaxkEigqeS6g5GQehrOTD4a7beltDrfsng1vJfoU460KPy/JtaPK+jBaZ
         KIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fneTaWvt5LfmlGFd4pWhc7mxNxNb8QeiB7fFByjo/Xc=;
        b=jVCSDe/Cy8YyH7eEXEYuqxCVzqqTS0yLGRlP5FTD3R4bqC8IxFkeXUO91H32naA5N5
         rtdZHMCTBSe9L09EgQnsO5Y3tVmRch7cjbgvDJkq3NpPVAUTUB9+LGx2nxs66/A/PVGa
         jlGlrfKcjD1e4BjVz9KcAdyDk2XHQ9/DzxAykWf0BQ0i7o98TrE0eYlUPFRYCqKNQk76
         M9yXsbDs6xwzyy0GKWBUH87dSyr+GOfy2KdW5ybXycGQYzz3Mui6JWFmnq4H6KXqnIVE
         ycWaJ+IzWWhetZZqTr6KFKhdMMKPGJHxupZVD2W+2LrO5Pe79XDjBDWPapDgEMrk47j7
         fgYQ==
X-Gm-Message-State: AOAM53152ZVcXggdRR28PICmfGDfMvSfFIRyJ7JbrjuAssO02QmwEizE
        PbsV1RUEwYDd44Ex29g1lPo=
X-Google-Smtp-Source: ABdhPJwJRHVAEX/jpEvez2p+3QLMZGzcfOAEJXMNDinIJGHhOz+QudKf5xfpLe+TpJiuJoyKk5w6HQ==
X-Received: by 2002:a9d:51d0:: with SMTP id d16mr21522115oth.326.1626765677850;
        Tue, 20 Jul 2021 00:21:17 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 14sm302293otg.72.2021.07.20.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:21:17 -0700 (PDT)
Date:   Tue, 20 Jul 2021 02:21:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Message-ID: <60f6796c18a4d_14a799208fb@natae.notmuch>
In-Reply-To: <YPZtxy1/742YlrlK@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
 <YPVW50Q6oyTxQ4D4@ncase>
 <xmqqtukqkuzr.fsf@gitster.g>
 <60f5d923848d3_145c71208cc@natae.notmuch>
 <YPZtxy1/742YlrlK@ncase>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Mon, Jul 19, 2021 at 02:57:23PM -0500, Felipe Contreras wrote:
> > Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > 
> > > > On Mon, Jul 19, 2021 at 04:33:54AM -0400, Jeff King wrote:
> > > >> On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:
> > > >> 
> > > >> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > > >> > [snip]
> > > >> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > > >> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > > >> > > 
> > > >> > >  Test update.
> > > >> > > 
> > > >> > >  What's the status of this one?
> > > >> > 
> > > >> > From my point of view this is ready, but it's still missing reviews so
> > > >> > far. The lack of interest seems to indicate that nobody has hit the
> > > >> > issue so far, and I wonder why that is. Am I the only one who sets
> > > >> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> > > >> > tests?
> > > >> 
> > > >> I had marked it to look at, but just hadn't gotten around to it. I just
> > > >> gave it a review (but the upshot is that it looks fine to me).
> > > >> 
> > > >> I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:
> > > >> 
> > > >>   GIT_TEST_OPTS = --root=/path/to/tmpfs
> > > >> 
> > > >> TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
> > > >> (--root predates it, and was written explicitly for the tmpfs case). But
> > > >> I also think --root is more convenient:
> > > >> 
> > > >>   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
> > > >>     will run locally, which makes it easy to "cd" in to inspect the
> > > >>     result
> > > >> 
> > > >>   - likewise, I find accessing the results in t/test-results/*.out a
> > > >>     little more convenient
> > > >> 
> > > >> But all of that is preference. I don't think you're wrong to use
> > > >> TEST_OUTPUT_DIRECTORY this way, but the above points might be
> > > >> interesting to you.
> > > >
> > > > It is, thanks a lot for the hint. But given your first point about
> > > > direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
> > > > contrast to `--root=/path/to/tmpfs`: especially in the context of perf
> > > > tests, I never run all of them together given that it takes such a long
> > > > time. So I instead either run them directly or via the `./run` script,
> > > > and in both cases I definitely want to have them in tmpfs given that
> > > > there's a lot of disk churn if you're using biggish repos.
> > > >
> > > > Patrick
> > > 
> > > Thanks, all.  Let me mark the patch for 'next'.
> > 
> > OK, if you don't care that TEST_OUTPUT_DIRECTORY is broken, so be it.
> 
> I just think we shouldn't strip away features if we should instead look
> at why the testcase is broken and how to fix the root cause.

I mean, we didn't really strip away any features, you just happened to add
one feature at the same time the fix was proposed.

> I'll send a patch in a minute which fixes the testcase without
> dropping support for TEST_OUTPUT_DIRECTORY.

OK. You mean without breaking functonality that is flying.

-- 
Felipe Contreras
