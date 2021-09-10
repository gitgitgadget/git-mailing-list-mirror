Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC6C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6161074
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhIJPmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:42:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:44162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232438AbhIJPmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:42:38 -0400
Received: (qmail 6260 invoked by uid 109); 10 Sep 2021 15:41:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:41:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26596 invoked by uid 111); 10 Sep 2021 15:41:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:41:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:41:26 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 5/8] http: correct version check for
 CURL_HTTP_VERSION_2
Message-ID: <YTt8ppkt/PloRn4D@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com>
 <YTt1RLty0KDEAio1@coredump.intra.peff.net>
 <nycvar.QRO.7.76.2109101713110.2614@fvyyl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.2109101713110.2614@fvyyl>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 05:20:24PM +0200, Daniel Stenberg wrote:

> On Fri, 10 Sep 2021, Jeff King wrote:
> 
> > > The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added
> > > in 7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in
> > > 7.47.0. So we could support an even older version here, but let's
> > > just correct the checked version.
> > 
> > Thanks for expanding on the history here. I agree it probably doesn't
> > matter much between the two versions, as they're both 6+ years old (and
> > only about 6 months apart). If somebody has a case where it really
> > matters, they can submit a patch.
> 
> Forgive me for digressing a bit here but wow, I *so* appreciate your digging
> into the details of the curl history and the symbols that were introduced
> when etc. I know of no other libcurl-using project with this eye and sense
> for historic details and as the lead maintainer of libcurl I learn a lot
> here. It also keeps me motivated to provide this documentation and work on
> keeping in accurate.

This documentation is most definitely appreciated. As is your continued
support and attention to our issues, not to mention just having libcurl
in general. :)

There are two related things that came up in this discussion that might
be of interest to you:

  - it would be convenient if libcurl provided preprocessor macros
    indicating a feature was present. E.g., if we could say:

      #ifdef CURL_HAVE_FOO

    rather than checking that "FOO" showed up in version 7.60.0 or
    whatever. That has two advantages. One, it's just less work and
    harder to get wrong. But two, it could help for cases where distros
    backport features (i.e., the version-to-feature mapping is not
    always 100% correct).

    Obviously that can't help historical versions, but maybe something
    to think about as new features are added.

  - Ævar mentioned at the end of:

      https://lore.kernel.org/git/87tuiscwso.fsf@evledraar.gmail.com/

    that the tags in the curl repo sometime seem to differ from the
    releases.

-Peff
