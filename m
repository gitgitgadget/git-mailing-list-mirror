Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A6BC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D02F20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y83dRCqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKUMef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:34:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42806 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUMef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 07:34:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so4177642wrf.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 04:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N25bJ2FAAYNJwtYiwA/m+2YpZR89dhR1fBlXuzeFnMA=;
        b=Y83dRCqBkcTiQUxoaq4vrnnpF24hUijMnohHdSe5hE805x8yelDjz7qeTRZ8UNAXaj
         kbA+iSCLh0oQYZ9krrqEAODxHiJdu7Ghc4ExHJJXTKTPqqhkzerZ84UN60+i+WLFnzFo
         yLNEbQwoneYR8O8MiWinTM4dQiDjjt3vMuMtXr2iGVqB6Luy+bk3TfXogQqe5wq58xs8
         Eqx0oqs/fm6qQIqoBgQHg4+wDnPaD3DGsNUZuXFDHK72TM6IlfuhukLF7G/elseTkYAz
         5R+thB5nne4ShYtrzUJXCOZl6akr9fH0ox1UQTm5VdhQBRbdiQnWir2uwSMr/XoC/HER
         ycwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N25bJ2FAAYNJwtYiwA/m+2YpZR89dhR1fBlXuzeFnMA=;
        b=KcBhMDvAqoRG7aGqxs4BiRl8OJ5zpo3kxMM88LwTI2kDwaNVzMvTs4s+YJTHkKgKFL
         9DsMdsr6mat5mzfre+b4WPFdojQA6irMUGnC1cYQHQo9mYlTUPPxv6ex0gSpSWeKYmbL
         63KR31DEKng/Bf3lpzyVa2uwQjB3bCTZ4fm+seSaVavU/XaTrwMTNPjSoylH5Y0tPw3E
         TKm6LR1M8w8KUScxFCucA7IP1bdMRczkDqWUgkHkBMdUePYnna1KQWLZc1nPmUDsDnGJ
         GUz20EL9O/w3BP09vA8IVK4RIWZnBnvCaPyl7hIlqagaAy63/F0qQtSXGq0Rb4xIZj81
         b2lg==
X-Gm-Message-State: APjAAAXT8Md61Dj8sDhavcn98+LeU+de2CLvNyGiqQWY2ze+YD0ykIJ/
        H0mz7SVjBv1kTZxW25PSAhc=
X-Google-Smtp-Source: APXvYqwluRamsRwAvCUmxgoCakjUljlibtPKxVzgFW5l3OGCTX3NZNwMKzcVFJ8OfcL6N8XCYpryQw==
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr10073646wrp.245.1574339672921;
        Thu, 21 Nov 2019 04:34:32 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id 65sm3307019wrs.9.2019.11.21.04.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 04:34:32 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:34:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191121123429.GS23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121114936.GR23183@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 12:49:36PM +0100, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> > Getting started with a sparse-checkout file can be daunting. Help
> > users start their sparse enlistment using 'git sparse-checkout init'.
> > This will set 'core.sparseCheckout=true' in their config, write
> > an initial set of patterns to the sparse-checkout file, and update
> > their working directory.
> 
> Enabling sparse-checkout can remove modified files:
> 
>   $ mkdir dir
>   $ touch foo dir/bar
>   $ git add .
>   $ git commit -m Initial
>   [master (root-commit) ecc81bd] Initial
>    2 files changed, 0 insertions(+), 0 deletions(-)
>    create mode 100644 dir/bar
>    create mode 100644 foo
>   $ echo changes >dir/bar
>   $ ~/src/git/git sparse-checkout init
>   error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
>   error: failed to update index with new sparse-checkout paths

And after this it leaves the 'sparse-checkout' file behind, which may
or may not be desired:

  $ cat .git/info/sparse-checkout 
  /*
  !/*/

