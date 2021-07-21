Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63526C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 19:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342DE6121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 19:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGUSmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhGUSmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 14:42:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E922C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 12:22:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id w22so3605043ioc.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BzvjTxiE2uMJ1Er31gnoI6+QTROfBAc2gJFcL2Mx68Q=;
        b=EwIN1TtHxHBRgqksLwbf11eM0vX4kXQMKUmvTi6aW13crX8yUf9CxjYZp99d/43IN+
         T95xp9QTTi3xjaaeqUWre29Y4zk3ujE9z+q+FGi0gQ6/Q8yxxkc1s1NANkxb5+Yjuc1O
         jr34G+OKMkheIOj1wYmS74+SFsxdGVwFzuLKqmP2oyC8e3nVzlVmlBsNeWOiIja7LjVT
         kSi7ob80Z6wY7L+pbMSbjrXKBGFRLY/gw5mavCzBVQIW0qcPbdSQII50BePlKwINW9TY
         6xhfUYrVv5OORG3R5tBNievYHonx41RyXujjbEIA4fWIDaEv6bFeXJPTodt1xUwso4hq
         N4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BzvjTxiE2uMJ1Er31gnoI6+QTROfBAc2gJFcL2Mx68Q=;
        b=RYrB5uyqLjQJ3Y5upe+CoCI77rvvybgj8WknpdiYLt+m91TU2HnoyAro6eZl5Squjs
         2jBP3F+r+UHJleASaVjSbbhvbkmsR0hr7J/hjnOsYOLHZdl0nP7y8dUPPg5XZsksDhXI
         /e99eTnAyj15QnelySV/82Ppy1xhdO6VgIQ1D0yr2M1+m/NdiyOwNfay/BC0hWhGU7Kf
         b0FqowfUjw7FQA15HMokEovInmH9GSFl1dsJ88uEmB9dgqWudvk056SO0IryKEuZWz7o
         LSX8YrV9uivLJkIUf7rX9r/BAR/u6dOmMbtcdmQS1bNfvt/3Z9F4hG11gaPd6Ii0E+cn
         jZ2g==
X-Gm-Message-State: AOAM530CyihiiTQXBaIjXevSKVsUUQ5zGctHKvO5O5o+cT7x43NYQeES
        K7zlQKecOY9vY8L0Vwh9ifKvIQ==
X-Google-Smtp-Source: ABdhPJyAKr4GHrp4I0GWzw5zEELrhlT4yj0fmwwDewvovI2QuT+h9qGW5S/aS+GWlnKM/4UBc0/R3g==
X-Received: by 2002:a02:2382:: with SMTP id u124mr31838682jau.138.1626895355980;
        Wed, 21 Jul 2021 12:22:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id h1sm9085623ioz.22.2021.07.21.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:22:35 -0700 (PDT)
Date:   Wed, 21 Jul 2021 15:22:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YPhz+iOMu4Q7zjY4@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:23:23AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:18PM -0400, Taylor Blau wrote:
>
> > When writing a new multi-pack index, write_midx_internal() attempts to
> > load any existing one to fill in some pieces of information. But it uses
> > load_multi_pack_index(), which ignores the configuration
> > "core.multiPackIndex", which indicates whether or not Git is allowed to
> > read an existing multi-pack-index.
> >
> > Replace this with a routine that does respect that setting, to avoid
> > reading multi-pack-index files when told not to.
> >
> > This avoids a problem that would arise in subsequent patches due to the
> > combination of 'git repack' reopening the object store in-process and
> > the multi-pack index code not checking whether a pack already exists in
> > the object store when calling add_pack_to_midx().
> >
> > This would ultimately lead to a cycle being created along the
> > 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> > has hard-to-debug downstream effects like saying a bitmap can't be
> > loaded for a pack because one already exists (for the same pack).
>
> I'm not sure I completely understand the bug that this causes.

Off-hand, I can't quite remember either. But it is important; I do have
a distinct memory of dropping this patch and then watching a 'git repack
--write-midx' (that option will be introduced in a later series) fail
horribly.

If I remember correctly, the bug has to do with loading a MIDX twice in
the same process. When we call add_packed_git() from within
prepare_midx_pack(), we load the pack without caring whether or not it's
already loaded. So loading a MIDX twice in the same process will fail.

So really I think that this is papering over that bug: we're just
removing one of the times that we happened to load a MIDX from during
the writing phase.

What I do remember is that this bug was a huge pain to figure out ;).
I'm happy to look further if you aren't satisfied with my vague
explanation here (and I wouldn't blame you).

> But another question: does this impact how
>
>   git -c core.multipackindex=false multi-pack-index write
>
> behaves? I.e., do we still write, but just avoid reading the existing
> midx? That itself seems like a more sensible behavior (e.g., trying to
> recover from a broken midx state).

Yes. Before this patch, that invocation would still load and use any
existing MIDX to write a new one. Now we don't, because (unlike
load_multi_pack_index()) prepare_multi_pack_index_one() does check
core.multiPackIndex before returning anything.

> -Peff

Thanks,
Taylor
