Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC8C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFD0206D4
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXCOkqQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgAXMIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:08:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39429 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgAXMIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 07:08:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so2060044edb.6
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TaMgaR6Csf1tJdDC1BZAztqXrUYMFsAlNSzDeJqIEiw=;
        b=kXCOkqQRI2Y7zikelUTj+bS7/CP8u/0RWKPE+DnLtqJQe/h3+tQfqKPXeSV5D0Afkk
         1qiegMEFCYVs4R2CXIMOa4+mErQpKdBvsQpsX3pfoN/DoPs3AxoWNE32I3AeLxEYhwJM
         RfbwXGWQr9IenB4IFdImgA6dhJxOekSljKj66/kp4q6oHa9t2mfPdVARr0BwYC215FHu
         Gb8zET4QAnNO6wR+1SEjE1txBPRjtoXnBF9RKu5Tp5Gkb80x9HOS8NDGwRIRENsu7/d+
         PFTipXcv40UpWL8NpPdXGwqTb9Np0OC7uGs+RuW4RKZ8q1QJEUgxwaQ78NSw2nwDKZDz
         APzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TaMgaR6Csf1tJdDC1BZAztqXrUYMFsAlNSzDeJqIEiw=;
        b=YlY5SaagHCnOIrg7tqDOTdcqgavcGwEpKuGNJdijwKgu/VshSGfnlYhe4XrVF2ck86
         eSykvXETdlliln+F/NcCP9Z1VwHoAGNHUQoSdqt05R7z2CxphvamwVGGqpGfsOufs3L4
         VSk+GRVl8GY3eA5G3PHUr6uI9Cu4RzvBEHAWfn8ykObuTyYyzq0grCL2+p8Q2yAe4Ub4
         Tl8RiyQRJoht8wrxpoNtFJL//qdrkRJJ0jYFk5ypD9yX6s6kVqXwL68qMegRCTyNdiJI
         56nclwtTMvPV9AG7fg/A5bZHHLla/LznPUQLcqkF/tf8gid0zuSONiaHUqGO707H3JHU
         3EzQ==
X-Gm-Message-State: APjAAAXq7zixhIj4en9i9gZZr/2CNpwFrGN/aT2dPjdO4+to9eK1xjer
        /UbW0gSqh4bHdity/BeLy4zoWLx+
X-Google-Smtp-Source: APXvYqzysnkKOBDxLAAWNHAgcv6Bd8PSuHm5e03cr7/qIcsPVXl/zxBwyGIRru0qTvEJOKsqfET6sw==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr4233557wrm.394.1579867363644;
        Fri, 24 Jan 2020 04:02:43 -0800 (PST)
Received: from szeder.dev (x4db61038.dyn.telefonica.de. [77.182.16.56])
        by smtp.gmail.com with ESMTPSA id v3sm7051189wru.32.2020.01.24.04.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 04:02:42 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:02:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200124120240.GG6837@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <20200123141626.GB6837@szeder.dev>
 <20200123175645.GF6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 10:39:12PM +0100, Johannes Schindelin wrote:
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index a90d0dc0fd..c3a8cd2104 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -162,6 +162,9 @@ linux-clang|linux-gcc)
> >  	if [ "$jobname" = linux-gcc ]
> >  	then
> >  		export CC=gcc-8
> > +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
> > +	else
> > +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
> >  	fi
> >
> >  	export GIT_TEST_HTTPD=true
> > @@ -182,6 +185,9 @@ osx-clang|osx-gcc)
> >  	if [ "$jobname" = osx-gcc ]
> >  	then
> >  		export CC=gcc-9
> > +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
> > +	else
> > +		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
> >  	fi
> >
> >  	# t9810 occasionally fails on Travis CI OS X
> 
> My only worry is that this makes it even more obscure what purpose which
> job has. Nothing in the name `osx-gcc` shouts loudly "I want to use Python
> 3.x!" to me.

Do they have to shout that loudly in the name?

We could rename these jobs to e.g. 'linux-clang-py2' and the like, but
I think it would bring little benefit, if any.  In our Travis CI
builds these Linux/OSX Clang/GCC jobs come from the build matrix,
therefore the jobname is not visible on the Travis CI web interface or
API, only in the build logs.  There are some pages on Azure Pipelines
that do show the jobname (and some that could, but hide it instead),
but it's just too convoluted (or sometimes even impossible, well, for
me anyway) to get there.

And if the requested Python binary can't be found, which will
eventually happen with 'python2', then the non-zero exit code of
'which' will abort the build, no matter how the job is called.

