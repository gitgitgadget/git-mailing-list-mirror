Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E265BC4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91EC20735
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HW7A03xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCWTQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:16:06 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50245 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgCWTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 15:16:06 -0400
Received: by mail-pj1-f66.google.com with SMTP id v13so300700pjb.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rzqgG9VpXBgnBRRo7GFe/M/F/xoGl/2Z57Jdu81P7J8=;
        b=HW7A03xMgixqciil10PMU0se5l4It5SIqmOBYJMWgsnp3qhfSZSrn82yG9m1KQJtFA
         6YY0CMeJ2AQOK/Q4h0cv7WMKqSU9NmsXN3xyrukilbVBT+6GYTNL2lqX5X+XrCGqIkKo
         eqb12/JEwxM7z4trL7L6IW+A02dz6gYn1i4y8loK9pYMKzURr4vhjmcvO2TlqAUpnlOO
         Vu91sYxmINDklduBz1+op6x5wHuYqZotF94cshZMRgxYmYb6XyWuBsMTbxw4632uxpGX
         19s2NubPQeOMEsFzZhvTTxpjRGLhK+pAx8wzBbOVl+D2pBiX2cS7IA/IZ80R4gr+EQB8
         l2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rzqgG9VpXBgnBRRo7GFe/M/F/xoGl/2Z57Jdu81P7J8=;
        b=TYa06S2t8sC66Vxtz8FVimWOSaM8aYBLFxgzJSDY2gtNRlUJGF3Jgtexswzy0CMFjw
         ZNPnOKRsmlORCVUhpll/kJ8wLOOuoULdBkrKa8MmexrvUpUcGzLV3+ABgl2t9w7tuehT
         lGMPSAKOd55Q6MDj+XWZqPFBwcSUBg1fDnkCouvp4YU4+QihPQg1vAY5BxHJHXjSci18
         +oSSnUHnCVJzP/0de8vvlvtJq4TewLKlt5zAX0tPieHuUrjnVdgUm+DQ2iX1U0qYGhas
         cQkv/PdxAEpljkRZwGA+2lSnAufST5csaOk22h/RRLZ7kdwLP3noTxf0A7o7l8L4jym4
         gcWQ==
X-Gm-Message-State: ANhLgQ2FC/RMoxvIpJbtK0jKDVnfb1gNB7A8pWQVw6kjsK8d6Th6q1v6
        TIEoD8qiLYE+jcMMSzZmhE2MKQ==
X-Google-Smtp-Source: ADFU+vuycg7E61BVH4MSBZ0C86bJxLmNakiab89TvjgJxRTc12k3sMkMK0gIhXqjRwifTp1X+ln3Pg==
X-Received: by 2002:a17:90b:230d:: with SMTP id mt13mr943527pjb.164.1584990964657;
        Mon, 23 Mar 2020 12:16:04 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t66sm311913pjb.45.2020.03.23.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:16:04 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:16:02 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #07; Sun, 22)
Message-ID: <20200323191602.GC93624@syl.local>
References: <xmqqh7yf7u6q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7yf7u6q.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Mar 22, 2020 at 06:10:05PM -0700, Junio C Hamano wrote:
> Git 2.26 (final) has been tagged.

Thanks; your work to ensure that 2.26 was a success is much appreciated.
I wrote an accompanying blog post summarizing your release notes here:

  https://github.blog/2020-03-22-highlights-from-git-2-26/.

> * tb/commit-graph-split-merge (2020-03-05) 3 commits
>   (merged to 'next' on 2020-03-09 at f3aa7bb305)
>  + builtin/commit-graph.c: support '--input=none'
>  + builtin/commit-graph.c: introduce '--input=<source>'
>  + builtin/commit-graph.c: support '--split[=<strategy>]'
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  Will cook in 'next'.

I noticed that this has been cooking in 'next' for a few weeks now. Is
there anything you're looking for specifically before graduating this to
master?

For what it's worth, we've been running this patch at GitHub for a
little over a ~month and using these options in our repository
maintenance jobs.


Thanks,
Taylor
