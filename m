Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A5BC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6B520663
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCSQMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:12:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:43986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726912AbgCSQMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:01 -0400
Received: (qmail 25890 invoked by uid 109); 19 Mar 2020 16:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28422 invoked by uid 111); 19 Mar 2020 16:21:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:21:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:12:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200319161200.GF3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:06PM +0700, Đoàn Trần Công Danh wrote:

> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> update feature, 2016-08-03), we started to use ls as a trick to update
> directory's mtime.
> 
> However, `-ls` flag isn't required by POSIX's find(1), and
> busybox(1) doesn't implement it.
> 
> Use an equivalence `-exec ls -dils {} +` instead.

Makes sense. I wonder if we need all of "-dils", but it's not clear to
me which syscalls actually trigger the FreeBSD lazy-update behavior. I
guess probably it's stat()ing the directory, so "ls -ld" would be
sufficient (and that's implied by the examples in 6b7728db81).

But I doubt the extra options would create a portability problem, so I
think it's fine either way.

-Peff
