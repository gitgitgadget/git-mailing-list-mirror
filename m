Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA82C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9227C2078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5KEsgKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJQHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:07:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJQHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 12:07:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so805005plm.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LXVSStVufOuI+ezKgNneOJ5MepK4BLxjf4xEimC0sjY=;
        b=a5KEsgKSYUb7khKqqRt/L/y6d24WjwoAKe8lBucVHtZpug22XgQsdpShJqtrCF7HyN
         owgoK4fDanPheTcFdyLykV6FCg+VTValHO7AIDj0XSll0zdBFIJnYAuG6qMORzyvKHBF
         M2hv64b8unel+nZzYnpmpAO/3q4EJm1/7qvjd2Lee6c9XxcrmqESf0/hXHBJltzkMybT
         Yj+Q27yMT/sVXLTUIa9/+vrmsyfGJX6E/1Jjoznn+thnaEY1gBZENa5VE6jukrrb4rVJ
         Hly2+GC3HnWDNJ8wchli0ssWsmWrLXf4skUdXGDXGJTRnUlZzl0I6NB+3yijJIZzlXuS
         xleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LXVSStVufOuI+ezKgNneOJ5MepK4BLxjf4xEimC0sjY=;
        b=b9Zf6UsCELiFe/lrUveg4RcKwo0sYslpikdJxbl9D/0KEjIdNCNvSTcDm3pmSx7eV8
         pkVCRMNTIXjDeDxiXbpaJGQbIrWKBNW6eqiAqknuy2ONAmlj2cuNEL9cAXCEpmH2YjCW
         yBsjziJRe2glzGZjZEYAJp1ufaboAvRIK6ckZk+jUwGCni9ElRaNB3tTU91E1j+6hkiy
         81NdfF3M4I8Am2cvw6AuKa9Y4Wy+XdkHFSWjW8QYY5v6dk0YYTXXDZ9CBQhQgkvYgKSM
         CpsRifZihNqjfcYQ8qUaZoZFNC+DX3JVt9sH5y05HoN4HRjUaszTxBWUNpZSUGyQ/JRJ
         Z/1w==
X-Gm-Message-State: AGi0PuZ3o7OTMOC7m11YcasfEVu12mzfTQilYahBfLAfebIbRcpTAgSK
        UF8rfAZ92MSY+2ySudhvb7U=
X-Google-Smtp-Source: APiQypLfgWIGOw/mbn3qHep+Bg8BG1SlF7UcC2eqajrlGqoYWcmUzfgkrKMtQxWAIdRRSEDT8R2h5A==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr6177108pjr.22.1586534863671;
        Fri, 10 Apr 2020 09:07:43 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id e22sm1873903pgh.14.2020.04.10.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 09:07:43 -0700 (PDT)
Date:   Fri, 10 Apr 2020 23:07:41 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 05/12] ci: explicit install all required packages
Message-ID: <20200410160741.GA12360@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586309211.git.congdanhqx@gmail.com>
 <4f80724641e17bf0d1937dbad77f987fbf86cd64.1586309211.git.congdanhqx@gmail.com>
 <20200410155322.GN2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410155322.GN2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-10 17:53:22+0200, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Wed, Apr 08, 2020 at 11:05:36AM +0700, Đoàn Trần Công Danh wrote:
> > In a later patch, we will support GitHub Action.
> > 
> > Explicitly install all of our build dependencies.
> 
> ... on Linux.  This patch doesn't touch the parts installing
> dependencies in the osx jobs, but we do rely on some packages being
> installed by default in the osx images we use.  This is worth
> clarifying in the commit message, and in its subject line.

Fair enough.

> > Since GitHub Action VM hasn't install our build dependencies, yet.
> 
> s/install/installed/

> > +UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
> > + perl-modules liberror-perl tcl tk gettext zlib1g-dev apache2
> > + libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl
> > + libnet-smtp-ssl-perl"
> 
> I note that this list includes 'make' and 'apache2'.

I'll remove apache2.

> >  case "$jobname" in
> >  linux-clang|linux-gcc)
> >  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
> >  	sudo apt-get -q update
> > -	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
> > +	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
> 
> 'apache2' is listed here again.
> 
> > +		$UBUNTU_COMMON_PKGS
> >  	case "$jobname" in
> >  	linux-gcc)
> >  		sudo apt-get -q -y install gcc-8
> > @@ -63,11 +68,16 @@ StaticAnalysis)
> >  	;;
> >  Documentation)
> >  	sudo apt-get -q update
> > -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns
> > +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns \
> > +		libcurl4-openssl-dev
> 
> Does the Documentation job really need the 'libcurl4-openssl-dev'
> package?  FWIW, I just removed this package from my system, and 'make
> doc' still succeeded.

At the time of writing this series.
pu requires `curl-config` for Documentation jobs.

Skimming over the mail archive, Peff has sent a patch to fix it.
I haven't checked again, though.

> Furthermore, this doesn't install 'make', though in other jobs it is
> installed explicitly.  Note that the StaticAnalysis job requires
> 'make' as well.

I copied them from Azure Pipelines declaration.
I think it's better to list make explicitly in all jobs.

> Also note that we have a 'linux-gcc-4.8' job as well...

Will do in the re-roll.


> > +GETTEXT_POISON)
> > +	sudo apt-get -q update
> > +	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
> 
> The GETTEXT_POISON job currently doesn't install 'apache2', but with
> this change it will.  If this change is intentional, then please
> justify it in the commit message.  But I think that we shouldn't
> include 'apache2' in $UBUNTU_COMMON_PKGS.

No, this patch shouldn't change it.
I will remove apache2 from $UBUNTU_COMMON_PKGS


-- 
Danh
