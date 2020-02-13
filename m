Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DAFC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99DA2168B
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvj+kY9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBMWCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:02:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45420 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMWCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 17:02:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so3699780pgk.12
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 14:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Tp1b3EBHO8ECJLYCyGBg3uD07vmT34GNuSVXL9pt91Y=;
        b=pvj+kY9R0ZhuoHWxcbnZvNVJKjkj/tq8sa1qXOQajlAjRKjd8G/69meL3FG/CIVOiQ
         SgKiOwpuh1Gc+oHSXQN6s5yS3+2+bUrAI7Qgu80KlxNYVEtyJozjSNULK0DSQgoXDpVm
         DivdXhMuLQ2sSs7zWmY297FHE9biSMvMhjvklf/bdiYuX4mWOCmr923j5H3hoSeukzu+
         xiCh3yZMsdxqRit43GXXy84mzYatc1QEvptr4QyoiEzqrhJAwv43EmXuJEdqkc21I5QB
         J72eLwW3rslX1mnoiYOZBKDHBL5YirsYIwjYDorrN5uJ4FsLFjWc8R7uir3DEBjSUKLY
         hGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Tp1b3EBHO8ECJLYCyGBg3uD07vmT34GNuSVXL9pt91Y=;
        b=skgOo6byTR8B3NYHeb4eU7f0MFPZB62pIw3VEcU9wkFbFGLtqeQ9lY6j4/hSrwY7hY
         xqD60JuSEYves2deaEPomLxW8Ckyfx2A0+M7LjOdZMIsvHW8lybksNSjqlpQtlVRKGYp
         BpvVCTxgLOY40MDigmHm2GJyYZcZf99BWuDsnGGlmrPgIjuVReTZiY+VcVYLCCSlYuUI
         VvFz38oTDzL4ErntQZI72hiPwcQRfjLRYVvxBY+fsvVxtjtBuoPhbsfAwolDOYIuNylL
         VPFM+k5osLLXs2a46lIyPbiTxg1b92L85g+w6/hleRnwRHfd/HCaTTMAbldVRwv9d58q
         /8qg==
X-Gm-Message-State: APjAAAWSdZte/1LB8hfYrRe1+2EN70CrBVsGKJReDoqjcEI9JKs9cEde
        h1ngBu6U5hsdMF0hnusZIbxGLg==
X-Google-Smtp-Source: APXvYqytzdwl95xa5gMRfnzxbgvwZB4DufAS9aHMxT96BA3YML3Xgt3yKshI37wPgCVEg9KBqTNmVQ==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr26165pgl.196.1581631330781;
        Thu, 13 Feb 2020 14:02:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o16sm4034284pgl.58.2020.02.13.14.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:02:10 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:02:06 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v6 10/15] bugreport: add config values from safelist
Message-ID: <20200213220206.GH190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-11-emilyshaffer@google.com>
 <20200207144725.GF2868@szeder.dev>
 <20200207150857.GH2868@szeder.dev>
 <CAPig+cQ8vHjzBdMAemznFbyUSHOuJu167RHkTNg_qmqi-DOB3g@mail.gmail.com>
 <87zhdue3ye.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhdue3ye.fsf@igel.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 05:51:05PM +0100, Andreas Schwab wrote:
> On Feb 07 2020, Eric Sunshine wrote:
> 
> > On Fri, Feb 7, 2020 at 10:09 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >> macOS 'sed', that's what I was missing :)
> >>
> >>   sed -n 's/^\(.*\) \+annotate:bugreport\[include\].* ::$/  "\1",/p' | sort
> >>
> >> and the 'sed' included in macOS apparently interprets that '\+'
> >> differently than GNU 'sed', and as a result won't match anything.
> >
> > More generally, this would be a problem with any 'sed' of BSD lineage.
> >
> >> FWIW, that '\+' doesn't seem to be necessary, though, and after
> >> removing it the resulting generated array looked good to me [...]
> >
> > A reasonable replacement for "<SP>\+" would be "<SP><SP>*" (where <SP>
> > represents 'space').
> 
> Another problem with that regexp is that it contains two adjacent
> repetitions matching the same character.  When there are two or more
> spaces before "annotate:" all but the last of them can be matched by
> either '\(.*\)' or ' \+'.  To fix that '\(.*\)' needs to be modified to
> not match a trailing space.

Hum. I had assumed since the capture group was not greedy, it would not
capture any trailing spaces that could be captured by ' \+'. I don't see
a problem in making it non-explicit, though.

I'll hack on this some more. I do find myself pretty annoyed at the
matcher difference between 'sed' and 'also sed', though, and don't see
in the manpage a way to guarantee which matcher 'sed' should use (a la
'grep -[EFGP]'). :)

 - Emily
