Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DAAC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 07:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65C32146E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 07:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfLQHdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:33:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:48356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfLQHdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 02:33:07 -0500
Received: (qmail 30489 invoked by uid 109); 17 Dec 2019 07:33:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Dec 2019 07:33:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20531 invoked by uid 111); 17 Dec 2019 07:37:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Dec 2019 02:37:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Dec 2019 02:33:06 -0500
From:   Jeff King <peff@peff.net>
To:     Mikael Simonsson <m@mikaelsimonsson.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Bug? git commit fileA tries to delete fileB and other oddities
Message-ID: <20191217073306.GA3313061@coredump.intra.peff.net>
References: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912152209020.46@tvgsbejvaqbjf.bet>
 <CA+PLxnWLWckpZdjy8XQLbO0EVJ1khiyUYi1T=Mcy_rBkvbLpZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+PLxnWLWckpZdjy8XQLbO0EVJ1khiyUYi1T=Mcy_rBkvbLpZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 09:50:33AM +0000, Mikael Simonsson wrote:

> I will try to recreate the problem with a new repository.
> 
> So far I think I've narrowed it down to a bug introduced in git 2.20.0.
> 
> Not buggy:
> [...]

If you can build Git from source, you might try using "git bisect" to
find the exact commit where the problem starts.

> The buggy versions all try to delete fileX when running "git commit fileA":
> 
> % git commit fileA
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> #
> # On branch master
> # Your branch is up to date with 'origin/master'.
> #
> # Changes to be committed:
> #       deleted:    fileX
> #       modified:   fileA
> #
> # Changes not staged for commit:

Is there anything about "fileX" and "fileA"'s names that might be
relevant? E.g., might they case-fold to the same name or something?

-Peff
