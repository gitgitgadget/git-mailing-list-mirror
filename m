Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8800C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjBVTwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 14:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjBVTv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 14:51:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0143906
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:51:30 -0800 (PST)
Received: (qmail 15040 invoked by uid 109); 22 Feb 2023 19:51:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Feb 2023 19:51:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11003 invoked by uid 111); 22 Feb 2023 19:51:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Feb 2023 14:51:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Feb 2023 14:51:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] archive: add --mtime
Message-ID: <Y/ZyNNMFmafz8YvE@coredump.intra.peff.net>
References: <Y+6G9n6cWRT9EKyl@google.com>
 <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de>
 <xmqqilfykhsf.fsf@gitster.g>
 <57b6643a-b9ff-3ea4-d60d-1a434d9ea75e@web.de>
 <xmqqlekrh94h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlekrh94h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 09:37:18PM -0800, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> >> This is the solution with least damage, letting the existing code to
> >> set archive_time and then discard the result and overwrite with the
> >> command line option.
> >
> > I actually like Peff's solution more, because it's short and solves the
> > specific problem of non-deterministic timestamps for tree archives.
> 
> Yes.  That would be my preference as well.  Without any UI to
> educate users about.

My biggest concern with the patch I showed is that it gives no escape
hatch if people don't like the change. Like I said earlier, I don't
think anybody has grounds to complain about the byte-for-byte output
hash changing, as it would be changing once per second. But they may
complain about the cosmetic problem.

One "escape hatch" is to tell them to use "tar -m", but I don't know how
friendly that is. The more obvious one at the Git level is to have
"--current-mtime" or something to get the old behavior. But at that
point, you may as well support "--mtime=now", which is the same amount
of work, and much more flexible.

-Peff
