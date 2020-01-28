Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2EC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BFF2173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A16K77jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgA1N5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:57:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41665 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1N5M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 08:57:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so16118344wrw.8
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23NDgQTFjvALxcAdidkDF0rozwQCkKkcj+NdnPoRCvw=;
        b=A16K77jXZXgkM3CD4u8SRSxKeOYee4CinaID7P1CjhAVp8PLh9MMcN4hHXvFj4fHz2
         YQZ8Mz7MtURgELWOhYBAmjvpAJSBp2RDYFbAfjtMngp7tqf1llHUzHVEY221cMasj9/A
         tNRHVQJyrAl1kX1+IHxzVexUgG+7BRXTgn4mS3qvacPl6rLe/+tVPKFPKh5DVf3tcofu
         PikJIEzyTL+RWnJ+C5kCK4dsYIR7KE3urUMiVDNb5q2ppnjmLvpQ+8M6VvBGQjDLXt05
         hrNS9xcQJ1s0izo7t0qzMzn9bgJyb0rZR0S+KxgULmzNzaDssKcvcdf0pZ53z8nXva/D
         gz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23NDgQTFjvALxcAdidkDF0rozwQCkKkcj+NdnPoRCvw=;
        b=Tlml/4giDxg9uerFgTwXGo9xUYqBzbF/ABz7pTrW8gF+CaqylaYCJBK6Q4LCgRqJ9v
         05MY7kQrDdIPDRzqxV689VpS3TtqLFhJZ+QI7ToGMo5ApPrIQQ21sSJzi2JPmWHjeBMa
         5scTn3WKlx898Mr1a60CO67Hh8F3iDKTSmzlTtdzqkstW+jSzU2eHzqu/tbQtzQ796oD
         nFU+vU2GHVpxMaTav7FUlnuld3qBNa9KdwD5nJ3YxzMHJC80RPPq2PGDdz5kV+q2f5De
         dHnDJVdi8WIBL2L4DU9x1rp8O82PKgjMmYcMB5nbZY0+ZagEVXuigsmL8u47M5koi0ME
         iX9Q==
X-Gm-Message-State: APjAAAUgW3TxGh9Kzh3MNAX0xc5zb4bXoGEfRcZe9oYZQsooSDT3Jby2
        uJv01rEj73bOWq6Vf9UaFi0InJyv
X-Google-Smtp-Source: APXvYqx98bDfLVS5kgdhqigPdSRXV1xoZMqmo+5sNywogZzrJQ0LtPM+GIoZ63KGhgslE5kDlFvYIw==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr29294741wrs.237.1580219830658;
        Tue, 28 Jan 2020 05:57:10 -0800 (PST)
Received: from szeder.dev (x4dbe41cb.dyn.telefonica.de. [77.190.65.203])
        by smtp.gmail.com with ESMTPSA id d8sm24765450wrx.71.2020.01.28.05.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 05:57:09 -0800 (PST)
Date:   Tue, 28 Jan 2020 14:57:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Martin Melka <martin.melka@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: git status --ignored hangs when a deep directory structure
 present in working tree
Message-ID: <20200128135707.GD10482@szeder.dev>
References: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
 <20200127120837.GA10482@szeder.dev>
 <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 09:06:01PM -0800, Elijah Newren wrote:
> > the runtime of 'git status
> > --ignored' grows quickly with the depth of the untracked directory.
> > Running this shell loop produces the numbers below:
> >
> > for depth in $(seq 10 30)
> > do
> >         dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
> >         rm -rf dir
> >         mkdir -p $dirs
> >         >$dirs/untracked-file
> >         /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
> > done
> >
> > 10: 0.01
> > 11: 0.03
> > 12: 0.05
> > 13: 0.11
> > 14: 0.23
> > 15: 0.47
> > 16: 0.97
> > 17: 1.97
> > 18: 3.88
> > 19: 7.85
> > 20: 16.29
> > 21: 32.92
> > 22: 76.24
> 
> Wow.
> 
> Really nice testcase, though, thanks.
> 
> > Beautifully quadratic, isn't it? :)
> 
> I think you mean exponential (in particular 2^n rather than n^2).

Ouch, yeah, indeed.

> > Unless I messed up my numbers, with a depth of 120 directories it
> > would take over 6*10^23 years to complete... so yeah, it does qualify
> > as indefinitely.
> 
> No comment about how people today are spoiled and addicted to instant
> gratification?  I mean, can't folks just be a little patient?  ;-)

Nope.  Notice how my shell loop above goes to 30, but the results only
to 22 :)

> > This slowdown was caused by commit df5bcdf83a (dir: recurse into
> > untracked dirs for ignored files, 2017-05-18), which was part of a
> > patch series to fix 'git clean -d' deleting untracked directories even
> > if they contained ignored files.
> >
> > Cc'ing Samuel, author of that commit, and Elijah, who had quite some
> > fun with 'dir.c' recently.
> 
> Heh, yes, what "fun" it was.
> 
> Anyway, after digging around for quite a bit today... that commit
> added calling read_directory_recursive() directly from itself for
> certain untracked paths.  This means that read_directory_recursive()
> (which I'll abbreviate to r_d_r()), when we're dealing with certain
> untracked paths:
> 
>   * Calls treat_path() -> treat_one_path() -> treat_directory() -> r_d_r()
>   * Calls r_d_r() directly as well
> 
> So, from the toplevel directory, r_d_r() will call itself twice on the
> next directory down.  For each of those, it'll call r_d_r() twice on
> the second directory down.  From each of those, it'll call r_d_r()
> twice on the third directory in the hierarchy and so on until we have
> 2^n calls to r_d_r() for the nth level deep directory.

Got it, thanks.

> Trying to back out the underlying problem, I _think_ the cause behind
> all this is that r_d_r() and friends all use the path_treatment enum,
> which says that the treatment of any path has to be one of those four
> types. The dichotomy between path_untracked and path_recurse in
> particular means the system has no way to mark that something should
> be both marked as untracked and recursed into, yet we definitely need
> to have some directories marked as untracked and we also need to
> recurse into them.  This, I think led to Samuel's attempt to
> workaround that dichotomy by having the code in r_d_r() check for
> certain path_untracked cases which should also be recursed into.  I
> think adding another type to the enum and shifting the logic elsewhere
> might enable us to both simplify the logic and avoid this expensive
> exponential behavior, but I haven't gotten it working yet.  We'll see
> if my patch goes anywhere, or if it's just another dead-end among
> many.

I was wondering whether it would make sense to give the enum contants
power-of-two values, so we could say 'path_recurse | path_untracked'.
But while this particular combination makes sense, others, at least to
my superficial understanding, not at all (e.g. 'path_recurse |
path_exclude').

