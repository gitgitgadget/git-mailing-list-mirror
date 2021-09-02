Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBCC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCE961008
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbhIBJl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:41:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245381AbhIBJl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:41:26 -0400
Received: (qmail 21894 invoked by uid 109); 2 Sep 2021 09:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:40:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23215 invoked by uid 111); 2 Sep 2021 09:40:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:40:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:40:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YTCcCXkUpnnHOzyK@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
 <xmqq5yvkqidc.fsf@gitster.g>
 <YS/Pqc7lkMlnlBYR@nand.local>
 <xmqq1r68qevl.fsf@gitster.g>
 <YS/juRg9N/cCoR0d@nand.local>
 <xmqq35qoowb8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35qoowb8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 01:49:47PM -0700, Junio C Hamano wrote:

> > As far as I can tell, supporting arbitrary directories with
> > `--object-dir` was a historical accident, since even the documentation
> > says `<alt>` when referring to the value passed to this option.
> 
> The synopsis has [--object-dir=<dir>], which wants to be cleaned up
> for consistency (or <alt> updated to <dir>, but I tend to agree with
> you that unifying to <alt> may make our intention more clear).
> 
> It is unfortunate that "git multi-pack-index -h" says <file>, which
> is probably doubly wrong.  It seems this is the only instance that
> abuses OPT_FILENAME() for a non-file, so perhaps it is not too bad
> to fix it using the lower-level OPTION_FILENAME (instead of adding
> a one-off OPT_DIRECTORY_NAME() helper).

That made me wonder what "git commit-graph -h" says. It says "<dir>"
(even though it already must be an alternate), because it uses
OPT_STRING().

I think using OPTION_FILENAME or similar is better there, too, though,
because it reinterprets the name after the repo-setup chdir() step. But
now you'd have to for an OPT_DIRNAME() helper. :)

> Neither is something that would block this step, of course.

Yeah, very much agreed that this can come later on top.

-Peff
