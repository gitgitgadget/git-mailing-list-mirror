Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A5C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 19:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIHTXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 15:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIHTXc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 15:23:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE025FF
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 12:23:31 -0700 (PDT)
Received: (qmail 28587 invoked by uid 109); 8 Sep 2022 19:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 19:23:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23801 invoked by uid 111); 8 Sep 2022 19:23:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 15:23:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 15:23:29 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: [PATCH 0/2] v2 protocol can't "git pull" with restricted refspec
Message-ID: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
 <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev>
 <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
 <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
 <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
 <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 02:14:07PM -0400, Jeff King wrote:

> This is a bug which we should fix. But in the meantime the obvious
> workaround is to expand the default refspec to cover both branches.
> Obviously the default of fetching "refs/heads/*" would work, but if you
> want to keep it limited for some reason, you can add the second branch
> explicitly. In the example above, it would be:
> 
>   git config --add remote.origin.fetch +refs/heads/branch2:refs/remotes/origin/branch2

And here's the patch to fix it. There was a small cleanup needed, hence
the 2-patch series.

  [1/2]: fetch: stop checking for NULL transport->remote in do_fetch()
  [2/2]: fetch: add branch.*.merge to default ref-prefix extension

 builtin/fetch.c | 18 +++++++++++++++---
 t/t5520-pull.sh | 17 +++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

-Peff
