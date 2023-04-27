Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F713C77B7E
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbjD0QqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbjD0QqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:46:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B674C12
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:46:12 -0700 (PDT)
Received: (qmail 23934 invoked by uid 109); 27 Apr 2023 16:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 16:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20877 invoked by uid 111); 27 Apr 2023 16:46:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 12:46:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 12:46:11 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230427164611.GA1976451@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
 <20230427081715.GA1478467@coredump.intra.peff.net>
 <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
 <ad4f927f-607a-5391-ce50-a342d09934d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4f927f-607a-5391-ce50-a342d09934d6@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 12:55:26PM +0100, Phillip Wood wrote:

> On 27/04/2023 11:11, Phillip Wood wrote:
> 
> > > +    test_commit 1234567890 &&
> > > +    git cat-file commit HEAD >commit.orig &&
> > > +    sed "s/>.*/>    /" <commit.orig >commit.munge &&
> > > +    ws_commit=$(git hash-object --literally -w -t commit
> > > commit.munge) &&
> > > +    sed "s/>.*/>   $(printf "\013")/" <commit.orig >commit.munge &&
> > 
> > Does the shell eat the '\v' when it trims trailing whitespace from the
> > command substitution (I can't remember the rules off the top of my
> > head)?
> 
> Having looked it up, the shell trims newlines but not other whitespace so
> this should be fine.

Yep. I also wondered if some sed versions might complain. But it's
really not that much more exotic than a tab, so it's probably OK.

-Peff
