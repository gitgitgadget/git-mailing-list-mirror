Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1134C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AAC61101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhHTSMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:12:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:53458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhHTSMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:12:36 -0400
Received: (qmail 23449 invoked by uid 109); 20 Aug 2021 18:11:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Aug 2021 18:11:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7019 invoked by uid 111); 20 Aug 2021 18:11:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Aug 2021 14:11:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Aug 2021 14:11:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Xia XiaoWen <haoyurenzhuxia@gmail.com>, git@vger.kernel.org,
        worldhello.net@gmail.com, Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
Message-ID: <YR/wbWhei0PPLSgX@coredump.intra.peff.net>
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
 <xmqq4kbl2sre.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kbl2sre.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 11:28:53AM -0700, Junio C Hamano wrote:

> > https protocol, and only supports libcurl 7.15.5 and above.
> 
> We are likely be raising the floor versions of libcURL to 7.16.0 or
> even 7.19.4 soonish.  It probably would make it easier to allow it
> unconditionally (otherwise you'd probably need to implement error or
> warning messages when configuration is given but the libcURL version
> used is too old, etc.).

Yeah, I agree that if we can drop the conditional totally, we should.

If we do need to make it conditional, I think there was a preference for
shifting to checking the actual option constants, like:

  #ifdef CURLOPT_MAX_RECV_SPEED_LARGE
  ...ok, we have it...
  #endif

The rest of your comments all seemed quite reasonable to me.

As a general feature, IMHO speed-limiting is best done outside of
application-level tools like Git (and instead done via proxies or kernel
network config). But since we are not building the feature ourselves,
but rather just plugging our config to curl's feature, I don't have any
problem with it here.

-Peff
