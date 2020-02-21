Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD9C35641
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11620722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBUGj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:39:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:50170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726045AbgBUGjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 01:39:55 -0500
Received: (qmail 16006 invoked by uid 109); 21 Feb 2020 06:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 06:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16693 invoked by uid 111); 21 Feb 2020 06:48:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 01:48:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 01:39:54 -0500
From:   Jeff King <peff@peff.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command.c: ensure signaled hook scripts are waited
 upon
Message-ID: <20200221063954.GJ1280313@coredump.intra.peff.net>
References: <20200221060636.4507-1-asottile@umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221060636.4507-1-asottile@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 10:06:36PM -0800, Anthony Sottile wrote:

> In the event of a `^C` while hook scripts are running, ensure that the
> hook processes are cleaned up and do not become zombies.  This also ensures
> that upon `^C` execution is not handed back to the terminal until the
> processes have been waited upon.

If we assume that most people would prefer this "wait until the hook has
died" behavior, I think this shouldn't have any unwanted secondary
effects. I'm on the fence on whether it's what most people would want or
not (I guess most people don't care either way, because their scripts
don't ignore SIGINT).

(Earlier in the thread, we discussed possibly swapping the order of the
cleanup code and dropping the signal handler, which could have more
unexpected effects, but that part isn't in this patch).

-Peff
