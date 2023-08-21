Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75911EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHUUrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHUUrG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:47:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BECE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:46:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d690c9fbda3so3720416276.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692650815; x=1693255615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TTp+a/bynjy0OB5w83CcnJdfbLuovdC9sp09le4XfLw=;
        b=iQ3emH1frcHZvBGEKcCBX3c2sVDFY3SfbILS/7nv4lquPqdpqHDOMJClN83z/+gArT
         Ui6wUwTlG4h0f37ixflmCYu5UsO00LHlazrLPyuNuXxfjpT2xbKEnqdXVbDQWJC8E2N3
         CCwxaygems5zvhoIrXEa41zEGsjmf1CQa2Euf4QF6xBwlTKd4lt7Eg4MiUaKq6LAYTiy
         UGrABhXAtpxBbR32OHG+dFC+jQdcUcRp5I1FQqza62e/GDf17dw9ZrjfcIOeRYXjKBal
         Grpbjd7/MgROIMAeh+u5oJ6DQhpSJUMWufr6G0AmLwhWQtB5Dy8f23lANuE2FuestIW8
         onNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692650815; x=1693255615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTp+a/bynjy0OB5w83CcnJdfbLuovdC9sp09le4XfLw=;
        b=B1S435xzUZKpVwkBo3fyU9GAH7YZsVuWOw6pSKePdRC504gQqKWpFN646cBA5B7Rwq
         D/7K7/I3U9hjoWBGKOknBizo/rOCwdVRRJydomHjgOrsqyb9TyxTncDkVji/v74QtYFg
         0UIY8qqti+5abr8YTjA8l4nNewHboNcqRCmPVx+9vLnD5yR0wEeDPeLAHS+d8GYO0EDD
         YxFUJOv8ldntGrIhrGOqKYJ2w+Dbpz2IMfPHoyybP9t2zKp0XAjF8YWup2D17heYlQT0
         UpDR5EzurbdKl/TaDbPOf69pyuQpHSfpTNazdTckOjUVnjUB1rvJiJVMtSZ5pqDwRL9Y
         jJ4Q==
X-Gm-Message-State: AOJu0YzSKeVIrkIfPpVO/0T2CLciMIx2nTV4MoK+2fHFkKfdGu3/u5HY
        ZR25K8ZevPAqra0SW+12W6k+9w==
X-Google-Smtp-Source: AGHT+IFOF4cP02FquErcVDPOhrmyTkJvYXjWTo3WXyLUIx7wANINm4uVQXeUCIoFNv8q3RRrRnkgIg==
X-Received: by 2002:a25:2501:0:b0:d1c:7549:4e8b with SMTP id l1-20020a252501000000b00d1c75494e8bmr7228274ybl.29.1692650814822;
        Mon, 21 Aug 2023 13:46:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 65-20020a250f44000000b00d0644cd90a2sm2028335ybp.23.2023.08.21.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:46:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:46:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/6] bloom: reuse existing Bloom filters when
 possible during upgrade
Message-ID: <ZOPNPU/cekgJU7S7@nand.local>
References: <cover.1691426160.git.me@ttaylorr.com>
 <20230811221337.3331688-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811221337.3331688-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 03:13:37PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > On both linux.git and git.git, this series gives a significant speed-up
> > when upgrading Bloom filters from v1 to v2. On linux.git:
> >
> >     Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit
> >       Time (mean ± σ):     124.873 s ±  0.316 s    [User: 124.081 s, System: 0.643 s]
> >       Range (min … max):   124.621 s … 125.227 s    3 runs
> >
> >     Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths
> >       Time (mean ± σ):     79.271 s ±  0.163 s    [User: 74.611 s, System: 4.521 s]
> >       Range (min … max):   79.112 s … 79.437 s    3 runs
> >
> >     Summary
> >       'GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths' ran
> >         1.58 ± 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths'
> >
> > On git.git (where we do have some non-ASCII paths), the change goes from
> > 4.163 seconds to 3.348 seconds, for a 1.24x speed-up.
>
> My main concern is that this modifies the code somewhat pervasively
> (tracking the version of Bloom filters and removing assumptions about
> what Bloom filter versions are in memory) in return for what I think
> is a small speedup, when considering that we will perform this
> operation only once for a given repo. I'll defer to server operators
> on this (or other people handling large numbers of repos), though.

Yeah, I think that this is certainly on the riskier side of things. But
I have confidence in our test coverage here, and feel better with your
thorough review.

FWIW, I think that the speed-up is worthwhile (though I'm obviously
biased here). When we were rolling out changed-path Bloom filters to
repositories on GitHub.com, it was apparent that computing them from
scratch in a single shot was infeasible. This led to 809e0327f5
(builtin/commit-graph.c: introduce '--max-new-filters=<n>', 2020-09-18).

That would of course still save us here if we didn't have an upgrade
path, since each recomputed filter would count against the maximum
number we can generate in a single run.

We could introduce a configuration knob, but I'd rather avoid it if
possible. That can also be done on top in a later patch, which should be
easy enough to do if we hear of a compelling use-case for wanting to
disable the upgrade path here.

> Putting that concern aside, I've reviewed the code and assuming that
> we're OK with modifying the code in this way, this patch set looks good
> to me, and hopefully my review will be of some help.

Thanks very much -- it was more than helpful :-). I'll collect up this
and your previous patches (as we have discussed off-list) and tie
everything together in a single series for the maintainer.

Thanks,
Taylor
