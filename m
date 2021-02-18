Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D532C4332D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104216148E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhBRT70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:59:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:38020 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhBRT4z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:56:55 -0500
Received: (qmail 28521 invoked by uid 109); 18 Feb 2021 19:56:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Feb 2021 19:56:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23901 invoked by uid 111); 18 Feb 2021 19:56:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Feb 2021 14:56:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Feb 2021 14:56:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 10/10] fsck.h: update FSCK_OPTIONS_* for object_name
Message-ID: <YC7GW8L+nJLFYHpY@coredump.intra.peff.net>
References: <20210217194246.25342-1-avarab@gmail.com>
 <20210218105840.11989-11-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210218105840.11989-11-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 11:58:40AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Add the object_name member to the initialization macro. This was
> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
> go, 2016-07-17) when the field was added.

We're correct either way here, because trailing fields that are not
initialized will get the usual zero-initialization. But I don't mind
trying to be more complete.

That said, we have embraced designated initializers these days, in which
case we usually omit the NULL ones. So perhaps:

  #define FSCK_OPTIONS_DEFAULT { \
	.walk = fsck_error_function, \
	.skiplist = OIDSET_INIT, \
  }
  #define FSCK_OPTIONS_STRICT { \
	.walk = fsck_error_function, \
	.skiplist = OIDSET_INIT, \
	.strict = 1, \
  }

would be more readable still?

-Peff
