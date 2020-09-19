Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CDC43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E762067D
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyh7H6Av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgISAke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 20:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISAke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 20:40:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C65C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 17:40:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so3870336pjb.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 17:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P9RYv7NlL2UjTtiSKMmfN4ddm1oyyN25RBlYAteNBBM=;
        b=oyh7H6AvUMbN05zD6/Qt5o2kF7JzsOcgCoN19h85ljM7XOAu1l+MXK1HO6GQExq45l
         k2yzDGjxqPeuklgWRq1Thg4SUZx16dexKjCtDMupgo1o3qd8ixRT9R11lnsPRUfs5og9
         dRQ2ZppRDZUccNFQJgmlhOiO6rwEXxd6hIyNUQnas3DhlvYUfDpCBp3EIlT116VMjyv7
         720yg7Jl7W8/tI30kEY9NDbsU20LEeasyyi9EyNVleHVq2QRDSjoA+Bed373hU5G/NX6
         OnacfXpdzo13JUo2joa8ke/so8cFWBH/VbgckeGlxzc+JNOReq8mpYfw1BNsfPGP85Pe
         YyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P9RYv7NlL2UjTtiSKMmfN4ddm1oyyN25RBlYAteNBBM=;
        b=ayUpx3Wv/1JxfX0QGUqP5A/TgXM3G4bXzAPueSlyh6uawMckYeen7RUI868qVEzEEC
         2/IrsAV1kmP5MAWrsC/pwm3ajDjgwNVgwOHJarMY4oa0lvxmFCv3mLjaWDPZSHShgSZ4
         MjvRNQILQYZW/+UpXgxrBtx7C4q7OsoaTMAAfFoU9ku0MEvdiX6kaAnQiTJ5CAmvkT76
         WqzfDBe4C+XrhPT5F75K5WFoi7gggwy6janfyU+wkUbAJoxMo2PNr8BbEimjPLq+xHe4
         DpLukPJs7vzMGdOHrXurVfsaVhx6ziAYXN7g6pUTJLPa1IadGqzH8e19+l0SNfzYboGR
         rjDw==
X-Gm-Message-State: AOAM530Ea23ZFPSiuO24P8TVYl/M5C4mHqiG65dKsZ9l6YMpQE1JZaPb
        8SSbOT9sf7K8+nefGWuxOD8=
X-Google-Smtp-Source: ABdhPJwNilWvOOVSZSH2jlhb6VEmNIeij3W2PWhK1pCzZX0CNhzLe3gwtxjiYisRhIkI8p3TL16qSQ==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr15260040pjq.212.1600476033152;
        Fri, 18 Sep 2020 17:40:33 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id v6sm4637993pfi.38.2020.09.18.17.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:40:32 -0700 (PDT)
Date:   Sat, 19 Sep 2020 07:40:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
Message-ID: <20200919004030.GB1837@danh.dev>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
 <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
 <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
 <20200918155015.GA1837@danh.dev>
 <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-18 09:21:45-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Actually, in CMake land, people usually do this instead:
> >
> > 	mkdir build
> > 	cmake [-Ggenerator] ..
> > 	<make/ninja/msbuild>
> 
> I presume you "cd build" between steps 1 & 2?

Opps, yes, there is a "cd build" there, and it should be:

	cmake [-G<generator>] ..

<generator> is the target build system, default to "Unix Makefiles"
in *nix land.

> I take the "people usually do" is the best current practice?

I would say it's the best practice. It's recommended in cmake official
guide (although, they don't write the word "best practice") [1]

	It is recommended to build in a separate directory to the
	source because that keeps the source directory pristine,
	allows for building a single source with multiple toolchains,
	and allows easy clearing of build artifacts by simply deleting
	the build directory.

> 
> > Then, when they want to run something equivalent with make distclean,
> > they run:
> >
> > 	cd ..
> > 	rm -rf build
> >
> > instead.
> >
> > The change that Dscho suggested was meant for those people that run
> > CMake in same directory of source dir, which is mostly discouraged
> > in CMake land.
> >
> > In additional, CMake's default Generator in *nix is Unix Makefiles,
> > which will clash with our Makefile, and totally unsupported.
> 
> I recall that our CMakeLists file asks the top-level Makefile about
> basic things so that we do not have to duplicate "list of files"
> etc.  in places, so I can understand that it would lead to a
> disaster to do "cmake -Ggenerator" at the top-level.

Yes, and in some first iteration, the proposal didn't check for
builddir != sourcedir when -G"Unix Makefiles", which was corrected later.

I haven't checked, but I could imagine that "cmake -Gninja" at top-level
sourcedir should work without problems, though.

> > I think the original CMake proposal didn't touch .gitignore because
> > they run in a separated build-dir.
> 
> If so, not only my "do we need a matching change to CMakeLists to
> teach how to clean crufts?" becomes unnecessary, but the original
> patch that started this thread to touch .gitignore at the top level,
> does, too.
> 
> I wonder what led Dscho not to follow the "create a 'build' dir and
> do things there" practice.  Judging from the fact that the "because
> they run in a separate build directory" assumption did not hold to
> somebody as experienced as Dscho, it is likely others would do the
> same.
> 
> What can we do to make it easier for people to discover and follow
> the best current practice?  Are there things in our build
> instruction document (e.g. the comment at the top of CMakeLists.txt)
> that needs updating?

I think Sibi had done a lot of good work to write instruction at the
top of CMakeLists.txt, I guess it's a bit too much instruction.
The instruction for out of source build was written after the
instruction to build in-tree.

Should we change the order?  I don't really know.

I only tried to build Git with CMake only one during the review process.
And haven't touched it ever since.

1: https://cmake.org/cmake/help/v3.18/guide/user-interaction/index.html#command-line-cmake-tool

-- 
Danh
