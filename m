Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A8520248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCRVRk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:17:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:55478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727055AbfCRVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:17:40 -0400
Received: (qmail 10295 invoked by uid 109); 18 Mar 2019 21:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23786 invoked by uid 111); 18 Mar 2019 21:18:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:18:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:17:38 -0400
Date:   Mon, 18 Mar 2019 17:17:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QmrDtnJu?= Kautler <Bjoern@kautler.net>
Cc:     git@vger.kernel.org
Subject: Re: fast-import should fail on invalid unsupported paths
Message-ID: <20190318211737.GC29661@sigill.intra.peff.net>
References: <CAKChYSo9x5k0Ly2CNs5tbZ+jMdxBmDLZ9gm_645pwXZsCQ4ySg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKChYSo9x5k0Ly2CNs5tbZ+jMdxBmDLZ9gm_645pwXZsCQ4ySg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 06:28:16PM +0100, Björn Kautler wrote:

> I think fast-import should refuse to import paths Git cannot handle
> properly later on, so that the migration fails early and the frontend
> that generates the fast-import stream can be fixed / configured to not
> include such invalid paths.

Yeah, that seems quite sensible to me[1].

If you (or anybody else) are interested in working on this, I suspect
the answer is to just sprinkle some calls to verify_path() in the right
spots. Probably in fast-import.c:file_change_m(), etc.

-Peff

[1] Stretching to think of a way this might backfire, I guess somebody
    could be using Git as an intermediate format to then convert to
    another system. But that seems terribly obscure, and at most I think
    we should give that case an escape hatch to disable the check; it
    should definitely be on by default.
