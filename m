Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044271F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbeAOVmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:42:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:44426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750716AbeAOVmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:42:10 -0500
Received: (qmail 14056 invoked by uid 109); 15 Jan 2018 21:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 21:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20060 invoked by uid 111); 15 Jan 2018 21:42:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 16:42:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 16:42:08 -0500
Date:   Mon, 15 Jan 2018 16:42:08 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function
 parameter
Message-ID: <20180115214208.GD4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:

> Make valid_atom as a function parameter,
> there could be another variable further.
> Need that for further reusing of formatting logic in cat-file.c.
> 
> We do not need to allow users to pass their own valid_atom variable in
> global functions like verify_ref_format because in the end we want to
> have same set of valid atoms for all commands. But, as a first step
> of migrating, I create further another version of valid_atom
> for cat-file.

I agree in the end we'd want a single valid_atom list. It doesn't look
like we hit that end state in this series, though.

I guess I'm not quite clear on why we're not adding these new atoms to
ref-filter (and for-each-ref) right away, though. We already have the
first three (name, type, and size), and we'd just need to support
%(rest) and %(deltabase).

I think %(rest) doesn't really make sense for for-each-ref (we're not
reading any input), but it could expand to the empty string by default
(or even throw an error if the caller asks us not to support it).

IOW, the progression I'd expect in a series like this is:

  1. Teach ref-filter.c to support everything that cat-file can do.

  2. Convert cat-file to use ref-filter.c.

-Peff
