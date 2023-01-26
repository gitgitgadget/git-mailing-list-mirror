Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED48BC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 11:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbjAZLj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbjAZLj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 06:39:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E663844
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 03:39:43 -0800 (PST)
Received: (qmail 20917 invoked by uid 109); 26 Jan 2023 11:39:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 11:39:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22934 invoked by uid 111); 26 Jan 2023 11:39:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 06:39:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 06:39:42 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
Message-ID: <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
 <Y81lQwG85+Skujja@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y81lQwG85+Skujja@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2023 at 11:33:07AM -0500, Todd Zullinger wrote:

> > So I haven't reported the bug further yet. But I thought I'd post this
> > here before anybody else wastes time digging in the same hole.
> 
> FWIW, I think this is the same issue we discussed about 2
> months back, in <Y4fUntdlc1mqwad5@pobox.com>¹.
> 
> I haven't done much else with it since then.  It's almost
> surely either an apache httpd/mod_http2 or curl issue.  If I
> had to bet, I'd say mod_http2.  (But then, it could be curl
> and just has yet to be exposed widely because not many are
> using the current mod_http2 code.)
> 
> ¹ https://lore.kernel.org/git/Y4fUntdlc1mqwad5@pobox.com/

Ah, I somehow completely forgot about that issue. Despite being one of
the two participants on the thread.

Yeah, after seeing that, I'm quite sure this is a mod_http2 issue. It
would be nice to bisect within the mod_http2 history to find the
culprit, but I'd first have to figure out how to build standalone apache
modules. ;)

I may try to poke at it later if I have time. It might also be worth
submitting a bug report to the mod_http2 folks. I'd hope to have a more
compact reproduction, but it does at least seem to fail reliably for me
(not even racily).

-Peff
