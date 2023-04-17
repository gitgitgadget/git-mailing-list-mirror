Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06437C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 07:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjDQHm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjDQHmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 03:42:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C44488
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 00:41:47 -0700 (PDT)
Received: (qmail 21772 invoked by uid 109); 17 Apr 2023 07:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Apr 2023 07:41:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22215 invoked by uid 111); 17 Apr 2023 07:41:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Apr 2023 03:41:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Apr 2023 03:41:36 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230417074136.GB39931@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
 <20230417054032.GA26997@coredump.intra.peff.net>
 <b517d7ca-4b8f-487b-8836-8966a2a9d9ee@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b517d7ca-4b8f-487b-8836-8966a2a9d9ee@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 08:20:30AM +0200, Kristoffer Haugsbakk wrote:

> > The problem with repairing them is that it rewrites history, changing
> > the object id of every commit which comes after.  So you'd want to do it
> > once centrally for the project, and declare a flag day that everybody is
> > moving over to the new, fixed history.
> 
> I wasn’t interested in fixing the repo for future development. Just to
> see if that weird git-log(1) behavior went away. It’s like the inverse
> of a minimal example to reproduce a bug; repair the corrupt object so
> that future askers can be convinced that it’s not a bug. ;)

Ah, OK. Carry on, then. ;)

I'm 99% sure it would indeed go away, since the patch I showed earlier
(to make the parsing more lenient) worked. But if you want to try, I
suspect you could do it with git-filter-repo's --commit-callback option.
Or if you don't mind being a little loose with the parsing, probably
just piping fast-export through sed, and then back to fast-import.

-Peff
