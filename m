Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6205C4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86734613D2
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFDFWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDFWS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 01:22:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACFEC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 22:20:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o9so4101452pgd.2
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OunbsFKEYJk1oKxFiYu43Ts46kMPthyD+5h4ZsP/IQk=;
        b=lGYm+RWc9CrVLokn6C5m2VJMdt6SLf1XGsGIO7WHg/c218PL5PrDGfD7EXHWgu7SCG
         2fsCo38vAKY9d/Cr4kUpcmdI5JxIJ5WBZRpkrEqJdZE05ffmmEOOTE5i8ZmqxXmkQqb/
         0YcilwE7CdL7bgdCfBIoyTSLlb0fELNCETD9/2Xccxf+eAwQGT6rklOulIXebHJ/9/zR
         Ilu+UcnJdYCHyvKIl1LEiMWA4padEdiMOYpBvpyAFfYw6jf34iK+yN2IbJDN8n4AL3Hg
         o6h8Bz7Yi4fvHedmXo6OIQtDhWhjvYrA9TsnbnQquMtSTBIPmvibMsTNIBJusURCObVm
         5hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OunbsFKEYJk1oKxFiYu43Ts46kMPthyD+5h4ZsP/IQk=;
        b=AwKOvNnuMWC5LiiYEqc137FD0tgAtvqds8O/5Vixkrxp1LYE62Qx0EBagtef9mJpHh
         vQ/h3gt/pvlslVCIIECjB3T8CqMMl822PdM3ToZ1mZm0pV9exFsX1p8CzP8VTh+NPNqP
         fX14Cc+xMF8BLGkwlE/BHq5JpEK57VMd7iqpquQaxKfLHbGZPLwUP5Cgx8bUA24dJgww
         XhzofsFUMs7wIFlituxYrWj8LLljBdKEfV1d9ZLLXqe03UEmSk7nj9Jt9CtcAaQJEgCY
         F5Lms7w0XvqdSIt53Ye7Yz3kijk+xw8yJharLx4korx02/0QAb237dGbgk9S8xIyax9r
         jrbQ==
X-Gm-Message-State: AOAM533/eMU+wKDfmt1z7kEZi8z3etsCBm4VH6kq4sJE+Qo1yYKIXg9n
        QiXeCOimxCMmyxkmAf3OB0dWfxdJ3H0l/g==
X-Google-Smtp-Source: ABdhPJyd/oqdraV/eWwyQhQClXNPuMyLdc+l64kXBhJB7svZbutJmTIb1oiY9ldMuA91p8nwuidcOA==
X-Received: by 2002:a05:6a00:882:b029:24b:afda:acfa with SMTP id q2-20020a056a000882b029024bafdaacfamr2693496pfj.72.1622784020994;
        Thu, 03 Jun 2021 22:20:20 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id np1sm3507706pjb.13.2021.06.03.22.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 22:20:20 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:20:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use user-specific utf-8 locale for testing
Message-ID: <YLm4EXRqsXF/VenO@danh.dev>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <f8cbd947-3176-34bc-a0f0-dd816298e2c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8cbd947-3176-34bc-a0f0-dd816298e2c7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-04 10:32:04+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Hi Đoàn,
> 
> On 02/06/21 18.46, Đoàn Trần Công Danh wrote:
> > In some test-cases, utf-8 locale is required. To find such locale,
> > we're using the first available UTF-8 locale that returned by
> > "locale -a".
> > 
> 
> On most systems, the first available such locale is C.UTF-8, so why don't we
> just use it?

I don't know. I think in Linux with glibc, C.UTF-8 must be enable
explicitly and run "localedef"?
Worse, systems have a right to not have any UTF-8 locales.
Someone may only enable C and en_US.ISO-8859-1

> > Despite being required by POSIX, locale(1) is unavailable in some
> > systems, e.g. Linux with musl libc.  Some of those systems support
> > utf-8 locale out of the box.
> > 
> > However, without "locale -a", we can't guess provided UTF-8 locale.
> > 
> > Let's give users of those systems an option to have better test
> > coverage.
> > 
> 
> So can we assume to UTF-8 locale as default for testing on systems without
> locale(1)?

I don't know, either. POSIX only requires 2 locales, C and POSIX,
All other locales are optional:

	Conforming implementations shall support one or more coded
	character sets. 

I don't know if such systems exist or not.

C and POSIX treats any bytes higher than 0x80 as arbitrary characters [1].

	The POSIX locale shall contain 256 single-byte characters
	including the characters

> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >   Makefile                                 |  6 ++++++
> >   t/lib-git-svn.sh                         | 15 +++++++++------
> >   t/t9100-git-svn-basic.sh                 | 14 +++-----------
> >   t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
> >   t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
> >   5 files changed, 23 insertions(+), 22 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index c3565fc0f8..4b2c24e5ea 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -398,6 +398,9 @@ all::
> >   # with a different indexfile format version.  If it isn't set the index
> >   # file format used is index-v[23].
> >   #
> > +# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing.
> > +# If it isn't set, use the first utf-8 locale returned by "locale -a".
> > +#
> 
> Better say "... to prefer utf-8 locale for testing".

I intended to say:

	... to *the* preferred ...

We need utf-8 locale to test anyway ;) So, we don't prefer utf-8 locale,
we pick a utf-8 locale from a handful of utf-8 locales.


1: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap06.html#tag_06_02

-- 
Danh
