Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE4EC8750
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjIGTJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIGTJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:09:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606B92
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:09:22 -0700 (PDT)
Received: (qmail 27168 invoked by uid 109); 7 Sep 2023 08:02:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 08:02:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24407 invoked by uid 111); 7 Sep 2023 08:02:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 04:02:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 04:02:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/8] builtin/repack.c: extract redundant pack cleanup for
 existing packs
Message-ID: <20230907080240.GD1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <7bb543fef8b140726b6b3efc2bb2cb1a6384fcd9.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bb543fef8b140726b6b3efc2bb2cb1a6384fcd9.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:48PM -0400, Taylor Blau wrote:

> To remove redundant packs at the end of a repacking operation, Git uses
> its `remove_redundant_pack()` function in a loop over the set of
> pre-existing, non-kept packs.
> 
> In a later commit, we will split this list into two, one for
> pre-existing cruft pack(s), and another for non-cruft pack(s). Prepare
> for this by factoring out the routine to loop over and delete redundant
> packs into its own function.
> 
> Instead of calling `remove_redundant_pack()` directly, we now will call
> `remove_redundant_existing_packs()`, which itself dispatches a call to
> `remove_redundant_packs_1()`. Note that the geometric repacking code
> will still call `remove_redundant_pack()` directly, but see the previous
> commit for more details.
> 
> Having `remove_redundant_packs_1()` exist as a separate function may
> seem like overkill in this patch. However, a later patch will call
> `remove_redundant_packs_1()` once over two separate lists, so this
> refactoring sets us up for that.

Heh, so this is basically the same "_1" case discussed in the earlier
patch. This commit message explains the split a bit better, IMHO. :)
(Not worth re-rolling; just thinking out loud).

-Peff
