Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BF7201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdKLPWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:22:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:54004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751007AbdKLPWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 10:22:48 -0500
Received: (qmail 3342 invoked by uid 109); 12 Nov 2017 15:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 15:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15353 invoked by uid 111); 12 Nov 2017 15:23:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 10:23:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 15:22:46 +0000
Date:   Sun, 12 Nov 2017 15:22:46 +0000
From:   Jeff King <peff@peff.net>
To:     Soukaina NAIT HMID <nhsoukaina@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [add-default-config 1/5] add --color option to git config
Message-ID: <20171112152245.fetxqionsqqg2obp@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:00:40PM +0000, Soukaina NAIT HMID wrote:

> From: Soukaina NAIT HMID <snaithmid@bloomberg.net>
> 
> Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Hi Soukaina, and welcome to the list! Thanks for working on these
patches.

I'll go through and make inline comments on your patches, but first a
few overall issues:

 - you have five patches in your series, some of which are backing out
   changes made by the other patches. It's normal in the Git community
   to use "git rebase -i" to squash down your changes to "clean" patches
   that form a sequence. For your topic, I'd expect to see two patches
   in the end:

     1. Add a "config --default" option (and documentation and tests).

     2. Add a "config --color" type (and documentation and tests).

 - your commit messages are mostly empty. :) This is a good place to
   describe the motivation for the patch, document any design decisions,
   discuss any alternatives, etc. This is helpful for reviewers to
   understand what you're trying to achieve, and for people later who
   discover your commit from "git log".

> diff --git a/builtin/config.c b/builtin/config.c
> index d13daeeb55927..124a682d50fa8 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -80,6 +80,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
>  	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
>  	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
> +	OPT_BIT(0, "color", &actions, N_("find the color configured"), ACTION_GET_COLOR),

I think we'd want this "--color" to actually be a type, not a separate
action. I.e., so that it behaves --int, --bool, etc. Part of the goal
(well, my goal) was to make accessing color config more like other types
of config.

-Peff
