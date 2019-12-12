Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D5C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472BC208C3
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLLDKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:10:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:44688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726647AbfLLDKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 22:10:05 -0500
Received: (qmail 9470 invoked by uid 109); 12 Dec 2019 03:10:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Dec 2019 03:10:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10984 invoked by uid 111); 12 Dec 2019 03:14:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Dec 2019 22:14:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Dec 2019 22:10:03 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope
Message-ID: <20191212031003.GA1196215@coredump.intra.peff.net>
References: <20191211233820.185153-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211233820.185153-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 03:38:20PM -0800, Emily Shaffer wrote:

> If a user is interacting with their config files primarily by the 'git
> config' command, using the location flags (--global, --system, etc) then
> they may be more interested to see the scope of the config file they are
> editing, rather than the filepath.

I don't mind adding this in, but I think we did discuss this same
concept when we did "config --show-origin", and ended up showing the
whole path, to help with a few cases:

  - you know you're getting a value from the "system" config, but you
    don't know where that is (e.g., because the baked-in sysconfdir path
    is something you didn't expect)

  - you're in a scope like "global", but the value actually comes from
    an included file

Of course there's a flip-side, which is that showing "/etc/gitconfig"
doesn't tell you that this is the "--system" file; the user has to infer
that themselves.

There are no callers added here, so I'm not sure exactly how the new
function is meant to be used. But I'd caution that it might be worth
showing the scope _and_ the path, instead of one or the other.

-Peff
