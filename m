Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D196200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbeEHSKi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:10:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:60712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932933AbeEHSKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:10:37 -0400
Received: (qmail 15679 invoked by uid 109); 8 May 2018 18:10:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 18:10:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7285 invoked by uid 111); 8 May 2018 18:10:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 14:10:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 14:10:34 -0400
Date:   Tue, 8 May 2018 14:10:34 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH 3/5] refs.c: drop dead code checking lock status in
 `delete_pseudoref()`
Message-ID: <20180508181034.GB7210@sigill.intra.peff.net>
References: <20180506141031.30204-4-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180506141031.30204-4-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 04:10:29PM +0200, Martin Ågren wrote:

> After taking the lock we check whether we got it and die otherwise. But
> since we take the lock using `LOCK_DIE_ON_ERROR`, we would already have
> died.
> 
> Unlike in the previous patch, this function is not prepared for
> indicating errors via a `strbuf err`, so let's just drop the dead code.
> Any improved error-handling can be added later.

I suspect this ought to eventually be converted to return an error, to
match the rest of the refs code. And in that sense, this is a step
backwards versus leaving the current die_errno in place and dropping the
LOCK_DIE_ON_ERROR flag. But it probably doesn't matter much either way,
and whoever does the conversion later can deal with it.

-Peff
