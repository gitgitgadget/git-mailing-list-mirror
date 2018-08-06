Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1BF208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 13:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeHFPvt (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 11:51:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727112AbeHFPvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 11:51:49 -0400
Received: (qmail 9043 invoked by uid 109); 6 Aug 2018 13:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 13:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25380 invoked by uid 111); 6 Aug 2018 13:42:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 09:42:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 09:42:38 -0400
Date:   Mon, 6 Aug 2018 09:42:38 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806134237.GB31282@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180805204930.GA202464@genre.crustytoothpaste.net>
 <20180806133954.GA31282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806133954.GA31282@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 09:39:55AM -0400, Jeff King wrote:

>   3. Default to number of CPUs, which is what a lot of other threading
>      in Git does. Unfortunately getting that from the shell is
>      non-trivial. I'm OK with $(grep -c ^processor /proc/cpuinfo), but
>      people on non-Linux platforms would have to fill in their own
>      implementation.

Is this too horrible to contemplate?

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0f09bbbf65..fa8caeec0c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -635,6 +635,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--online-cpus")) {
+			printf("%d", online_cpus());
+			continue;
+		}
+
 		/* The rest of the options require a git repository. */
 		if (!did_repo_setup) {
 			prefix = setup_git_directory();

-Peff
