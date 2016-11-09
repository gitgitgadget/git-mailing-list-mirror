Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813412021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbcKIXNt (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:13:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:40930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbcKIXNt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:13:49 -0500
Received: (qmail 27192 invoked by uid 109); 9 Nov 2016 23:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 23:13:48 +0000
Received: (qmail 395 invoked by uid 111); 9 Nov 2016 23:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 18:14:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 18:13:46 -0500
Date:   Wed, 9 Nov 2016 18:13:46 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Dacre <mike.dacre@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git mergetool indefinite hang on version 2.10+
Message-ID: <20161109231346.poarr3i47ltkiae3@sigill.intra.peff.net>
References: <CAPd9ww_B7gCxvSuuBzH9AbnLsOF1bC_2+mfk0sVfLFF7YHWvNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPd9ww_B7gCxvSuuBzH9AbnLsOF1bC_2+mfk0sVfLFF7YHWvNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 02:54:59PM -0800, Mike Dacre wrote:

> I have no idea how to debug this. As of git version 2.10.0 git hangs
> indefinitely when I run `git mergetool`, the result is the same if I
> run `git mergetool --tool-help`.

Mergetool is a shell script. Try setting GIT_TRACE=1 in the environment
to see which git programs it's running. Of course it may be
hanging in a non-git program, too. Try:

  PATH=$(git --exec-path):$PATH
  sh -x $(which git-mergetool) --tool-help

to get a dump from the shell.

> I am on Arch Linux, with all of my software updated to the latest
> versions as of this morning. git 2.9.3 and lower works perfectly.
> 
> Any ideas?

If it works on v2.9.3 and the bug reproduces, you should be able to use
"git bisect" to find the commit that introduces the problem. There
weren't a lot of changes to the shell scripts in that time frame, so
just as a guess, it may be related to d323c6b64 (i18n: git-sh-setup.sh:
mark strings for translation, 2016-06-17), which was the only
significant change in that time.

-Peff
