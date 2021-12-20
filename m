Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F84C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhLTNtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:49:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:55034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhLTNtH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:49:07 -0500
Received: (qmail 10254 invoked by uid 109); 20 Dec 2021 13:49:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Dec 2021 13:49:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2508 invoked by uid 111); 20 Dec 2021 13:49:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Dec 2021 08:49:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Dec 2021 08:49:05 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Message-ID: <YcCJ0bU1y4TnS3yp@coredump.intra.peff.net>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
 <YbzSfwQixuonrK/o@coredump.intra.peff.net>
 <7969c9e5-dd57-705c-b554-67681b9af62f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7969c9e5-dd57-705c-b554-67681b9af62f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 08:37:52AM -0500, Derrick Stolee wrote:

> > +test_expect_success TTY '--quiet disables progress' '
> > +	test_terminal env GIT_PROGRESS_DELAY=0 \
> > +		git -C midx repack -ad --quiet --write-midx 2>stderr &&
> > +	test_must_be_empty stderr
> > +'
> > +
> >  test_done
> 
> Thanks. I added this test.
> 
> When first running the test, it failed because I didn't have the
> IO::Pty Perl module installed. I'm not sure why I don't fail with
> other tests that use test_terminal. If someone knows more about
> what is going on, then maybe we need to expand the TTY prereq?

Weird. I uninstalled IO::Pty, and get:

  checking prerequisite: TTY
  
  [...prereq code...]

  
  + perl /home/peff/compile/git/t/test-terminal.perl sh -c test -t 1 && test -t 2
  + command /usr/bin/perl /home/peff/compile/git/t/test-terminal.perl sh -c test -t 1 && test -t 2
  Can't locate IO/Pty.pm in @INC (you may need to install the IO::Pty module) (@INC contains: [...etc...]
  BEGIN failed--compilation aborted at /home/peff/compile/git/t/test-terminal.perl line 5.
  prerequisite TTY not satisfied
  ok 25 # skip --quiet disables progress (missing TTY)

What does running with "-x -i" say for the prereq?

-Peff
