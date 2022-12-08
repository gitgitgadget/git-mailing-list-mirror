Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3881C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 06:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHGkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 01:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHGkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 01:40:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17654347
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 22:40:18 -0800 (PST)
Received: (qmail 22863 invoked by uid 109); 8 Dec 2022 06:40:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 06:40:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9616 invoked by uid 111); 8 Dec 2022 06:40:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 01:40:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 01:40:16 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
Message-ID: <Y5GG0HT7V36vinb8@coredump.intra.peff.net>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
 <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
 <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
 <4d4e02c3-89dc-8372-7e8a-7ec76fdd6f4e@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d4e02c3-89dc-8372-7e8a-7ec76fdd6f4e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 10:54:31AM -0500, Derrick Stolee wrote:

> On 12/7/2022 10:27 AM, Derrick Stolee wrote:
> > On 12/7/2022 7:57 AM, Jeff King wrote:
> 
> >> There are a couple other unused parameters in this series, too, but they
> >> are all in virtual functions and must be kept. I'll add them to my list
> >> of annotations.
> > 
> > Your UNUSED annotations exist in my tree, so I'll try my best to update
> > them in the next version.
> 
> One of these showed an example where I should have been using
> repo_config_...() instead of git_config_...(). Thanks!

Oh good. It is always satisfying when the warning finds a potential bug,
as it sometimes feels a bit like annotation make-work. ;)

In this instance we're in server-side v2 protocol code, which is already
very global-heavy in its world-view. So I don't think it's a real bug
here, but just a nice-to-have.

I have seen this "oops, we don't really use our repository parameter"
issue in a few places. And while I do think it's best to use it if you
have it, I suspect it's the tip of the iceberg in terms of functions
using the_repository. In the long run, I think we'll really smoke those
out from the bottom up, as more functions insist on taking a repository
parameter (and then their callers will have to switch or face the
embarrassment of passing the_repository themselves, and so on).

All of which is to say that yes, that is a fine change to make. But I
don't consider at all urgent in this instance.

-Peff
