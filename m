Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C283C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612A661246
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhI1Sr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:47:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:56892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhI1Sr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:47:56 -0400
Received: (qmail 10739 invoked by uid 109); 28 Sep 2021 18:46:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 18:46:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2385 invoked by uid 111); 28 Sep 2021 18:46:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 14:46:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 14:46:15 -0400
From:   Jeff King <peff@peff.net>
To:     Joey Hess <joeyh@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] avoid insecure use of mail in man page example
Message-ID: <YVNi91WYyj3Le6UF@coredump.intra.peff.net>
References: <20210928121648.1390915-1-joeyh@joeyh.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210928121648.1390915-1-joeyh@joeyh.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 08:16:48AM -0400, Joey Hess wrote:

> As recently seen in fail2ban's security hole (CVE-2021-32749),
> piping user controlled input to mail is exploitable,
> since a line starting with "~! foo" in the input will run command foo.
> 
> This example on the man page pipes to mail. It may not be exploitable.
> git rev-list --pretty indents commit messages, which prevents the escape
> sequence working there. It's less clear if it might be possible to embed
> the escape sequence in a signed push certificate. The user reading the
> man page might alter the example to do something more exploitable.
> To encourage safe use of mail, add -E 'set escape'

Seems like a good goal, but is "-E" portable?

On my system, where "mail" comes from the bsd-mailx package, "-E" means
"do not send a message with an empty body" and your example command
barfs as it tries to deliver to the recipient "set escape".

At least we'd want to make a note in the documentation saying what the
mysterious "set escape" is doing, and that not all versions of mail
would need / want it.

-Peff
