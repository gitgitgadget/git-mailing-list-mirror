Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C7CE7A8C
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 07:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIWHDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjIWHDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 03:03:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A22199
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 00:03:28 -0700 (PDT)
Received: (qmail 9604 invoked by uid 109); 23 Sep 2023 07:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 07:03:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24945 invoked by uid 111); 23 Sep 2023 07:03:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 03:03:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 03:03:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/6] coverity: support building on Windows
Message-ID: <20230923070327.GA1471672@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <14cdefff08244f9b5e2ee1fa2a78cfd3e58c14d2.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14cdefff08244f9b5e2ee1fa2a78cfd3e58c14d2.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:42:01AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> By adding the repository variable `ENABLE_COVERITY_SCAN_ON_OS` with a
> value, say, `["windows-latest"]`, this GitHub workflow now runs on
> Windows, allowing to analyze Windows-specific issues.

Makes sense. I figured we'd key this on COVERITY_PLATFORM itself, but I
guess we need to map Actions environments to Coverity platform names,
so starting with the Actions names makes sense.

> +# The workflow runs on `ubuntu-latest` by default. This can be overridden by setting
> +# the repository variable `ENABLE_COVERITY_SCAN_ON_OS` to a JSON string array specifying
> +# the operating systems, e.g. `["ubuntu-latest", "windows-latest"]`.

OK. I was envisioning that we'd just run on one platform, and maybe
git-for-windows would run on another. But it does not hurt to be able to
do both from one repo. I'm not sure how Coverity presents that, but it
should be able to figure out based on "version" and "platform" fields
that they are two builds of the same version (and not, say, one
overriding the other as the "latest").

-Peff
