Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BAC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BF6613B1
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhHWRGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHWRGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:06:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F0C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ofXIbYSlrdjuqKClndGdEZVzz4p/z/1HNFfCiGUAYww=;
        t=1629738334; x=1630947934; b=mX2z5X7TvpY8lXyuhFhx47Mpf4iMqlp9dojUZvukfIizlZw
        VhbGsinIcEU/sxtfj5drbrLzgErQn6vw1hiwlIW2xZ9V7T6fhtFqvBL0fE8BXu+j4VtjwnCIe5cY+
        lDNtEBRKzACo72SGAlydZgbptG9DbKWyD8nQJJgOH6Cnkrfa57DivZaNTor+aTFYPW6rA3PRWVs5t
        hvIM5rLXkYyQp3zPLLiqHeGSlIVOhflfLMcX6xsEJb4qvcIyD9jzpH1iQPmlheg2OhHWH1zAya5hi
        cTOX5VQKkaFbAqwq2EHhRA7bgSkOvpI2RGuayWyZlONDk42FZGfrtbgLIdSsbpjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIDO7-00Ew4a-Vr; Mon, 23 Aug 2021 19:05:32 +0200
Message-ID: <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with
 --object-dir
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Date:   Mon, 23 Aug 2021 19:05:31 +0200
In-Reply-To: <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
References: <20210823094049.44136-1-johannes@sipsolutions.net>
         <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 12:06 -0400, Jeff King wrote:
> On Mon, Aug 23, 2021 at 11:40:49AM +0200, Johannes Berg wrote:
> 
> > If using --object-dir to point into a repo while the current
> > working dir is outside, such as
> > 
> >   git init /repo
> >   git -C /repo ... # add some objects
> >   cd /non-repo
> >   git multi-pack-index --object-dir /repo/.git/objects/ write
> > 
> > the binary will segfault trying to access the object-dir via
> > the repo it found, but that's not fully initialized. Fix it
> > to use the object_dir properly to clean up the *.rev files,
> > this avoids the crash and cleans up the *.rev files for the
> > now rewritten multi-pack-index properly.
> 
> I'm not entirely convinced that writing a midx when not "inside" a repo
> is something that we want to support. But if we do, then...

Seemed like that was the point of --object-dir?

johannes

