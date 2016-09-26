Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94993207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422681AbcIZQgZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:36:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34522 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161424AbcIZQgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:36:24 -0400
Received: by mail-oi0-f65.google.com with SMTP id a62so13921700oib.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BTXKyezS5sv64K4lnJroiN7YjwVU8XuEEIM8UV2CAk0=;
        b=fWRp8CBvnUkQn3Mf/6Ca9+6t/+5VPj8+r5S/UQhnJ5i4ttZSRkQnNQp4lzlcJZNCcw
         qxq/YVol1r3OuYflW4mlY2b92QTTOtAYB/dncdrxy7D7iEvMidnopvmcgTi1fLoifc2p
         tT8SY/mwR/tBkZYYMKeF0wNay1r5iz1YLcZOMcseAeKxvtSXGr/EdumR8V/mvS/gjgkG
         WK0io2jP2hg4ZrBctFjHmez4m4wisUf6DJhB7Onx+3WmfZh6LemPbyaCHvfyzxtv+QRb
         OYLVhnXTWrf0y4pP2BKeF3f3hOE9mw7TY3wSm5uuJWKm6HkA4mTcWO1v7lVM2aq2tl88
         UI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BTXKyezS5sv64K4lnJroiN7YjwVU8XuEEIM8UV2CAk0=;
        b=fJ0v1VQcBdTcWFwtzeQEO+Mvt1pdYZQMzWdXLTlP6faLYXS+e2Nh1p9PiTsr00rMZA
         qTmovlt0YmPBLTGHDTceSO3j0HyXQgM/evOkIdcq08O3RfPv5SiGy7H86Tqy5wbYhgbu
         yYqT3CoWm4rftMwYxpG0u3DLg9mUTrMr/yKLJPQtoVLKsmtsqQhKyjykII9X6SBbsDpw
         ukkgwVyGGHtyhiv/ctGTx82bp1VrxiTUGcJ8ZL2cct2Z4wMi6a9OJL7oVZZdO4ILUQ8v
         o3R4yF3EJ/7aX2FHcaqMpkFr1zCB07BSNAFuHsOraMJ6Wa1PdRReih2hoUfEzjg/4JDa
         sE3w==
X-Gm-Message-State: AE9vXwO8j2vp1m3RpYLzRY+2OK2NAHD+b8EZx3s7qZ0hYN1snr0S1IooTfdPOvZPnktrwrNHmm57yLih2zt5lg==
X-Received: by 10.202.89.66 with SMTP id n63mr29762955oib.90.1474907783945;
 Mon, 26 Sep 2016 09:36:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.119.104 with HTTP; Mon, 26 Sep 2016 09:36:23 -0700 (PDT)
In-Reply-To: <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net> <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Sep 2016 09:36:23 -0700
X-Google-Sender-Auth: ze64a3VwzdSm9CxKE63941LXVlo
Message-ID: <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 5:00 AM, Jeff King <peff@peff.net> wrote:
>
> This patch teaches get_short_sha1() to list the sha1s of the
> objects it found, along with a few bits of information that
> may help the user decide which one they meant.

This looks very good to me, but I wonder if it couldn't be even more aggressive.

In particular, the only hashes that most people ever use in short form
are commit hashes. Those are the ones you'd use in normal human
interactions to point to something happening.

So when the disambiguation notices that there is ambiguity, but there
is only _one_ commit, maybe it should just have an aggressive mode
that says "use that as if it wasn't ambiguous".

And then have an explicit command (or flag) to do disambiguation for
when you explicitly want it.

Rationale: you'd never care about short forms for tags. You'd just use
the tag name. And while blob ID's certainly show up in short form in
diff output (in the "index" line), very few people will use them. And
tree hashes are basically never seen outside of any plumbing commands
and then seldom in shortened form.

So I think it would make sense to default to a mode that just picks
the commit hash if there is only one such hash. Sure, some command
might want a "treeish", but a commit is still more likely than a tree
or a tag.

But regardless, this series looks like a good thing.

                        Linus
