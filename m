Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A33C2D0C4
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED06A2053B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpx3XRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfLJKaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:30:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33055 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfLJKaS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 05:30:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so19427839wrq.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPCbnmndFMepHn9Zp01xcE/K4dkaQYI10c9mJSq+LpU=;
        b=ATpx3XRZ3tBni1+GMAY3NWeYEScBgwezoAXOYzSAR3SezOXqAg4eXe82KpzHIjxv9+
         KWh9/EfvDvsy7bTCuBQDQQGta21w34Olf6pL4TFm8dR4zCO34L3Ouj4G5T/jNEbt1Kmp
         qma0gQQUmKlUWuFSQy3uLDkDE64k3IjtmEjkpRfUAQ1ZliifVxWret8ICn6ofJKrH8xm
         jWwnDsJTKA1Uwhw3mGOYh71KdmuZHkMi70yo0xkyvduf8JempykaLToOhfyXeBSG6Al4
         0peuLb+SgPHT2UeY0v2QlJPyVo59zZvFSek8jqThvSAQIT2J2KnFyLn0EMiRsj2ItaTP
         uIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPCbnmndFMepHn9Zp01xcE/K4dkaQYI10c9mJSq+LpU=;
        b=rWEQ0vuf30Yy3yPHbuTYDWi/DYXW8X4Qj2mY+aFf4OYSqvxoZCTXQEd30/DeojjLcZ
         4xQ8Y93B2p3Oj57L3Fufyokicg756GrX/Tp1bzKNEArpGmRQ3a9tCZzgOsqSbGkWg7Ma
         /JbuPeeytnNnut/W/plcqLVB7qjQTICCstKHBkQ8cf9IDP9q6psSYAqdvh71ykar7oUz
         4AvrVgNHvBxzTx1OKmtY4hX6ReNqNeayKHAjf729Qt9evZGSWWXj9cHqZQcbalFsCDpM
         aebjSY9CxyyvgDzkBuj/9nmx2hmaE54l2rMmQ6n8kK+1RKbekPINjQU9PLR7k46QQPu2
         PSFw==
X-Gm-Message-State: APjAAAXxl7MT+Sp4HW7PAHb0rirh7nsuXZsS2AS4IF4npIYVvcyZWOmm
        oyHd2mxlcJSvOXxyGA6Laf9MMGZ9
X-Google-Smtp-Source: APXvYqyoseJ8hlYGKZEI6rIWBi1z51j5ZPurSPH63PveKnLJDwmABv6bJz3Ta4yRx0vCXL2Fj99lCA==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr2496867wrt.100.1575973816557;
        Tue, 10 Dec 2019 02:30:16 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id n30sm2584070wmd.3.2019.12.10.02.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:30:15 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:30:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7
 environment
Message-ID: <20191210103014.GF6527@szeder.dev>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191207003333.3228-2-yang.zhao@skyboxlabs.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 06, 2019 at 04:33:19PM -0800, Yang Zhao wrote:
> git-p4.py includes support for python-3, but this was not previously
> validated in CI. Lets actually do that.
> 
> There is no tangible benefit to repeating python-3 tests for all
> environments, so only limit it to linux-gcc for now.

In the subject line and the commit message body you speak about CI in
general, without sinling out a particular CI system ...

>  azure-pipelines.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

... but the patch only modifies 'azure-pipelines.yml', and not
'.travis.yml'.

> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> index 37ed7e06c6..d5f9413248 100644
> --- a/azure-pipelines.yml
> +++ b/azure-pipelines.yml
> @@ -331,7 +331,18 @@ jobs:
>    displayName: linux-gcc
>    condition: succeeded()
>    pool: Hosted Ubuntu 1604
> +  strategy:
> +    matrix:
> +      python27:
> +        python.version: '2.7'
> +      python37:
> +        python.version: '3.7'
>    steps:
> +  - task: UsePythonVersion@0
> +    inputs:
> +      versionSpec: '$(python.version)'
> +  - bash: |
> +      echo "##vso[task.setvariable variable=python_path]$(which python)"

I don't speak 'azure-pipelines.yml', so question: will this build Git
and run the whole test suite twice, once with Python 2.7 and once with
3.7?  I'm asking because 'git-p4' is the one and only Python script we
have, with no plans for more, so running the whole test suite with a
different Python version for a second time instead of running only the
'git-p4'-specific tests (t98*) seems to be quite wasteful.

Furthermore, this is the first patch of the series, with all the
Python3 fixes in subsequent commits, so the Azure Pipelines build with
Python 3.7 would fail with only this patch, wouldn't it?  I think this
patch should be the last in the series, after all the Python 2 vs 3
issues are sorted out.

>    - bash: |
>         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
>  
> -- 
> 2.21.0.windows.1
> 
