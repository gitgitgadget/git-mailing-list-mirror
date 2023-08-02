Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA47C001E0
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 19:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjHBT2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 15:28:06 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5B123
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 12:28:05 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5607cdb0959so61583eaf.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691004484; x=1691609284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=duHTCxUXnPR7Aj+vkudVVJG2DaroCmodMenPevzOBkY=;
        b=J4YU4Q8h+CNVkwvS+9+/yq/PKa7N8Df1zysqB30sdmbGXLrLq8kZXodXvy2ev55xTO
         XUR3S1sowdFx8eA+qQDdve62oozU7DmD4PybYUxgQ+0dfwtnOmTBwdTEyGyV65j6OHrP
         flS7fMz3MapSrZNJDubNApGEPTeJLbq74Ijs/3Kqk3fX3A73rPcLiBh6J5MXx7ekVj59
         DTdCC/JejeGYrmRJCW02u0rZioPa4bJFlT2NpXi8K3F/bQKggGpNGkAYWojItg5RJmQM
         GcML4yWHFvX9xNwnk9VqzGs04tNZ7jm1UBwONdqZD1LBE0fZailGx2xvz9OETiGkrJeE
         jONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004484; x=1691609284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duHTCxUXnPR7Aj+vkudVVJG2DaroCmodMenPevzOBkY=;
        b=Q8MvntcINEejc2n5ddnzsZ20Eif9fSpOIlI4f/MLTLx1nMY4t/+YIAUEa2zIQAsnYt
         LmMpJ4iCX7377JpBZ0+ToUj2QnIMOPDK3Zg8hQkCFccNt/6YkYiQBrzeN6yohfCPCaiF
         PgljDaI+HXeprtOIdEtqKg4faznEFnE4gd69vOLeCdF8vHoCn+oXLPX5I5RIWj+jooeg
         ElPOzGx8MMSehMZthC5QB6mHCfRKs6h5JQr4hddyZfEWKQcE5clfvIFRMJDMmVHMOp/R
         +jCCcpsjuuOxF1MeRuV3WXmpszcOcj5TiuR5w2lRFG51SLozduonM2dONdp0uwyN0YBT
         3QXQ==
X-Gm-Message-State: ABy/qLZGA6y3IifR84N9GNPhWI/j0ZtQImX3/PU9maSUmhsVzq1935x9
        +7pmT+5N1Y/ZnUkyS2KTPdrj27UCaD4zTq4CvMq0iA==
X-Google-Smtp-Source: APBJJlFFRU+mPXR6sfeU3L1CmyTtiWUSKCTjefrSG5xaZZI5twih2OdVHC+u+IkAbYI8wkwz8UTBCw==
X-Received: by 2002:a05:6808:11c9:b0:3a4:2941:b0d4 with SMTP id p9-20020a05680811c900b003a42941b0d4mr18088244oiv.24.1691004484537;
        Wed, 02 Aug 2023 12:28:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s131-20020a815e89000000b0057085b18cddsm4871787ywb.54.2023.08.02.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:28:04 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:28:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: jt/path-filter-fix
Message-ID: <ZMquQ7XiYKYNrc/e@nand.local>
References: <xmqqfs518gdh.fsf@gitster.g>
 <ZMqp6K2iXixWH/zT@nand.local>
 <xmqqy1it6ykm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1it6ykm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2023 at 12:20:25PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Aug 02, 2023 at 11:10:34AM -0700, Junio C Hamano wrote:
> >> * jt/path-filter-fix (2023-08-01) 7 commits
> >>  - commit-graph: new filter ver. that fixes murmur3
> >>  - repo-settings: introduce commitgraph.changedPathsVersion
> >>  - t4216: test changed path filters with high bit paths
> >>  - t/helper/test-read-graph: implement `bloom-filters` mode
> >>  - bloom.h: make `load_bloom_filter_from_graph()` public
> >>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
> >>  - gitformat-commit-graph: describe version 2 of BDAT
> >>
> >>  The Bloom filter used for path limited history traversal was broken
> >>  on systems whose "char" is unsigned; update the implementation and
> >>  bump the format version to 2.
> >>
> >>  Still under discussion.
> >>  cf. <20230801185232.1457172-1-jonathantanmy@google.com>
> >>  source: <cover.1690912539.git.jonathantanmy@google.com>
> >
> > I am happy with the most recent round, but I think that it is probably a
> > little late in the cycle to be merging down such a large change.
> >
> > I wouldn't be opposed if you did so, but it may be worth waiting until
> > we're on the other side of 2.42 so that other reviewers have a chance to
>
> Since I hear some folks (not just Google) base their own edition of
> Git on 'next', it probably is a good idea to merge it to 'next' and
> have their users help find potential issues in it, as I agree that
> the area it touches is important in the correctness department.  Of
> course, it is important enough that the topic may very well want to
> be cooked longer than the usual "for at least one calendar week" in
> 'next', so I tend to agree that in a first few batches after the
> release may be the best time to have it graduate (if it turns out to
> be OK).

Yep, I agree with all of that. Thanks for juggling the merges, as always
:-).

Thanks,
Taylor
