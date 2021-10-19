Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1081FC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9D16101A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJSVdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:33:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:41982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhJSVdW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 17:33:22 -0400
Received: (qmail 7462 invoked by uid 109); 19 Oct 2021 21:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 21:31:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15432 invoked by uid 111); 19 Oct 2021 21:31:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 17:31:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 17:31:06 -0400
From:   Jeff King <peff@peff.net>
To:     BARDOT =?utf-8?B?SsOpcsO0bWU=?= <bardot.jerome@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Questions, improvements
Message-ID: <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 07:38:16PM +0200, BARDOT Jérôme wrote:

> 1)
> 
> Why git not embed by default some gitinore rules (and can be "disable"
> after).
> All the time i have to add all operating system stuff, all editor stuff.

I think you may have a hard time getting people to agree on what should
go into those rules. ;)

But you may find core.excludesFile (documented in "git help config")
helpful. You can set up your personal set of files once, and they will
be used in every repository.

> 2)
> 
> I need a domain name / uri / ip base way to choose auth information.
> i find some examples in past but not as smart as what i want. (Maybe i
> miss something)
> 
> 3)
> 
> For auth client side can we use tools like Pass and or identity manager.

I'm not entirely sure I understand your questions here, but I think
you're looking for credential helpers? Try "git help credentials" for an
overview.

There are helpers which interact with common OS secure storage systems
(like osxkeychain, libsecret, etc). But you can also write your own
little scripts, and restrict them based on URLs.

So for instance I use this config to pull a GitHub PAT out of the "pass"
tool:

  [credential "https://github.com"]
  username = peff
  helper = "!f() { test $1 = get && echo password=`pass github/token`; }; f"

-Peff
