Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1311DC2D0A8
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C4322207
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 02:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxxkYoYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgI0CZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 22:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0CZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 22:25:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FEC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 19:25:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so1579434pjb.2
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=05QFXwtpTp3y6/bKNziiLokRVCmtg4rx+GnYtoCKfPo=;
        b=kxxkYoYlGRRV9ZkGHBKyijIiEGJWmUtwN4YUP67oekufmY11LwuzixzK3HRLpWdKm8
         /riimJPMvqJE8Qmj3T6ZjOFByiqpmMN9EJhiwpEBK4PQ4/k6w2wmVTnMIrbbXl9OpjHS
         omelOgfLTVywxzE8cnW44ZCgw0WC1t9GYzudWGQ6dWk0gZVbZgDB+Fq5RxtTPquI9yss
         6slegVSNGeKA3pZG/SZltfMDpry3X5BjBeCvnfa59OqJ+RxZjHGbGKyD4i4+xZa1i3Vr
         JVhJRQ1ARwE0x+msWejL2PLi9Maq7RJFMTEiWpdHouRMlmPFxuVewwM7cIVagWB3PQkO
         UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05QFXwtpTp3y6/bKNziiLokRVCmtg4rx+GnYtoCKfPo=;
        b=mSTA3QX3yExHBWR5JZYh55Og6DvQdr1tzrzHglfZ++Lw4CSdMUfzuZEkGoIBHOqxKg
         3iUPvYhWmNe4KaCfV7x1Tqh8mVkHSik3a7XOhRAawbzDa3snLprGQ8gzOycBlzsh3OEp
         3L5KsA2AI4IoElfo0sHfUIZqfREDTsyF3Q6BcvFwz1fJaITaK9N3GDS+7Bg3ks7cyek5
         3qLgf0Q963qpsk5d2HdZhRDwusSSGTwWUQsWTZ7U0bzBv/S1mlYYRz2nLyF6JutIqNun
         fp8x/MbA7D1zHMbrPEWwwwn12YWRvjGbogVHFc0LJ5qIqh2fmM7CfldSDv0/5jsrpWMK
         aNnw==
X-Gm-Message-State: AOAM530HrvASa0frGdUSe+TZ/MnJpiqIzTVKdkJOGPuBF02kU2OX2g/k
        G7Cq0/i2xTK2kjKNLt5NiIg=
X-Google-Smtp-Source: ABdhPJylh7ZG1N0wBz0NSsUSYGlYASLP2qUB9ob2S2hOpvojgcXytTC5SHtL03Gwia2tCxJlwr4JBQ==
X-Received: by 2002:a17:90b:a44:: with SMTP id gw4mr3790081pjb.26.1601173547034;
        Sat, 26 Sep 2020 19:25:47 -0700 (PDT)
Received: from localhost ([2001:ee0:164:8119:190b:4a41:c771:566d])
        by smtp.gmail.com with ESMTPSA id d12sm2395377pgd.93.2020.09.26.19.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 19:25:46 -0700 (PDT)
Date:   Sun, 27 Sep 2020 09:25:43 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 02/10] cmake: do find Git for Windows' shell interpreter
Message-ID: <20200927022543.GD20935@danh.dev>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
 <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com>
 <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-26 22:32:25+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Since the Git-for-windows installer does append
> > 'your_installation_directory'/Git/bin to the PATH variable, it should
> > be fine.
> 
> No, it does not. Quite purposefully so.
> 
> The `/bin/` directory is kind of a hack to reinstate _some_ level of
> support for use cases that relied on Git for Windows v1.x installing its
> binaries into that directory (v2.x distributes them between `/usr/bin/`
> and `/mingw64/bin/`).
> 
> What _does_ get appended, at least by default, is the `/cmd/` directory
> (which does _not_ contain `sh.exe`).
> 
> Now, there _is_ an option in the Git for Windows installer to append all
> of its Unix tools to the `PATH`, but it is highly discouraged to do so.

I agree with this decision.

> 
> > I personally don't install my dev tools(except Visual Studio) to
> > Program Files(because of the _space_), it messes up the Makefiles.
> 
> Sure, and that's your prerogative. There's unfortunately no good way to
> support your use case.
> 
> Luckily, the vast majority of Git for Windows' users do not change the
> default location, and this patch is for them. (And "them" in this case
> includes me, personally ;-))

This doesn't fit into my view of Git for Windows' users
For some users that have the Administrator right, it's the default
location if they grant the Administrator right for the installer.

For those poor souls that works for enterprise companies, and thoses
that not feel comfortable give Administrator right to _another_
installer, the installer will install into (hopeful, I type it right):

	%USERPROFILE%/AppData/Local/Programs/Git

I think it's better to offer SH_EXE as an OPTION, let user specify it
as will. And we'll search in PATH if it's not specified, fallback to
2 default value if not found.

-- 
Danh
