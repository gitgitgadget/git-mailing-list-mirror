Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62365C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 02:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309DE206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 02:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="varRvGJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLVCH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 21:07:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34872 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLVCH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 21:07:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so6987762pgk.2
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 18:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hplSm5RlQT0QBxegmQnKBEVeWioBkdixJZ6OX+RD6tI=;
        b=varRvGJBsiQPbUxuZPBqPqIILJP0fiQfPi0como8rcvmADfxn6i22lR2TGWEZgvfrP
         aP4q+rGwGpp5M2RdUIOPl+zIFw/27UnCDoeGrh6rsEIgVku2s9FHwc8GY1qb9uKtKUSz
         Pk2i1DkxPo9YNL835t0c6LmT+fBz7tjqMC9U4Tmn6SAbVHFe5F/jdFCJ+z1E8wCHenqO
         ZdJxewP1drQeFT0eyQLcgmT5vHSltfEyfAb0jFLnDL8skxsYGlwf3cxvy12kl7s5MuEL
         yQQVNOJw3bNwRTJIqb2Z9QVZVH51qe2+9PqYoleo8P2bJQXuD5e3bdUT4AnxhNa87MXq
         EtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hplSm5RlQT0QBxegmQnKBEVeWioBkdixJZ6OX+RD6tI=;
        b=nGZrZHWkS7TQtlX4gX7uqOvXOhjX32WPC2cCYCea4fUIGcWYa+Rhnf7RMWi9Wbm+Ma
         z24EBCPreSPkkuigrr6Zrl3+EDB7UJNO5dFkOKExL9Lq637kFeQyNG/yhBaSt3y++CYd
         ozKZEPx0Mh6VkICE/bMmJYMJ7PNS0zJaB3lEKdhmG368vMb223FbRNejJv+oS1jeQtWL
         OxmBXPzAGaPUONgswdSQk9EvgCM58clrYhJU+Nfucgvc47nhorUbp35xiT5LOCb7r4ZX
         G7AyQ6u2gCci9pHHx27DyMp5/72DEidozlC+Ggp3F5xh4MoaaQ1fdthMQynuLUt+u70W
         aczQ==
X-Gm-Message-State: APjAAAVr3BOXqKStBuygqFBcbpJgFvxHX938E2v26iRZcv3JnkeGUUnP
        yTpbp+HGJaLY7BMTZRWEE4I=
X-Google-Smtp-Source: APXvYqyLmxdvhHS+1UjDz+vpqwKtDeo7/kq8R8Ppw9WsDraQRlIOmKQffx2HEMJcZqKjl64toBD7og==
X-Received: by 2002:a65:4206:: with SMTP id c6mr24145561pgq.46.1576980476978;
        Sat, 21 Dec 2019 18:07:56 -0800 (PST)
Received: from localhost ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id o16sm16466713pgl.58.2019.12.21.18.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 18:07:56 -0800 (PST)
Date:   Sun, 22 Dec 2019 09:07:53 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test: switch to POSIX compliance symlink check
Message-ID: <20191222020753.GA14802@danh.dev>
References: <20191221164057.24616-1-congdanhqx@gmail.com>
 <CAPUEsphavRpYeJGLY73rzy18VFvTUfhsb=y6pC53e8b9aEbfRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEsphavRpYeJGLY73rzy18VFvTUfhsb=y6pC53e8b9aEbfRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-12-21 12:45:43-0800, Carlo Arenas <carenas@gmail.com> wrote:
> On Sat, Dec 21, 2019 at 8:50 AM Doan Tran Cong Danh
> <congdanhqx@gmail.com> wrote:
> >
> > POSIX doesn't specify `-L' flag for test(1), POSIX specify `-h' for
> > checking symlink instead.
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
> 
> seems to indicate both are valid and equivalent

It's seems like I've misread my manpages.
Somehow, I couldn't find the mention of `-L' when I tried it last
time.
Please ignore this patch.

> 
> > While most shells and test(1) implementation provides both `-L' and
> > `-h' for checking symlink,
> > OpenBSD and NetBSD says we shouldn't rely on its existence. [1]
> 
> and macOS (from FreeBSD[1]) says the exact opposite :
> 
>      -h file     True if file exists and is a symbolic link.  This operator
>                    is retained for compatibility with previous versions of
>                    this program.  Do not rely on its existence; use -L
>                    instead.
> 
> agree it would be a good idea to use only one for consistency though,
> but it might be in that case a good idea to add it as a
> "recommendation" by adding this rule in t/check-non-portable-shell.pl
> or something like that IMHO
> 
> Carlo
> 
> [1] https://www.freebsd.org/cgi/man.cgi?test

-- 
Danh
