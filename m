Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07684C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E069E6102A
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGPoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGPob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:44:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088AC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 08:42:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h12so10542851pfe.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pcf4cZZTKMMEfMjLE/s/dQ7+xGX/BcyJLpiJfsxPXJE=;
        b=txU5ntdp4tKn48qPLEZbm+h8iSeXLLAfbV7NJz3UtRwJ0WUWuNP7HpKaAbVnP5MmlG
         GRsYC/QEPM7nK/+7+ibMoJCZX8HeuaHDcwLmbAuF5ewIlAmEvTYRXwjQGNL5G5F91LAr
         A3AY5X6ZMU60BsE8q5ZtYq2ydMw+CQxQ5KR8U/XTio6gX6SxtSv5Dwbh36OlBYaG4alq
         Dfp0CeSbUW+zco2452YoHAZ3ZDl0LrweCyNNLN1S4TkJs+Wnu0v8tbPxdBUCDeKhByzj
         nXeSRUP5Ua0V9tcUKOXzeRKbZxnV2n7OaCq9D1stuIK8E9SiMGnpxlha4RNmn271L68E
         6Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pcf4cZZTKMMEfMjLE/s/dQ7+xGX/BcyJLpiJfsxPXJE=;
        b=o54/pde3hVXZNAKa3T9N6bwF0VfljL8OIpv/YVICCCO8iHNF56Q7GGQj5yPRYayx38
         XVjiuNavdCg/oZKmJb865ENtz8SOWEjK/WXsQC98ViWajjj7xhz09xxHUPNTD3+P5YR9
         /a7yZlQsJtAe958xn7lFwerCKTamzPrhTtusVVKBU3XN8OkqZRDu1toQTVD89q2/015T
         5utqRAMwdEMsfoiCyu/8G2MEhO/TB7sWpHL48EjYnPZ4/P2DQsjUYA/meKowBw89w2xA
         oRXPjim1v3djko36qFgkM36/cSGG4A+t4uyQjBBrfgtSaafzCOYa78xyNFCIXvW4JWkg
         DfzA==
X-Gm-Message-State: AOAM530jW8ZyUbXV7JKeJk93MoYVqE0CUn6At/VIyNIV97Ddk+Y9Cj64
        foAHnfjyEMJmOtCMw+RZ9WI=
X-Google-Smtp-Source: ABdhPJym59lF7RoWIYNE+4XpFDwe0JZ/ecXk0cLLHysD5AE7N5n8DmguKa0GtZ0dG2zHjalga1vNCA==
X-Received: by 2002:a63:bf0d:: with SMTP id v13mr18231437pgf.303.1623080557839;
        Mon, 07 Jun 2021 08:42:37 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id t14sm9116812pgk.21.2021.06.07.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:42:37 -0700 (PDT)
Date:   Mon, 7 Jun 2021 22:42:34 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
Message-ID: <YL4+ao9L9R6LcN9W@danh.dev>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210607004838.15235-1-congdanhqx@gmail.com>
 <xmqqk0n6wkrr.fsf@gitster.g>
 <20210607143815.77djyvxf4xec2qht@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210607143815.77djyvxf4xec2qht@tb-raspi4>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-07 16:38:16+0200, Torsten Bögershausen <tboegi@web.de> wrote:
> On Mon, Jun 07, 2021 at 10:01:12AM +0900, Junio C Hamano wrote:
> > Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> >
> > > Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
> >
> > That certainly is better than "user-specific", but a lot worse than
> > "user-specified".  "pre-defined" leaves it open to question "who
> > defines it?", and it is a reasonable interpretation that the locale
> > may be hardcoded in the makefile, but that is not what this patch
> > does.  Saying "user-specified" would not have such a problem.
> >
> > >> I kind of wonder if trying "C.UTF-8" would be a reasonable fallback so
> > >> that people don't even have to set this extra Makefile knob. But I'm not
> > >> sure if we have a good way of testing if that locale works (if we can't
> > >> find the "locale" binary).
> > >
> > > I also think we should fallback to "C.UTF-8" instead of not testing those
> > > tests.  However, I don't know if there're any systems that not have "C.UTF-8"
> > > locale.
> >
> > I do share the feeling, but have a hunch that systems lacking
> > "locale -a" may be either superset of, or has at least large overlap
> > with, those lacking "C.UTF-8", and the new mechanism introduced here
> > will cover both of them, so I think it is OK to stop here, at least
> > for now.
> >
> > Thanks.
> 
> I did a little bit of digging, the first (?) usage of locale was probably
> introduced in the i18n patch to use gettext and msgfmt and stuff:
> 
> commit 5e9637c629702e3d41ad01d95956d1835d7338e0
> Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Date:   Fri Nov 18 00:14:42 2011 +0100
> 
>     i18n: add infrastructure for translating Git with gettext
> 
> --------------------------
> 
> I can't get rid of the feeling, that most systems have an UTF-8
> locale enabled by default these days.
> 
> What does the following give us under Linux musl ?
> set | grep UTF

It's empty.

OK, I lied.  Distributions include a file in /etc/profile.d to enable
LC_ALL/LANG.  Without that file, it's empty.  However, such use-case
is covered by our fallback to LC_ALL and LANG.

Technically, Linux with musl always knows those locales C, POSIX,
C.UTF-8

I worried more about other systems instead.

> MacOs (my box here) has this:
> 
> LANG=en_US.UTF-8
> LC_ALL=en_US.UTF-8
> LC_CTYPE=UTF-8
> XTERM_LOCALE=en_US.UTF-8
> 
> If, and only if, Linux musl has a similar setup,
> then we may be able to skip the Makefile knob for the moment.

Yes, this patch allows to skip the Makefile knob.  Because LC_ALL and
LANG will be the first and second fallback, respectively.  And we can
skip a (potentially expensive) call to "locale -a".

> Just skip locale -a, if locale is not available.
> This is just a loose idea, I need to install the git-svn bindings and
> test if the git-svn tests pass.

-- 
Danh
