Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8EC6FA83
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIMAce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIMAcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:32:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB34E601
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:32:31 -0700 (PDT)
Received: (qmail 29495 invoked by uid 109); 13 Sep 2022 00:32:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 00:32:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19755 invoked by uid 111); 13 Sep 2022 00:32:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 20:32:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 20:32:29 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
Message-ID: <Yx/PnWnkYAuWToiz@coredump.intra.peff.net>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 08:15:33PM -0400, Jeff King wrote:

> This is a lot of new processes. Should be OK in the run-once-for-all-tests
> mode. It does make me wonder how much time regular test-lib.sh spends
> doing these tput checks for every script (at least it's not every
> snippet!).
> 
> It feels like we could build a color.sh snippet once and then include it
> in each script. But maybe that is dumb, since you could in theory build
> in one terminal and then run in another. Unlikely, but it shows that
> file dependencies are a mismatch. I guess a better match would be
> stuffing it into the environment before starting all of the tests.

I timed running the suite with and without TERM=dumb, as that is enough
to get test-lib.sh to skip running tput entirely. It doesn't seem to
make a measurable difference for me. Possibly it could on Windows, but I
don't think it's worth worrying about too much.

(If we did want to worry, "tput -S" is another option; it's not in
POSIX, but probably could be used on Windows).

And of course this was all "gee, I wonder about test-lib.sh"; it is all
orthogonal to your patch.

-Peff
