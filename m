Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD92C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB6E20BED
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585675348;
	bh=EyOFtifAj4Nv5ZHFF0MyS9OeMZi5aDRKIoZZmji26+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c+EWKOhJjf+SpkHQiymL0W/YYQmQZkzpENk7JQWcFZVDD/py5afkc/ptR6h5tahFP
	 78pQkSWaMLc34UIrlAFMb8OdN1/dGmU/LqyeWpSYifXPR/IlgjDzX8DcVxMjW2FEJD
	 5N/lxxJan0UngyxFDslWuxw1WBWHKHWU2XFa9SNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCaRW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:22:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 13:22:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so753510wmk.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2dOr4ZxDnnsdaMKQV2e2xTOUEQAecZefGGXrnSV+Ks=;
        b=Ks73nIqdIwz4rpp8WwGYphZkOVftU2V9XgYPhj7p06Glx307m8OaKBQXu5cpOCWIis
         +AUimkuex9MxvW7AxzT7nZ1w4nyVvgiNS4nRPZuLHt4o4W0C8TCVtb7WYBUjGRMq2qLI
         q76YllZEws4Jjbx8hRR37OHs/T3E1cFR+CZzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=d2dOr4ZxDnnsdaMKQV2e2xTOUEQAecZefGGXrnSV+Ks=;
        b=lxqTlECYI0hHqKY2AN8oY52GHSAVAWe8/t05muqghIKqeko9+U489Kdu6h1VUXAtcj
         4u9IwuglvXhgk2XXXw+1n83O8WPWqOCgH2T/MBlnxApkXecOFdtpLPtIG3lF3pYOC43I
         uT6qKNxJ1mSYFDEb8voXz0x+eFuBxcC5rVMAr1flwihBglGsZ9qUAMKwUx1FJl8nGcac
         GMIYl2X1/zPmVCWzy7CU1ccMwi2cqObejH29DHt3b2rEWY7+ZeDy4laiiIKZTkAQpVhf
         jQe3q5qUpU8T9wkHt9HRZAQg2Oj9uyHMqdhlrAAPp0wNN82K34me2j49CcizOW9EmAqv
         zXSA==
X-Gm-Message-State: ANhLgQ0OZUKn1FU0eY9XCmddBOkAeRCa+c9jUxxywfVKLOo3D0xEcaIs
        Jv0VmBjKo/S24Gr7r2pWXT7NsA==
X-Google-Smtp-Source: ADFU+vvakZsPrUsz5JNCbUe7AfZjURVljDhByr4WfwU517kv7o1dcL0Br7EfDkeWsHHmacVwUduzOA==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr4449507wmk.101.1585675343940;
        Tue, 31 Mar 2020 10:22:23 -0700 (PDT)
Received: from chatter.i7.local ([185.220.102.6])
        by smtp.gmail.com with ESMTPSA id w66sm4786530wma.38.2020.03.31.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:22:22 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:22:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Josep Torra <n770galaxy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200331172218.evsoljccfmjec2mz@chatter.i7.local>
Mail-Followup-To: Josep Torra <n770galaxy@gmail.com>, git@vger.kernel.org
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 07:13:25PM +0200, Josep Torra wrote:
> Today I'd noticed a failure in some custom automation that seems to
> came as a side effect after of a git client update.
> 
> The issue issue I'd spotted is the following:
> 
> $ git clone git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic
> linux/bionic
> Cloning into 'linux/bionic'...
> fatal: remote error: Parameters must have values
> 
> Reverting to git 2.17.1 didn't show the issue.
> 
> I'd asked at #git in freenode and @rafasc was able to reproduce and
> bisect, pointing to
> 
> https://github.com/git/git/commit/684ceae32dae726c6a5c693b257b156926aba8b7
> 
> For the time being I'd added `-c protocol.version=0` as a temporary workaround.
> 
> Is this a regression?

I'd like to relay the following conversation I had recently:

06:00 <sfr> anyone know why git recently has fetched basically a whole kernel
            repo when I try to update some trees/branches
06:00 <sfr> this has happened to me for three separate trees over the past few days
06:01 <sfr> none were on git.kernel.org
11:31 <mricon> sfr: if you have an example of the tree/branch that caused you to
               download a lot for a simple pull, I'd be interested in knowing what it
               is so I can poke.
16:26 <sfr> mricon: last evening it was fetching the drm tree
            (git://git.freedesktop.org/git/drm/drm.git branch drm-next):
16:26 <sfr> remote: Enumerating objects: 7237633, done.
16:26 <sfr> remote: Counting objects: 100% (7237633/7237633), done.
16:26 <sfr> remote: Compressing objects: 100% (1069838/1069838), done.
16:26 <sfr> remote: Total 7237633 (delta 6121918), reused 7236008 (delta 6120350)
16:26 <sfr> Receiving objects: 100% (7237633/7237633), 1.32 GiB | 642.00 KiB/s, done.
16:26 <sfr> Resolving deltas: 100% (6121918/6121918), done.
16:26 <sfr> From git://git.freedesktop.org/git/drm/drm
16:26 <sfr>    c2556238120bc..700d6ab987f3b  drm-next   -> drm/drm-next
16:30 <mricon> sfr: interesting. What's your git version?
16:30 <sfr> $ git --version
16:30 <sfr> git version 2.26.0
16:31 <sfr> Debian, so may have some extra patches
16:35 <mricon> sfr: git-2.26.0 switched to protocol v2 by default, so I'm curious
               if that is what changed
16:35 <mricon> but I've been using protocol v2 for a while now, and I don't see
               this problem
16:36 <mricon> I also don't yet have git-2.26.0
16:37 <mricon> sfr: if you come across another repo that shows this problem, 
               I suggest you set protocol.version=1 in your .gitconfig to see
               if that makes any difference
16:37 <sfr> mricon: ok, thanks
16:38 <mricon> total shot in the dark
16:46 <sfr> mricon: that *seems* to make a difference
16:47 <sfr> repo: git://anongit.freedesktop.org/drm/drm-misc branch: for-linux-next
16:48 <sfr> went from trying to transfer 7226542 to just 19
16:48 <sfr> even after I did a reset of the remote branch at my end and a gc
16:49 <sfr> it updated b1e7396a1d0e..98878d9dfc7a
16:50 <sfr> in case it matters, I have "tagopt = --no-tags" set for all the repos
            I fetch (for obvious reasons)
16:52 <sfr> removing the protocol.version=1 (and resetting/gcing) gets me the bad 
            behaviour again :-(
16:52 <sfr> mricon: so good shot! :-)

It appears that there are cases where protocol.version=2 is causing 
weird results during ref negotiation?

-K
