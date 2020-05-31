Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EBC433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ADC2074B
	for <git@archiver.kernel.org>; Sun, 31 May 2020 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cryYnUze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgEaB2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 21:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbgEaB2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 21:28:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F26C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 18:28:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so3347929pjm.2
        for <git@vger.kernel.org>; Sat, 30 May 2020 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Az1zJmmw25C/fxaZb0OpcCCbPRkgBR6Om6uES2kR3Fg=;
        b=cryYnUzeHzj1hRA/FlrGyqp8OfM7G8hDxaEg/WUs6Sfn2KXxBveN90BOtU13Bo+cS8
         C9ABNdVWQsltdek2LKjA125v1G4s9PHo+i1usqx1gFf+iH0h3xHOau6HzWqUeTdfKqtA
         FTVXusfm53tjHtWl892StIqEOD9/9wD3t34rqClO93smfXvMx7V7oLbIrTgsdy9DG5ew
         Z0Lv2h5cnIO7eISAbx2HdgVGaPDxKDER4gkozZeU0wpVGAvyR82BnDd0Qk+/45PubIC4
         icC78zPTeJxgBsFOjLjlwAB8gPQGj+tTdE3IIkF9kuYhJLNpw+aSdvr2nuux7TokH56e
         /gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az1zJmmw25C/fxaZb0OpcCCbPRkgBR6Om6uES2kR3Fg=;
        b=STLg25LszHPH06aEhHhjlx3ZViM3MUE5uLRdL6wPQ6CD7loF1wbSJT7g9Z6nFIEUrG
         tNnEQMN3H5n4PQaxmQnYW5M8kL6UTcGPpSZ9X/pWGUMNS975RciGsiV7uycfHJdrAEth
         KiIdJ9WrXKZnxltvz09FBZx0AXFOig6YQXHEMcvvhenbJRJ2+YTIXEmGm7QCiaTvknr0
         /Llzj7C8CHzrMbcNtfMh6Lx70xREooonF5gOekMDXI0rGWlxdMZcNwsaf1r2yTvfwbCJ
         l8TsB7hy19fGbF/8ONiyeV9ruzgdh24b7HHtaqxE+4sxE+WuMfkSH9aOI8b2POEMKrhz
         8tog==
X-Gm-Message-State: AOAM531C84RQZW63pRtAg4fABjMndffZgALC8OXgYewpkQdVWs02sR0f
        smStT1y9hAzMNMl6Sg5ZWBc=
X-Google-Smtp-Source: ABdhPJzM886exwf13QMawlubyCowPwmqByyPvRK8DZUq07vtoGlstdtirexFdIc2g/MEx+Fr16ZNtQ==
X-Received: by 2002:a17:90a:b10e:: with SMTP id z14mr16955447pjq.57.1590888518088;
        Sat, 30 May 2020 18:28:38 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id i14sm3446421pju.24.2020.05.30.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 18:28:37 -0700 (PDT)
Date:   Sun, 31 May 2020 08:28:35 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/8] cmake: support for testing git with ctest
Message-ID: <20200531012835.GA2148@danh.dev>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
 <cdc53172b3f073095911fe9f7f5ff8ea6546013c.1590759624.git.gitgitgadget@gmail.com>
 <20200530134923.GB2151@danh.dev>
 <CAKiG+9WxoffdtQPvVk=8nG+Q58VvrCd4T41bP3ef3wn+FV8h4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9WxoffdtQPvVk=8nG+Q58VvrCd4T41bP3ef3wn+FV8h4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-31 00:34:52+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > Anyway, there're test is failing in Linux with this CMake.
> >
> >         $git_repo/t/../build/bin-wrappers/git is not executable; using GIT_EXEC_PATH
> >
> > It looks like CMake Generator forgets "chmod +x bin-wrappers/git"
> >
> 
> CMake does not support changing permissions of files easily.
> You have to juggle them around to a temporary location and
> change the permissions when you do `file(COPY ...)`.

Does it work better to use `configure_file` and `file(COPY)`

> > OK, so this maybe the pain point, let me build in source again.
> > Hm, no, I still see the same problems.
> > Worse, CMake overrides my current Makefile.
> > Luckily, I don't have any changes in Makefile.
> >
> 
> Please read the next PATCH, it supports out of source building and testing.

It's the remind to NOT mess with Git's Makefile ;)

> > > +endif()#BUILD_TESTING
> >
> > We can use:
> >
> >         endif(BUILD_TESTING)
> >
> 
> The docs suggest that this way of endif() is for backwards compat only.
> Not sure if I should change this, as CMake might remove this in the
> future(very unlikely though).

I don't have strong opinion for this syntax.

-- 
Danh
