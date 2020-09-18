Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920BC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815C523888
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YReUDPv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRPuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRPuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:50:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5221AC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:50:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f1so3177098plo.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gy9axbz17QGEmcqpvlZ+pDfCtOsOTj2P4kGi8JhEzZ0=;
        b=YReUDPv9/NckC+sNw4pgFzcNwW3CadsHuFIGoFxIw0fZJuYqTkebqdIj2q+EP5uLgv
         YOKDUYdIqSXEr/8JIkIiNsiEY8k1uPh8Y+d9I7xLOsdV/mfLaoMCqiaCtaQ+IT0B5+nT
         YjfhKp63qS8JuJOc8wzK7DJdmP7yOYn4PILZfKBBZoecflOob60szi3htaEHv0UZ96dZ
         emAy3KG4zTPumA8Lkky8iT9C68zK8dR7eP+HgNFA80Bfa7I01H3nGA0XEVibtQvNQG9O
         WIckrWtrqM3MJpfQliF6j1T8ptNP7lHnDiHVXZn61ncs/u6oaTxvNvn1/60zM/thtLfq
         UdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gy9axbz17QGEmcqpvlZ+pDfCtOsOTj2P4kGi8JhEzZ0=;
        b=KMFSl2bmsnTjFXOkiDvun2fwararN0La9/DWXR24z6DS2zWTN2Lg/1GE5rIB07cEVP
         H6MSFyizYIX12jI0o5uLpFdOBG5MtSaqVOFMGdw4GgmWGtpkbqi+fzaaxRf4ZEh6nn5e
         fm+pfofH+iiSnyhi7FGmDxBDH0uw0+NkgmIj3BId2KrrUDvwn8rgoCwg701j68+me93a
         JrmYxclc6LM37CgnJvRk9E6HIpPfIp/4YTBComQdwHD+K9mJPtO1UP9P5S/XhqD7PtBk
         czW3W8R/jZMaCQA0tf6je1b5kuyWZEZrjn9hTMnIOg4NEJFsjOAq/hl0sZ7AhO04CjKw
         ZpQA==
X-Gm-Message-State: AOAM5300seQ9hx19b6Hvt4smf3eorMyqfO6hxLvZnrpt6vbdgAya3qP9
        vKGePHYlPBLxqWULu4tBNgo=
X-Google-Smtp-Source: ABdhPJxF22GxFqpS84PZMtHyN+icER+boNhibq46Pv5kq1G2F8M+WNXQjpgSyJKG3lHNNwudnHaU5w==
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr13599426pjh.194.1600444217847;
        Fri, 18 Sep 2020 08:50:17 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id u2sm3356526pji.50.2020.09.18.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 08:50:17 -0700 (PDT)
Date:   Fri, 18 Sep 2020 22:50:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
Message-ID: <20200918155015.GA1837@danh.dev>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
 <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
 <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-18 08:28:48-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Good to catch these cruft.
> >>
> >> Does the equivalent of "make distclean" need to be updated to clean
> >> them as well, or is it sufficient to ignore the build procedure and
> >> just rely on "git clean -f -x"?
> >
> > Since CMake in conjunction with Visual Studio completely side-steps
> > `make`, I think it would make most sense to ignore `make distclean` in
> > this context and go for `git clean -dfx` instead.
> 
> I think you misunderstood the question, overlooking the "equivalent"
> part.
> 
> I expected that when CMake & VS discards build artifacts, it would
> not make literal use of "make distclean".  After all, it does not
> use "make all" to build, either.

Actually, in CMake land, people usually do this instead:

	mkdir build
	cmake [-Ggenerator] ..
	<make/ninja/msbuild>

Then, when they want to run something equivalent with make distclean,
they run:

	cd ..
	rm -rf build

instead.

The change that Dscho suggested was meant for those people that run
CMake in same directory of source dir, which is mostly discouraged
in CMake land.

In additional, CMake's default Generator in *nix is Unix Makefiles,
which will clash with our Makefile, and totally unsupported.

I think the original CMake proposal didn't touch .gitignore because
they run in a separated build-dir.

-- 
Danh
