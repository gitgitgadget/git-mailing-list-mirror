Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A770C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC6D2173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHhgTv3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfLLON2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:13:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55008 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfLLON1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:13:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so2522568wmj.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W/2p6hWIf69EGgNxbFPIziu3qqTIPvmCdMGYGIPaWws=;
        b=FHhgTv3uTaSdOCPTbHJIEUkMPDxzYy/lj/cKWaGIjdsjRsnce4Vj/kCD1iJjgRNadt
         HNgL01p/aGexdbzx2xp+GLq615iggPSsUzQWfWtrsTJRHbVeMQP6HELsKSZB0ieA18ce
         DC/xyzDUR4GMflTDG0HTQ1cWBIT2b8fXd+K0nDVrqlccwBDNkFMEKVK9g9xeTrGZarRa
         cGiwQbd9tQimCJBYdUO2MrYQqtsAePWYCet+SmFAXuuBIiTT4v4lw0/m79nhp3hLzwJS
         w0PxejiCZIVa2C6UyWOoT8ZZeACjoOgXspHO+TOTBvl0hG/rX4jgr0C3wHoY/11mtre7
         pKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W/2p6hWIf69EGgNxbFPIziu3qqTIPvmCdMGYGIPaWws=;
        b=fMf9tsuw4NesrKZ7Fz4XCc65exDQlF+m/g2CQ2APOE6YBg0xG7XlfLPrKztwRdi7y6
         bgOaC8VlphOQU4Aw9OGU12nB29+G6L05DNqUvkmWuy0XZo2QRb2oJwkliOgckCEHT9/0
         WAJOFEEyWPLEpBhO9Dz8yPneESxl+9s20N9R5waPoeok5cBymWDGyLms/I7tkM2B8dKs
         eQ3eZU3hcOH8i1Okd+Zn5cbhA3zP7b446RD+ShwEYzOo+OkInq26CDixi2rc5Z/ZlIuZ
         MKfeEkOVPQix71/nQAuWlHDOro40206U6dGahYcbqWcnJkoEJ0QZcFhtfnfp8o0yS7qK
         e2PQ==
X-Gm-Message-State: APjAAAWAkhauwXgFDTkLM2JJy9sV+4mXb0aj4Gjg8knx0XqxzG3hFP7b
        Mr6TpkwZRRr2eBNn7xdvjW1/OtF6
X-Google-Smtp-Source: APXvYqwjbDPxkp6KDtVLb4O7q0j+CL0sLYoiKpOl02wslY/70kPYQwTdchvYi/ncgc0URDahAAgTxA==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr6711491wml.138.1576160005664;
        Thu, 12 Dec 2019 06:13:25 -0800 (PST)
Received: from szeder.dev (x4dbe262b.dyn.telefonica.de. [77.190.38.43])
        by smtp.gmail.com with ESMTPSA id i16sm6600716wmb.36.2019.12.12.06.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:13:24 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:13:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7
 environment
Message-ID: <20191212141322.GK6527@szeder.dev>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com>
 <20191210103014.GF6527@szeder.dev>
 <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 11:11:09AM -0800, Yang Zhao wrote:
> On Tue, Dec 10, 2019 at 2:30 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Fri, Dec 06, 2019 at 04:33:19PM -0800, Yang Zhao wrote:
> > > diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> > > index 37ed7e06c6..d5f9413248 100644
> > > --- a/azure-pipelines.yml
> > > +++ b/azure-pipelines.yml
> > > @@ -331,7 +331,18 @@ jobs:
> > >    displayName: linux-gcc
> > >    condition: succeeded()
> > >    pool: Hosted Ubuntu 1604
> > > +  strategy:
> > > +    matrix:
> > > +      python27:
> > > +        python.version: '2.7'
> > > +      python37:
> > > +        python.version: '3.7'
> > >    steps:
> > > +  - task: UsePythonVersion@0
> > > +    inputs:
> > > +      versionSpec: '$(python.version)'
> > > +  - bash: |
> > > +      echo "##vso[task.setvariable variable=python_path]$(which python)"
> >
> > I don't speak 'azure-pipelines.yml', so question: will this build Git
> > and run the whole test suite twice, once with Python 2.7 and once with
> > 3.7?  I'm asking because 'git-p4' is the one and only Python script we
> > have, with no plans for more, so running the whole test suite with a
> > different Python version for a second time instead of running only the
> > 'git-p4'-specific tests (t98*) seems to be quite wasteful.
> 
> The CI scripts as it is currently does not separate compiling and testing for
> non-Windows builds. I don't see a good way to only run a specific set of tests
> given a particular environment without re-architecturing the CI pipeline.

Building git and running the test suite is encapsulated in the
'ci/run-build-and-tests.sh' script, while installing dependencies is
encapsulated in 'ci/install-dependencies.sh', just in case Azure
Pipelines Linux images don't contain both Python 2 and 3 (Travis CI
images contain 2.7 and 3.5)  So I don't think it's necessary to touch
'azure-pipelines.yml' or '.travis.yml' at all.

> Furthermore, there's a step in the build that hard-codes the
> environment's python
> path into the installed version of the script. This complicates being
> able to even create
> a `git-p4` that runs under different python environments in Azure
> Pipelines due to how
> `UsePythonVersion@0` pulls python into version-specific directories.

The PYTHON_PATH that we build 'git p4' with can be a symbolink link,
and then choosing which Python version to use is only a matter of
pointing that symbolic link to the python binary of the desired
version.

In fact our default PYTHON_PATH is '/usr/bin/python', which is a
symbolic link pointing to 'python2.7' on Ubuntu 16.04, including the
Travis CI's images that we use.

> I haven't dug into
> why this hardcoding is done in the first place.
> 
> So, the question is if it's worth doing this work now when the desire
> seems to be dropping
> python-2.7 completely in the (near?) future.
> 
> -- 
> Yang
