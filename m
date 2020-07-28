Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04790C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D345E2053B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dw3ZMMC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgG1QDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbgG1QD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:03:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B03C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:03:29 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so9289718qtq.8
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snfJRMgcBXV5my//AWoJiGdGh/AJTuRaJnm6moZ2Zk4=;
        b=dw3ZMMC9xIRgvvgcFZtMiOpQubMzz7zpk4SQG+TI8v5UOekbkk0pllOHjFLcL5CaZ0
         ixpBkZqLcrod7M28hLzH4XdbV3qPHsEWkpdPQ3cABPOkg7XNqpsEBva/WJzXu1wj8d5c
         ofqAuRWLak6jy/xqRJVTR1ODNtFahSPbYy3gFiOVXGsxPDWzi9OQ4YUuP6IW6GTaUuKS
         UJm4B2HPM+DyRGc/u2haWEEkUV+crU6eaSHSXc3O0TpGLlPJEiXNWjdHFrK5ptx3luRJ
         MeYmVPZpfQjCOQFpdwMrzDD91UJZ3s5+T8TWE+6GEc+1z9ZYw2Mt3LE0mreOl2ieFc4Z
         /Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snfJRMgcBXV5my//AWoJiGdGh/AJTuRaJnm6moZ2Zk4=;
        b=HE2QSZCKH4x+VOLm9ru/ubyl/k163C8WKorFt/NAM6JD2pLlhX5SpuECyHm1pOarVG
         iW85+is/qLm8MOzbmPXm6jo6g2N3orPmM+RU1qb5n5ovynlYqv/T06JASMBjCaWkNnly
         u74auISArLo/QKyW33Y9Z9vX3RuL1imlAVig6VakjyX/OH/nOneOvpajbVEdP7eowNX7
         VvHldlDmX7m9ou8MJ1t2SSeBk5lrF063osLiQDa2BBEdTE7ckjoWSRRvjl0ar9KPlYEm
         XX5yTVYnzhUSfWr3fL6DpqMxh4U9cDgPjF7OqVNDK6AhQHp87kSXmnQ5NJsCVKyUyiPC
         6MRw==
X-Gm-Message-State: AOAM531rGxevfl3whMfAyCrXeHQhWuvhv/3HnPATDegejeAMGD/innCp
        ALh2Ol7opR66OiQ66i2y4+X1ug==
X-Google-Smtp-Source: ABdhPJyE5y3YVJtlEuh1wL1dkhmUKh6Hv3+arGXDbXK39wT4RtFdlLAPEnX4OY7+1mZQ7fPmuBlE7A==
X-Received: by 2002:ac8:188:: with SMTP id x8mr6481873qtf.372.1595952208521;
        Tue, 28 Jul 2020 09:03:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id e15sm12914974qtw.22.2020.07.28.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 09:03:27 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:03:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 4/6] commit-graph: consolidate compare_commits_by_gen
Message-ID: <20200728160326.GE87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <812fe75fc7252db0b7b6604f84b17dcf7324b922.1595927632.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <812fe75fc7252db0b7b6604f84b17dcf7324b922.1595927632.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:13:49AM +0000, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> Comparing commits by generation has been independently defined twice, in
> commit-reach and commit. Let's simplify the implementation by moving
> compare_commits_by_gen() to commit-graph.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 15 +++++++++++++++
>  commit-graph.h |  2 ++
>  commit-reach.c | 15 ---------------
>  commit.c       |  9 +++------
>  4 files changed, 20 insertions(+), 21 deletions(-)

All looks good to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
