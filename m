Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B3C19F28
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 23:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiG3XuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 19:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiG3XuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 19:50:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A72665
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 16:50:03 -0700 (PDT)
Received: (qmail 27997 invoked by uid 109); 30 Jul 2022 23:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jul 2022 23:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7626 invoked by uid 111); 30 Jul 2022 23:50:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jul 2022 19:50:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jul 2022 19:50:01 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuXDqRNQSeyQXWGj@coredump.intra.peff.net>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
 <YuR5Jado2LrtZUjP@danh.dev>
 <YuSNhhRVpg2oT6ry@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuSNhhRVpg2oT6ry@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 01:46:46AM +0000, brian m. carlson wrote:

> > Well, config.mak.uname automatically adds -std=c99 for RHEL 7 and
> > CentOS7. Can we add the same things for Debian? Or should we just
> > remove both?
> 
> I don't think we can do that, since Debian kernels don't include a
> distinguishing pattern like that[0].  Also, Debian jessie doesn't have a
> full set of security support, unlike CentOS 7, and thus I would argue we
> probably wouldn't want to support it anyway.

The check really ought to be using the compiler version and not uname
anyway. But outside of DEVELOPER=1, we don't (yet) do any probing of the
compiler.

> My guess is that Peff used jessie because he uses Debian and it's easier
> for him to set up than CentOS 7, not because we should use it as an
> intentional target.

Yep, exactly.

> Personally, although I don't use RHEL and company in either my personal
> or professional life anymore, I think it's probably worth providing a
> modicum of support to because they're very common, at least as long as
> there are freely available clones with security support (e.g., CentOS
> and Rocky Linux) that we can test against.
> 
> All that to say that I think we don't need to change config.mak.uname
> and can rely on folks just setting -std=c99 if need be.

Agreed. I only brought it up as a "gee, is anybody even using this?"
head-scratcher. I just wasn't aware of the CentOS workaround.

-Peff
