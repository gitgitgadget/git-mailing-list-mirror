Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC6C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9014A206F9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K9c2VHW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDPQdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDPQdd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:33:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D5C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:33:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cl8so1621192pjb.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6kVfq3fiveRfyozGdWApgEpUGjoSc1nFS2nktZM5NQg=;
        b=K9c2VHW8WpiyGnHYtSTTmV4HNOqeZ2MhnbJdGPO7E6FgfZR8IygSlbFwSlG28rUBCM
         4Aj2yzSyTH6WyNuMGh/XSmIoSInEPVW9iK7aN4yRCRRO/lmEcqXOMyETAf6I4PkTx59i
         LHUHCSxUvVEID+yZ76zFTCkmrR/kOV/1G8+p1E4P+9d1uwfLmEU8fEBhi71Q9hJa/Zx4
         kwXqBo2Z7pirsmA7x9HTBGSGsk5EZclFh7oeV4jrq04MaWf0BFBmfL7u9KfFEs+qb1CP
         YpqmTdHm2U4UtN2BM3X6wQ488dPX71EHDHmDLbcmvncOPV71vb5j/sjh3EnQD8Dmd4z1
         BAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6kVfq3fiveRfyozGdWApgEpUGjoSc1nFS2nktZM5NQg=;
        b=DBx4AFxoFRGtMHgHUe/gh15/yG3SNG2yezJCZLpUzTMPForI5OiSJOVbzsKzMZCJGe
         l7Jiyfi1gcJA8r8prbMzLAopO6FY1s6oEgE9qO4uE9ro0cKxVBTrCciXlGPKGGEOOHiW
         ehks2F9uiDVkcrgjyPyimtUGQqKuidpOUEjJUfyR5Fz5tBbuz362kKA6ta8CmpwHbQ6y
         oflrjpExm+3ACGLYK3txHc1dWvKwSqkpHgQI2NR+nb79pI82Aja2d/02p+Yu726z7Bcv
         /ZYPvw0iT23iFsi0MleRefaUHnu8ysGd6kZMxfMCEJVKJOZ/ba+26OYURqcsREbRHTCK
         ys6Q==
X-Gm-Message-State: AGi0PuZM0KsET5ypFhnz9HY8mtcOy6MMJ3zzG49XOk7C41l/kLXU1tYX
        t9Jnh0+IhCccz54CNeQgpSG/qA==
X-Google-Smtp-Source: APiQypJ3iNkwyBNIHqAsJZN8K8hld8jGRIV5HswGQnDzcZVlylx3blxkFT3GsgY3V5Dm8wjG0e/HSw==
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr5912759pjo.141.1587054813078;
        Thu, 16 Apr 2020 09:33:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s44sm3288128pjc.28.2020.04.16.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:33:32 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:33:30 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Garima Singh <garimasigit@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200416163330.GB78342@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
 <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
 <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
 <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
 <20200416005241.GB36156@syl.local>
 <67350f6c-d558-8b9b-4d57-5830f7a74fab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67350f6c-d558-8b9b-4d57-5830f7a74fab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 09:26:49AM -0400, Derrick Stolee wrote:
> On 4/15/2020 8:52 PM, Taylor Blau wrote:
> > On Thu, Apr 16, 2020 at 12:18:33AM +0200, Jakub Narębski wrote:
> >> On Wed, 15 Apr 2020 at 20:37, Derrick Stolee <stolee@gmail.com> wrote:
> >> [...]
> >>> -->8--
> >>> From 89beb9598daabb19e3c896bbceeb0fc1b9ccc6ca Mon Sep 17 00:00:00 2001
> >>> From: Derrick Stolee <dstolee@microsoft.com>
> >>> Date: Wed, 15 Apr 2020 18:04:25 +0000
> >>> Subject: [PATCH] bloom: compute all Bloom hashes from lowercase
> >>>
> >>> The changed-path Bloom filters currently hash path strings using
> >>> the exact string for the path. This makes it difficult* to use the
> >>> filters when restricting to case-insensitive pathspecs.
> >>>
> >>> * I say "difficult" because it is possible to generate all 2^n
> >>>   options for the case of a path and test them all, but this is
> >>>   a bad idea and should not be done. "Impossible" is an appropriate
> >>>   alternative.
> >>>
> >>> THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
> >>> Bloom filters computed by a previous commit will not be compatible
> >>> with the filters computed in this commit, nor will we get correct
> >>> results when testing across these incompatible versions. Normally,
> >>> this would be a completely unacceptable change, but the filters
> >>> have not been released and hence are still possible to update
> >>> before release.
> >>>
> >>> TODO: If we decide to move in this direction, then the following
> >>> steps should be done (and some of them should be done anyway):
> >>>
> >>> * We need to document the Bloom filter format to specify exactly
> >>>   how we compute the filter data. The details should be careful
> >>>   enough that someone can reproduce the exact file format without
> >>>   looking at the C code.
> >>>
> >>> * That document would include the tolower() transformation that is
> >>>   being done here.
> >>
> >> Why not modify the BDAT chunk to include version of
> >> case folding transformation or other collation algorithm
> >> (other transformation).that is done prior to computing
> >> the Bloom filter key? Though that might be unnecessary
> >> flexibility...
> >
> > If this ends up being something that we want to do, I agree with
> > Stolee's reasoning that this should be a breaking change. If we were,
> > say, several months into having Bloom filters in a release and decided
> > at that point to make the change, then: sure, supporting both by writing
> > a bit in the BDAT chunk makes sense.
> >
> > But, we're many months away from that state yet, and so I don't think
> > the cost of rebuilding what few commit-graphs exist with bloom filters
> > in them today to support both ordinary and lower-cased paths in the
> > filter.
> >
> > Anyway, I'm still not sold on this idea in general (nor do I understand
> > it that others are), so I'll respond in more detail in another part of
> > the thread...
>
> I agree that this is not a good direction to go. I created the patch
> because I was curious how difficult it would be, and it is good to have
> a record of the possible direction. However, it complicates the file
> format and will have unpredictable effects on the entropy (or on the
> performance of history for case-colliding paths).
>
> It is good that we have the capability to extend the filter data in
> the future if we really need to.
>
> I'll make a TODO item for myself to try writing that detailed Bloom
> filter format documentation as a follow-up. In the meantime, I'll try
> to close this out by responding to the feedback we have so far.

Sounds good, and thanks for investigating.

> Thanks,
> -Stolee

Thanks,
Taylor
