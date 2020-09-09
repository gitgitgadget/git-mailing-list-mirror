Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62502C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A1120708
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgIIJL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:11:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51872 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIIJLx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:11:53 -0400
Received: (qmail 3397 invoked by uid 109); 9 Sep 2020 09:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 09:11:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32148 invoked by uid 111); 9 Sep 2020 09:11:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 05:11:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 05:11:49 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
Message-ID: <20200909091149.GB2496536@coredump.intra.peff.net>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 03:07:34PM -0400, Derrick Stolee wrote:

> This message could also mention 14438c4 (introduce hasheq() and
> oideq(), 2018-08-28) which introduced oideq().
> 
> This use of !oidcmp() was introduced by 0906ac2b (blame: use
> changed-path Bloom filters, 2020-04-16). My bad. There is no
> good reason to introduce this use since it is well after the
> oideq() method was introduced.
> 
> > @@ -1353,8 +1353,8 @@ static struct blame_origin *find_origin(struct repository *r,
> >  	else {
> >  		int compute_diff = 1;
> >  		if (origin->commit->parents &&
> > -		    !oidcmp(&parent->object.oid,
> > -			    &origin->commit->parents->item->object.oid))
> > +		    oideq(&parent->object.oid,
> > +			  &origin->commit->parents->item->object.oid))
> >  			compute_diff = maybe_changed_path(r, origin, bd);
> 
> The code itself looks correct.

Yeah, it looks obviously correct. I am puzzled why "make coccicheck"
doesn't find this, though. +cc René, as my favorite target for
coccinelle nerd-snipes. :)

(But clearly we should make the change with or without figuring out the
coccinelle part).

-Peff
