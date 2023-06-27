Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3EC001DE
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjF0Ifo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjF0If2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:35:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB6DD
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:35:27 -0700 (PDT)
Received: (qmail 2502 invoked by uid 109); 27 Jun 2023 08:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:35:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15082 invoked by uid 111); 27 Jun 2023 08:35:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:35:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:35:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] replace strbuf_expand_dict_cb() with
 strbuf_expand_step()
Message-ID: <20230627083526.GA1273865@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <5ce9513b-d463-6f62-db4e-f9f60a7c3e9f@web.de>
 <20230627082902.GI1226768@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627082902.GI1226768@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 04:29:02AM -0400, Jeff King wrote:

> Your comment above does make me wonder if strbuf_expand_step() should be
> quietly handling "%%" itself. But I guess strbuf_expand() doesn't, and
> your branch.c quote-literal example probably would not want that
> behavior.

Er, nope, strbuf_expand() does handle "%%" itself. It really feels like
we'd want strbuf_expand_step() to do so, too, then. Even if we had two
variants (a "raw" one which doesn't handle "%%" so that branch.c could
use it, and then another that wrapped it to handle "%%").

-Peff
