Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F563C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CCA60E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhH3S3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhH3S3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:29:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE20C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:28:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d16so27495888ljq.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dyrQ/rgfpi6D0hLsf6hcjHgBTojaT3wzb9QM4rKGcdI=;
        b=mk1nSWWcSmWx2NHbUuhr5qDSduUBppPkkAQGhEzgUnFceyiabjx84f0mSbn3ayPrIY
         Wqi5gRqDoXB8u5u8bzuKR00SL+GDpgKoiZm8H2m7MirlhqSBEVtWDFU+yN75OmeEVtS5
         foIVZq0q5mfeCtT5izy7831LVA5ZQDJ20DhxYykE2OSpJs5c/PqVf+4kZ/ASQYKvOcqO
         hQtIpptJVLc64NrHVOxnrV2tAmlfN/bIEvZxi2lma5jHtwIoQpAqFxeBZJR5Fa97lAPt
         x5hsFANN/ph7zrI6t9ukgzR1SHJxVxPwtZzxJfXKjHOgPf44TITRkZ8a0fQokCHVVFji
         ZldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyrQ/rgfpi6D0hLsf6hcjHgBTojaT3wzb9QM4rKGcdI=;
        b=qr6Kjn/6Q+CXGI2gewmAEWR0Z33MqOjjLLEWCOrCct+M9L3hj3BU33arwVMw6i8SoA
         rHYb2ioEKKf7b1D+Mt4DrrQcob6ZXIKSQ0SBQmnydiUbGAMcBN0XiQecLN0UirxDPF+J
         1FdXXHcU2Ja3bV5CW2hT5lOpVWCBb9siHP6ZyasbZYO1eFut8CN6RK8NkcNaUGCic/et
         lnARZLFrmrEebL4adQFdSceS6D7IEoTQCzXjYuid1WXqr8BqSW571ADkd09TzOjBIsgF
         dTJa6ZTgczglcIis6Xrt1PGW7LO5KcQ0aGCaY3tY1TjmqtHneXSXRLbkxR3ECC6o+L5G
         5RVQ==
X-Gm-Message-State: AOAM533M0oR6dr0qKZo31KXYrmT7eS7vBtqReGMQAP9V3U1+04RglHTz
        YDPDe0q+YWt98Xhhk8/sNbT9bQ==
X-Google-Smtp-Source: ABdhPJyWlkehRIM/tMUyAa4KXzD2cZcZUlp10JyyUDX1cs8W5ku9mgEWgizvq14baSj5VhJa5gQMSw==
X-Received: by 2002:a05:651c:2125:: with SMTP id a37mr20790557ljq.317.1630348126854;
        Mon, 30 Aug 2021 11:28:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a28sm568787lfr.51.2021.08.30.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:28:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 89AE3102EF9; Mon, 30 Aug 2021 21:28:45 +0300 (+03)
Date:   Mon, 30 Aug 2021 21:28:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830182845.pnv7ywnc364jnblt@box>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 02:16:04PM -0400, Jeff King wrote:
> On Mon, Aug 30, 2021 at 07:11:49PM +0300, Kirill A. Shutemov wrote:
> 
> > I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> > fails with an error:
> > 
> >         fetch-pack: unexpected disconnect while reading sideband packet
> > 
> > It only happens when I access git.kernel.org over git:// (github over
> > git:// works fine) and if there's a gitproxy configured.
> > 
> > For test I used a dummy gitproxy:
> > 
> >         #!/bin/sh -efu
> >         socat - "TCP:$1:$2"
> > 
> > It is enough to trigger the issue.
> > 
> > I'm not sure if it's kernel.org problem or git problem.
> > 
> > Has anybody else stepped on the issue? Any clues?
> 
> I can't reproduce the problem here, using core.gitproxy with a script
> identical to what you showed above. I tried both cloning, and fetching
> via both git-fetch and git-fetch-pack.

Could you try with a kernel repo?

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I found that not all repos on kernel.org trigger the issue.

> Can you show us a more complete example? What does the command that
> fails look like? What's the repo state before you run it? At what part
> of the conversation does it fail (before a pack is sent, during, or
> after)?

The last I see sent to the server is "packfile". It is consistent with the
bisected commit. Removing close() in do_fetch_pack_v2() helps.

> If you can reproduce it at will and it fails on 2.33 but not earlier,
> then bisecting might be helpful.

I did. See my other mail.

-- 
 Kirill A. Shutemov
