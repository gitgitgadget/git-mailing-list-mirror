Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EADC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA66061263
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEMH2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:28:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:53318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhEMH2E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:28:04 -0400
Received: (qmail 32412 invoked by uid 109); 13 May 2021 07:26:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 07:26:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13775 invoked by uid 111); 13 May 2021 07:26:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 03:26:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 03:26:53 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Message-ID: <YJzUvZjzSYuKcsTr@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
 <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
 <609ccf688a4e7_329320879@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <609ccf688a4e7_329320879@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 02:04:08AM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > It is a bit unfortunate to have to go through these contortions, but
> > this is definitely the best we can do for now. I think in the long run
> > it would be nice to have a "--stdin" mode for git-config, where we could
> > do something like:
> > 
> >   git config --stdin <<\EOF
> >   key=foo.bar
> >   type=bool
> >   default=false
> > 
> >   key=another.key
> >   type=color
> >   default=red
> >   EOF
> 
> Why do we even have to specify the type? Shouldn't there be a registry
> of configurations (a schema), so that all users don't have to do this?

One of the purposes of git-config is to serve third-party scripts that
store their own config keys that Git does not know about. So we can't
know the set of all possible types that will be asked about.

Obviously we could have git-config know internally about all of the keys
other parts of Git would ask about. But generally we have pushed that
knowledge out to the users of the keys, rather than any kind of central
registry.

-Peff
