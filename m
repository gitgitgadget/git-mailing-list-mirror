Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECFC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F820715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1KEQKwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVP35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:29:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVP34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 10:29:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so9118457wrv.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EpTAVDJKr9uTYtAPzyHqF2OJBVshYqKvqd6tqq2H4l0=;
        b=f1KEQKwRhwW2dvVI1dSW0FhjRtsqzOBhl6beptKMz0FIRvxivKjDTHLd9j3nN3J6PV
         BuiiRuxWiA/bPZEcKRT+rmMkuTh2l0Ae23BciZ6lWZOFOjUR0YcRssh8I6H9PDjbU0Lg
         JMyZast7CE5XQFzOTa1pNPQ/jqmCv3VY//0b2rEU4CinR7JjOKQTPfNCk1+5VPPNjAU/
         PijKUh4em9Rw4rj9ribMOVWhRm88tKL8nEnmVv5G0UdFn0SdeDN++RzP9gJ0XzVtMel2
         zp5gIrVHrTiE3ubnJSil0wBf2ERPN8MYCOQSvnyhGICl20MqWsJgATXr/HTnSoCZRUR3
         5RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EpTAVDJKr9uTYtAPzyHqF2OJBVshYqKvqd6tqq2H4l0=;
        b=ReOhUEqV+e8fNPYO9w+rxQjpQt3Z4/pEW+h26aTznWDTWLmFmcS+jSgXZGUmqJlRSd
         MX8EyV9EZMH96Qw162VXUXaxRfPv0nWqyKiVdgL5bUPRKvetA+J1qzbD4zNXkQGcnRiA
         Qw+WA/K8u0V9K9dWA+bIx8hPkwydFLDGAIIWf3wgD5bvl/yebui4spTL5seLvtAQqVmP
         9GWzjx/wppmF3A/ZOKFVn6V60XZqwJa+IfEMwGo2urxUw4TztlH1so7HZTf+I2+ghwK2
         jPS2UFTIcWYZwf0OoZJ6Iw2fELbjXEdE9L72hzqXHH6zwjFh5kEJOorwOyHDpHWPZWmJ
         mMyA==
X-Gm-Message-State: APjAAAXwXAAQjFw+iS0JjxO8O9fg6tM+QG8k1PU2bZ0iImliRABodFg+
        yur18RcbGiBVedeZEHxi8E8=
X-Google-Smtp-Source: APXvYqzZJS5UX1PBIIGcCnzjkoXJIUjwXNmoH2bk8pigrp+WMm/6beKACr2xCOTJm1gobxth37o0zA==
X-Received: by 2002:a5d:56d1:: with SMTP id m17mr8261884wrw.222.1574436593754;
        Fri, 22 Nov 2019 07:29:53 -0800 (PST)
Received: from szeder.dev (x4db9604a.dyn.telefonica.de. [77.185.96.74])
        by smtp.gmail.com with ESMTPSA id v128sm4241078wmb.14.2019.11.22.07.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:29:52 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:29:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: coccinelle: improve array.cocci
Message-ID: <20191122152950.GZ23183@szeder.dev>
References: <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
 <d053612d-107b-fdb2-b722-6455ef068239@web.de>
 <4f55b06b-35f3-da06-ae86-8a4068f78027@web.de>
 <06ff24b6-f154-9ec6-7b22-05b0ea664a36@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06ff24b6-f154-9ec6-7b22-05b0ea664a36@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 08:44:12PM +0100, Markus Elfring wrote:
> The program “spatch” supports parallelisation also directly by the parameter “--jobs”.
> Did you try it out occasionally?

I did try --jobs on a couple of occasions, and the results always
varied between broken, not working, or downright making things even
slower.


  $ spatch --version
  spatch version 1.0.4 with Python support and with PCRE support
  $ spatch --sp-file contrib/coccinelle/array.cocci --all-includes --patch . --jobs 2 alias.c alloc.c
  init_defs_builtins: /usr/lib/coccinelle/standard.h
  HANDLING: alias.c alloc.c
  Fatal error: exception Sys_error("array: No such file or directory")

This issue seems to be fixed in later versions, but this is the
version what many distros still ship and what is used in our CI
builds, so we do care about 1.0.4.


  $ spatch --version
  spatch version 1.0.8 compiled with OCaml version 4.05.0
  Flags passed to the configure script: [none]
  OCaml scripting support: yes
  Python scripting support: yes
  Syntax of regular expressions: PCRE
  $ /usr/bin/time --format='%e | %M' make contrib/coccinelle/array.cocci.patch
      SPATCH contrib/coccinelle/array.cocci
  102.06 | 129084

Our Makefile recipes run Coccinelle in a sequential loop, one 'spatch'
invocation for each source file by default.  Therefore, merely passing
in '--jobs <N>' doesn't bring any runtime benefits:

  $ /usr/bin/time --format='%e | %M' make SPATCH_FLAGS='--all-includes --patch . --jobs 8' contrib/coccinelle/array.cocci.patch
      SPATCH contrib/coccinelle/array.cocci
  105.31 | 118512

Some time ago we found that invoking 'spatch' with multiple files at
once does bring notable speedup (with 1.0.4), although at the cost of
drastically increased memory footprint, see commit 960154b9c1
(coccicheck: optionally batch spatch invocations, 2019-05-06).  Alas,
trying to use that in the hope that 'spatch' can do more in parallel
if it has more files to process at once doesn't bring any runtime
benefits, either:

  $ /usr/bin/time --format='%e | %M' make SPATCH_FLAGS='--all-includes --patch . --jobs 8' SPATCH_BATCH_SIZE=8 contrib/coccinelle/array.cocci.patch
      SPATCH contrib/coccinelle/array.cocci
  116.27 | 349964

And by further increasing the batch size it just gets notably slower;
also note the order of magnitude higher max memory usage:

  $ /usr/bin/time --format='%e | %M' make SPATCH_FLAGS='--all-includes --patch . --jobs 8' SPATCH_BATCH_SIZE=32 contrib/coccinelle/array.cocci.patch
      SPATCH contrib/coccinelle/array.cocci
  197.70 | 1205784

It appears that batching 'spatch' invocations with 1.0.8 does not
bring the same benefits as with 1.0.4, but brings slowdowns instead...

Anyway, looking at 'ps u -L' output it appears that 'spatch' doesn't
really do any parallel work, and there are only two 'spatch' processes
and no threads despite '--jobs 8':

  szeder    2561  0.4  0.5  36944 21520 pts/0    S+   15:31   0:00 spatch
  szeder    2567 97.1 30.5 1228372 1205332 pts/0 R+   15:31   0:29 spatch


Note that 1.0.8 above was run in a Docker container, while 1.0.4 on
the host.  This may or may not have influenced the runtimes reported
above.  FWIW, 'make -j4 coccicheck' parallelizes just fine even in the
container and with 1.0.8.


A different approach relying on 'make -j' to parallelize 'spatch'
invocations was discussed here:

  https://public-inbox.org/git/20180802115522.16107-1-szeder.dev@gmail.com/T/#u

