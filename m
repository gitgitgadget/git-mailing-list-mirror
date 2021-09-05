Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE078C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59E260F22
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 12:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhIEMuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 08:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:39724 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhIEMuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 08:50:18 -0400
Received: (qmail 8627 invoked by uid 109); 5 Sep 2021 12:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Sep 2021 12:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22634 invoked by uid 111); 5 Sep 2021 12:49:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Sep 2021 08:49:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Sep 2021 08:49:14 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
Message-ID: <YTS8yiYwR+eeZf4+@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 05, 2021 at 04:19:53PM +0800, ZheNing Hu wrote:

> > In this version there are 2 patches, tested against 'git for-each-ref
> > --format="%(objectname) %(refname)"' on a fully packed repo with 500k
> > refs:
> >
> 
> Regarding this 500k refs, is there any way I can reproduce it?

Try this in a clone of linux.git (or any other repo):

  git rev-list HEAD |
  head -500000 |
  perl -lne 'print "create refs/foo/$. $_"' |
  git update-ref --stdin

  git pack-refs --all --prune

Though I actually think for these tests that it is not important that
each ref point to a unique commit (we are not opening up the objects at
all, and just treating the oids as strings).

-Peff
