Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CAC43465
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C520657
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnP4GfJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGJXDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGJXDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 19:03:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE04C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 16:03:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so3148517pfn.12
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a81RDvqW6qVZ+Yzl1vRzSr+rsGscrhQsTXfqxGYJOB0=;
        b=OnP4GfJWZHG5oF80hw+SJUULzF62iF8upqyjtYj60HSn9KkTsBaHi8W4whOLcA6rCH
         Xm0TtjEUmBO1hqqrTEMojv0rujFdM/SFM8j7oTvIYcTfZSRNFNPFP+uXEHZOtd2vEQCq
         pI8RVEpCjS6YKYxGxMuK1SjrjhgwGqV1qOfSdDrihV4B2yjq9mbWxxKokIL2DUvmA9hp
         Goq7dB9PPzNt+4fvDjjJ4Y2U5lh1xDfUDvKvwfEpoaGwm66to5aYAi0YUefPmupoxZL+
         AOdTyiPMuojq2Pnp0pnRrDK8naJyUoCVBEIXngNrCz0VbclmGcz/sz2YXXrh+QbpGXaQ
         lCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a81RDvqW6qVZ+Yzl1vRzSr+rsGscrhQsTXfqxGYJOB0=;
        b=byhtdcw4MIMwTDFjJ2O3u64LvKZF6Mr82DaIOGic97RMMAk3YMRny7M0qPCMc++oeY
         zUdXySlY6Oe7FgYKIAZtPVQdNBs35+VMq3ZW5zpsN/Nd9RXE1QM5VtIWQCuCnb50znRB
         Arfg/looihk0vfDZGyyFdy+sUIOohT3aMmiLOtE2QL9UsSc3nMNUC+FbYifXZQIIGmPH
         KJj36QVWxbp3D9CSXCSrfdruhI/0ujvMBjVwxoEXwnpztXwhNX85XoFmqyN1n3rZ+O4S
         xZ9D+hqytbZteODXF57x1cziUn8LOxZgHio05mS9neYLRKzNmgw1RvIzL0liZCnOPA1X
         qgnw==
X-Gm-Message-State: AOAM532/mX1LxFT48jUv3n6PqNa6ucLBsU3egdbarcYWLE0Uemqs9r8q
        j4aaTCcX4aHJJPEr64ljHcylDyAH7sI=
X-Google-Smtp-Source: ABdhPJx/2o//56DHzeKKuQhWd+82EGBj1np+qf4XUunVh8F9r4mVfrN63CddAWUyna+vNXJSxEVjlQ==
X-Received: by 2002:a63:b255:: with SMTP id t21mr50173377pgo.78.1594422219480;
        Fri, 10 Jul 2020 16:03:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id hg13sm6443922pjb.21.2020.07.10.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:03:38 -0700 (PDT)
Date:   Fri, 10 Jul 2020 16:03:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
Message-ID: <20200710230334.GH3189386@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-3-emilyshaffer@google.com>
 <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
 <20200710022040.GB39052@syl.lan>
 <xmqq1rljurvj.fsf@gitster.c.googlers.com>
 <20200710192731.GE3189386@google.com>
 <xmqqpn93ta4h.fsf@gitster.c.googlers.com>
 <20200710202955.GF3189386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710202955.GF3189386@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 01:29:55PM -0700, Emily Shaffer wrote:
> 
> On Fri, Jul 10, 2020 at 12:58:54PM -0700, Junio C Hamano wrote:
> > 
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > Will it make your life easier if I base this series on the other topic?
> > > Or would you rather I leave it to you?
> > 
> > Either is fine.  
> > 
> > Just don't expect any quick turnaround time for a new and involved
> > change like this while we are entering the pre-release freeze.  We
> > are supposed to be stablizing, not churning ;-).
> 
> Understood.
> 
> It's got a nit or two from Stolee's review so I need to reroll it
> anyway; I'll send it based on the other topic.

Hum. It seems that, as of `git fetch github.com/gitster/git` in the past
hour, sg/commit-graph-progress-fix doesn't include
es/trace-log-progress, so I don't think it is actually a good idea for
me to submit this series based on sg/commit-graph-progress-fix instead.
I'll send the next version based on master, after all.

> 
>  - Emily
