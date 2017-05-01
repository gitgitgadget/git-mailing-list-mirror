Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7AA1F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750720AbdEATXq (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:23:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdEATWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:22:15 -0400
Received: (qmail 18650 invoked by uid 109); 1 May 2017 19:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 19:22:14 +0000
Received: (qmail 4603 invoked by uid 111); 1 May 2017 19:22:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 15:22:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 15:22:12 -0400
Date:   Mon, 1 May 2017 15:22:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
Message-ID: <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 01:23:28PM +0200, René Scharfe wrote:

> Am 24.04.2017 um 12:39 schrieb Duy Nguyen:
> > BTW, I ran t7009 with valgrind and it reported this. Is it something
> > we should be worried about? I vaguely recall you're doing something
> > with prio-queue...
> > 
> > ==4246== Source and destination overlap in memcpy(0x5952990, 0x5952990, 16)
> > ==4246==    at 0x4C2EACD: memcpy@@GLIBC_2.14 (in
> > /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> > ==4246==    by 0x545D05: swap (prio-queue.c:15)
> > ==4246==    by 0x545D72: prio_queue_reverse (prio-queue.c:25)
> > ==4246==    by 0x4CBC0C: sort_in_topological_order (commit.c:723)
> > ==4246==    by 0x574C97: prepare_revision_walk (revision.c:2858)
> > ==4246==    by 0x48A2BA: cmd_rev_list (rev-list.c:385)
> > ==4246==    by 0x405A6F: run_builtin (git.c:371)
> > ==4246==    by 0x405CDC: handle_builtin (git.c:572)
> > ==4246==    by 0x405E51: run_argv (git.c:624)
> > ==4246==    by 0x405FF3: cmd_main (git.c:701)
> > ==4246==    by 0x4A48CE: main (common-main.c:43)
> 
> I can only get gcc and clang to call memcpy instead of inlining it by
> specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
> curious.)

I do my normal edit-compile cycles with -O0 because it's fast, and
because it makes debugging much easier.

> But I can't get Valgrind to report overlapping (nicely explained in
> http://valgrind.org/docs/manual/mc-manual.html#mc-manual.overlap, by
> the way), not for t7009 and not for the short test program at the
> bottom.  Do you set flags in GIT_VALGRIND_OPTIONS or use a special
> version of Valgrind?  I use valgrind-3.12.0.SVN from Debian testing.

I saw it with 3.12.0-1.1 on Debian unstable.

-Peff
