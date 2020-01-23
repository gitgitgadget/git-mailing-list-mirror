Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B27C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F5D20718
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjoxn2+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAWR4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:56:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgAWR4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 12:56:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so4098825wrm.11
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kXYz/vWxvpvi0hNNURT7fX+0oQcl5TtplvyaAuVNnag=;
        b=Fjoxn2+ID9PyxQ6Jm3EqqMPJN0vW4VAS3r2aCTy9qfTTi799LC8bAzFHBz3YEBy+gn
         wz1gMdhDQLaMrfQ/H4Ez0BH3Ok3qUxTXG/KIdNZLz/YCLLN/kW+3pkVcBbG8+vLL5N75
         o9TSPbTamfbMQbCgITjqBRaZ8o8iEzySwcop1n4WDhAFZn7naTEJ91zUelIGzugiHsFc
         9hJHKL8yAWfNPulHeNCg+ps93X+voSVgnyD3htbaKqnhl1cTLs4byzWIh15IUud83d/h
         gHgSRA1Tjh/t5YhRyP6ShbKTld5aOoOhFycYNRCacuN9WNL+DXN6EBA7FaAso2NHX4/W
         wKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kXYz/vWxvpvi0hNNURT7fX+0oQcl5TtplvyaAuVNnag=;
        b=rOs+aa8wUlQNkqF6ojUtpqRiwAr7ZmvrS2dSXUCj+yShPakBQW9c3XzT6ZUx00lCD1
         cn6FlB2B3d+8clRBCDDRyxOiworRRd6FdRwpnwBaNVltXPIrlsL2tWX+oAgusTwodHBS
         8KUM5JuACqWDX2TR5zBNv+zt3o65vQtbHGZVTMaZ6BpNAPckJJQxvxaYIA4SmE5AuRuX
         I8V9DCBwXJYCpXsLElNNQ2hmyXKwq1SRtl/t559QZXkOHkEkYINYSaUNfuo1jSR3lJtZ
         lQ93nBUnbJWQdKPL0WH0jk2lVMJwRh/bGdZmbQN/I+3Dut/7ySj7QG8Rv8fouL31WQPP
         sT+A==
X-Gm-Message-State: APjAAAWwjPOOTDFC/eJtJceuibSfarqTgUG/hdvqWRI157cWfZU6GmMq
        5fWmtggHfFPnG6BYHZBqPNU=
X-Google-Smtp-Source: APXvYqyMRY0Q2ic+oPP0h9GxsW8JA99Sk9I+MpmxuvV3Fk2Z/zfFetdgu7BAyjrHaWwJ0kQmrNInkg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr18697832wre.91.1579802207723;
        Thu, 23 Jan 2020 09:56:47 -0800 (PST)
Received: from szeder.dev (x4db607d2.dyn.telefonica.de. [77.182.7.210])
        by smtp.gmail.com with ESMTPSA id e18sm3786102wrw.70.2020.01.23.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:56:47 -0800 (PST)
Date:   Thu, 23 Jan 2020 18:56:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200123175645.GF6837@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <20200123141626.GB6837@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123141626.GB6837@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 03:16:26PM +0100, SZEDER Gábor wrote:
> > What's the ideal endgame wrt the tests?

> Running the 'linux-clang' job with Python 2 and the 'linux-gcc' job
> with Python 3 would be the simplest and cheapest, I'd think.  We'd
> only need to add the appropriate 'PYTHON_PATH=...' to out MAKEFLAGS.
> As far as Travis CI is concerned, their Xenial image (i.e. the Linux
> image we're using) comes with both 'python2' and 'python3' in PATH, at
> versions v2.7 and v3.5, with the former being the default.
> 
> Perhaps we could do the same with the OSX Clang and GCC jobs as well,
> dunno.  Travis CI's OSX image, too, comes with both 'python2' and
> 'python3' in PATH, though Python 3 is already at v3.7, but still v2.7
> is the default.

Replacing that last patch of the series with the diff below works both
on Linux and macOS and both on Travis CI and Azure Pipelines.

linux-clang with Python 2:
  https://travis-ci.org/szeder/git/jobs/640912453#L499
  https://dev.azure.com/gitgitgadget/git/_build/results?buildId=27690&view=logs&j=8f20da19-31b7-5cef-4813-95b8788bd086&t=56027f08-fde3-50ad-0c9a-5ec7df432ed0&l=615

linux-gcc with Python 3:
  https://travis-ci.org/szeder/git/jobs/640912454#L606
  https://dev.azure.com/gitgitgadget/git/_build/results?buildId=27690&view=logs&j=275f1d19-1bd8-5591-b06b-07d489ea915a&t=33e5d3ec-87e7-5f80-0281-074c6962cb44&l=652

osx-clang with Python 2:
  https://travis-ci.org/szeder/git/jobs/640912455#L272
  https://dev.azure.com/gitgitgadget/git/_build/results?buildId=27690&view=logs&j=b80c90c8-f62d-51c1-0986-3bb8359d9b6f&t=f8b92b00-54c3-55aa-48a6-84ec793cfb94&l=365

osx-gcc with Python 3:
  https://travis-ci.org/szeder/git/jobs/640912456#L283
  https://dev.azure.com/gitgitgadget/git/_build/results?buildId=27690&view=logs&j=cfa20e98-6997-523c-4233-f0a7302c929f&t=3de1ae02-4adb-5138-54da-65cec5dd3141&l=394


 --- >8 ---

diff --git a/ci/lib.sh b/ci/lib.sh
index a90d0dc0fd..c3a8cd2104 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -162,6 +162,9 @@ linux-clang|linux-gcc)
 	if [ "$jobname" = linux-gcc ]
 	then
 		export CC=gcc-8
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
+	else
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	fi
 
 	export GIT_TEST_HTTPD=true
@@ -182,6 +185,9 @@ osx-clang|osx-gcc)
 	if [ "$jobname" = osx-gcc ]
 	then
 		export CC=gcc-9
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
+	else
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	fi
 
 	# t9810 occasionally fails on Travis CI OS X
