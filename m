Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24FC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B47020773
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 05:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCTFlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:41:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726030AbgCTFlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 01:41:03 -0400
Received: (qmail 31015 invoked by uid 109); 20 Mar 2020 05:41:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Mar 2020 05:41:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3053 invoked by uid 111); 20 Mar 2020 05:50:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2020 01:50:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Mar 2020 01:41:01 -0400
From:   Jeff King <peff@peff.net>
To:     Timothee Cour <timothee.cour2@gmail.com>
Cc:     Eric Wong <e@yhbt.net>, git@vger.kernel.org
Subject: Re: git makes it impossible to ignore or override global gitconfig,
 needs `GITCONFIGFILE`
Message-ID: <20200320054101.GF499858@coredump.intra.peff.net>
References: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
 <20200319064407.GA26408@dcvr>
 <20200319165149.GA4074934@coredump.intra.peff.net>
 <CANri+EzrP0TeHTfjhsf=LZkwkEZU7fSRnnKN9NLga7CNow9F0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANri+EzrP0TeHTfjhsf=LZkwkEZU7fSRnnKN9NLga7CNow9F0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 07:28:58PM -0700, Timothee Cour wrote:

> * require passing commands (eg `git -c`) is not good either; it'd
> require updating scripts that rely on git (this could be arbitrarily
> complex, sometimes impossible if you just have a binary and no source
> code access)

Well, yes, that's why I suggested setting $GIT_CONFIG_PARAMETERS
directly. :)

That said, I don't have any real opposition to an environment variable
to override the user-level config location, if somebody wants to work up
a patch. A few preliminary thoughts:

 - there are several levels of config file, so it probably should be
   called GIT_GLOBAL_CONFIG or something to make it clear that it
   matches "config --global" (and not system or repo-level config)

 - we'll read user-level config from multiple sources currently:
   ~/.gitconfig and the xdg config dir. Presumably this would override
   them rather than add to them to be of any use.

 - I wondered for a moment if such a variable would need to be added to
   local_repo_env[] to get cleared when moving between repos. But as a
   user-level thing, it should be outside that.

-Peff
