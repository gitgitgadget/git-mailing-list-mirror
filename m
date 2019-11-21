Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09CBC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DAE20692
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8VeyCmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKUXDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:03:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52435 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXDb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:03:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so5543129wme.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pfTFka37vM/olfHOAsOrseuQBW4lt+T+kjf1VUwPq3E=;
        b=Q8VeyCmD629YHdtwSUSeyXJXcZoe+JXwYPNt5xsQP/JB8a9flafudbzpU5kQb+O0cz
         mmDY4krhem4uFsefizxERHxg1InUlWl40vKLPWuQlWNQXUq+kiy8ztskcijq/nBLs1uO
         5INeh+0HtCyIFPwx3tSW/askNX0Ic9PtWe0LDNlDC7Eekz//lrLBTLucCPVUfYcETQgf
         o+TnPXf/5rAKromW2jJa1lrffZn3v1ngo2hDbWkAE0IP/IrGym7cIWsaHV7wBeuDgY0A
         ut/Y++eh/b7GIh1eHQAI1luGkoE8eYc14B77oJjHDpkAOr2Vmpih9ohM8MWmwqrjId+b
         EGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pfTFka37vM/olfHOAsOrseuQBW4lt+T+kjf1VUwPq3E=;
        b=NsoOdE1rBfsDTO2bnDBZM27FS+LqXfU8HJl6SpxubY++TDjcN3vZ2s6Tmi3yjTLrjx
         2XX05h29MCVdDm8LO570AXu9XyMGeIXa7QKsLWGbsVUbFv6RxO6u/UmHoD/TvAaWjBkZ
         q7S2tTBRe5O8J+MaMH1bA9y4SrZ7fNumRvl/uHaDN3C6nfmgDXARlhJyrq7EOSQimlDK
         4+m3yukXMnptvcW7Jiebg6pwGF6HkUsSiApKuchXsOnA8FwFskHRRIBj0Ex48CUHQPtr
         fJE8gSsp/rEYnYt/0/WbUp7Z9BO//giC7lzVrb3BZ3zZ/3HPdcNg1+WcWBNvXHPsCnjs
         W4lw==
X-Gm-Message-State: APjAAAWqEQF4FyglXTGvfcpvofLKa0TfPJMSLCXs+aEWCIx1CGt3OPrN
        /X6f8CEnWmN+PVsXPwYFgk//XupN
X-Google-Smtp-Source: APXvYqxRV/bNfM6N+UW/FRqeUePLGjPD90cW6vDx+qM2SpENTOGYiIAOI4Yetb4wQy2w/CWYLokd7w==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr12594302wma.119.1574377409524;
        Thu, 21 Nov 2019 15:03:29 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id y6sm5156245wrn.21.2019.11.21.15.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:03:28 -0800 (PST)
Date:   Fri, 22 Nov 2019 00:03:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] commit-graph: use start_delayed_progress()
Message-ID: <20191121230326.GW23183@szeder.dev>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <3c0c9675e125f9357aeadd76f290413aaa09e4cf.1573148818.git.gitgitgadget@gmail.com>
 <20191107212614.GC29042@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107212614.GC29042@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 04:26:14PM -0500, Jeff King wrote:
> On Thu, Nov 07, 2019 at 05:46:58PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > When writing a commit-graph, we show progress along several commit
> > walks. When we use start_delayed_progress(), the progress line will
> > only appear if that step takes a decent amount of time.
> > 
> > However, one place was missed: computing generation numbers. This is
> > normally a very fast operation as all commits have been parsed in a
> > previous step. But, this is showing up for all users no matter how few
> > commits are being added.
> 
> This part of the patch is a good thing, and obviously correct. But I
> wondered...

Agreed.

> > The tests that check for the progress output have already been updated
> > to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
> > is one test in t6500-gc.sh that uses the test_terminal method. This
> > mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
> 
> Why doesn't GIT_PROGRESS_DELAY make it through? Overall it's not that
> big a deal to me if it doesn't, but in this test:

But I was wondering this, too.  If I run the following test:

        (
                write_script script <<-\EOF &&
                echo "GPD: $GIT_PROGRESS_DELAY"
                EOF
                GIT_PROGRESS_DELAY=42 &&
                export GIT_PROGRESS_DELAY &&
                test_terminal ./script dummy-arg
        ) &&

then its output looks like this:

  + write_script script
  + GIT_PROGRESS_DELAY=42
  + export GIT_PROGRESS_DELAY
  + test_terminal ./script dummy-arg
  GPD: 42

So test_terminal does preserve GIT_PROGRESS_DELAY.

