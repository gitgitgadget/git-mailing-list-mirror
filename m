Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F7C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2808160F6D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbhIPTCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbhIPTCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:02:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDBC122743
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:31:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so10995670wrb.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xnIHpzt9SCUIyy0rJGaeJ/JoPvsNlspP3BccfkKC6rY=;
        b=gnTnTtE0T3DViFqchmexwVyHHUsqGAoh+u0pHGgEJKKi9fhnFfb8EL59UrYhgp/jdj
         KhrXtlg/3SYLwWZGDAMSadHU5IXWTpJ/dj0JLDcFLYZW/XtVko+pBQSMCgVT099s8FM/
         a6U0VZjcFzdUrlyFFqhrriMuptshffsQCb5fiIdfPJp1QO6NnzW8aVaCk5gCxnqbRWp9
         p4rYTY0ssqfg8QKlijQBY/eTJ4keEdGpkx4Q/J1bVqqZPMMIkZxAavJEZx1yEi/zfm8F
         FB8s4xLSTM6xpzKBuwRjrQgjqsa6hFaHagjA1F3yNc3GrV+J7scW2mmPj8TUuAXT+faz
         HfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xnIHpzt9SCUIyy0rJGaeJ/JoPvsNlspP3BccfkKC6rY=;
        b=z0tmcnq2ZRnzIOoG2PjJrtgJp8pWaGnCG/ZO+mP16IZ3HFHIs55r2EYSP4Sh2rkZx5
         YxwQtb5vt3+jkGdXSZIvO1Lf2NAYR9QLODRLKel4Kzb8WAW5HrDr3HRYUsGAoSZPl+S/
         VVyIloziHOn1wKRyEv++nVZvfMzaCzjqd2P5pt0FH9+lNxqODZNuA2de+vVTR3iQAxYE
         J18gRzYiNFu85of6faUenRpogZPe7nSkT493kLCT2OqW2g4soVluCk8GOmi1c8uep6un
         fwR7LSxAPWVLoB4h4VJN60ZB6pdbzOnjC+O1JRSzak/9Tj3BWZUX4igZxgkXJp4ukhta
         FpOQ==
X-Gm-Message-State: AOAM530qKmlKtugj/So9OrUBmnD2IYcp1a9wY9/zVHRTAzeb5Ij1vP0O
        2JBw2pC90jcGFWK8aOtwGug=
X-Google-Smtp-Source: ABdhPJwffluTZ0ijIdNbayW8tHwFGdQx0Ms8uqvmOBsZjQGvskxK3IWO1dAF5PRcecEpA90HXU25Ww==
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr7621234wrz.218.1631817100455;
        Thu, 16 Sep 2021 11:31:40 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id u6sm4978076wrp.0.2021.09.16.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:31:39 -0700 (PDT)
Date:   Thu, 16 Sep 2021 20:31:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 12/25] progress.c: add & assert a "global_progress"
 variable
Message-ID: <20210916183137.GD76263@szeder.dev>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-12.25-c4e7179e957-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-12.25-c4e7179e957-20210623T155626Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 07:48:12PM +0200, Ævar Arnfjörð Bjarmason wrote:
> The progress.c code makes a hard assumption that only one progress bar
> be active at a time (see [1] for a bug where this wasn't the case),
> but nothing has asserted that that's the case. Let's add a BUG()
> that'll trigger if two progress bars are active at the same time.

I very much dislike the idea of any BUG() in the progress code that
can trigger outside of the test suite.

As the number of progress-related fixes clearly show, we often misuse
the progress API, and, arguably, a bug is a bug is a bug, so strictly
speaking a BUG() is not wrong here.

However, the progress line is merely a UI gimmick, not a crucial part
of Git, and none of those progress bugs affected the correctness of
the operation itself.  Worse, calling BUG() during some operations
(e.g. 'git commit-graph write', the worst offender when it comes to
progress bugs) can leave a lockfile behind, resulting in scary errors
and requiring manual cleanup in the .git directory, which is a much
worse UX than showing some bogus values or out of order progress
lines.

