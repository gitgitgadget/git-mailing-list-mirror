Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF96C201CF
	for <e@80x24.org>; Thu, 18 May 2017 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933480AbdERRWZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 13:22:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54315 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932513AbdERRWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 13:22:24 -0400
Received: (qmail 17744 invoked by uid 109); 18 May 2017 17:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 17:22:23 +0000
Received: (qmail 18912 invoked by uid 111); 18 May 2017 17:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 13:22:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 13:22:20 -0400
Date:   Thu, 18 May 2017 13:22:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 00/23] Prepare to separate out a packed_ref_store
Message-ID: <20170518172220.6caa2dcoc72b5g7z@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <6d84ff31-0282-00ec-83d6-9be2a8b7a776@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d84ff31-0282-00ec-83d6-9be2a8b7a776@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 07:14:38PM +0200, Johannes Sixt wrote:

> Am 17.05.2017 um 14:05 schrieb Michael Haggerty:
> > This patch series is the next leg on a journey towards reading
> > `packed-refs` using `mmap()`, the most interesting aspect of which is
> > that we will often be able to avoid having to read the whole
> > `packed-refs` file if we only need a subset of references.
> 
> Which features of mmap() are you going to use? We have only MAP_PRIVATE on
> Windows. We do emulate PROT_WRITE (without PROT_READ), but I don't think
> that code is exercised anywhere. See also compat/win32mmap.c.

It's just on the reading side, so it should be the same as the mmaps we
do for reading packfiles, the index, etc. You can see the actual call in
the upcoming series that Michael linked earlier:

  https://github.com/mhagger/git/commit/d22420b5f3e967d24aba019a0916a5a93ab00e03

-Peff
