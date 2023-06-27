Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EFEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjF0IbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjF0Iav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:30:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361B358B
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:29:44 -0700 (PDT)
Received: (qmail 2079 invoked by uid 109); 27 Jun 2023 08:29:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:29:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14976 invoked by uid 111); 27 Jun 2023 08:29:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:29:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:29:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] replace strbuf_expand_dict_cb() with
 strbuf_expand_step()
Message-ID: <20230627082902.GI1226768@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <5ce9513b-d463-6f62-db4e-f9f60a7c3e9f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ce9513b-d463-6f62-db4e-f9f60a7c3e9f@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 10:42:26PM +0200, René Scharfe wrote:

> Avoid the overhead of setting up a dictionary and passing it via
> strbuf_expand() to strbuf_expand_dict_cb() by using strbuf_expand_step()
> in a loop instead.  It requires explicit handling of %% and unrecognized
> placeholders, but is more direct and simpler overall, and expands only
> on demand.

Great. I think even replacing the dictionary with regular
strbuf_expand() would be an improvement in terms of the on-demand
loading. But I am happy to see it go all the way to the iterative
version. :)

Your comment above does make me wonder if strbuf_expand_step() should be
quietly handling "%%" itself. But I guess strbuf_expand() doesn't, and
your branch.c quote-literal example probably would not want that
behavior.

-Peff
