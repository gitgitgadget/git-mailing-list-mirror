Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF0C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BADC20CC7
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLPTZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:25:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:47928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726426AbfLPTZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 14:25:55 -0500
Received: (qmail 26033 invoked by uid 109); 16 Dec 2019 19:25:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Dec 2019 19:25:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14314 invoked by uid 111); 16 Dec 2019 19:30:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2019 14:30:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Dec 2019 14:25:54 -0500
From:   Jeff King <peff@peff.net>
To:     Chrissy Wainwright <chrissy@sixfeetup.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Stash does not save rename information
Message-ID: <20191216192554.GB2678964@coredump.intra.peff.net>
References: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
 <87immizf55.fsf@kyleam.com>
 <87fthmzewl.fsf@kyleam.com>
 <EF4FE28C-1111-46C7-9EDE-24940E8A5727@sixfeetup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF4FE28C-1111-46C7-9EDE-24940E8A5727@sixfeetup.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 02:32:31PM +0000, Chrissy Wainwright wrote:

> Thank you, using --index does work! Now the trick is to actually
> remember to use it in this case, since it doesn't seem the change can
> be restored if you forget to use it the first time you pop/apply.

I think this is a spot where git-stash could be a little friendlier. If
you've stashed index changes and "git stash pop", then those index
changes are not applied but get thrown away, losing information.

It would be nicer if "stash pop" noticed that there are entries in the
stashed index that do not match HEAD or the stashed working tree, and
applied as requested but _didn't_ remove the stash (with a message that
you can get your index changes out with "--keep-index").

Maybe a good small project for somebody looking to get their feet wet
with contributing to Git (you, or anybody else reading this).

-Peff
