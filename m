Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B0EC67871
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 14:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbjAMOCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbjAMOB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 09:01:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66702BC20
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 05:58:51 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id jr10so11803277qtb.7
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xYcPKIX+Y8m9mLRovZ+w3Y5OC3BgJaJrztwqhNSQ/8=;
        b=VexR+wvKkyTLOGQBXjEBNxWbNeTzsv6Bhq2b+d2fYmacXFGdaa13RWaej3IUI6Pp1M
         UmrNQoTW0b8XjxD05+XUUixJxPPrt2BOw+QvlazqkR9F64VL03he8Iy0ciX3LoL1QKH3
         Q/6MhG7UegX4+YMjlYoJOWxQcLztzUbD/EewPjBANylnUa6KivemjuCiD9ZZBZaCZ1dK
         eEF9WGCcH5ysm1JKUFARiXs1WvAifMFDKruwI5q8op03vl5XZ3ioMPRhCi2u/IImNlrD
         tN/16igveIUjdiHNhb0NiM+SnZvQSg79llYKFwNzqytTMtUh40msUjQw0bf2M4mBsp+d
         W1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xYcPKIX+Y8m9mLRovZ+w3Y5OC3BgJaJrztwqhNSQ/8=;
        b=gNysnvaGTQMF94gmO8B+sp+WK7IE4+gwCs2rvrxvwiqxpDM4lbj8THvMjNVbItxA8y
         p0+v3KhRwr967cl7HSUC2/VfRRznGL+R4B6SXfH3ntxqmvlfP00Zh0rQl2s3rq9ukfRZ
         MFvK9B2IHrqrwoR2vu7ub5YQP2q+HssGN8DGpR8bo1QGmKSB4eQrEIDA3aldLIDl/ivs
         +YN+JKj4fiKYM8yUEvWQc2FsjxdhRzAgWxKlgUSbvxOkS3Bqd5+j7GJdaQ5TZsrGCVTW
         fsETDSAYrThFYeEtRBBSpTW6Q+lsGtwFb4plEQKig9wtCRcjz0YCT1Lp4kicedmAkYcU
         UDBw==
X-Gm-Message-State: AFqh2kq68BBdFMDjRwq8YXONzyHv6l6ooPccz8esPB3JXFL8OZnL3pO5
        TF4TWZFHa/M8S/4W6cWlkQ9LlTcli9c=
X-Google-Smtp-Source: AMrXdXv75AIvBq4cgRIk5U061QHG2XmGUamKp0MdKsCMvEg0pGXWI5kOkSVwMS9lNDn+QEMoAyz+7w==
X-Received: by 2002:ac8:568a:0:b0:3a6:348c:5159 with SMTP id h10-20020ac8568a000000b003a6348c5159mr95269743qta.26.1673618330269;
        Fri, 13 Jan 2023 05:58:50 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id r3-20020ac84243000000b003a5430ee366sm10539177qtm.60.2023.01.13.05.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 05:58:49 -0800 (PST)
Subject: Re: Bug report: checkout --recurse-submodules failing
To:     Carlos Gonzalez <carlos.gonzalez@codeplay.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CWXP265MB3688191D75A56F27A0C4DDB69CFD9@CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c587b501-494a-bb9c-4789-dc78f4ad655b@gmail.com>
Date:   Fri, 13 Jan 2023 08:58:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CWXP265MB3688191D75A56F27A0C4DDB69CFD9@CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlos,

Le 2023-01-12 à 07:17, Carlos Gonzalez a écrit :
> What did you do before the bug happened? 
> 
> Checking out a custom commit or tag using `--recurse-submodules`, where the specific commit contained a submodule
> not included in the main branch. The checkout command failed. (Detailed steps below)
> 
> What did you expect to happen? 
> 
> The repository should be checked out to the specified commit and submodules updated, and the one missing in the main 
> branch, cloned.

It's a reasonable expectation, but the current 'checkout' code does not
know how to clone missing submodules.

> 
> What happened instead? 
> 
> git checkout --recurse-submodules submodule
> fatal: not a git repository: ../.git/modules/sycl-blas
> fatal: could not reset submodule index
> 
> What's different between what you expected and what actually happened?
> 
> This only fails when the repository was cloned with --recursive flag.
> 
> Anything else you want to add:
> 
> I wrote these simple steps to reproduce:
> 
> mkdir repo1 && cd repo1
> git init
> git submodule add --name sycl-blas  https://github.com/codeplaysoftware/sycl-blas.git
> git commit -m "Adding submodule"
> git tag -a submodule -m submodule
> git submodule deinit sycl-blas
> truncate -s 0 .gitmodules
> rm -rf sycl-blas/
> git add .gitmodules
> git rm sycl-blas
> git commit -m "Remove submodule"
> cd ../
> 
> # When repository is cloned without `--recursive`, checkout works
> git clone repo1 cloned-repo1
> cd cloned-repo1
> git checkout --recurse-submodules submodule # ok
> cd ../
> # When repository is cloned with `--recursive`, checkout fails
> git clone --recursive repo1 cloned-repo2
> cd cloned-repo2
> git checkout --recurse-submodules submodule
> fatal: not a git repository: ../.git/modules/sycl-blas
> fatal: could not reset submodule index

Thanks for a complete reproducer. This has been reported before,
see the threads linked at [1].

I was working on that issue last month, so that at least the checkout fails
in a clean way, but have not gone back to it yet.

In the meantime, as you've discovered, a workaround is to clone without
'--recurse-submodules', then manually run 'git submodule update --init --recursive'
after switching branches.

Cheers,

Philippe.

[1] https://github.com/gitgitgadget/git/issues/752
