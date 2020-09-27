Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A8C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574B123977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgI0IIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:08:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgI0IIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:08:47 -0400
Received: (qmail 29003 invoked by uid 109); 27 Sep 2020 08:08:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:08:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3830 invoked by uid 111); 27 Sep 2020 08:08:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:08:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:08:46 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
Message-ID: <20200927080846.GD1286220@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070211.GB62741@coredump.intra.peff.net>
 <CAPig+cTfYmNAP_65RDa_fZOyuQEH65HuLs-UYSPT0yJ=s6BftA@mail.gmail.com>
 <20200927080345.GB1286220@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927080345.GB1286220@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 04:03:45AM -0400, Jeff King wrote:

> but that's pretty lengthy. We could also reword the whole thing as:
> 
>   --group=<type>::
>           Collect and collate values of type `<type>`; if no `--group`
> 	  option is given, the default is `author`:
>    - `author`, commits are grouped by author
>    - `committer`, commits are grouped by committer (the same as `-c`)
> 
> I'm not sure if that's clearer or not. The first sentence seems a bit
> opaque, but I'm not sure how to improve it.
> 
> For now (and what plan to send out in v2), I'll take your suggestion to
> just drop the phrase.

OK, I lied. After reading your other email, I ended up with:

  --group=<type>::
          Group commits based on `<type>`. If no `--group` option is
          specified, the default is `author`. `<type>` is one of:
  +
   - `author`, commits are grouped by author
   - `committer`, commits are grouped by committer (the same as `-c`)

  -c::
  --committer::
          This is an alias for `--group=committer`.

which I think works by itself, and extends nicely to trailers.

-Peff
