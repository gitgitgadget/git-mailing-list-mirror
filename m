Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DDC2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF89E206CC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 09:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJalsOvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgBFJGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:06:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgBFJGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 04:06:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id z9so6120051wrs.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 01:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ob9eUXPhiwwhnRwLEdct3W1PEMNPIp6A4mTuRJEp1Bk=;
        b=fJalsOvu8gtmIQdafu8qiNLvDC738XPU+Ps5MwKcDFWhAr9D9mJz8ecsahUtzUKx36
         FEn4A+LEr8jBr6kKJQJtdm4IO6vA8CieK3jeZknQMiA9hqHUIjGnZJ5jJTOY4K/0spWU
         LrnqExCWRnF38T6vfwh49xpY2da2S2m0eXdmELwLrZ341lpdwKekPGVFgjBkW7rHRHEH
         2LG9oGlU6NjJFBzrkCuxKzhgjbL89uw8pE+DefNSNSlZItb2pe6DTQ+IloDQo15I0SW0
         ZKO8v9TyvpA5/TVJkSDhyI5Ap3lUwVZU8xgS7ZQCpar7hbzVzdJuWSpNSUtZi7hkT22Y
         /rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ob9eUXPhiwwhnRwLEdct3W1PEMNPIp6A4mTuRJEp1Bk=;
        b=VexE9qmT4IXqpnRjzEQwSuSAF2BXxW+K+iOFeOlb37zfOqKuX3vynMkaRGnOi5eZkf
         7Q6G+jq6mwUtfhP54XB1kJc5ZVuZ8MYTjtKcGbFAVB6TM92wwHM+DB1RRXaIS1N2eIdD
         hJDN9MzABh0owjvPo9OXy+2D2xxdaeakj0g6M4BuPHheO3N69BRdLHt668VaiQ00vVqS
         j7kkPlRx8UgjoCck0rOn1AIZSdWnuaBm/f4JUffKq69nlqUVIHtMGmOXREaAD/NkuiGk
         j9g61eKUmkrOjm35vS4RWv7gNTGgdolSajrxwjtGzhwqBF0BwZonARhARfoFQ4f/ML6+
         XyFQ==
X-Gm-Message-State: APjAAAXeFfKZcGNpv9RdTCWhg5joGJKWsk+qKjhErtbERyasXcWmkUNh
        TQCiYI+jSfnEQS/8mDAziZs=
X-Google-Smtp-Source: APXvYqwndAiNNjK249LsMdLqAcHSKNBrelG0/L8mzJ4DTmQy/+rq/KoxV8LhCU2zM3JNbIiGqzKXaA==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr2683693wrn.400.1580979998208;
        Thu, 06 Feb 2020 01:06:38 -0800 (PST)
Received: from szeder.dev (x4db62c67.dyn.telefonica.de. [77.182.44.103])
        by smtp.gmail.com with ESMTPSA id p5sm3299087wrt.79.2020.02.06.01.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 01:06:37 -0800 (PST)
Date:   Thu, 6 Feb 2020 10:06:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200206090632.GA17842@szeder.dev>
References: <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <20200123141626.GB6837@szeder.dev>
 <20200123175645.GF6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
 <20200124120240.GG6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet>
 <xmqqeev8694x.fsf@gitster-ct.c.googlers.com>
 <20200206002754.GM10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002060930210.3718@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2002060930210.3718@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 09:57:51AM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Thu, 6 Feb 2020, SZEDER Gábor wrote:
> 
> > On Wed, Feb 05, 2020 at 01:01:50PM -0800, Junio C Hamano wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > >> Do they have to shout that loudly in the name?
> > > >>
> > > >> We could rename these jobs to e.g. 'linux-clang-py2' and the like, but
> > > >> I think it would bring little benefit, if any.  In our Travis CI
> > > >> builds these Linux/OSX Clang/GCC jobs come from the build matrix,
> > > >> therefore the jobname is not visible on the Travis CI web interface or
> > > >> API, only in the build logs.  There are some pages on Azure Pipelines
> > > >> that do show the jobname (and some that could, but hide it instead),
> > > >> but it's just too convoluted (or sometimes even impossible, well, for
> > > >> me anyway) to get there.
> > > >>
> > > >> And if the requested Python binary can't be found, which will
> > > >> eventually happen with 'python2', then the non-zero exit code of
> > > >> 'which' will abort the build, no matter how the job is called.
> > > >
> > > > I am mostly worried about contributors whose PRs break for "magic"
> > > > reasons. If it is not clear where the difference between `linux-gcc` and
> > > > `linux-clang` lies, that can cause unintended frustration, and I do not
> > > > want to cause that.
> >
> > I'm not worried about that.  If a contributor doesn't touch any of our
> > Python scripts, then I don't see why using a different Python version
> > in the build would cause any issues.  And if they do modify one of the
> > Python scripts, then they should make sure that their modifications
> > work both with Python 2 and 3 in the first place.
> 
> If the frequent problems with downloading the Perforce binariers taught me
> anything, it is that the most likely explanation for failures in the
> linux-gcc job is that Perforce, once again, updated their binaries,
> uploaded them _to the exact same URL as before_, and that there is nothing
> wrong in the PR or the patches.
> 
> That _is_ the most likely explanation, given our record.
> 
> So what are contributors supposed to do with that? Nothing in the name
> `linux-gcc` cries out loud: Hey, this is a Homebrew problem, there is most

Yes, because the 'linux-gcc' job doesn't run Homebrew...

> > > So, what, if any, decision have we reached?
> > >
> > > If linux-gcc and linux-clang labels are not visible, linux-clang-py2
> > > and osx-py3 would not be, either, so...
> >
> > The 'linux-gcc' and 'linux-clang' labels are not visible on Travis CI,
> > because those jobs as part of the build matrix, and, consequently, we
> > can't set the a 'jobname' environment variable for them in
> > '.travis.yml'.  If we were to include additional jobs for the Python
> > scripts, then for those we can (and should!) set
> > 'jobname=linux-python' or something, and that would be visible on the
> > Travis CI web interface, just like e.g. 'jobname=StaticAnalysis'.
> 
> I think we can see that jobname very well, though. If you direct your web
> browser to
> https://travis-ci.org/git/git/builds/646646192?utm_source=github_status&utm_medium=notification
> you will see something like this:
> 
>     Build jobs		View config
> 
> ! 5281.1 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment variables set	8 min 20 sec
> ! 5281.2 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variables set	8 min 23 sec
> X 5281.3 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment variables set	1 min 57 sec
> X 5281.4 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variables set	2 min 41 sec
> ! 5281.5 AMD64		Xcode: xcode10.1 C			jobname=GIT_TEST_GETTEXT_POISON	5 min 14 sec
> X 5281.6 AMD64		Xcode: xcode10.1 C			jobname=linux-gcc-4.8		1 min 13 sec
> ! 5281.7 AMD64		Xcode: xcode10.1 C			jobname=Linux32			6 min 50 sec
> ✓ 5281.8 AMD64		Xcode: xcode10.1 C			jobname=StaticAnalysis		10 min 56 sec
> ✓ 5281.9 AMD64		Xcode: xcode10.1 C			jobname=Documentation		6 min 15 sec

I don't see any 'linux-gcc' and 'linux-clang' jobnames.

