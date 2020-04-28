Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B36C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EFD206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD1Ipp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:45:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:42094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726363AbgD1Ipo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 04:45:44 -0400
Received: (qmail 19737 invoked by uid 109); 28 Apr 2020 08:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 08:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32707 invoked by uid 111); 28 Apr 2020 08:57:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 04:57:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 04:45:43 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] Use OPT_CALLBACK and OPT_CALLBACK_F
Message-ID: <20200428084543.GC2381876@coredump.intra.peff.net>
References: <xmqq7dy092tq.fsf@gitster.c.googlers.com>
 <d6d35a21a5bb1077eea4dd49f5716bece9e015de.1588062647.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6d35a21a5bb1077eea4dd49f5716bece9e015de.1588062647.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 04:36:28AM -0400, Denton Liu wrote:

> In the codebase, there are many options which use OPTION_CALLBACK in a
> plain ol' struct definition. However, we have the OPT_CALLBACK and
> OPT_CALLBACK_F macros which are meant to abstract these plain struct
> definitions away. These macros are useful as they semantically signal to
> developers that these are just normal callback option with nothing fancy
> happening.

I think this is worth doing. It's a little easier to read, and sets a
better example anyone copying the code.

> Replace plain struct definitions of OPTION_CALLBACK with OPT_CALLBACK or
> OPT_CALLBACK_F where applicable. The heavy lifting was done using the
> following (disgusting) shell script:
> [...]

I'll admit I gave only a quick read through the results. I think between
your script, the manual look-over for style, and the fact that the
compiler would catch any minor syntactic screwups, I'm not likely to
see any new errors.

> I contemplated breaking this down into file-sized patches but I don't
> think it really makes sense in this case since it's the same change
> which is being made in each file and, imo, it wouldn't really ease
> reviewer burden since the same number of changes are being reviewed.

As a reviewer I much prefer one big patch like this, since these are all
the same case: changing style X to style Y. I'd want patches broken out
if there were other case (say, the parameters for some version needed
fixed up as you were converting). But I don't see that here.

-Peff
