Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C154C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 09:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCIJHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCIJGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 04:06:49 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A011CBFD
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 01:06:08 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3703C1F47D;
        Thu,  9 Mar 2023 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678352768;
        bh=O9aFb4P6zf/aP5d7xbJWvc/r8yaNjoC2mlGlOL/6VJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYALr7dzxRL6yHmLz8gYxtvazRCcjLIQxnEHeR1NGiqvmaF3AGYEYUOHbjsSwcTR+
         0lfO5Z2jyd6e4UpCPP8y66DKK4QkvaEsG4K60lbRQfr8p0Vc4prcSNOW/Tei6o/VT3
         YI3nNB+5I7y0STF6NzeidwY8ebrAq1GAcxCWJq04=
Date:   Thu, 9 Mar 2023 09:06:08 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
Message-ID: <20230309090608.M92573@dcvr>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
 <ZAmJtnLgwimRBGTb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAmJtnLgwimRBGTb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> The only downside might be performance. For sane cases, I think scanning
> the new alternates is OK. I know Eric (cc'd) has some crazy
> 100k-alternate setup (from 407532f82d, etc), but I'd expect a reprepare
> there is already expensive (we already have to re-scan every one of
> those directories for packfiles, and throw out any loose object caches).

I'm not sure if that 100k alternate thing is happening, yet...
(initial specs called for ~30k, but I figured it might grow)

If it does, I'm thinking about enhancing --batch-command, to support
`add-alternate' to dynamically add alternates while running cat-file.

Right now, my biggest use case is only 250 alternates or so.
