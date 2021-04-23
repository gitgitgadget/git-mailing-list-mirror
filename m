Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CBC43461
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 13:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AA60FE9
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 13:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbhDWNHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 09:07:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:33316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242576AbhDWNHi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 09:07:38 -0400
Received: (qmail 6791 invoked by uid 109); 23 Apr 2021 13:07:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 13:07:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8317 invoked by uid 111); 23 Apr 2021 13:07:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 09:07:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 09:07:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lilinchao@oschina.cn, git <git@vger.kernel.org>
Subject: Re: [Question] git cat-file --batch cannot handle irregular path
Message-ID: <YILGdNkvyG2im6mk@coredump.intra.peff.net>
References: <54526f48a18b11ebad130024e87935e7@oschina.cn>
 <xmqqim4h7fek.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim4h7fek.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 09:23:31PM -0700, Junio C Hamano wrote:

> If properly designed, it would have
> 
>  - supported "-z" to take NUL-delimited input, and
> 
>  - when "-z" is not in effect, after reading a single line of input,
>    we would have called quote API to un-cquote the string, so that
>    we can express LF and other special characters in the pathname.
> 
> but those who worked on "cat-file --batch" didn't.

Yeah, this has been a long-standing pain.

It would be easy to add "-z" now, and probably worth doing.

It is too late to do the unquoting thing by default now. We could add an
option to enable it, but once "-z" exists, it hardly seems worth it.

-Peff
