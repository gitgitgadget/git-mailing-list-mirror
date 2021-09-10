Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D677C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92E611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhIJPLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:11:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:43990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJPLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:11:09 -0400
Received: (qmail 6011 invoked by uid 109); 10 Sep 2021 15:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 15:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25956 invoked by uid 111); 10 Sep 2021 15:09:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 11:09:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 11:09:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 5/8] http: correct version check for
 CURL_HTTP_VERSION_2
Message-ID: <YTt1RLty0KDEAio1@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:30PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In d73019feb44 (http: add support selecting http version, 2018-11-08)
> a dependency was added on CURL_HTTP_VERSION_2, but this feature was
> introduced in curl version 7.43.0, not 7.47.0, as the incorrect
> version check led us to believe.
> 
> As looking through the history of that commit on the mailing list will
> reveal[1], the reason for this is that an earlier version of it
> depended on CURL_HTTP_VERSION_2TLS, which was introduced in libcurl
> 7.47.0.
> 
> But the version that made it in in d73019feb44 had dropped the
> dependency on CURL_HTTP_VERSION_2TLS, but the corresponding version
> check was not corrected.
> 
> The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added in
> 7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in
> 7.47.0. So we could support an even older version here, but let's just
> correct the checked version.

Thanks for expanding on the history here. I agree it probably doesn't
matter much between the two versions, as they're both 6+ years old (and
only about 6 months apart). If somebody has a case where it really
matters, they can submit a patch.

-Peff
