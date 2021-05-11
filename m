Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA98161168
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhEKSSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:18:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:18:16 -0400
Received: (qmail 23951 invoked by uid 109); 11 May 2021 18:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 18:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26216 invoked by uid 111); 11 May 2021 18:17:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 14:17:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 14:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Syntax for specifying a command in git config
Message-ID: <YJrKJAa45mNIL+rf@coredump.intra.peff.net>
References: <YJrH8uqzapnpNEsb@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJrH8uqzapnpNEsb@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:07:46PM -0600, Gregory Anders wrote:

> Certain git config parameters (notably sendemail.smtpServer) expect an
> absolute path in order to use a command. If the value begins with a / git
> interprets it as a command; otherwise, it's interpreted it as a server
> hostname.
> 
> Using an absolute path is not very portable, however. If I want to have a
> common shared config file across multiple machines, each of which uses a
> command for smtpServer (e.g. msmtp) but installed at different locations, I
> have to modify the config file on each machine to update the absolute path.
> 
> Obviously this is not a *huge* deal, but it is a minor annoyance. I'm
> wondering if it would be possible to add a new syntax to config options like
> this. For example,
> 
>     [sendemail]
>             smtpServer = !msmtp
> 
> The leading ! character says "the following value is a command that should
> be looked up in PATH". This is congruent with alias definitions, where the
> leading ! means to run the following value as a command directly instead of
> as a git subcommand.
> 
> This also is unambiguous since server hostnames will never begin with a !
> character.

IMHO this is a good path forward. There's a thread from a few months ago
which talks about this idea:

  https://lore.kernel.org/git/YCvotU6KVruFuf9%2F@coredump.intra.peff.net/

There's some back and forth, and I'm not sure if I convinced Junio in
the end. But certainly a patch would be a good way to restart the
conversation. :)

-Peff
