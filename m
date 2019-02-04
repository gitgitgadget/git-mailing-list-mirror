Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADF71F453
	for <e@80x24.org>; Mon,  4 Feb 2019 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBDX2u (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 18:28:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:32830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725900AbfBDX2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 18:28:49 -0500
Received: (qmail 9928 invoked by uid 109); 4 Feb 2019 23:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Feb 2019 23:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23803 invoked by uid 111); 4 Feb 2019 23:28:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Feb 2019 18:28:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2019 00:28:45 +0100
Date:   Tue, 5 Feb 2019 00:28:45 +0100
From:   Jeff King <peff@peff.net>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Partial clone - bad pack header?
Message-ID: <20190204232844.GA2366@sigill.intra.peff.net>
References: <CAE5ih7-Gi6i8ZRDjsVELLesTORRDxvrLYf00DYTBRFUWUmAAdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE5ih7-Gi6i8ZRDjsVELLesTORRDxvrLYf00DYTBRFUWUmAAdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 04, 2019 at 01:45:35PM +0000, Luke Diamand wrote:

> I tried to do a partial clone, but it gave me a "bad pack header". Is
> there anything I can do to debug this?
> 
> I did "git config uploadpack.allowfilter true" in my repo.
> Then I went to a scratch directory and did:
> $ git clone --filter=blob:limit=10M ssh://localhost/~/git/my_big_repo
> remote: Enumerating objects: 1619425, done.
> remote: Counting objects: 100% (1619425/1619425), done.
> remote: Compressing objects: 100% (362435/362435), done.
> remote: Total 1619425 (delta 1225623), reused 1604277 (delta 1211975)
> Receiving objects: 100% (1619425/1619425), 10.34 GiB | 35.61 MiB/s, done.
> Resolving deltas: 100% (1225623/1225623), done.
> Note: checking out 'a943f529b4781f34602f1ad5aab99a8699975c29'.
> [...]
> fatal: the remote end hung up unexpectedly
> fatal: protocol error: bad pack header
> warning: Clone succeeded, but checkout failed.

Just a guess, but does setting uploadpack.allowAnySHA1InWant to "true"
in the source repo help?

By default, upload-pack will not allow the client to request those
arbitrary blob sha1s. I thought it was _supposed_ to notice this and
complain with a nice error message, but I know I have run into cases in
the past where it does not (but never tracked it down -- this may well
be one of them).

-Peff
