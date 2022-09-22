Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A253AC6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 05:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiIVFbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 01:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIVFbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 01:31:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2367AB439
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 22:31:14 -0700 (PDT)
Received: (qmail 4681 invoked by uid 109); 22 Sep 2022 05:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 05:31:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30414 invoked by uid 111); 22 Sep 2022 05:31:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 01:31:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 01:31:13 -0400
From:   Jeff King <peff@peff.net>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: fatal: options '--bare' and '--origin foo' cannot be used
 together
Message-ID: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
References: <20220921192333.yasrvnisccuk3ivg@Lima-X2>
 <Yyvq01W/r73xfgqf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyvq01W/r73xfgqf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 12:55:47AM -0400, Jeff King wrote:

> This second case is IMHO a minor bug in the git-remote code. As
> documented in git-clone(1):
> [...]
> So probably it needs to use the "gently" version of git_config_set_multivar(),
> which avoids calling die(), and then check for a return code which
> indicates no value was found.

Actually, there is an even simpler fix. So here are two cleaned-up
patches which fix both issues you found.

  [1/2]: clone: allow "--bare" with "-o"
  [2/2]: remote: handle rename of remote without fetch refspec

 builtin/clone.c          |  3 ---
 builtin/remote.c         | 48 +++++++++++++++++++++-------------------
 t/t5505-remote.sh        | 11 +++++++++
 t/t5606-clone-options.sh |  9 ++++----
 4 files changed, 41 insertions(+), 30 deletions(-)

-Peff
