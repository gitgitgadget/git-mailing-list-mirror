Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C1C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F8620674
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy9LguRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKUP1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:27:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUP1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 10:27:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so4198607wmh.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wEYnB5StjvhxqiJ0s79/prqc8rFrF3QQR/cUNdJfGs0=;
        b=Hy9LguRMHvcZfT9ZF8Kl8mwgznQo70IvR9DxQWJWiTyFzSBblKZKcEBH0V8a6Gtca6
         DjflrxaMG8qZGlIsa7v8q5wx/alv2nbWGQiKq3Pw9wZVLm2hlmHW/lxKs1VNCn2D3TfD
         uxE81bSbz3NFV21ov7ccNir0q/dcDrE1qV+ste7/xvjlDDvJQ4vL6ZTmXTlOOnq1ri0B
         wCFxIJWnppVwPGnKEZPsbSMGdz9JIkZ0fJE0VSRr+xER+bH4naxB+b2PLoJydjtEOZMA
         BbPJ1AloenC+iksJ59ktPw+lLhJ+YlU5n3+YWhGMaNVXGJ+XCfQe002V0NGGRKeiAnID
         9TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wEYnB5StjvhxqiJ0s79/prqc8rFrF3QQR/cUNdJfGs0=;
        b=G8UPjO13oUdVY0Q7xTBC1aNl0c4pWDvqaKbdLacpItChbEvBzc5oDCczQJ4FQgZi4D
         UYvLcuA+2qu1m0ZcUBn8HuDCwNwe/bCCgQl7gb/7fobeo6dLyHlesA7X+MHcVNlSjZyE
         0XbTldgaUgTSRz9N1Xua2kTMs3r4/msqYfRrKsWYvyclDMSDL5RYpAwju1WQ/d1x9Dqz
         UHVt+S/UhqM6H3Qarz/JeHv9gHKGjfUxSl4niq+eRV95j5oZsgtZ2FtyLfpXrbFCdH+y
         orL2y9Q3PG2ebvYWoSDTodTdqS7DAptn9Gr2ZbcpXkrooSpIoHueD8eH7KeUw5/E8Ii4
         ko/w==
X-Gm-Message-State: APjAAAUetIQguycyO3c/u/uzqveJWxoOd/cHqa89Mpoi+b7cJGI+X7h+
        r2fnx4IQQqyNk2BHekApEWo=
X-Google-Smtp-Source: APXvYqyGqJLKMjG0O/XdUenYXhlGR8XNjNNl7BCNdslzKmdz7nfNk/WYBmeslSyW3/rFmIbdci3Rvg==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr10645427wmh.152.1574350068005;
        Thu, 21 Nov 2019 07:27:48 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id c9sm3078155wmb.42.2019.11.21.07.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:27:47 -0800 (PST)
Date:   Thu, 21 Nov 2019 16:27:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191121152744.GU23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
 <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 09:28:59AM -0500, Derrick Stolee wrote:
> On 11/21/2019 6:49 AM, SZEDER Gábor wrote:
> > On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> >> Getting started with a sparse-checkout file can be daunting. Help
> >> users start their sparse enlistment using 'git sparse-checkout init'.
> >> This will set 'core.sparseCheckout=true' in their config, write
> >> an initial set of patterns to the sparse-checkout file, and update
> >> their working directory.
> > 
> > Enabling sparse-checkout can remove modified files:
> > 
> >   $ mkdir dir
> >   $ touch foo dir/bar
> >   $ git add .
> >   $ git commit -m Initial
> >   [master (root-commit) ecc81bd] Initial
> >    2 files changed, 0 insertions(+), 0 deletions(-)
> >    create mode 100644 dir/bar
> >    create mode 100644 foo
> >   $ echo changes >dir/bar
> >   $ ~/src/git/git sparse-checkout init
> >   error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
> >   error: failed to update index with new sparse-checkout paths
> >   $ cat dir/bar 
> >   changes
> > 
> > So far so good, my changes are still there.  Unfortunately, however:
> > 
> >   $ git add -u
> >   $ ~/src/git/git sparse-checkout init
> >   $ echo $?
> >   0
> >   $ ls
> >   foo
> > 
> > Uh-oh, my changes are gone.
> 
> Here, your changes are not "lost", they are staged, correct? 

Well, yes, the changes were staged, so they must be in the object
database somewhere, the user just has to go through the dangling
objects reported by 'git fsck' to find and restore it...  So from the
perspective of an ordinary user they are lost.

> A "git status"
> should report that your changes are ready for committing. This seems to be
> the expected behavior.

No, unfortunately enabling sparse-checkout did throw the staged
changes away:

  ~/test (master +)$ ~/src/git/git sparse-checkout init
  ~/test (master)$ git status 
  On branch master
  nothing to commit, working tree clean

Note also the shell prompt going from "you have staged changes" to
"working tree is clean".

But wait, I thought that only changes to files that are excluded from
the sparse-checkout are thrown away, but as it turns out it throws
away changes to files that are included in the sparse-checkout:

  ~/test (master #)$ echo original >foo
  ~/test (master #%)$ git add .
  ~/test (master +)$ git commit -m Initial
  [master (root-commit) 04cb2a2] Initial
   1 file changed, 1 insertion(+)
   create mode 100644 foo
  ~/test (master)$ echo changes >foo 
  ~/test (master *)$ ~/src/git/git sparse-checkout init
  ~/test (master *)$ cat foo 
  changes

So far so good, but:

  ~/test (master *)$ ~/src/git/git sparse-checkout disable
  ~/test (master *)$ git add .
  ~/test (master +)$ ~/src/git/git sparse-checkout init
  ~/test (master)$ cat foo 
  original

This is not really sparse-checkout-specific, because this is what 'git
read-tree -um HEAD' always does on its own:

  ~/test (master)$ echo changes >foo 
  ~/test (master *)$ git read-tree -um HEAD
  ~/test (master *)$ cat foo 
  changes
  ~/test (master *)$ git add -u
  ~/test (master +)$ git read-tree -um HEAD
  ~/test (master)$ cat foo 
  original

These issues are present at the end of the patch series as well, but
that is sort-of expected, because the later commit message states
that:

    Remove this extra process call by creating a direct call to
    unpack_trees() in the same way 'git read-tree -mu HEAD' does.

