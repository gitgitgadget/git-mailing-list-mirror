Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A84C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJKAsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:48:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9467B1E0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:48:51 -0700 (PDT)
Received: (qmail 29829 invoked by uid 109); 11 Oct 2022 00:48:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:48:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15764 invoked by uid 111); 11 Oct 2022 00:48:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:48:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:48:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 2/7] shortlog: accept `--date`-related options
Message-ID: <Y0S9cZBiLL3GuWm0@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <b587b8ea4ab593806b9fb6d1db8751591991455b.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b587b8ea4ab593806b9fb6d1db8751591991455b.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:05PM -0400, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> Prepare for the future patch which will introduce arbitrary pretty
> formats via the `--group` argument.
> 
> To allow additional customizability (for example, to support something
> like `git shortlog -s --group='%aD' --date='format:%Y-%m' ...` (which
> groups commits by the datestring 'YYYY-mm' according to author date), we
> must store off the `--date` parsed from calling `parse_revision_opt()`.

Sorry, I haven't had a chance yet to look carefully at the rest of the
shortlog discussion, but I wanted to note here: this patch also affects
custom output formats. So:

  - we probably want to note that in the commit message as a limitation
    of this, versus something like %(authordate:format=...). I think
    that's fine, as the same limitation already applies to multiple
    dates in a single format string.

  - it's arguably a bug-fix, and can be tested in isolation like:

       git shortlog --format='%ad %s' --date=short

    which currently ignores the --date option entirely.

-Peff
