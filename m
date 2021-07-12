Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F6C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6593F611B0
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGLVrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:47:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:47152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhGLVru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:47:50 -0400
Received: (qmail 23170 invoked by uid 109); 12 Jul 2021 21:45:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 21:45:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2873 invoked by uid 111); 12 Jul 2021 21:45:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 17:45:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 17:45:00 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH 6/6] git-compat-util.h: add __attribute__((printf)) to
 git_*printf*
Message-ID: <YOy33I+T0LsLHYoS@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com>
 <YOyiTTbFJmWjwXlq@coredump.intra.peff.net>
 <012b01d7775c$2ddcca60$89965f20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <012b01d7775c$2ddcca60$89965f20$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 04:26:16PM -0400, Randall S. Becker wrote:

> >> In practice this is redundant to the compiler's default printf format
> >> checking, since we mostly (entirely?)  develop and test on platforms
> >> where SNPRINTF_RETURNS_BOGUS is not set. I'm doing this mainly for
> >> consistency with other code, now we don't need to think about why this
> >> particular case is different.
> >>
> >> See c4582f93a26 (Add compat/snprintf.c for systems that return bogus,
> >> 2008-03-05) for the commit that added these functions.
> >
> >I'm slightly lukewarm on general on adding this to a compat function.
> >Those are meant to be a lowest-common-denominator fallback, and we usually avoid fancy features or our usual styles there in favor of
> >simplicity.
> >
> >I guess this probably isn't _hurting_ anything, but it makes me wonder how many systems have a broken snprintf _and_ support the
> >attribute.
> 
> NonStop does not support __attribute__ on any compiler I know of. This
> appears to be a gcc extension, so compat.c would create a gcc
> dependency, which is also not on the platform. snprintf is in place.

We already turn __attribute__ into a noop on unsupported platforms early
in git-compat-util.h (around line 443). So this would be OK, since the
snprintf macro hackery is later in the file (around line 786).

-Peff
