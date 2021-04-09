Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2849C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A3661056
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhDISq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:46:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:46860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234598AbhDISq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:46:26 -0400
Received: (qmail 1201 invoked by uid 109); 9 Apr 2021 18:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15563 invoked by uid 111); 9 Apr 2021 18:46:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:46:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:46:11 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOyglQ==?=
         =?utf-8?B?7IiY66OM7Jew6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>, git@vger.kernel.org,
        hanjiyeon0@gmail.com
Subject: Re: Possible memory leak bug reports for the latest "git" repository.
Message-ID: <YHCg8ycLahSwNvJL@coredump.intra.peff.net>
References: <CAPb83E_r-gx-zDU1eLwPLfC_Zd-4Hyb_x6t_s_pGHwfxuQ0+vQ@mail.gmail.com>
 <b96f76f2-db00-cc7c-eb83-3033873023ec@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b96f76f2-db00-cc7c-eb83-3033873023ec@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 06:49:39PM +0200, Andrzej Hunt wrote:

> > ==63105== 40 bytes in 1 blocks are possibly lost in loss record 38 of 142
> > ==63105==    at 0x4C31B0F: malloc (in
> > /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> > ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> > ==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
> [...]
> 
> These are a bit odd: chdir_notify_register() is attaching the newly
> allocated memory to a static list (chdir_notify_entries), and I can't see
> any obvious reason why this would leak (but maybe valgrind doesn't like
> static pointers)? Either way, this doesn't seem to be anywhere near the
> regex code.

These "possibly lost" are false positives; there's more discussion in
this thread:

  https://lore.kernel.org/git/20201117002435.GA13516@coredump.intra.peff.net/

-Peff
