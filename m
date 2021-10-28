Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C4AC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13878610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1Saw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:30:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55568 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhJ1Sav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:30:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6DBE81F953;
        Thu, 28 Oct 2021 18:28:24 +0000 (UTC)
Date:   Thu, 28 Oct 2021 18:28:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] allow disabling fsync everywhere
Message-ID: <20211028182824.GA1307@dcvr>
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 28, 2021 at 12:21:02AM +0000, Eric Wong wrote:
> 
> > "core.fsync" and the "GIT_FSYNC" environment variable now exist
> > for disabling fsync() even on packfiles and other critical data.

Fwiw, I'm questioning the need for core.fsync.  GIT_FSYNC alone
may be sufficient.

> > This will also be useful for 3rd-party tools which create
> > throwaway git repositories of temporary data.
> 
> Do you mostly just care about the tests, or is the third-party tool
> support important to you? I ask because most of us switched to running
> the tests with --root=/some/tmpfs long ago to achieve the same speedup.

Third-party tools and OSes which don't have a tmpfs mounted by
default (I don't think most *BSDs have tmpfs enabled by
default).

I try to use libeatmydata everywhere I can; but that's not
always installed.

I'm also strongly considering making GIT_FSYNC=0 the default for
our own test suite since it's less setup for newbies.
