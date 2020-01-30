Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62CC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C55D206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgA3IXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:23:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726757AbgA3IXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 03:23:55 -0500
Received: (qmail 22634 invoked by uid 109); 30 Jan 2020 08:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 08:23:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21822 invoked by uid 111); 30 Jan 2020 08:31:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 03:31:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 03:23:53 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: packObjectsHook and the git executable
Message-ID: <20200130082353.GA3442119@coredump.intra.peff.net>
References: <CAGyf7-E==gzsvP-ckK0kwHD+f9pMmLBVpL4y2rC9tqk7ZiuW1g@mail.gmail.com>
 <20200130071102.GA2189233@coredump.intra.peff.net>
 <CAGyf7-HkUV43A79DKiDVvKnW5vuwsFz0KnZKj9bBQYc906VONg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-HkUV43A79DKiDVvKnW5vuwsFz0KnZKj9bBQYc906VONg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 11:38:23PM -0800, Bryan Turner wrote:

> I suspect it's a case of a broken Git build. Not that Git is doing
> anything wrong, or has any problems with its build, to be clear--I
> mean instead that someone ran a local build and didn't set it up
> "right". Correct me if I'm wrong but:
> - If the GIT_EXEC_PATH environment variable isn't set, Git will use
> the path that was compiled in when it was built
> - If that Git is installed in a different path (i.e. compiled for
> /usr/local but installed in /opt), the compiled-in exec path may not
> exist or not contain "git"
> - In that case, "git" gets run from wherever it's found in $PATH and
> you get whatever version that happens to be
> 
> Does something like that seem like it could happen?

Yes, that's quite plausible. One easy way to trigger that is to run Git
out of the build directory without a "make install". That's why we have
the bin-wrappers/ subdirectory, which sets up the exec-path to use the
built-but-not-installed version (and that's what we use when running the
test suite).

-Peff
