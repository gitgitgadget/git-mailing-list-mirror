Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C88C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A00864EBC
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 12:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhB0Mc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhB0Mc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 07:32:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D4C06174A
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 04:31:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id a7so12539122iok.12
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 04:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tYpp0m1wlJ1dQxhVMFWokLpzowaFeJeU35YYyI2OWgk=;
        b=jyc12oPJ/o4M9IWbWVNTkGK3LgoU9dTPMdq2ILaTsJDDzRBTMs+HAAW0XzypK/wGP9
         6zsyMZl4KC0ua/1v1tybPUQdJUSzLGyJXgse+tZpxMTKbg3ZT3VSrv1GhlCQ3RzYYPDT
         gOCeUHeWhxPdHZOu8C2UyqR921glCw+nwjyCSmABewRr6IYSr+mlS4dALn+BSnJV3Sg6
         pmgP4dJWxCjuQTqVj1c2CTaXi55O6hCHCqTTvv3VnmaGUIjHw6yOczh35aXe8uDaqIVK
         M9ljaVJCG/yVQsayV86DgFi6gA5t+86zy2ZC+vtOlx9am374r5tdHLBsXRZNe+O4BeHy
         pU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tYpp0m1wlJ1dQxhVMFWokLpzowaFeJeU35YYyI2OWgk=;
        b=ZO+HlEjM4SAMtH1OieUPptYo2rYDSYx+dwuOPKGbel9+pzc/xt+ULwFFlaJ1o+CIqx
         0LNuGeEv4FuL0zqSNtWZ+ky+a8K1KLlnMw2cxVc4a0WJ+KLzFjUR7uaTLiWdnXsSYqRk
         W06yGUZh8rpPGA0X0gVOM/E3NLnYFXPXE+C/T7FlE9il0VcyCdt2lxd97b7JyGFTayeR
         QLcjgx7lBv+ELwyclQJQcFfd09GDKNIPSP9VdyU2DP3S+j0MXDp25OdjKXnbaSMfVaLo
         CaAEL75IebV2o2J/gl//cSGxCrqco8COa8/OZWRcDphw8TcsBNgfLpHT0xiOxyj/CMVr
         lzpw==
X-Gm-Message-State: AOAM533cfiEUaMuH+AlQegFal+yh+MkfYG6mWXGonzwAzFwTJJOKGSMs
        Vp4wCA+wdya2H/PkXCnBo7pAfoxbacatiySTups+cKrAnCmhUA==
X-Google-Smtp-Source: ABdhPJxAYMffyyTEPtgygc09hUNzC00IF03PjHNiKptC1aBzKhKoYysFEZiweGaZ5k1WzvIhLxTUekp7mna6QM8AqKU=
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr6774234iok.108.1614429108205;
 Sat, 27 Feb 2021 04:31:48 -0800 (PST)
MIME-Version: 1.0
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sat, 27 Feb 2021 15:31:32 +0300
Message-ID: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
Subject: Round-tripping fast-export/import changes commit hashes
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I can't get the same commit hashes after fast-export and then fast-import of
this repository without any edits https://github.com/simons-public/protonfixes
I have no idea what causes this, and how to prevent it from happening. Are
there any workarounds?

What did you do before the bug happened? (Steps to reproduce your issue)

  #!/bin/bash

  git clone https://github.com/simons-public/protonfixes.git
  git -C protonfixes log --format=oneline | tail -n 4

  git init protoimported
  git -C protonfixes fast-export --all --reencode=no | (cd
protoimported && git fast-import)
  git -C protoimported log --format=oneline | tail -n 4

What did you expect to happen? (Expected behavior)

  Expect imported repo to match exported.

What happened instead? (Actual behavior)

  All hashes are different, the exported repo diverged on the second commit.

What's different between what you expected and what actually happened?

  The log of hashes from initial repo:

    + git -C protonfixes log --format=oneline
    + tail -n 4
    1c0cf2c8e742e673dba9fd1a09afd12a25c25571 Update README.md
    367d61f9b2a799accbdaeed5d64f9be914ca0f7a Updated zip link
    d3d24b63446c7d06586eaa51764ff0c619113f09 Update README.md
    7a43ca89ff7a70127ac9ca0f10b6eaaa34f2f69c Initial commit

  The log from imported repo:

    + git -C protoimported log --format=oneline
    + tail -n 4
    a27ec5d2e4c562f40e693e0b4149959d2b69bf21 Update README.md
    e59cf92be79c47984e9f94bfad912e5a29dfa5e0 Updated zip link
    fb6498f62af783d2e943770f90bc642cf5c9ec9c Update README.md
    7a43ca89ff7a70127ac9ca0f10b6eaaa34f2f69c Initial commit

[System Info]
git version:
git version 2.31.0.rc0
cpu: x86_64
built from commit: 225365fb5195e804274ab569ac3cc4919451dc7f
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.8.0-43-generic #49-Ubuntu SMP Fri Feb 5 03:01:28 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
-- 
anatoly t.
