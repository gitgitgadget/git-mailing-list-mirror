Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E78C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC372077B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAHHZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:25:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:60040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbgAHHZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 02:25:43 -0500
Received: (qmail 20063 invoked by uid 109); 8 Jan 2020 07:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 07:25:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7791 invoked by uid 111); 8 Jan 2020 07:31:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 02:31:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 02:25:41 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] graph: fix collapse of multiple edges
Message-ID: <20200108072541.GC1675456@coredump.intra.peff.net>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
 <12abb32531ed7125293986dc139a7ffed3839065.1578457675.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12abb32531ed7125293986dc139a7ffed3839065.1578457675.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 04:27:55AM +0000, Derrick Stolee via GitGitGadget wrote:

> Before this change:
> 
> 	| | | | | | *
> 	| |_|_|_|_|/|\
> 	|/| | | | |/ /
> 	| | | | |/| /
> 	| | | |/| |/
> 	| | |/| |/|
> 	| |/| |/| |
> 	| | |/| | |
> 
> By adding the logic for "filling" a horizontal edge between the
> target column and the current column, we are able to resolve the
> issue.
> 
> After this change:
> 
> 	| | | | | | *
> 	| |_|_|_|_|/|\
> 	|/| | | | |/ /
> 	| | |_|_|/| /
> 	| |/| | | |/
> 	| | | |_|/|
> 	| | |/| | |

Hmm. Your description and your diagrams make sense to me. But one
curious thing is that the earlier test you added for 6_* does not need
modified. Because it continues to show:

          | | | | * 6_F
          | |_|_|/|
          |/| | |/
          | | |/|
          | |/| |
          | * | | 6_D

rather than adding a horizontal component to the second-parent line.
That seems inconsistent.

-Peff
