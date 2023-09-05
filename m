Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DECA0FFB
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjIEQAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353688AbjIEHRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:17:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7BCC2
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:17:20 -0700 (PDT)
Received: (qmail 13697 invoked by uid 109); 5 Sep 2023 07:17:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:17:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19824 invoked by uid 111); 5 Sep 2023 07:17:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:17:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:17:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: use OPT_HIDDEN_BOOL for --peel-tag
Message-ID: <20230905071719.GF199565@coredump.intra.peff.net>
References: <5a86c8f8-fcdc-fee9-8af5-aa5ecb036d2e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a86c8f8-fcdc-fee9-8af5-aa5ecb036d2e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 08:38:34PM +0200, René Scharfe wrote:

> adfc1857bd (describe: fix --contains when a tag is given as input,
> 2013-07-18) added the option --peel-tag, defining it using a positional
> struct option initializer and a comment indicating that it's intended to
> be a hidden OPT_BOOL.  4741edd549 (Remove deprecated OPTION_BOOLEAN for
> parsing arguments, 2013-08-03) added the macro OPT_HIDDEN_BOOL, which
> allows to express this more succinctly.  Use it.

Yeah, this is a definite improvement.

OPT_HIDDEN_BOOL() itself is a little funny to me. I guess back then we
did not have the "_F" variants, but really it is just:

  OPT_BOOL_F(0, "peel-tag", &peel_tag,
	     N_("dereference tags in the input (internal use)")),
	     PARSE_OPT_HIDDEN);

which would remove one more special case (after all, being hidden is
orthogonal to the type). But there are enough of them that maybe having
a special name for this is worth it. I dunno. But we could probably
simplify the definition, at least. :)

-Peff
