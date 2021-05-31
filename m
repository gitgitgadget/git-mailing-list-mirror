Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0017C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F11261009
	for <git@archiver.kernel.org>; Mon, 31 May 2021 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhEaEjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 00:39:16 -0400
Received: from mout01.posteo.de ([185.67.36.65]:52445 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhEaEjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 00:39:07 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 57B2C240028
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622435846; bh=KjASyODX36BlT3GknjoVUylD8cXBD3F6i8v4ThO3Mv8=;
        h=Date:From:To:Cc:Subject:From;
        b=D71MXy99gJ+U0ewvvXuRrp4IHSLZHtyFscvH4b9TH1Vl0/0EVm0RTZXolL0FSuK8x
         0hsCpEEkDnRAK6AGaHh+Sph+H+H+eEQ86GRPaqLnArVTHkBq50+OHImFPHiBXemltz
         1KwvOem3SYFwFKliJvNIjQiChC8CPWrIrGH8ixE9oeNkc8KwiTEdOuUwUpZZluQTgC
         ftmprMlAbYOtU/YUvlUHqFZk2/tpU5jamrAXC5CjeQ95cccGt+5lkHZT8LjZDQRcer
         ZDpXa9Z2N0ETOdL/B0WkX0a5RKWwBtoB2jUyfULL7HpSqYt9apQKgeg/G8p591I10a
         nlXWMOlYif9yA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FtjFJ1Vnyz6tmD;
        Mon, 31 May 2021 06:37:23 +0200 (CEST)
Date:   Mon, 31 May 2021 04:37:20 +0000
From:   asymptosis <asymptosis@posteo.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?QmrDtnJu?= Kautler <Bjoern@kautler.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug when cloning a repository with a default branch called HEAD
Message-ID: <YLRoAIBExd+dAe0C@sleipnir.acausal.realm>
References: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
 <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>I'm trying to create minimal reproducible test repo by switching 
>initial branch to HEAD:
>
>$ mkdir shark && cd shark
>$ git init
>$ git checkout -b HEAD
>
> /snip
>
>The remote [1] might misconfigured default branch, so instead of 
>master/main it pointed to HEAD, and it caused the issue.

Hi Bagas,

I think he meant the remote had its default branch set to HEAD before he tried cloning. I.e. reproducing the error would look something more like this:

#! /bin/bash
remote_repo=/tmp/remote
local_repo=/tmp/local
mkdir $remote_repo
cd $remote_repo
git init -b HEAD
touch README
git add -A && git commit -m "Initial commit"
cd ..
git clone $remote_repo $local_repo


For me, the generated /tmp/local repo does issue warnings about ambiguous HEAD ref. However, it still works, and I don't get the wild errors like reported by Björn.

I suspect it's something to do with the implementation on the local OS. I'm on Linux and it seems like Björn is using Windows.
