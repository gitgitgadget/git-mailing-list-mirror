Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF412C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904F56101D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGNVjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:39:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhGNVjC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 17:39:02 -0400
Received: (qmail 32766 invoked by uid 109); 14 Jul 2021 21:36:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 21:36:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28445 invoked by uid 111); 14 Jul 2021 21:36:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 17:36:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 17:36:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: GIT_CONFIG and user.email/name
Message-ID: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
References: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
 <YO8ordiN18sNP6tA@coredump.intra.peff.net>
 <xmqqeec0vczo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeec0vczo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:47:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The GIT_CONFIG variable doesn't work that way. It is not a general
> > mechanism used by all of Git, but rather a specific feature of the
> > git-config program (and even there it is a historical wart; you should
> > use "git config --file" instead).
> 
> We both have known that, but a fresh re-read of GIT_CONFIG in "git
> help config" gave me a misleading impression.
> 
>     ENVIRONMENT
>     -----------
> 
>     GIT_CONFIG::
>             Take the configuration from the given file instead of .git/config.
>             Using the "--global" option forces this to ~/.gitconfig. Using the
>             "--system" option forces this to $(prefix)/etc/gitconfig.
> 
> is what we have above the GLOBAL and SYSTEM you quoted below.  We
> should say GIT_CONFIG is only for "git config" command while the
> other two affects everybody, right?

Yes, it looks like that description is from 2007 (when GIT_CONFIG really
did impact other commands). And adding GIT_CONFIG_GLOBAL and SYSTEM
nearby certainly didn't help (before then, I might have argued that
since GIT_CONFIG is only in git-config(1), it is more clear that it only
applies there).

Here's a short series to improve things.

  [1/3]: doc/git-config: explain --file instead of referring to GIT_CONFIG
  [2/3]: doc/git-config: clarify GIT_CONFIG environment variable
  [3/3]: doc/git-config: simplify "override" advice for FILES section

 Documentation/git-config.txt | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-Peff
