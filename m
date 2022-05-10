Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8F2C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 20:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiEJUMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiEJUMC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 16:12:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3925B87A
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:12:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e15so19744357iob.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D9u1Jo5a0Le/J+CWtDAHTXduDNFK5TeeCxnqMujISeg=;
        b=YCmBN/dMsnTOeCZoObumDqHUXQAYirW3lVzirlydQcp2cVQtuHzk8o+kY3PDkzrYXw
         H85mRX848th3thshVZCE8Yjs5YP0T6kJhcklO8Nc4FY/oKbleingwTjisR4VXzmtQJMd
         ENMsGyQeSorq84TtR7luFbdGwUpNkZTUr5+2ev4l1rXBicMFzNagrLIzDQWWbMCUav8j
         syVMSchDPll5T3lT+KOB17hzGy40G5SOKxMQn+/oyVGTUbGIBYWA9r824JvR8FqpNugv
         OTzS5siSVM+hSaHrhEfWDM8a59EDLYaGpDMBotlYdJaywPmBreCo8sPFX6iZfz0tev6/
         kygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D9u1Jo5a0Le/J+CWtDAHTXduDNFK5TeeCxnqMujISeg=;
        b=zG/uMeQhYVP0b9/WdEF51PRlF4z/bArdn76j+J8Adw4D58mAwzg0h/0Zxx4aq9rYmj
         3R4+iSkxSqrFdociZBWcuA2FmLAQi3xJsvz6DNlUoKKwfEefACccc45ElCBNXMhb8I9R
         GsOEVnwJa94z9PFV3PHmvw/s4R5M4xygHIVTviOjl3MaGHc+vT6XzEUY0o+KedDxr5fi
         em38YMbSDdlW5HTtqE0BGFng5psM7/ZjIxJfu3C+kpa9fpeR72Coyb+ycMkgnSxBIIkL
         tgmUq7FFEC77nKYhRkf3kWyl1WpJ3YDd83bGAGbmKCiJ1eBLnzZFLAQ/K/9KntMhhtgr
         Up0g==
X-Gm-Message-State: AOAM533MYKXvXq00W/kb7lm8xx9v1Ms1na88cK0eczNK8Gac0RDADq+a
        iyaQg1u47fYCMBenUVBWqiyUU9gIY87b32hJ
X-Google-Smtp-Source: ABdhPJyo/zuXLISDKnfpybASM3vsP9THW7KQbk9xITIMN/DEIAEGW5FkmEx0GefPGayzZ0mUDq85nw==
X-Received: by 2002:a05:6638:168f:b0:32d:8105:7646 with SMTP id f15-20020a056638168f00b0032d81057646mr5533259jat.9.1652213520300;
        Tue, 10 May 2022 13:12:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x11-20020a92060b000000b002cde6e352c8sm97490ilg.18.2022.05.10.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:11:59 -0700 (PDT)
Date:   Tue, 10 May 2022 16:11:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Message-ID: <YnrHDieIQqjBUl/2@nand.local>
References: <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com>
 <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g>
 <20220429190625.GA1626@szeder.dev>
 <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
 <20220510183321.GA4408@szeder.dev>
 <YnrDK0wCV6taY1QX@nand.local>
 <20220510200658.n2ythd5soyzguqb4@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510200658.n2ythd5soyzguqb4@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 01:06:58PM -0700, Carlo Marcelo Arenas Belón wrote:
> On Tue, May 10, 2022 at 03:55:23PM -0400, Taylor Blau wrote:
> > > >
> > > > 	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory
> > >
> > > Oh, wow.  This is so obvious, no wonder it didn't occur to me :)
> >
> > Don't we consider this one-shot environment variable to be sticky on
> > some shells (i.e., that it persists beyond just the "git config"
> > invocation here)?
>
> do you have an example of such a shell?, I would assume that since the
> mechanism to implement these would be similar to local and we already
> require local for running our tests, that shouldn't be an issue (at
> least in the test suite), right?
>
> any such variables should be only set as part of the environment used
> by the posix shell before it call execve to invoke the next command IMHO.

This is completely my mistake, that stickiness exists only when invoking
shell _functions_, not other commands (like "git").

I have gotten so used to looking for the former, that I didn't read
carefully enough to realize that we are in the latter situation instead.

> Carlo

Thanks,
Taylor
