Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB8EC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBHQaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHQaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:30:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8345BF9
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:30:05 -0800 (PST)
Received: (qmail 25140 invoked by uid 109); 8 Feb 2023 16:30:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Feb 2023 16:30:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 584 invoked by uid 111); 8 Feb 2023 16:30:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Feb 2023 11:30:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Feb 2023 11:30:03 -0500
From:   Jeff King <peff@peff.net>
To:     William Blevins <wblevins001@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
Message-ID: <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
 <xmqqedr0vd1l.fsf@gitster.g>
 <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 08:49:57AM -0500, William Blevins wrote:

> This still feels "weird" to me. Other pattern matching tools like grep
> and sed don't have exceptions to their behavior like this.
> 
> Can you reference the unit tests that verifies this specific behavior?

See commit 631f0f8c4b (ls-remote: do not send ref prefixes for patterns,
2018-10-31), which also adds a test. However, it was just handling
existing behavior (which in fact confused another developer and caused a
bug which the commit was fixing!).

I think the tail-matching behavior is not what we would probably choose
today, but that is how it has behaved since 2005, and we are not going
to break backwards compatibility in a plumbing tool like ls-remote.

There's some discussion in this thread about adding a new option to do
prefix-matching, but I don't think any code was ever written:

  https://lore.kernel.org/git/m2k12g7v5u.fsf@gmail.com/

Likewise, something more elaborate like full-path globbing or even
regex matching would be possible, but would need to be activated by an
option.

-Peff
