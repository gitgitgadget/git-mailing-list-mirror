Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BB01F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 01:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941296AbcIZBjh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 21:39:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34286 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936362AbcIZBjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 21:39:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id a62so12700647oib.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=RKWZ8CuIvyW+hZxDvOFUBJY8/RQN0Gv2kHmtfzabBuY=;
        b=A7dKQ/qYLTs0KnIW8GmegR9H2gUvwzLZNZ15oh4dF3yh25rFiUDTjsB5MCbIrA86n2
         UOOT8RMoHxOwr8e/w61E7oix3M6xq0uWgfZmCmcQ3LbPidua9ecvhkh4irhWos8N1VSG
         nfKZT/dr8Vf43D5J7+TddII0NaPReAitf3MTcU3PxkQXoBgAiqF+o5gCJ+PDoCg5Jbae
         4LzxbEI9aCAsMiQpgMmH0veBBCveJ318WAT91BnuEUG3Czj5CvoZlFn09q6Yoh6oXH3J
         A3tZ/QSrsTrVWHe7TJgZI2+Cx0/orWLJoucy8dfML4fr8KtgIXTda2r0nqpNuhAckJab
         BtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=RKWZ8CuIvyW+hZxDvOFUBJY8/RQN0Gv2kHmtfzabBuY=;
        b=Nq58qViKDDjXqwzP1vtuu2WlxB2h74yS8L0qKoChVc6Hqyg72lzZ+3iZ6z2AEpWqlc
         rdVMYwd/HMQOb+GSc2PQVeiY9aJnLKqGe602MtfYhQ3injnzwqnVIj4kM8fl3iV+vcgo
         B90yafCt5sw/GHgtk+lXYe5DpKjgggU6uatCGJJjrhShFD/RFhWuLyuX6J1vFCKYUOKV
         cmZKeYwjAVLNShzZfsx7z0wv70QKULc49dmP7q5+81+9ESBLCbyCk1OTexEEynWyeyxS
         FBvmyCsom9uSPVYq32leOUFUc/4f9SWKz9mZjv7jxTv9zD22wDjlG6cPUYcv++39b5dT
         YpGQ==
X-Gm-Message-State: AE9vXwNGIFJ2HqUoulEuo9VkZkE9+RTYtfUaxG2gFpzTmxzwRcVCzJD5/QJZrchBWb04823acV/gugTUbBP97g==
X-Received: by 10.202.220.194 with SMTP id t185mr23579955oig.116.1474853975422;
 Sun, 25 Sep 2016 18:39:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.119.104 with HTTP; Sun, 25 Sep 2016 18:39:34 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Sep 2016 18:39:35 -0700
X-Google-Sender-Auth: eYSzsVu0JWWhTeHjrtI9tqXksl4
Message-ID: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
Subject: Changing the default for "core.abbrev"?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default value for commit abbreviation (environment.c: 19) is seven:

    int minimum_abbrev = 4, default_abbrev = 7;

which back in the dark early days of git was fairly reasonable.

It's probably still a perfectly fine default for lots of projects,
since 7 hex digits is a few hundred million unique values, and you
won't really start to get very many collisions in that until you get
closer to a million objects.

The kernel, these days, is at roughly 5 million objects, and while the
seven hex digits are still often enough for uniqueness (and git will
always add digits *until* it is unique), it's long been at the point
where I tell people to do

    git config --global core.abbrev 12

because even though git will extend the seven hex digits until the
object name is unique, that only reflects the *current* situation in
the repository. With 5 million objects and a very healthy growth rate,
a 7-8 hex digit number that is unique today is not necessarily unique
a month or two from now, and then it gets annoying when a commit
message has a short git ID that is no longer unique when you go back
and try to figure out what went wrong in that commit.

I can just keep reminding kernel maintainers and developers to update
their git config, but maybe it would be a good idea to just admit that
the defaults picked in 2005 weren't necessarily the best ones
possible, and those could be bumped up a bit?

I think I mentioned this some time ago, and it's not a huge deal, but
I thought I'd just mention it again because it came up again today for
me..

Thanks,

              Linus
