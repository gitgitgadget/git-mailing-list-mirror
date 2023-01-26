Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4293C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 11:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjAZLgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjAZLgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 06:36:04 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103093A876
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 03:36:03 -0800 (PST)
Received: (qmail 20904 invoked by uid 109); 26 Jan 2023 11:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 11:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22918 invoked by uid 111); 26 Jan 2023 11:36:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 06:36:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 06:36:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
Message-ID: <Y9JlouutFD21lvna@coredump.intra.peff.net>
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
 <230123.86a629tzgc.gmgdl@evledraar.gmail.com>
 <b4b48877-5b80-e96f-d09f-2fe275f42950@web.de>
 <xmqqmt67fysf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmt67fysf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 12:44:16PM -0800, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > ...  It's basically harmless.  Perhaps
> > we just need a comment stating that, to contain the urge to "fix" this.
> 
> Yeah, especially since fsck finds and warns about bad mode with
> FSCK_MSG_BAD_FILEMODE and also FSCK_MSG_ZERO_PADDED_FILEMODE in a
> separate codepath, adding another piece of code that checks a
> slightly different condition does not sound like a good idea.

Yeah, I'm happy to drop this whole thing. I do think it would be
reasonable for fsck to check for overflow alongside BAD_FILEMODE, etc,
but it's annoying to do since we are relying on the existing parser.

I actually have a suspicion that it might be reasonable for fsck to just
parse the trees itself, rather than relying on decode_tree_entry(), etc.
But that's a much bigger topic (and a possible maintenance burden) for
questionable gain, so unless we find some compelling reason (some case
that we really want to detect but which we want the regular decoder to
ignore), it's probably not worth exploring.

-Peff
