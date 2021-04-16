Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A9AC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734156023F
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbhDPVXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbhDPVXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:23:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50AC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:22:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sd23so35428264ejb.12
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PnebQ4nT6WaLuJawOkWjEHdAGphNQ+dcI09R9HBNxjg=;
        b=NkVmI9kONa6+aYdeohYijVb6uF6XLdZCuoGwz8soJ/02a3+QDy9fUzolgd9ZpeX0xf
         weFQnEmnANTKOXjvW6eGdIETL65v7VKgnX6NrUs27pi+jay9swRBa9SfKgWlcxzlmiTT
         rgDuxHL3+MI4ltCeu7J2HM6e4bTUBCGNaJh3YjJkRZkOVhQK/VIohyVFMgoBM10pf1FX
         KqrV1nYGkHtkBXa0kc3oosjIi+3nW/Gy4ngm7sfBbw5MJQtjj93zZTBCj+PLGI6zmZYV
         D1r6FSMcAskHpUL5Sp7aF2Pf4j5xOzfg/rHijLB4pv75RnyK/l1PHBgCqYHMJodtfNNA
         lcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PnebQ4nT6WaLuJawOkWjEHdAGphNQ+dcI09R9HBNxjg=;
        b=NSLuk/WIHxloS7VB6C8lGQKCFBhJ8AP10SIVZjmERZn6ULQpUE0HYMYIo5nycsSajD
         El8v2kSr9Gu5vo6+PijoKuaIbQSidiSNV91fs2LQmq0gKAsCha9axfQTn8Ym+lRtQnUR
         AmEaQrkUWA8bWQTxCfvMVVBOx3oO7zh/i9hNJhie/2i7ll9Fq87uZc2k0Qs+ZqNfpd+g
         FAb83cCT+VA1AZiuqSrAfIwsbPg287y8ASSG/I6Q+hsCSKprlGDqMo+bhIVhnPO6a/vd
         OAe7Au/VYExGJyq5GGAd5AnRZ7owweW49CpxHMF6tpFbxUflSsjmbebj3K83P8KI5XR8
         xQNA==
X-Gm-Message-State: AOAM53003BFAccFuBzFnLdXHZpiYBlg5mofs5DjQ/ZQlb5364r19moj8
        kK8VwZxC2bHOy3416GYCTQs=
X-Google-Smtp-Source: ABdhPJy6VS5QzQqiy1nB4Mcm4oxaVfus+QzTMJHuNXFWlf6xeVOWRO0edBzw7FF22/OSXRJeqOHg3A==
X-Received: by 2002:a17:906:4a89:: with SMTP id x9mr10145881eju.121.1618608173550;
        Fri, 16 Apr 2021 14:22:53 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id u24sm6230122edt.85.2021.04.16.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:22:53 -0700 (PDT)
Date:   Fri, 16 Apr 2021 23:22:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/16] test-lib: modernize test_create_repo() function
Message-ID: <20210416212251.GQ2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
 <20210415211013.GM2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415211013.GM2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 11:10:13PM +0200, SZEDER Gábor wrote:
> >  3. We won't ever hit that "Cannot setup test environment"
> >     error.
> 
> ENOSPC?  Some rogue background process on Windows still desperately
> clinging to an open file descriptor to some file in the same
> directory, preventing 'rm -rf "$TRASH_DIRECTORY"' near the beginning
> of 'test-lib.sh' and interfering with 'git init'?
> 
> >     Checking the test environment sanity when doing "git init" dates
> >     back to eea420693be (t0000: catch trivial pilot errors.,
> >     2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
> >     was successfully created, 2006-01-05).
> > 
> >     We can also see it in another form a bit later in my own
> >     0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
> >     $old, 2010-08-30).
> > 
> >     But since 2006f0adaee (t/test-lib: make sure Git has already been
> >     built, 2012-09-17) we already check if we have a built git
> >     earlier.
> > 
> >     The one thing this was testing after that 2012 change was that
> >     we'd just built "git", but not "git-init", but since
> >     3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
> >     repositories, 2018-11-12) we invoke "git", not "git-init".
> > 
> >     So all of that's been checked already, and we don't need to
> >     re-check it here.
> 
> I agree that if we already have a 'git' binary that can run 'git
> version', then we can safely assume that it will be able to run 'git
> init' as well.  It might be that 'git init' is buggy and segfaults,
> but that is not a "have you built things yet?" kind of error.

> > -	mkdir -p "$repo"
> > -	(
> > -		cd "$repo" || error "Cannot setup test environment"
> > -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> > -			init \
> > -			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> > -		error "cannot run git init -- have you built things yet?"
> > -		mv .git/hooks .git/hooks-disabled
> > -	) || exit
> 
> This patch removes this '|| exit', which is...
> 
>   - good: if 'test_create_repo' is invoked in a test case (and not in
>     a subshell) and if it were to fail for some reason, then it won't
>     abort the whole test script, but will fail only that test case.
> 
>   - bad: 'test_create_repo' is responsible for creating the repository
>     in the trash directory as well; if that were to fail for any
>     reason, then the test script will not be aborted early.
> 
> I think the 'exit' on error should be removed from 'test_create_repo',
> but the callsite in 'test-lib.sh' should become 'test_create_repo ||
> exit 1'.

Case in point: the bug I just reported in

  https://public-inbox.org/git/20210416211451.GP2947267@szeder.dev/

does break Git in a way that in one of our CI jobs 'git init' is
unable to create the repository in the trash directory.

