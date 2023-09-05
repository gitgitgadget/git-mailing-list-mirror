Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF3C83F2C
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjIEQA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353705AbjIEHV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:21:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C33A8
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:21:25 -0700 (PDT)
Received: (qmail 13706 invoked by uid 109); 5 Sep 2023 07:21:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:21:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19858 invoked by uid 111); 5 Sep 2023 07:21:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:21:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:21:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
Message-ID: <20230905072122.GG199565@coredump.intra.peff.net>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 08:54:54PM +0200, René Scharfe wrote:

> a91f453f64 (grep: Add --max-depth option., 2009-07-22) added the option
> --max-depth, defining it using a positional struct option initializer of
> type OPTION_INTEGER.  It also sets defval to 1 for some reason, but that
> value would only be used if the flag PARSE_OPT_OPTARG was given.
> 
> Use the macro OPT_INTEGER_F instead to standardize the definition and
> specify only the necessary values.  This also normalizes argh to N_("n")
> as a side-effect, which is OK.

This looks correct to me (and an improvement in readability). In
general, I wonder how many of the results from:

  git grep '{ OPTION'

could be converted to use the macros and end up more readable. There are
a number of OPTARG ones, which I guess can't use macros. Looks like
there are a handful of others (mostly for OPT_HIDDEN).

-Peff
