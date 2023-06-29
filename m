Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D0EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjF2Im3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjF2IlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99C1995
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 01:39:02 -0700 (PDT)
Received: (qmail 1081 invoked by uid 109); 29 Jun 2023 08:39:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jun 2023 08:39:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5755 invoked by uid 111); 29 Jun 2023 08:39:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jun 2023 04:39:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jun 2023 04:38:59 -0400
From:   Jeff King <peff@peff.net>
To:     Tiago d'Almeida <tjamadeira@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: index.skipHash doesn't work with split index, was Re: Bug Report
Message-ID: <20230629083859.GA585934@coredump.intra.peff.net>
References: <CAO=RawtAvOna1xrBNY+T-fo4UQe-ipC6OvFODvOSdu4wUML3Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO=RawtAvOna1xrBNY+T-fo4UQe-ipC6OvFODvOSdu4wUML3Ng@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 05:02:30PM +0100, Tiago d'Almeida wrote:

> Attached to this email follow the `git bugreport` and global `config`
> files, and the git_bug repo.

Thanks for providing your config; it was very important to reproducing.
The bug comes from the combination of "core.splitIndex" and
"index.skipHash" (the latter is triggered in your config by
"feature.manyFiles").

Here's a quick reproduction:

  git init repo
  cd repo
  touch file
  git -c core.splitIndex=true -c index.skipHash=true add file

That should add "file" to the index but doesn't. Removing either the
splitIndex option or the skipHash option makes it work. I didn't dig
further than that.

Adding the author of skipHash to the cc.

-Peff
