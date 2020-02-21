Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EBC35640
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2F222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgBUFik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:38:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:50088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726088AbgBUFik (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:38:40 -0500
Received: (qmail 15784 invoked by uid 109); 21 Feb 2020 05:38:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 05:38:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16215 invoked by uid 111); 21 Feb 2020 05:47:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 00:47:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 00:38:38 -0500
From:   Jeff King <peff@peff.net>
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Message-ID: <20200221053838.GD1280313@coredump.intra.peff.net>
References: <BL0PR2101MB1089AA571A3277AEF4798B5D80120@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <CABPp-BHJeAfj0=OWLeU8UuXtAu1-cCCLs4O_rLqiDHxGbMEhAQ@mail.gmail.com>
 <BL0PR2101MB1089E6E522A983429473719380120@BL0PR2101MB1089.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB1089E6E522A983429473719380120@BL0PR2101MB1089.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 03:06:13AM +0000, Adam Milazzo wrote:

> I wonder now why Git makes an effort of appearing to represent a full
> set of Unix file permissions. Perhaps the idea was to leave the door
> open to storing them in the future...

I think to some degree it's the other way around. The very earliest
versions of Git did track the full mode, but that turned out to be
annoying (you'd record useless changes caused by umasks of different
committers). It was changed in e44794706e (Be much more liberal about
the file mode bits., 2005-04-16), which is quite early on. :)

We do use the mode bits for other things, too. Subtrees are 040000,
symlinks are 120000, and submodule "gitlinks" are 160000.

-Peff
