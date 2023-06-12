Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B0AC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjFLDOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjFLDOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:14:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78EC4
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:14:27 -0700 (PDT)
Received: (qmail 21733 invoked by uid 109); 12 Jun 2023 03:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:14:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11589 invoked by uid 111); 12 Jun 2023 03:14:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:14:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:14:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 02/11] config: fix a leak in
 git_config_copy_or_rename_section_in_file
Message-ID: <20230612031425.GB306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <2ce6f067-9d02-2a10-5eb9-6820e66f0b84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ce6f067-9d02-2a10-5eb9-6820e66f0b84@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:49:28PM +0200, Rubén Justo wrote:

> In 52d59cc645 (branch: add a --copy (-c) option to go with --move (-m),
> 2017-06-18) a new strbuf variable was introduced, but not released.
> 
> Thus, when copying a branch that has any configuration, we have a
> leak.
> 
>    $ git branch foo
>    $ git config branch.foo.some-key some_value
>    $ git branch -c foo bar

Looks good. Thanks for digging up the commit which introduced the
problem. I always find that gives me more confidence that the leak is
just a simple "oops, we forgot to free", and there isn't something more
subtle going on.

-Peff
