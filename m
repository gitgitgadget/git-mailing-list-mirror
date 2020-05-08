Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521FDC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E05121775
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEHRQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:16:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:41838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726756AbgEHRQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:16:37 -0400
Received: (qmail 10510 invoked by uid 109); 8 May 2020 17:16:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 17:16:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30210 invoked by uid 111); 8 May 2020 17:16:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 13:16:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 13:16:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] upload-pack: fix filter options scope
Message-ID: <20200508171635.GB637136@coredump.intra.peff.net>
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
 <20200508080115.15616-1-chriscool@tuxfamily.org>
 <20200508130616.GA631018@coredump.intra.peff.net>
 <xmqqtv0qzax9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv0qzax9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 08:46:58AM -0700, Junio C Hamano wrote:

> Even though the log message itself got a lot better explaining the
> nature of the issue, I do not think the title of the patch does a
> good job explaining what it is about to the readers of shortlog.
> 
> "fix" is a meaningless word in a bugfix patch, and it does not make
> it clear what bad effect of the original code had by not giving a
> clean-slate "options" variable to the second invocation of the
> callchain.
> 
> Is it that the server side was incapable of serving a follow-up
> fetch request in the same process when protocol v2 was in use?
> Perhaps
> 
>     upload-pack: allow follow-up fetch in protocol v2
> 
> or something?

Yeah, I agree that's better. Maybe even:

  upload-pack: clear filter_options for each v2 fetch command

which is more direct (we already allow follow-up fetches; they just
don't work sometimes) and makes it clear that this is about fixing the
filter feature with v2.

-Peff
