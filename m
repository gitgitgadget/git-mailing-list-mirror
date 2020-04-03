Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2004AC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B58207FF
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDhtoE8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDCWHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:07:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40787 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCWHi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 18:07:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so9359608wmf.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gm2fxeKPE1xrMshHBUUAOQnbQwvJFK8ElIhsjPp8lh8=;
        b=hDhtoE8wDJGrD7x529tcYzXRB4xM5Vn96GKIPuLd3BX0T5yPLnCxM3Zs6Q39kWqa8I
         vFtEoq8WnqYiQ0umBGyc9s9kNU4xIA6VNgP0kCAhJSTxxQZdXJGrTJ95Oc7h5RN9j3o8
         8Po94hhd8gp4OqbEGpJetlznWpDU3NfazUHtaoFu2FJNdkQ1D6Tl/ASAFEymLGX390HK
         T793r56aSM2p+/1ZvRyqhq2nfxLmbkLByIIlL5icHxBAHzn37yyR5F+v2V2GtNSgIxfa
         2+s5zvWuQYAIiA4T34pfnBxKDBlvIKrbHml63ophOEVwY/0twMEftFxqsH09Y8kKyT1w
         MPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gm2fxeKPE1xrMshHBUUAOQnbQwvJFK8ElIhsjPp8lh8=;
        b=URcz+F+4griJGySZ6nIXkG4VYJO7+8EdZjXwZfYDftfQyXtjT9mvVQJsHoh+jIp/Mg
         R9DxpjDVrQd0FO6YAjx6uRD7nsIh/1EtOz42dWBPyYkngdwvF9QsU/7yA2vh96TyffmH
         xxB00obFyi4t4qzkL5ma8uH8pwjT1z3vhNJ3oySzHPoank1uZ1lXs1kJiLhq1Tgk/Hj/
         x5Vy7e7WfDmBtgMfltC5RxRK6+ROTgIOsk3kBPSjSedk7s4JgjG1avpU/BvGI8+JtxMz
         8iP/wnFkh27JGairbxUA/1gNbV+ZhG2SsZ2maQSJRPcL4JECqnWImfnAIYq284bYQs2I
         d34A==
X-Gm-Message-State: AGi0PuYrrhfDenX4njplxtODsC0Fral90gM4jl9JB3sNBIQCLqAk5IAt
        1GxIjFfa48eJRn9TJU51Cpg=
X-Google-Smtp-Source: APiQypKj1mc9eXDu3/iy789ALnML7+0PMnanrgZiJtqO0ZaDPvrwkB2Vl7AxSn52kL8fJLtI58hCyA==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr10571518wma.122.1585951655652;
        Fri, 03 Apr 2020 15:07:35 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id p17sm12779153wmb.30.2020.04.03.15.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 15:07:35 -0700 (PDT)
Date:   Sat, 4 Apr 2020 00:07:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] ci: configure GitHub Actions for CI/PR
Message-ID: <20200403220732.GL2224@szeder.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <36621bdd31a53046450f73ed197585469b1a1b96.1585658913.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36621bdd31a53046450f73ed197585469b1a1b96.1585658913.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 12:48:31PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This patch adds CI builds via GitHub Actions. While the underlying
> technology is at least _very_ similar to that of Azure Pipelines, GitHub
> Actions are much easier to set up than Azure Pipelines: no need to
> install a GitHub App, no need to set up an Azure DevOps account, all you
> need to do is push to your fork on GitHub.

And then receive emails from GitHub if a build fails, even though you
never asked for it?  Well, I've always preferred opt-in instead of
opt-out.

Btw, does it offer direct shell access for debugging?

> Therefore, it makes a lot of sense for us to have a working GitHub
> Actions setup.
> 
> While transmogrifying `azure-pipelines.yml` into
> `.github/workflows/main.yml`, we also use the opportunity to accelerate
> the step that sets up a minimal subset of Git for Windows' SDK in the
> Windows-build job: we now download a `.tar.xz` stored in Azure Blobs and
> extract it simultaneously (by calling `curl` and piping the result to
> `tar`, decompressing via `xz`, all three utilities being available by
> grace of using Git for Windows' Bash that is installed on the build
> agents). This accelerates that step from ~1m50s to ~7s.
> 
> Also, we do away with the parts that try to mount a file share on which
> `prove` can store data between runs.

... and on which we store the list of already successfully tested
trees, so when a branch is rebased changing e.g. only the commit
messages but leaving the code intact, then the CI won't run
unnecessary builds.

> It is just too complicated to set
> up, so it's little return on investment there.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> +  linux-clang:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      env:
> +        CC: clang
> +      run: |
> +        sudo apt-get update &&
> +        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&

Why install all these dependencies here, when the very next command is
'ci/install-dependencies.sh', whose purpose is to install the
dependencies?

> +        ci/install-dependencies.sh
> +    - name: ci/run-build-and-test.sh
> +      env:
> +        CC: clang
> +      run: |
> +        ci/run-build-and-tests.sh || {
> +          ci/print-test-failures.sh
> +          exit 1
> +        }
> +  linux-gcc:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      run: |
> +        sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
> +        sudo apt-get update &&
> +        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 &&

Likewise, and here you install some additional packages compared to
the clang job as well.

> +        ci/install-dependencies.sh
> +    - name: ci/run-build-and-tests.sh
> +      run: |
> +        ci/run-build-and-tests.sh || {
> +          ci/print-test-failures.sh
> +          exit 1
> +        }
> +  osx-clang:
> +    runs-on: macos-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      env:
> +        CC: clang
> +      run: ci/install-dependencies.sh
> +    - name: ci/run-build-and-tests.sh
> +      env:
> +        CC: clang
> +      run: |
> +        ci/run-build-and-tests.sh || {
> +          ci/print-test-failures.sh
> +          exit 1
> +        }
> +  osx-gcc:
> +    runs-on: macos-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      run: ci/install-dependencies.sh
> +    - name: ci/run-build-and-tests.sh
> +      run: |
> +        ci/run-build-and-tests.sh || {
> +          ci/print-test-failures.sh
> +          exit 1
> +        }
> +  GETTEXT_POISON:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      run: |
> +        sudo apt-get update &&
> +        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev
> +    - name: ci/run-build-and-tests.sh
> +      env:
> +        jobname: GETTEXT_POISON
> +      run: |
> +        ci/run-build-and-tests.sh || {
> +          ci/print-test-failures.sh
> +          exit 1
> +        }
> +  linux32:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: ci/run-linux32-docker.sh
> +      run: |
> +        res=0
> +        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
> +  static-analysis:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      run: |
> +        sudo apt-get update &&
> +        sudo apt-get install -y coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext

Likewise, except here you don't even run 'ci/install-dependencies.sh'
(which would install the same packages, btw.)

> +    - name: ci/run-static-analysis.sh
> +      env:
> +        jobname: StaticAnalysis
> +      run: ci/run-static-analysis.sh
> +  documentation:
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v1
> +    - name: install dependencies
> +      run: |
> +        sudo apt-get update &&
> +        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns
> +    - name: ci/test-documentation.sh
> +      env:
> +        ALREADY_HAVE_ASCIIDOCTOR: yes.
> +        jobname: Documentation
> +      run: ci/test-documentation.sh
> -- 
> gitgitgadget
> 
