Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E207C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E345C2063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpJBvdjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHQMQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHQMQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 08:16:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72BAC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:16:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q19so7441433pll.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h61gcJpsuXBf6bV0ZXEeiCoFCjAqu3QogtG4fk34Pvo=;
        b=mpJBvdjl17U+Pd+xG6U8zuEKP+oEy07XhCqh+xc8Rvschs8w22XhTkEg9EeMo9ilfG
         euJ43XBLsi3g1J5vdD3LQEg86eXcE2fiVv56zOj0fGbQw+969b9Xc5z+vLpTR8Gsz31v
         80VG11JnuS1Sv19GrLUB9IsTn0Tm39lQzUQVM5s7Cyr4vpGf2tticv68SHMVCcu6fWUr
         TSnrazSgFmsog0JfiMPXhWhR7e/HjmGky0pPQOrA0aMwO5CM/VsJ+4ucyQhC+90wx4RD
         nJku/zPONN7EMzpaRXKaN/J2TraP+CLUZ2JSAGz5aj3HHbn7ihw7NV/e3ilq5V4bv7vL
         s0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h61gcJpsuXBf6bV0ZXEeiCoFCjAqu3QogtG4fk34Pvo=;
        b=gz5IiQvTMf170BXzVB6SKdpRGZanS/4yTlNeD/+lh7/scy3yRLESUDMY1dA79kR6j+
         hJBl3frMubddz06gzpbe115/kKUPm+zwf3Mhhjzi9woeVElrlHvksw+VyvQ/arMjyJbT
         lO9wyVNyO4DzWFjU3MeZCsiK9LvKF1cnGHu3reRMtjS97NEAW4yVgppF8OkoQ5IeNz1n
         S0pmc9RMUJ+bBIf1H79CQ/aYGqyivU73rU+eMaqBklwvEkBbFLQxXvQkkp2D9jFMyYS/
         3rc0oyimvHWP2/XY1jouTGa8bZzGtI4SklyxRft4PqwV3Cm/I/fh54U4OShGApxr1LYm
         2mMg==
X-Gm-Message-State: AOAM530Dixh0V2uhXe6f47JTUWxzMgAyabtFWMwqdEM0SXM2JIzPS/c9
        toBsjrhuPdAkzHf1O2apoNGEjXERnAbyMQ==
X-Google-Smtp-Source: ABdhPJz2NGDsD/sQV7fl3wMB0KLaKynAt4m+J4xYbn+GII3+eNyOJ/R78ZRTvH2wQEraCSzmUww6Dg==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr10987852plz.239.1597666608293;
        Mon, 17 Aug 2020 05:16:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id f20sm20700397pfk.36.2020.08.17.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 05:16:47 -0700 (PDT)
Date:   Mon, 17 Aug 2020 05:16:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200817121643.GB44309@google.com>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813145936.GC891370@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 10:59:36AM -0400, Jeff King wrote:
> 
> There's no reason that bugreport has to be a separate binary. And since
> it links against libgit.a, it has a rather large disk footprint. Let's
> make it a builtin, which reduces the size of a stripped installation
> from 24MB to 22MB.
> 
> This also simplifies our Makefile a bit. And we can take advantage of
> builtin niceties like RUN_SETUP_GENTLY.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile                            |  6 +-----
>  builtin.h                           |  1 +
>  bugreport.c => builtin/bugreport.c  | 10 +++-------
>  contrib/buildsystems/CMakeLists.txt |  5 +----
>  git.c                               |  1 +
>  5 files changed, 7 insertions(+), 16 deletions(-)
>  rename bugreport.c => builtin/bugreport.c (96%)

And I saw no surprises in the diff. As stated in
https://lore.kernel.org/git/20200817121239.GA44309@google.com I think
this is a fine idea, so:

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
