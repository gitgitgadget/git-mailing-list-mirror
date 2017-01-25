Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4834C1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdAYUul (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:50:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:44754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbdAYUuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:50:40 -0500
Received: (qmail 1720 invoked by uid 109); 25 Jan 2017 20:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 20:50:40 +0000
Received: (qmail 15696 invoked by uid 111); 25 Jan 2017 20:50:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 15:50:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 15:50:38 -0500
Date:   Wed, 25 Jan 2017 15:50:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 2/5] revision.c: group ref selection options together
Message-ID: <20170125205037.cg3aebh5rsx4zb2l@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
 <20170125125054.7422-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170125125054.7422-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 07:50:51PM +0700, Nguyễn Thái Ngọc Duy wrote:

> These options have on thing in common: when specified right after
> --exclude, they will de-select refs instead of selecting them by
> default.
> 
> This change makes it possible to introduce new options that use these
> options in the same way as --exclude. Such an option would just
> implement something like handle_refs_pseudo_opt().
> 
> parse_ref_selector_option() is taken out of handle_refs_pseudo_opt() so
> that similar functions like handle_refs_pseudo_opt() are forced to
> handle all ref selector options, not skipping some by mistake, which may
> revert the option back to default behavior (rev selection).
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  revision.c | 134 +++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 100 insertions(+), 34 deletions(-)

Hmm. I see what you're trying to do here, and abstract the repeated
bits. But I'm not sure the line-count reflects a real simplification.
Everything ends up converted to an enum, and then that enum just expands
to similar C code.

I kind of expected that clear_ref_exclusion() would just become a more
abstract clear_ref_selection(). For now it would clear exclusions, and
then later learn to clear the decoration flags.

Maybe I am missing something in the later patches, though.

-Peff
