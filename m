Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B061F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 19:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfDVT20 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 15:28:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726260AbfDVT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 15:28:26 -0400
Received: (qmail 3626 invoked by uid 109); 22 Apr 2019 19:28:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 19:28:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2022 invoked by uid 111); 22 Apr 2019 19:28:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 15:28:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 15:28:21 -0400
Date:   Mon, 22 Apr 2019 15:28:21 -0400
From:   Jeff King <peff@peff.net>
To:     Cameron Steffen <cam.steffen94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Stage or discard a hunk at a time?
Message-ID: <20190422192821.GA22798@sigill.intra.peff.net>
References: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 01:09:03PM -0600, Cameron Steffen wrote:

> I have this feature idea for git. There should be a command that
> effectively combines git add -p and git checkout -p so that I can
> navigate changed hunks and either stage or discard them.
> 
> There is already a SO question asking about this exactly...
> https://stackoverflow.com/questions/11538650/simultaneously-git-add-p-and-git-checkout-p
> 
> Has this been discussed before? Is this a reasonable request? If so, I
> might look into contributing the change myself.

This is something I've sometimes wanted, too. I don't think it would be
_too_ hard to do by modifying the add-interactive code. Both of those
operations are driven by the same code; see the %patch_modes hash in
git-add--interactive.perl, which defines the various situations. You
would need to modify the actual code to handle the tri-state (there is
not just "yes, apply it" and "no, leave it alone", but now "apply /
discard / skip"). But it seems do-able.

If you do plan to work on it, be aware that the perl bits of
add--interactive are being re-written in C. So it might make sense to
target the new C implementation instead of modifying the perl.

-Peff

PS Sorry for the slow reply, and I hope you're still interested in the
   topic. Your message got throw onto my "interesting, should reply"
   pile and I just happened to see it while clearing out old mails. :)
