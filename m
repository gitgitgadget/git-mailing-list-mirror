Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6CC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200E922266
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 23:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CVudprRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgJRXnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgJRXnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 19:43:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B0C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:43:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y20so10972617iod.5
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=npiVkdTeaX7idikLUSQ1wcVMfKsseqkG1KW32SQiGaM=;
        b=CVudprRYacTLQEUXx+OrNyN87LZzrXLxAU/5f4V+mHGS6QlrurLAU2U/utn6Kj7Xj0
         qVdTmOQYQPU8yXTBx74PTl8R+JJqxSOxEE4R9JZSQHHx0yRAdcigOebLf3piD4ppPKoB
         JrqSeAivV+Uf3ioMCaVKqHpnQwb1iSRr3eb9ZNrbTdz74EV0ogBhZRoBf/sQdis7VuMA
         u5Ck7oOtlOW8VSgUkocevN/qWpLej+AWJgitfSLtjzxBJ96xZg7QqLLfJ9NEBBqAdh5F
         Qf2JzQ8qgYOqxkmi6W1PPMFWns704FjPP7yMeGAeUhQ3Ctu1Lv73I1PckRVKlZQDz7m1
         Du2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=npiVkdTeaX7idikLUSQ1wcVMfKsseqkG1KW32SQiGaM=;
        b=svIjYKuI+O/Obn4l1p4PcPtg/tVF+eFS/MaA8GvpAh/0YFse5+VI0PktKX1lnUzlEu
         9W/a6m21arPGbDNzFvfBMosJEPwtHgoNZUioKXYG70VmfKlIGmtgJqpGcNyoXjE5StPe
         ORo8rtg0EE0awXAnuihHRURW+02ugi1lI65kHmnu4Pfiajk1UGRXvxfvwX/I5/PGehym
         2PTOKO77Pbf8smcRRvD04HJMAeBWV6IOPsySNkdv+4rVUcBgrTSn8V/surkFt4mIKE5h
         RRROhaxFPLSJDa3noQvoVmM2OughBn0jl2TP7QfiaBOPysVARivE0JrQDFMiIvC+kkEc
         Rucg==
X-Gm-Message-State: AOAM530aXCnlTpl7392DP4FAJRJFQDPurkmiR7mYp2KSMPtM93862rI0
        hvzytw10D1CQv4ODBQp5mPCuow==
X-Google-Smtp-Source: ABdhPJw/ssw/cE+1rbF655A/wOesKjvTM03urhDuI9nFPo8Y8XUwiN/9l0IoCdF6Cc63XdvE92z2TA==
X-Received: by 2002:a6b:8bd7:: with SMTP id n206mr8742015iod.13.1603064629154;
        Sun, 18 Oct 2020 16:43:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id k198sm10002865ilk.80.2020.10.18.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 16:43:48 -0700 (PDT)
Date:   Sun, 18 Oct 2020 19:43:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
Message-ID: <20201018234344.GC4204@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
 <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
 <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
 <20201018041642.GB2262492@nand.local>
 <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 10:02:04PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Hmm. I do agree that I'd like to stay out of the business of trying to
> > figure out exactly what that trade-off is (although I'm sure that it
> > exists), only because it seems likely to vary to a large extent from
> > repository to repository. (That is, 20% may be a good number for some
> > repository, but a terrible choice for another).
>
> I think both of you misunderstood me.
>
> My question was a simple yes/no "does there a trade off exist?"
> question and the sentences with 20% in it were mere example of
> possible trade-off I had in mind that _could_ exist.  I wasn't even
> suggesting to figure out what the optimum cut-off heuristics would
> be (e.g. solving "when more than N% paths are subject to diff
> fsmonitor is faster" for N).
>
> I was hoping that we can show that even having to lstat just a
> single path is expensive enough---IOW, "there is no trade-off worth
> worrying about, because talking to fsmonitor is so cheap compared to
> the cost of even a single lstst" would have been a valid and happy
> answer.  With such a number, there is no risk of introducing an
> unwarranted performance regression to use cases that we did not
> anticipate by adding an unconditional call to refresh_fsmonitor().
>
> But without any rationale, the performance implication of adding an
> unconditional call to refresh_fsmonitor() would become much muddier.

Aha; thanks for clarifying. I'm glad we agree that finding 'N' would not
be worth it, or at least that showing that talking to fsmonitor is
cheaper than a single lstat would be more worthwhile.

Nipunn - I don't have fsmonitor/watchman setup on my workstation, but if
you do, some numbers (or an interpretation of the numbers you already
provided) on this would be really useful. If you don't have it set up,
or don't have time to measure it, let me know, and I'd be happy to take
a look.

> > But, I think that we can invoke watchman better here; the
> > fsmonitor-watchman hook has no notion of a "pathspec", so every query
> > just asks for everything that isn't in '$GIT_DIR'. Is there anything
> > preventing us from taking an optional pathspec and building up a more
> > targeted query?
>
> Yup, it is what I had in mind when I brought up the pathspec.  It
> may be something worth pursuing longer term, but not within the
> scope of this patch.
>
> > There is some overhead to invoke the hook and talk to watchman, but
> > I'd expect that to be dwarfed by not having to issue O(# files)
> > syscalls.
>
> "invoke the hook"---is that a pipe+fork+exec, or something else that
> is far lighter-weight?

The former; see 'fsmonitor.c:query_fsmonitor()'.

Thanks,
Taylor
