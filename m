Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0050C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A501A20774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/1oNWvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgDXRpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727059AbgDXRpr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 13:45:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE9C09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:45:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so3996409plz.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8x7aMS/eGdhFSsdpC6jGUdpljZvBBLH3h539Koc4CqM=;
        b=l/1oNWvQ11jIrBo8BlPPvfact0v15RHbUcs801STtolVCOupXxNLVgWsa84RziYrJ4
         MwiPTEtG3b+O1lXQhy9HaYi6Wqh2zZ4JVcdHxqrhkATbQx4rulS6u9nMOGxkFzq9y2B/
         7mRML2CYZGAoahcDczP+gRdPKpxR5A9LD3/Asf8VJF30Ldq0uaFnLDFfdzL4aYe+JeLS
         67RjZLEKQYd/LytuWdh/dNJgi9LtfIAnC/f9AJXoUO+KKrTspBb9ZlpJuuFlM0qWg0CB
         nV/tZDs5eHFuQnEcc0AkUY3Tme8Sxjn9nJQn8G+whQo+yJfeINacpF4Bm8qjG7W6k4Vw
         lM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8x7aMS/eGdhFSsdpC6jGUdpljZvBBLH3h539Koc4CqM=;
        b=kL+xXeqintOq0Is9RCekAi1JV8FB1S/t8XLyf0kkBwXzSX6GhA8dWkKPp/x9ODsZdW
         ts4ZaORN+gaQEnVbfGvdUXmR02kDCXD+A5NPmJwk4kUvF6JKBrbb7ZuWD4h1YMGkXsw3
         TpO37sK913RV2uuHL/RHBWSzDKzeA4iUu1wmeef89WlIbhb0zvnrZmsoM3pg5pZj7FBE
         wgssS2Y4DgPptxTFON4I1ulkjc+JWcWlL3qfPttBNQ3KHZZ05SSz9Anp2j4HuLLlkLEX
         EgqOvZ9jlMVfIwAUItVZZwrGN+/mnRktf3IoQkcWrD5svBah55S3c89B65RwTnHUQ3N0
         pg6g==
X-Gm-Message-State: AGi0PuZDTIZcdHO+rehTNTSZc7naocXIXhJDhIgD4Vl4k0MADBoHQtJn
        dVj2TWUlBVC7vM0SMU+ypz0=
X-Google-Smtp-Source: APiQypL9CGJ8v8p0Pah6S7LBLau6dSJI980FbuBrbyXVTzg1b1UL0dbBI4HWEISowkIy5n+Ay7CIXA==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr10791549plr.16.1587750346910;
        Fri, 24 Apr 2020 10:45:46 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id a2sm6240765pfg.106.2020.04.24.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:45:46 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:45:44 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 8/8] ci: modification of main.yml to use cmake for
 vs-build job
Message-ID: <20200424174544.GN1949@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <f0294be3f1151526fe002a55fb79015bd35606b2.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0294be3f1151526fe002a55fb79015bd35606b2.1587700897.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 04:01:37+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch modifies .github/workflows/main.yml to use CMake for
> Visual Studio builds.
> 
> Modified the vs-test step to match windows-test step. This speeds
> up the vs-test. Calling git-cmd from powershell and then calling git-bash
> to perform the tests slows things down(factor of about 6). So git-bash
> is directly called from powershell to perform the tests using prove.
> 
> NOTE: Since GitHub keeps the same directory for each job
> (with respect to path) absolute paths are used in the bin-wrapper
> scripts.
> 
> GitHub has switched to CMake 3.17.1 which changed the behaviour of
> FindCURL module. An extra definition (-DCURL_NO_CURL_CMAKE=ON) has been
> added to revert to the old behaviour.
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  .github/workflows/main.yml | 43 ++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fd4df939b50..94f9a385225 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -80,13 +80,6 @@ jobs:
>      - name: download git-sdk-64-minimal
>        shell: bash
>        run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> -    - name: generate Visual Studio solution
> -      shell: powershell
> -      run: |
> -        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> -          make NDEBUG=1 DEVELOPER=1 vcxproj
> -        "@
> -        if (!$?) { exit(1) }
>      - name: download vcpkg artifacts
>        shell: powershell
>        run: |
> @@ -98,6 +91,13 @@ jobs:
>          Remove-Item compat.zip
>      - name: add msbuild to PATH
>        uses: microsoft/setup-msbuild@v1.0.0
> +    - name: generate Visual Studio solution
> +      shell: powershell
> +      run: |
> +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> +          cmake . -DCMAKE_PREFIX_PATH=./compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=./git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
> +        "@
> +        if (!$?) { exit(1) }

If you intended to modified some steps to provide a better script for
that step, I believe you should change in that step.

If the order of those steps need to be changed, please clarify your
reasoning!

>      - name: MSBuild
>        run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
>      - name: bundle artifact tar
> @@ -125,9 +125,9 @@ jobs:
>          nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>      steps:
>      - uses: actions/checkout@v1
> -    - name: download git-64-portable
> +    - name: download git-sdk-64-minimal
>        shell: bash
> -      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> +      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
>      - name: download build artifacts
>        uses: actions/download-artifact@v1
>        with:
> @@ -136,23 +136,30 @@ jobs:
>      - name: extract build artifacts
>        shell: bash
>        run: tar xf artifacts.tar.gz
> -    - name: test (parallel)
> +    - name: test

So the test couldn't be run in parallel anymore?
It's a regression!
And we don't need the matrix anymore!!!!!

I wonder if Dscho's effort is wasted, he tried very hard to make
those tests run in parallel.
He even tried to re-order the matrix in GfW project to let longest
test run first!


>        shell: powershell
>        env:
>          MSYSTEM: MINGW64
>          NO_SVN_TESTS: 1
>          GIT_TEST_SKIP_REBASE_P: 1
>        run: |
> -        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
> -          # Let Git ignore the SDK and the test-cache
> -          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
> +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
> +          # Let Git ignore the SDK
> +          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
>  
> -          cd t &&
> -          PATH=\"`$PWD/helper:`$PATH\" &&
> -          test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
> -                  `$(test-tool.exe path-utils slice-tests \
> -                          ${{matrix.nr}} 10 t[0-9]*.sh)
> +          ci/run-test-slice.sh ${{matrix.nr}} 10
>          "@
> +    - name: ci/print-test-failures.sh
> +      if: failure()
> +      shell: powershell
> +      run: |
> +        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh

What is changed?

-- 
Danh
