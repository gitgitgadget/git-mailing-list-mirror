Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEDC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EDB2080C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCSQCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:02:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:43946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727436AbgCSQCM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:02:12 -0400
Received: (qmail 25778 invoked by uid 109); 19 Mar 2020 16:02:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:02:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28224 invoked by uid 111); 19 Mar 2020 16:11:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:11:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:02:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Message-ID: <20200319160211.GC3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <7e184d97df8c673b0edfb6223c82385579777b19.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e184d97df8c673b0edfb6223c82385579777b19.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:03PM +0700, Đoàn Trần Công Danh wrote:

> Shell recognises first non-assignment token as command name.
> Thus, ` cd t/perf; ./p0000-perf-lib-sanity.sh -d -i -v` reports:
> 
> > test_cmp:1: command not found: diff -u
> 
> Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.

Adding an "eval" here will subtly change the behavior for other shells.
Right now they'd just do whitespace splitting (which presumably busybox
is not), but with this we'd expand metachars, etc.

I suspect that's fine (and maybe even preferable, because if you really
do have a space in the path you can actually escape it). So I don't mind
this change.

I do worry that this whitespace splitting behavior could bite us in
other scripts. Curiously, my version of busybox (1.30.1) doesn't seem to
have any problem with it, though.

-Peff
