Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6147C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6421D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="detEtzVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAWRqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:46:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42290 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWRqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 12:46:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so4060653wro.9
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z727j8Qt6m1TRNH5Uuxf9bXItsTbj/ME2W6/tHVGLCk=;
        b=detEtzVBf0oXhIKtXi/dcBu6Xz51dY+8CllT/0PPtnu1vvz9JQMAdKOWsRL2O+YUMJ
         quqO7PH5AXQDEmMd1UQUW4Af9hjp0PAKXLgEeBLI998Oke2s82V6uWJHk6rRmbFFCFOF
         1p7dXg0zhGov3vnFfut/dpaCK7OWKhQmSKP2UTShquaEHQ6+wrPk56vmieYmhtPOYVLz
         ROBqieUIROEQLn/TH0iNclL1IjvxXPt7S+SVxGCgfqp/+iV20o28Bso8itbxfADZ4YfQ
         COC4kr1XmfAtbp12+49w2x0HFgCCJT5qX2XeRIsHHThDjTI3hgZLqffVczl+pkuQGYcd
         /9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z727j8Qt6m1TRNH5Uuxf9bXItsTbj/ME2W6/tHVGLCk=;
        b=fjI1EtC/BuX3kOMlAU2827nhEwLEIomASuTjCwxGd/Wv5DAJDiOOIIf91GIaI14M6Y
         3a5aQlimSbReDpAD989vUaoXb6p/J0RZ7WctM4XVGHyxcPB9uLcOWuX6CZZDj6qH1aIt
         bije9loeuOoOES5DDUEr3rHrvuZLZJoifCPY1QjD668FMfrGHOw9C8aqgmToENrEVeRY
         7KYApsWfPRWWsDU1bpNpFvkX2996G4wtultPwMn0LD6Gwb7i3iU+5Dvd+1z2ORLVQFkj
         lGXfjjp6QvO+t5qxFNE0RAbtrVBvzbp8HaoSjdLR/20MjJ8N4DB9rQYxUAp5GfPT+6DV
         JSag==
X-Gm-Message-State: APjAAAVqROVPSGTA5e0hUu445KmgMujrDjYf9PdnAOegWumKIDPqrPUL
        T0i7flOGzk0+D3G/b1zrk3c=
X-Google-Smtp-Source: APXvYqxOM6TLvKx0vUgxTYEfCBxNJWkjecwX/aRhRkjE3ybuX/YRyfwLBX9Zm1Ib29hLsqYNIasDXg==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr18964048wrh.121.1579801570598;
        Thu, 23 Jan 2020 09:46:10 -0800 (PST)
Received: from szeder.dev (x4db607d2.dyn.telefonica.de. [77.182.7.210])
        by smtp.gmail.com with ESMTPSA id m3sm3697268wrs.53.2020.01.23.09.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:46:09 -0800 (PST)
Date:   Thu, 23 Jan 2020 18:46:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
Message-ID: <20200123174602.GE6837@szeder.dev>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <20200123170412.GD6837@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123170412.GD6837@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 06:04:12PM +0100, SZEDER Gábor wrote:
> On Thu, Jan 23, 2020 at 11:36:49AM -0500, Eric Sunshine wrote:

> > > Are you sure it's a recent regression?  I have no experience with
> > > 'gitk' in Git for Windows, but on Linux this has been broken for quite
> > > some time, namely since 784b7e2f25 (gitk: Fix "External diff" with
> > > separate work tree, 2011-04-04) in the v1.7 era.  FWIW, reverting that
> > > commit on top of v2.25.0 makes 'gitk' work again in bare repositories.
> > 
> > It's a new regression introduced by 2d92ab32fd (rev-parse: make
> > --show-toplevel without a worktree an error, 2019-11-19), as far as I
> > can tell.
> 
> Oh, that's interesting.
> 
> My local commit reverting 784b7e2f25 that I build my Git with is newer
> than 2d92ab32fd, so maybe that's why I haven't recalled seeing this
> issue earlier.  I did try to bisect it, but had a real hard time with
> gitk being subtree merged, and ultimately gave up on that, and started
> to look for a commit adding '--show-toplevel' to 'gitk', which lead me
> to 784b7e2f25, I reverted it, my issue went away, which then lead me
> to the wrong conclusion.

Oh, this is interesting indeed :)

I have a couple of older Git versions lying around, so I can quickly
ballpark a revision range for a regression, without checking out and
building older versions.  This has always worked well so far, because
Git looks for its non-builtin commands in the hardcoded exec-path that
was specified at build time, while builtin commands are, well,
builtins.  Alas, 'gitk' is not a regular Git command, and it runs
whatever 'git' executable comes first in PATH, which in my case was a
recent build already containing 2d92ab32fd.

  $ ~/src/git/BUILDS/v1.8.0/bin/git --exec-path
  /home/szeder/src/git/BUILDS/v1.8.0/libexec/git-core
  $ cd .git
  $ ~/src/git/BUILDS/v1.8.0/bin/gitk
  Error in startup script: fatal: this operation must be run in a work
  tree
      while executing
  "exec git rev-parse --show-toplevel"
      invoked from within
  "set worktree [exec git rev-parse --show-toplevel]"
      (file "/home/szeder/src/git/BUILDS/v1.8.0/bin/gitk" line 11810)
  $ PATH=~/src/git/BUILDS/v1.8.0/bin:"$PATH" ~/src/git/BUILDS/v1.8.0/bin/gitk
  # Works even in the .git directory!
  $ PATH=~/src/git/BUILDS/v2.24.0/bin:"$PATH" ~/src/git/BUILDS/v2.24.0/bin/gitk
  # This works, too!

With this newly gained knowledge I added 'bin-wrappers' to $PATH when
running gitk built from 2d92ab32fd and its parent, and indeed that's
the commit that introduced this regression.

