Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CCEB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 19:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGJTkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGJTkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 15:40:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC312A
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:39:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ca120c103so3421392b6e.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689017998; x=1691609998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jQH9r/ci2B6Pqf8f9e92pvRuptVRzsF37SAqeXTvDQ=;
        b=d9V+Tf5v4f/oWRyc043TlbH8L6yOyDsQF6ouv89Y8UYLi8C/G0lcjU7xo8VWW/PD+5
         lNlAa9Asfvm0XNypbVJD2H+SAjQvsAzqhO4DkT2pJ9ZZQXNl2vHjkmuaBRYS4W5Vttc0
         kX36rFPlZulukTk+cEtSDWMiwKlLhgAZDYXaN943xGzfz1DvDlTq+SbsWGZ4MwZmLpH8
         vLJMiVVO2+QkoyXgUkLICc4ONS0/vvOuxFqAXaEprt8WlbXDtvnf+zZc9oRiUPmI4HOL
         ocSH5ULjLRVonmnyM7yU+MQRDNP1CJMoIw0R0DDmseCLxKJjiePCpVq9q7YXj7HaJ7pX
         028g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017998; x=1691609998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jQH9r/ci2B6Pqf8f9e92pvRuptVRzsF37SAqeXTvDQ=;
        b=FhLx5pcy8p6OPm+kYzdTvFFnBDAdrkIa4Ueo3SRLj4+73fWsRCgzDXX9kS02fEhtzp
         qzfGKvoMWoytn/zsl3aDP1mmIMClvX0uF8iyK6cIz2oIg7+rL62rz5Y5wKMuELti+mG/
         eROIFRgKtuWqfMbF5yiGtCEBMAhkeG0J5YR3okVQizeb8hdKAUB8UNR4fUHEn2MHS9me
         VMSfP0tyl4AbNiEZZReU/z/LnBBNI/71dnM3K4P1faQqh1qyMfs54cqhswfkNg9qMbZR
         9SPw6TFE+b7vxcYXg3Y4orceSs03KuzsbqGYSfHVRV2db8riOPt1j0/+v8zVMAzAnr0Y
         CBWg==
X-Gm-Message-State: ABy/qLZUBpp3edllUb0jU2V1c7Qzei/nEYi4itF1464RCG1YtzwtJplc
        5EvwXqABDL307EzhhtUqWnEd+g==
X-Google-Smtp-Source: APBJJlFq6sArlNFcEVp7a1XJtn2aUrJyYGhD4m/OxK528blWiPju7Rb2rKp1QwyJnj2fQ1LAvfwg9A==
X-Received: by 2002:a05:6808:4292:b0:39a:a9e6:af3 with SMTP id dq18-20020a056808429200b0039aa9e60af3mr10535053oib.49.1689017997783;
        Mon, 10 Jul 2023 12:39:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o8-20020a0dcc08000000b0054c0f3fd3ddsm148186ywd.30.2023.07.10.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:39:57 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:39:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] repack: only repack .packs that exist
Message-ID: <ZKxejN7JQDWpNTAz@nand.local>
References: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
 <20230627075427.GE1226768@coredump.intra.peff.net>
 <ZJ1N2I6sDfxhrJo8@nand.local>
 <20230702131117.GB1036686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230702131117.GB1036686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 02, 2023 at 09:11:17AM -0400, Jeff King wrote:
> On Thu, Jun 29, 2023 at 05:24:40AM -0400, Taylor Blau wrote:
>
> > > I also kind of wonder if this repack code should simply be loading and
> > > iterating the packed_git list, but that is a much bigger change.
> >
> > I have wanted to do this for a while ;-). The minimal patch is less
> > invasive than I had thought:
>
> Yeah, I agree it's not too bad. If we want to go that route, though, I
> think we should do it on top of Stolee's patch, though (which makes it a
> pure cleanup once the behaviors are aligned).
>
> I'm also not sure if you'd need to do anything tricky with alternate
> object dirs (it looks like the existing code ignores them entirely, so I
> guess we'd want to skip entries without pack_local set).

Yep, we definitely want a `if (!p->is_local) continue` in there to be
consistent with the existing behavior.

> > [...]
> > I think you could probably go further than this, since having to store
> > the suffix-less pack names in the fname_kept and fname_nonkept lists is
> > kind of weird.
> >
> > It would be nice if we could store pointers to the actual packed_git
> > structs themselves in place of those lists instead, but I'm not
> > immediately sure how feasible it would be to do since we re-prepare the
> > object store between enumerating and then removing these packs.
>
> I think that would work, because we do not ever drop packed_git entries
> from the list (even if the files were deleted between prepare/reprepare).
> But it also creates a subtle memory ownership dependency/assumption
> between the two bits of code. It seems clearer to me to just copy the
> names out to our own lists here (i.e., the patch you showed).

Yeah, I agree. I thought that it might clean things up further, and to
an extent it does:

    https://github.com/ttaylorr/git/compare/tb/collect-packs-readdir

, but I think that the memory ownership issue is sufficiently subtle
that the clean-up isn't really worth it.

I put the above patch together with Stolee's, and sent the result back
to the list here:

    https://lore.kernel.org/git/cover.1689017830.git.me@ttaylorr.com/T/#t

Thanks,
Taylor
