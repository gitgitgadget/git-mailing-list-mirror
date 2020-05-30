Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C090C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0932074B
	for <git@archiver.kernel.org>; Sat, 30 May 2020 13:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuQhqkOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3Nt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 09:49:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26BC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 06:49:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so1824222pje.4
        for <git@vger.kernel.org>; Sat, 30 May 2020 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G6ufHX5JUrWwiR7HvtVV9pDN837E0paxBKAeFg/jkZc=;
        b=PuQhqkOI/xeoE2MzXH/fFiakQLkrh6GiSj8Wa8FRHmmKGFZd1Hy6Xp6N5kgQlq4khU
         QGQ/2SFszNCrgpAhDSKV5a6d2ivQ/spBSN5d1Y7OBh3XWEm1OdvBNQRNh8bSuRZ9Qub9
         o8gPcf4JZnFKUpy3m3SdJPlLlruh1LZ88w56RUISUxhh3+G66jm5U7GptmhVBH/FF7Di
         bEvjnGSBFaUYxpA1S8RPyoAv/Czh8bCHEzB5Jy6yE1czHcL4/Xub32yU6Wy/x5fLY+Kx
         6uu2916yI+9VYR04NhOAhuvSoWL/bxofa4Xh+NxVGHIgfl9U3ed/CuysL84q71KBAbya
         KJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6ufHX5JUrWwiR7HvtVV9pDN837E0paxBKAeFg/jkZc=;
        b=Lsei6rdaf0IJYbWR0qnMCoDKbOVyqxraBkbt6Cw92XK745bE3fU1XxK0c5axm4cFgs
         Ve4/b9zrOR7w+uk/QdG1L/Qx13TM0iA+y/j6TfW8M8X/leKX3G4myeASsfUqre8crDSo
         JPtF7tlOnke7T6P57jkB7zU/CUCouvN9UJI3nhEjRA21Rg4rbqvepZ4L0tgZ2TiwMWpR
         K3VMWsEMM8muljWu7V9DzH5jIL21dxiAw423GBNPUk97fvZgIRx+9JNgiBv8+sQsNOvM
         Sj4h5ijvroDGGs+s4CvQZdaGa43jkOGnJdXy2tSNVLqzT+ISoayKWGgtd8wuo1A0+0T2
         fQpg==
X-Gm-Message-State: AOAM5318HCC20RI04Pdg9xCRk3pjjB0l5RR6ySNdFVMlyh/ilG9T72TW
        mNW+vf8x7o06kr+MYtdK5GQ=
X-Google-Smtp-Source: ABdhPJxsYkfY66jtoAJd9Inc5MiThZ7oPqw3ywezx+Co2i8CQpO8Ar11Hl5pSsuxssZehb823cqPTg==
X-Received: by 2002:a17:90a:49c5:: with SMTP id l5mr14073878pjm.73.1590846565852;
        Sat, 30 May 2020 06:49:25 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id x191sm10283121pfd.37.2020.05.30.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 06:49:25 -0700 (PDT)
Date:   Sat, 30 May 2020 20:49:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v3 4/8] cmake: support for testing git with ctest
Message-ID: <20200530134923.GB2151@danh.dev>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
 <cdc53172b3f073095911fe9f7f5ff8ea6546013c.1590759624.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc53172b3f073095911fe9f7f5ff8ea6546013c.1590759624.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-29 13:40:20+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch provides an alternate way to test git using ctest.
> CTest ships with CMake, so there is no additional dependency being
> introduced.
> 
> To perform the tests with ctest do this after building:
> ctest -j[number of jobs]

Or we can just run: make test
CMake will run: ctest itself.

Ah, OK, that's not equivalence. make -j9 test doesn't work :/

Anyway, there're test is failing in Linux with this CMake.

	$git_repo/t/../build/bin-wrappers/git is not executable; using GIT_EXEC_PATH

It looks like CMake Generator forgets "chmod +x bin-wrappers/git"

> Test time =   1.11 sec
> 
> NOTE: Testing only works when building in source for now.

OK, so this maybe the pain point, let me build in source again.
Hm, no, I still see the same problems.
Worse, CMake overrides my current Makefile.
Luckily, I don't have any changes in Makefile.

> +endif()#BUILD_TESTING

We can use:

	endif(BUILD_TESTING)

-- 
Danh
