Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065F4C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDD320809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2Sav (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:30:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:41354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Sau (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:30:50 -0400
Received: (qmail 8200 invoked by uid 109); 29 Jul 2020 18:30:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 18:30:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7115 invoked by uid 111); 29 Jul 2020 18:30:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 14:30:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 14:30:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract
 "-m"
Message-ID: <20200729183049.GA2340161@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200728163853.GB2650252@coredump.intra.peff.net>
 <xmqqv9i7cq1k.fsf@gitster.c.googlers.com>
 <20200729182206.GA2339835@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729182206.GA2339835@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 02:22:07PM -0400, Jeff King wrote:

> After thinking on it more, I flipped it to:
> 
>   -m::
>   --diff-merges::
>      [existing text...]
> 
> and then I don't think we need to have another block for
> --no-diff-merges.
> 
> I'll likewise add a statement that "-m" is implied by "--first-parent"
> and can be counteracted with the "--no" form, which I think should spell
> out all the implications of the series.

Hmm, I take that back. I tried adding this:

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0785a0cfe9..41c859e63f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1154,7 +1154,9 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 	and diff is generated. An exception is that only diff against
 	the first parent is shown when `--first-parent` option is given;
 	in that case, the output represents the changes the merge
-	brought _into_ the then-current branch.
+	brought _into_ the then-current branch. Note that
+	`--first-parent` implies `-m` if no combined-diff option is
+	enabled; you can use `--no-diff-merges` to override that.
 
 -r::
 	Show recursive diffs.

but then I'm left wondering: why would you ever want to override it? I
added the option as an escape hatch in case anybody really needed the
old behavior. But I have trouble imagining a scenario where that is the
case, and I wonder if it is even worth advertising.

-Peff
